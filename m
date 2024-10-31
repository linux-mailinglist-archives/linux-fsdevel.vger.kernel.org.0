Return-Path: <linux-fsdevel+bounces-33336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE759B78AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 11:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C8B285025
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4347199253;
	Thu, 31 Oct 2024 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoA1xBuX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289901940BC;
	Thu, 31 Oct 2024 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370596; cv=none; b=eIA/1Ub2P3vIxU7cuy5PGMZGI8FSxNgr5WJHJKdisu6ac8etEZY1dD5nRbL9vVfqHWuppSQ3IgnEion3MBjFJIce6tFAxIbM+G09bLZiAkgs+vzohTHB5cIXbWury9ixa4LGBiQUQowixsyfCcQDkGxMkQRs3rRtAlLzoJZ8Tvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370596; c=relaxed/simple;
	bh=SqtJyNXRaOIlizsyJ91mqNdbxAV84nTcb7bpYktn3ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ak4nAsMbjJ5godicXTNqqKGTDj2pzFr3yiRL0oic8G95LuRbUPkU5upJXOEmCxBxSM31haLVjDa7P2yMEbOy4bL5AHwbyRvdL0HC8q4toB8cl2eYCSg1jZ12pp42DqoOcnLKJ0+JUxp1uF73Io8ZCdHVCO2Il/XcuF7qAWx6bik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoA1xBuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CEEC4CEC3;
	Thu, 31 Oct 2024 10:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730370596;
	bh=SqtJyNXRaOIlizsyJ91mqNdbxAV84nTcb7bpYktn3ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CoA1xBuXwKgsG3coiyxkwTh9F+nW3VvMkLOSO46I0HYKOixOAIyrUZNts/ktvwgRv
	 KmLTTGKAp1B1/3s5GgDnGG0VmEaAGBOCXly6NZrGhq0uaOpZb3E+YZXnQtPNbium9c
	 b5BBY6JC7UKZxD7PjCbLg+ErP+UcaPMrg1NjXKszXEiK8qdC1HU2RtW/5PilE1K00X
	 k8kCCpMOr5aFkmtCSB2WKrcvfsa03RwUMb/uXGQY/lHjF8dGkMzLaiuDfPRTFC36oJ
	 U6aI4j4IDIDuxahnOL3/o2wuWt/wMBs0jtB6EwT11mXMudLE5Fvu7QAmm/t1tRgkun
	 LWRkwPp+gAUCg==
Date: Thu, 31 Oct 2024 11:29:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Zorro Lang <zlang@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Ian Kent <raven@themaw.net>
Subject: Re: lots of fstests cases fail on overlay with util-linux 2.40.2
 (new mount APIs)
Message-ID: <20241031-ausdehnen-zensur-c7978b7da9a6@brauner>
References: <20241026180741.cfqm6oqp3frvasfm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241028-eigelb-quintessenz-2adca4670ee8@brauner>
 <9f489a85-a2b5-4bd0-98ea-38e1f35fed47@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f489a85-a2b5-4bd0-98ea-38e1f35fed47@sandeen.net>

On Wed, Oct 30, 2024 at 10:48:15PM -0500, Eric Sandeen wrote:
> On 10/28/24 7:22 AM, Christian Brauner wrote:
> > On Sun, Oct 27, 2024 at 02:07:41AM +0800, Zorro Lang wrote:
> >> Hi,
> >>
> >> Recently, I hit lots of fstests cases fail on overlayfs (xfs underlying, no
> >> specific mount options), e.g.
> >>
> >> FSTYP         -- overlay
> >> PLATFORM      -- Linux/s390x s390x-xxxx 6.12.0-rc4+ #1 SMP Fri Oct 25 14:29:18 EDT 2024
> >> MKFS_OPTIONS  -- -m crc=1,finobt=1,rmapbt=0,reflink=1,inobtcount=1,bigtime=1 /mnt/fstests/SCRATCH_DIR
> >> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /mnt/fstests/SCRATCH_DIR /mnt/fstests/SCRATCH_DIR/ovl-mnt
> >>
> >> generic/294       [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//generic/294.out.bad)
> >>     --- tests/generic/294.out	2024-10-25 14:38:32.098692473 -0400
> >>     +++ /var/lib/xfstests/results//generic/294.out.bad	2024-10-25 15:02:34.698605062 -0400
> >>     @@ -1,5 +1,5 @@
> >>      QA output created by 294
> >>     -mknod: SCRATCH_MNT/294.test/testnode: File exists
> >>     -mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
> >>     -touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
> >>     -ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
> >>     +mount: /mnt/fstests/SCRATCH_DIR/ovl-mnt: fsconfig system call failed: overlay: No changes allowed in reconfigure.
> >>     +       dmesg(1) may have more information after failed mount system call.
> > 
> > In the new mount api overlayfs has been changed to reject invalid mount
> > option on remount whereas in the old mount api we just igorned them.
> > If this a big problem then we need to change overlayfs to continue
> > ignoring garbage mount options passed to it during remount.
> > 
> 
> It fails on /any/ overlayfs-specific options during reconfigure, invalid or
> not, right?

Yes.

> 
>         if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
>                 /*
>                  * On remount overlayfs has always ignored all mount
>                  * options no matter if malformed or not so for
>                  * backwards compatibility we do the same here.
>                  */
>                 if (fc->oldapi)
>                         return 0;
>                 
>                 /*
>                  * Give us the freedom to allow changing mount options
>                  * with the new mount api in the future. So instead of
>                  * silently ignoring everything we report a proper
>                  * error. This is only visible for users of the new
>                  * mount api.
>                  */
>                 return invalfc(fc, "No changes allowed in reconfigure");
>         }
> 
>         opt = fs_parse(fc, ovl_parameter_spec, param, &result);
>         if (opt < 0)
>                 return opt; 
> 
> And because today mount(8) will re-specify everything it finds in
> /proc/mounts during remount, presumably that's why all these tests are
> failing - even a simple remount,ro will fail:

The easiest way is to just fallback to the old behavior and continue to
ignore unknown mount options. IOW, ignore my change.

> 
> # mount -t overlay overlay -o lowerdir=lower,upperdir=upper,workdir=work merged
> # strace -e fsconfig mount -o remount,ro merged
> fsconfig(4, FSCONFIG_SET_FLAG, "seclabel", NULL, 0) = 0
> fsconfig(4, FSCONFIG_SET_STRING, "lowerdir", "lower", 0) = -1 EINVAL (Invalid argument)
> ...
> 
> Surely mount -o remount,ro should continue to work for overlayfs when the new
> API is used.
> 
> Maybe there's a third way: accept remount options as long as they match
> current options, but fail if they try to modify anything? Not sure how tricky
> that would be.
> 
> (side note: it's a bit worrisome that there is probably no consistency at
> all across filesystems, here.)

One option would be to add a fsconfig() flag that enforces strict
remount behavior if the filesystem supports it. So it's would become an
opt-in thing.

