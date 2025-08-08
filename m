Return-Path: <linux-fsdevel+bounces-57092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE657B1EA19
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 16:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B82C7A31DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACFD27E07B;
	Fri,  8 Aug 2025 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjK/+29s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D726AC3;
	Fri,  8 Aug 2025 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662436; cv=none; b=IosKWHUYvHhridt/t+snl42ae11/XoYNDHCZbZNvvquJIfCF0ctldIeZXDsMvy+iW/ya5eeRosuzb7vME3yAbmy1KCh5/GNCNCIDzub+cB0QYCX85L+NPhou29UlPTdHnPUOINhFCv8T/faYMnGo64GhsDTNZKdTkh3glt8A8jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662436; c=relaxed/simple;
	bh=9yk04mc+0Ylbce9BjbokKz+Cr6x4aNkv2rGq0+e+Jt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6IjhEysR9MP9seAwF3kAxCYPmdMKh3Korus97PiKg/eTZ6221ET3hsnPHxiVvZheHVKyH0vRMAzSSsqhNWkigrvPR9n0wcLzP1nwfOsvFIgeMtOE2ebSMsdd6pska6Wh19jvAmjVYyIxH0G5pC3+hJh+yMAhFfNKNy1Ro/m5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjK/+29s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C91C4CEF4;
	Fri,  8 Aug 2025 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754662436;
	bh=9yk04mc+0Ylbce9BjbokKz+Cr6x4aNkv2rGq0+e+Jt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NjK/+29sJp+Jh7+L6gRyHXbecq2hI4C0ZzApO6eHPTdMfdxDFR5/cMbwf7g8s/gY4
	 j81ZKJbzsDCzow9mwZNzxBEnLaLUuQofa5/DcgyRWV0vhXBkW/fmgyGtO/Kd8p5rRU
	 z79SkO9wx1cpODEWIkQnDiK7T0aS0ThcmTAu0Fd3hvNsbqkoE8hjBsnJa0fYkhH2ou
	 PP9jbG7Fnrd35u1NQQCY4qylVConsnrnTIVPLdxyoBW5JIDxEIUIQq8H3OS6n5H6U6
	 P6iHBZHwQeP28VGjfvZPd5vznlZE4xPadp534409BKAPtJCatI+1ML3LC5Mgb5ktDd
	 Q3VCfNHzSMBQg==
Date: Fri, 8 Aug 2025 16:13:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Charalampos Mitrodimas <charmitro@posteo.net>, 
	Eric Sandeen <sandeen@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] debugfs: fix mount options not being applied
Message-ID: <20250808-aufrechnung-geizig-a99993c8e8f4@brauner>
References: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
 <a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
 <d6588ae2-0fdb-480d-8448-9c993fdc2563@redhat.com>
 <8734a53cpx.fsf@posteo.net>
 <cf97c467-6391-44df-8ce3-570f533623b8@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf97c467-6391-44df-8ce3-570f533623b8@sandeen.net>

On Wed, Aug 06, 2025 at 11:33:11AM -0500, Eric Sandeen wrote:
> On 8/5/25 12:22 PM, Charalampos Mitrodimas wrote:
> > Eric Sandeen <sandeen@redhat.com> writes:
> > 
> >> On 8/4/25 12:22 PM, Eric Sandeen wrote:
> >>> On 8/4/25 9:30 AM, Charalampos Mitrodimas wrote:
> >>>> Mount options (uid, gid, mode) are silently ignored when debugfs is
> >>>> mounted. This is a regression introduced during the conversion to the
> >>>> new mount API.
> >>>>
> >>>> When the mount API conversion was done, the line that sets
> >>>> sb->s_fs_info to the parsed options was removed. This causes
> >>>> debugfs_apply_options() to operate on a NULL pointer.
> >>>>
> >>>> As an example, with the bug the "mode" mount option is ignored:
> >>>>
> >>>>   $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
> >>>>   $ mount | grep debugfs_test
> >>>>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
> >>>>   $ ls -ld /tmp/debugfs_test
> >>>>   drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test
> >>>
> >>> Argh. So, this looks a lot like the issue that got fixed for tracefs in:
> >>>
> >>> e4d32142d1de tracing: Fix tracefs mount options
> >>>
> >>> Let me look at this; tracefs & debugfs are quite similar, so perhaps
> >>> keeping the fix consistent would make sense as well but I'll dig
> >>> into it a bit more.
> >>
> >> So, yes - a fix following the pattern of e4d32142d1de does seem to resolve
> >> this issue.
> >>
> >> However, I think we might be playing whack-a-mole here (fixing one fs at a time,
> >> when the problem is systemic) among filesystems that use get_tree_single()
> >> and have configurable options. For example, pstore:
> >>
> >> # umount /sys/fs/pstore 
> >>
> >> # mount -t pstore -o kmsg_bytes=65536 none /sys/fs/pstore
> >> # mount | grep pstore
> >> none on /sys/fs/pstore type pstore (rw,relatime,seclabel)
> >>
> >> # mount -o remount,kmsg_bytes=65536 /sys/fs/pstore
> >> # mount | grep pstore
> >> none on /sys/fs/pstore type pstore (rw,relatime,seclabel,kmsg_bytes=65536)
> >> #
> >>
> >> I think gadgetfs most likely has the same problem but I'm not yet sure
> >> how to test that.
> >>
> >> I have no real objection to merging your patch, though I like the
> >> consistency of following e4d32142d1de a bit more. But I think we should
> >> find a graceful solution so that any filesystem using get_tree_single
> >> can avoid this pitfall, if possible.
> > 
> > Hi, thanks for the review, and yes you're right.
> > 
> > Maybe a potential systemic fix would be to make get_tree_single() always
> > call fc->ops->reconfigure() after vfs_get_super() when reusing an
> > existing superblock, fixing all affected filesystems at once.
> 
> Yep, I'm looking into that. mount_single used to do this, and IIRC we discussed
> it before but for some reason opted not to. It seems a bit trickier than I first
> expected, but I might just be dense. ;)

If we can make it work generically, we should. I too don't remember what
the reasons were for not doing it that way.

