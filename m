Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB0D9A29AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 00:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfH2WXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 18:23:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40826 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfH2WXG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:23:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3Sok-0000EE-UR; Thu, 29 Aug 2019 22:22:59 +0000
Date:   Thu, 29 Aug 2019 23:22:58 +0100
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
Message-ID: <20190829222258.GA16625@ZenIV.linux.org.uk>
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
 <B35B5EA9-939C-49F5-BF65-491D70BCA8D4@kolumbus.fi>
 <20190826193210.GP1131@ZenIV.linux.org.uk>
 <b362af55-4f45-bf29-9bc4-dd64e6b04688@plexistor.com>
 <20190827172734.GS1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827172734.GS1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 27, 2019 at 06:27:35PM +0100, Al Viro wrote:

> Most of them are actually pure bollocks - "it can never happen, but if it does,
> let's return -EWHATEVER to feel better".  Some are crap like -EINTR, which is
> also bollocks - for one thing, process might've been closing files precisely
> because it's been hit by SIGKILL.  For another, it's a destructor.  It won't
> be retried by the caller - there's nothing called for that object afterwards.
> What you don't do in it won't be done at all.
> 
> And some are "commit on final close" kind of thing, both with the hardware
> errors and parsing errors.

FWIW, here's the picture for fs/*: 6 instances.

afs_release():
	 calls vfs_fsync() if file had been opened for write, tries to pass
	the return value to caller.  Job for ->flush(), AFAICS.

coda_psdev_release():
	returns -1 in situation impossible after successful ->open().
	Can't happen without memory corruption.

configfs_release_bin_file():
	discussed upthread

dlm device_close():
	returns -ENOENT if dlm_find_lockspace_local(proc->lockspace) fails.
No idea if that can happen.

reiserfs_file_release():
	tries to return an error if it can't free preallocated blocks.

xfs_release():
	similar to the previous case.

In kernel/*: ftrace_graph_release() might return -ENOMEM.  No idea whether it's
actually possible.

In net/*: none

In sound/*: 4 instances.

snd_pcm_oss_release():
        if (snd_BUG_ON(!substream))
                return -ENXIO;
	IOW, whine in impossible case.

snd_pcm_release():
	ditto.

sq_release():
        if (file->f_mode & FMODE_WRITE) {
                if (write_sq.busy)
                        rc = sq_fsync();
	subsequently returns rc; sq_fsync() can return an error, both on timeout
	and in case of interrupted wait.

snd_hwdep_release():
	passes the return value of hwdep ->release() method; two of those
	can return an error.   snd_asihpi_hpi_release() is, AFAICS, impossible,
	unless you manage to flip this module_param(enable_hpi_hwdep, bool, 0644);
	off after opening a file.  And snd_usX2Y_hwdep_pcm_release() calls
	usX2Y_pcms_busy_check() and passes its return value out.  No idea
	whether that can be triggered.


In other words, the real mess is hidden in drivers/*...
