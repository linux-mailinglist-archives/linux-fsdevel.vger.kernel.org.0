Return-Path: <linux-fsdevel+bounces-52749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C3CAE6321
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9334E3A650D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F57286D5C;
	Tue, 24 Jun 2025 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHvAU3tK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BBC218ABA;
	Tue, 24 Jun 2025 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762771; cv=none; b=byv50EAGgbAsYmnpG9Frsfw6mXIG9HEEu2dseerRBKGiJ+edKQo7ocsPxbV39yRGKJddFjnFhvOkcZ4eBUh4hun1ZXX44FHwwYyZjQ34UE8zqCkq6sJv9zp6uLz2HMGUuIEyLvnq2neE2Su9Xgdai3YpDexKAGAXZsGA2m6ljcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762771; c=relaxed/simple;
	bh=IV3WwRjZHcE8gAqnRRFUKQT4hQrsnjRFFGHpcUVFJSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGwhYWvMsJNCSgpOUplu+AjxJ7o/c+CUugGWyR1eQnuLSurN3ZexTWAimt0bVCXzRJoklkybd/NydivaNWJHKVcbmGoW2l/nIGWbIojA1btPLgj1ocU62qtunUZ1DCXkEauX6cSBqP3u9QoXd+d9ApQ8Joa5gruE4AtBgsmCqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHvAU3tK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBE0C4CEE3;
	Tue, 24 Jun 2025 10:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750762770;
	bh=IV3WwRjZHcE8gAqnRRFUKQT4hQrsnjRFFGHpcUVFJSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AHvAU3tKJVhbtKuel50dUrV8Pgmki5qT0fqyex6PADV8M/y6Vxg6SD0uKESkvyky+
	 qyj7KvsG1gU+i3Md1xGf/yHkxF/+NsRfZ3I5X5GbS5L6tI+yrpJfWDnqkKerDxBGZ0
	 uvywzINuUbrcjDlcStfrLZ6oj0khgpT/Nbqy67dR/jdG0VkGDo7r5WJYgMGbA0JUjv
	 W8ckqccHMyNxtsf0a0lqvohb+CK2OeqYXe5xu1Xch/IsiTVeguCdsxrNY67CD6SdSw
	 Ml0pOHTVasB52jPhIYqeE/fOzGQZcYb2/k7/zpJbT7PhM9pcz6LjMuc7a/I8hs4aF9
	 FcmXIBffQ7Zpw==
Date: Tue, 24 Jun 2025 12:59:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable@kernel.org
Subject: Re: [PATCH v2 00/11] fhandle, pidfs: allow open_by_handle_at()
 purely based on file handle
Message-ID: <20250624-teestube-noten-cbe0aa9542e1@brauner>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>

> For pidfs this means a file handle can function as full replacement for
> storing a pid in a file. Instead a file handle can be stored and
> reopened purely based on the file handle.

One thing I want to comment on generally. I know we document that a file
handle is an opaque thing and userspace shouldn't rely on the layout or
format (Propably so that we're free to redefine it.).

Realistically though that's just not what's happening. I've linked Amir
to that code already a few times but I'm doing it here for all of you
again:

[1]: https://github.com/systemd/systemd/blob/7e1647ae4e33dd8354bd311a7f7f5eb701be2391/src/basic/cgroup-util.c#L62-L77

     Specifically:
     
     /* The structure to pass to name_to_handle_at() on cgroupfs2 */
     typedef union {
             struct file_handle file_handle;
             uint8_t space[offsetof(struct file_handle, f_handle) + sizeof(uint64_t)];
     } cg_file_handle;
     
     #define CG_FILE_HANDLE_INIT                                     \
             (cg_file_handle) {                                      \
                     .file_handle.handle_bytes = sizeof(uint64_t),   \
                     .file_handle.handle_type = FILEID_KERNFS,       \
             }
     
     #define CG_FILE_HANDLE_CGROUPID(fh) (*CAST_ALIGN_PTR(uint64_t, (fh).file_handle.f_handle))
     
     cg_file_handle fh = CG_FILE_HANDLE_INIT;
     CG_FILE_HANDLE_CGROUPID(fh) = id;
     
     return RET_NERRNO(open_by_handle_at(cgroupfs_fd, &fh.file_handle, O_DIRECTORY|O_CLOEXEC));

Another example where the layout is assumed to be uapi/uabi is:

[2]: https://github.com/systemd/systemd/blob/7e1647ae4e33dd8354bd311a7f7f5eb701be2391/src/basic/pidfd-util.c#L232-L259

     int pidfd_get_inode_id_impl(int fd, uint64_t *ret) {
     <snip>
                     union {
                             struct file_handle file_handle;
                             uint8_t space[offsetof(struct file_handle, f_handle) + sizeof(uint64_t)];
                     } fh = {
                             .file_handle.handle_bytes = sizeof(uint64_t),
                             .file_handle.handle_type = FILEID_KERNFS,
                     };
                     int mnt_id;
     
                     r = RET_NERRNO(name_to_handle_at(fd, "", &fh.file_handle, &mnt_id, AT_EMPTY_PATH));
                     if (r >= 0) {
                             if (ret)
                                     *ret = *CAST_ALIGN_PTR(uint64_t, fh.file_handle.f_handle);
                             return 0;
                     }
     
In (1) you can see that the layout is assumed to be uabi by
reconstructing the handle. In (2) you can see that the layout is assumed
to be uabi by extrating the inode number.

So both points mean that the "don't rely on it"-ship has already sailed.
If we get regressions reports for this (and we surely would) because we
changed it we're bound by the no-regression rule.

So, for pidfs I'm very tempted to explicitly give the guarantee that
systemd just assumes currently.

The reason is that it will allow userspace to just store the 64-bit
pidfs inode number in a file or wherever they want and then reconstruct
the file handle without ever having to involve name_to_handle_at(). That
means you can just read the pid file and see the inode number you're
dealing with and not some binary gunk.

