Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C554072F577
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 09:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243227AbjFNHGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 03:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243301AbjFNHGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF862686;
        Wed, 14 Jun 2023 00:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 952046356C;
        Wed, 14 Jun 2023 07:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABDCC433C9;
        Wed, 14 Jun 2023 07:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686726346;
        bh=IqMEz7c0Np+QOZuMhwdSyOS7F3Bi7t3DOS1E8/3rmhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbpee/+5RxzOGbobbjCkXLESv9xAaH5TvkkUJlcyXyH0rQ0hwyo+wU6Bd9y/QKQAf
         Fe5EwlSwXUh8odrfs2oOQa3k6D4PNjcOC0CTUjMGVoRUqj0PL6tKOp5RmSUq0N174d
         icQ+ufHkGA5iTb7Ei5DBnjJsD/qemUt9YL531OngUWprEUKeuxEwY4Sv/E+kIUkLMk
         JtWurvp6vAykHhel3190ofztfPIA+AibvQxykyBRroJMG60Jt0IRlO+2zOCkLkxsAM
         GZBMimDLT9PmnhZYUjBMGIp4HlE0wThWlDcAJvy2G1MDghdGIDt02ANbpHz3DkXN1y
         aWN59AMEHyQQw==
Date:   Wed, 14 Jun 2023 09:05:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Colin Walters <walters@verbum.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Theodore Ts'o <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230614-talent-davor-e447eb7bcd93@brauner>
References: <20230612161614.10302-1-jack@suse.cz>
 <20230612162545.frpr3oqlqydsksle@quack3>
 <2f629dc3-fe39-624f-a2fe-d29eee1d2b82@acm.org>
 <a6c355f7-8c60-4aab-8f0c-5c6310f9c2a8@betaapp.fastmail.com>
 <20230613113448.5txw46hvmdjvuoif@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230613113448.5txw46hvmdjvuoif@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 01:34:48PM +0200, Jan Kara wrote:
> On Mon 12-06-23 14:52:54, Colin Walters wrote:
> > On Mon, Jun 12, 2023, at 1:39 PM, Bart Van Assche wrote:
> > > On 6/12/23 09:25, Jan Kara wrote:
> > >> On Mon 12-06-23 18:16:14, Jan Kara wrote:
> > >>> Writing to mounted devices is dangerous and can lead to filesystem
> > >>> corruption as well as crashes. Furthermore syzbot comes with more and
> > >>> more involved examples how to corrupt block device under a mounted
> > >>> filesystem leading to kernel crashes and reports we can do nothing
> > >>> about. Add config option to disallow writing to mounted (exclusively
> > >>> open) block devices. Syzbot can use this option to avoid uninteresting
> > >>> crashes. Also users whose userspace setup does not need writing to
> > >>> mounted block devices can set this config option for hardening.
> > >>>
> > >>> Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
> > >>> Signed-off-by: Jan Kara <jack@suse.cz>
> > >> 
> > >> Please disregard this patch. I had uncommited fixups in my tree. I'll send
> > >> fixed version shortly. I'm sorry for the noise.
> > >
> > > Have alternatives been configured to making this functionality configurable
> > > at build time only? How about a kernel command line parameter instead of a
> > > config option?
> > 
> > It's not just syzbot here; at least once in my life I accidentally did
> > `dd if=/path/to/foo.iso of=/dev/sda` when `/dev/sda` was my booted disk
> > and not the target USB device.  I know I'm not alone =)
> 
> Yeah, so I'm not sure we are going to protect against this particular case.
> I mean it is not *that* uncommon to alter partition table of /dev/sda while
> /dev/sda1 is mounted. And for the kernel it is difficult to distinguish
> this and your mishap.
> 
> > There's a lot of similar accidental-damage protection from this.  Another
> > stronger argument here is that if one has a security policy that
> > restricts access to filesystem level objects, if a process can somehow
> > write to a mounted block device, it effectively subverts all of those
> > controls. 
> 
> Well, there are multiple levels of protection that I can think of:
> 
> 1) If user can write some image and make kernel mount it.
> 2) If user can modify device content while mounted (but not buffer cache
> of the device).
> 3) If user can modify buffer cache of the device while mounted.
> 
> 3) is the most problematic and effectively equivalent to full machine
> control (executing arbitrary code in kernel mode) these days.  For 1) and
> 2) there are reasonable protection measures the filesystem driver can take
> (and effectively you cannot escape these problems if you allow attaching
> untrusted devices such as USB sticks) so they can cause DoS but we should
> be able to prevent full machine takeover in the filesystem code.
> 
> So this patch is mainly aimed at forbiding 3).
> 
> > Right now it looks to me we're invoking devcgroup_check_permission pretty
> > early on; maybe we could extend the device cgroup stuff to have a new
> > check for write-mounted, like
> > 
> > ```
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index c994ff5b157c..f2af33c5acc1 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -6797,6 +6797,7 @@ enum {
> >  	BPF_DEVCG_ACC_MKNOD	= (1ULL << 0),
> >  	BPF_DEVCG_ACC_READ	= (1ULL << 1),
> >  	BPF_DEVCG_ACC_WRITE	= (1ULL << 2),
> > +	BPF_DEVCG_ACC_WRITE_MOUNTED	= (1ULL << 3),
> >  };
> >  
> >  enum {
> > ```
> > 
> > ?  But probably this would need to be some kind of opt-in flag to avoid
> > breaking existing bpf progs?
> > 
> > If it was configurable via the device cgroup, then it's completely
> > flexible from userspace; most specifically including supporting some
> > specially privileged processes from doing it if necessary.
> 
> I kind of like the flexibility of device cgroups but it does not seem to

Let's not bring in device cgroups here just yet. They're an optional LSM
security measure while your change is more fundamental which is the
right thing to do imho.
