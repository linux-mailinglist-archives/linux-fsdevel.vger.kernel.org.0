Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53ACA2AEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 01:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfH2XcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 19:32:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41492 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfH2XcL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:32:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3Ttd-0002C0-JC; Thu, 29 Aug 2019 23:32:05 +0000
Date:   Fri, 30 Aug 2019 00:32:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     Kai =?iso-8859-1?Q?M=E4kisara_=28Kolumbus=29?= 
        <kai.makisara@kolumbus.fi>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
Message-ID: <20190829233205.GU1131@ZenIV.linux.org.uk>
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
 <B35B5EA9-939C-49F5-BF65-491D70BCA8D4@kolumbus.fi>
 <20190826193210.GP1131@ZenIV.linux.org.uk>
 <b362af55-4f45-bf29-9bc4-dd64e6b04688@plexistor.com>
 <20190827172734.GS1131@ZenIV.linux.org.uk>
 <20190829222258.GA16625@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829222258.GA16625@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 11:22:58PM +0100, Al Viro wrote:
> On Tue, Aug 27, 2019 at 06:27:35PM +0100, Al Viro wrote:
> 
> > Most of them are actually pure bollocks - "it can never happen, but if it does,
> > let's return -EWHATEVER to feel better".  Some are crap like -EINTR, which is
> > also bollocks - for one thing, process might've been closing files precisely
> > because it's been hit by SIGKILL.  For another, it's a destructor.  It won't
> > be retried by the caller - there's nothing called for that object afterwards.
> > What you don't do in it won't be done at all.
> > 
> > And some are "commit on final close" kind of thing, both with the hardware
> > errors and parsing errors.

[snip]

> In other words, the real mess is hidden in drivers/*...

BTW, here's a live example - v4l stuff.  There we have
static int v4l2_release(struct inode *inode, struct file *filp)
{
...
        if (vdev->fops->release) {
                if (v4l2_device_supports_requests(vdev->v4l2_dev)) {
                        mutex_lock(&vdev->v4l2_dev->mdev->req_queue_mutex);
                        ret = vdev->fops->release(filp);
                        mutex_unlock(&vdev->v4l2_dev->mdev->req_queue_mutex);
                } else {
                        ret = vdev->fops->release(filp);
                }
        }
...
        return ret;
}

	OK, so we have a secondary method, also called "release".  It lives in
struct v4l2_file_operations and its return value is passed to caller of
v4l2_release() (and discarded by it).  There is a sodding plenty of instances,
most of them explicitly initialized (for values of "sodding plenty" well over
a hundred).  Quite a few of those have .release initialized with vb2_fop_release
or v4l2_fh_release, so it's not _that_ horrible.  And these two helpers are
returning 0 in all cases.  Many instances return 0, vb2_fop_release(...),
or v4l2_fh_release(...), so they are also fine.  However, there are exceptions.

1) drivers/media/radio/wl128x/fmdrv_v4l2.c:fm_v4l2_fops_release()
...
        ret = fmc_set_mode(fmdev, FM_MODE_OFF);  
        if (ret < 0) {
                fmerr("Unable to turn off the chip\n");
                goto release_unlock;
        }
...
release_unlock:
        mutex_unlock(&fmdev->mutex);
        return ret;
}

2) drivers/media/platform/omap/omap_vout.c:omap_vout_release()
...
        /* Turn off the pipeline */
        ret = omapvid_apply_changes(vout);
        if (ret)   
                v4l2_warn(&vout->vid_dev->v4l2_dev,
                                "Unable to apply changes\n");
...
        return ret;
}

3) drivers/media/platform/pxa_camera.c:pxac_fops_camera_release()
...
        if (fh_singular)
                ret = pxac_sensor_set_power(pcdev, 0);
        mutex_unlock(&pcdev->mlock);

        return ret;
}

4) drivers/media/platform/sti/bdisp/bdisp-v4l2.c:bdisp_release()
...
        if (mutex_lock_interruptible(&bdisp->lock))
                return -ERESTARTSYS;

5) drivers/media/radio/radio-wl1273.c:wl1273_fm_fops_release()
...
                        if (mutex_lock_interruptible(&core->lock))
                                return -EINTR;

                        radio->irq_flags &= ~WL1273_RDS_EVENT;

                        if (core->mode == WL1273_MODE_RX) {
                                r = core->write(core,
                                                WL1273_INT_MASK_SET,
                                                radio->irq_flags);
                                if (r) {
                                        mutex_unlock(&core->lock);
                                        goto out;
                                }
...
out:
        return r;
}

... and then it gets even better: in drivers/media/pci/ttpci/av7110_v4l.c
we have struct v4l2_file_operations embedded into struct saa7146_ext_vv,
with
        .vbi_fops.open  = av7110_vbi_reset,
        .vbi_fops.release = av7110_vbi_reset,
in initializers.  Yes, the same instance for ->open() and ->release().
Both currently take struct file * and return int.  And it certainly
can return an error.

So we have
	* 3 simple cases of returning an error that gets seen by nobody.
	* 2 outright bugs - ERESTARTSYS is particularly cute, seeing that
restarting close(2) would not do the right thing even if it had been passed
to userland.  As it is, it simply leaks.  IMO they should switch to plain
mutex_lock; bdisp becomes regular, wl1273 becomes another "reporting error
that goes nowhere" case.
	* av7110, where we get basically the same "lost error, maybe we
care, maybe not" with a twist - we can't just convert the ->release() to
return void, since the same function is used for both ->open and ->release.
Not hard to produce a wrapper, of course...

I've no idea if v4l userland would want to see those errors; currently
they are simply lost.

All of the above is from grep; build coverage is not going to be great,
seeing how much in there is embedded stuff...  Granted, v4l is probably
the most hairy subsystem in that respect, but there's enough isolated
fun cases where file_operations ->release() in drivers/* is trying to
return errors, without any calls of subsystem methods...
