Return-Path: <linux-fsdevel+bounces-52785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BDAAE69A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 16:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7404E3E08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD442D8781;
	Tue, 24 Jun 2025 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKpepzvh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E2F2DCBF1;
	Tue, 24 Jun 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775952; cv=none; b=LuJ3NKoXL5aVqD4Rt9TRu71LQKBElhP7lPjRezchSTe40wtFHZdsGkhB9DHdkOwaG9BBiIVflpqX2FaLDC/9vcya1nEOLh3aC2V98jnVvGetY2PJ5H3a7+wJuAivk/WTT5ttQxF7QRgNtOe5TwYYMtdlxd14IvPcNf0lx+zlNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775952; c=relaxed/simple;
	bh=z76iv0nNJ5PETesVfYfk1aAg2R+D7gwgjnhHev+Ylug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ig3eBl7qDsGH884itdFZNDXrRKlDjGlgWWN6a5ftzpKU+mbgWTUOaKTLNbi0HqvxQyR9zjYDwydmTtqn6HUl1DSSf3WMIWoU3FVWSoOX+wruXvwMwQ3ashjsmUujtnFPTIz/qCo0RK4z+sExN261pnxYKg+V3YmH7xnpcXLqXsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKpepzvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FE7C4CEE3;
	Tue, 24 Jun 2025 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750775952;
	bh=z76iv0nNJ5PETesVfYfk1aAg2R+D7gwgjnhHev+Ylug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKpepzvhlGXeMCocz+3AHfZjYD596UktSZmpXdkexWX/wjYDYoG4EnWm/eqaz67nd
	 iL9neHaSygjGpHWPP3xa4C7PS1GzM6XxZ8JwV7nAty7f10M9Gc6vi8hptZhhVl0K1d
	 arzTYiRavqCdiMvMFDh6VTTLGTROXqdyXUjXDk0oV4tVJWD2omC6kI0CURxcXdJnco
	 HQ+gTEUulVEowkC0r00WWTWqBqgGVGZiLtVVi8IwBQLXKwA5Wdj4aL8Mzh/wMTPqn+
	 uU9eSk5/jcCgPpeh1cxTsm9wnpjjW6iHiYGvq3Od9qfm8YY2qT1HbwqrNYyXku9iQQ
	 s+oCIuaQHKdYw==
Date: Tue, 24 Jun 2025 16:39:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH v2 00/11] fhandle, pidfs: allow open_by_handle_at()
 purely based on file handle
Message-ID: <20250624-dubios-dissident-128110e328d3@brauner>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-teestube-noten-cbe0aa9542e1@brauner>
 <z4gavwmwinr6me7ufmwk7y6vi7jfwwbv5bksrk4v4saochb3va@zxchg3jqz2x4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <z4gavwmwinr6me7ufmwk7y6vi7jfwwbv5bksrk4v4saochb3va@zxchg3jqz2x4>

On Tue, Jun 24, 2025 at 04:15:37PM +0200, Jan Kara wrote:
> On Tue 24-06-25 12:59:26, Christian Brauner wrote:
> > > For pidfs this means a file handle can function as full replacement for
> > > storing a pid in a file. Instead a file handle can be stored and
> > > reopened purely based on the file handle.
> > 
> > One thing I want to comment on generally. I know we document that a file
> > handle is an opaque thing and userspace shouldn't rely on the layout or
> > format (Propably so that we're free to redefine it.).
> > 
> > Realistically though that's just not what's happening. I've linked Amir
> > to that code already a few times but I'm doing it here for all of you
> > again:
> > 
> > [1]: https://github.com/systemd/systemd/blob/7e1647ae4e33dd8354bd311a7f7f5eb701be2391/src/basic/cgroup-util.c#L62-L77
> > 
> >      Specifically:
> >      
> >      /* The structure to pass to name_to_handle_at() on cgroupfs2 */
> >      typedef union {
> >              struct file_handle file_handle;
> >              uint8_t space[offsetof(struct file_handle, f_handle) + sizeof(uint64_t)];
> >      } cg_file_handle;
> >      
> >      #define CG_FILE_HANDLE_INIT                                     \
> >              (cg_file_handle) {                                      \
> >                      .file_handle.handle_bytes = sizeof(uint64_t),   \
> >                      .file_handle.handle_type = FILEID_KERNFS,       \
> >              }
> >      
> >      #define CG_FILE_HANDLE_CGROUPID(fh) (*CAST_ALIGN_PTR(uint64_t, (fh).file_handle.f_handle))
> >      
> >      cg_file_handle fh = CG_FILE_HANDLE_INIT;
> >      CG_FILE_HANDLE_CGROUPID(fh) = id;
> >      
> >      return RET_NERRNO(open_by_handle_at(cgroupfs_fd, &fh.file_handle, O_DIRECTORY|O_CLOEXEC));
> > 
> > Another example where the layout is assumed to be uapi/uabi is:
> > 
> > [2]: https://github.com/systemd/systemd/blob/7e1647ae4e33dd8354bd311a7f7f5eb701be2391/src/basic/pidfd-util.c#L232-L259
> > 
> >      int pidfd_get_inode_id_impl(int fd, uint64_t *ret) {
> >      <snip>
> >                      union {
> >                              struct file_handle file_handle;
> >                              uint8_t space[offsetof(struct file_handle, f_handle) + sizeof(uint64_t)];
> >                      } fh = {
> >                              .file_handle.handle_bytes = sizeof(uint64_t),
> >                              .file_handle.handle_type = FILEID_KERNFS,
> >                      };
> >                      int mnt_id;
> >      
> >                      r = RET_NERRNO(name_to_handle_at(fd, "", &fh.file_handle, &mnt_id, AT_EMPTY_PATH));
> >                      if (r >= 0) {
> >                              if (ret)
> >                                      *ret = *CAST_ALIGN_PTR(uint64_t, fh.file_handle.f_handle);
> >                              return 0;
> >                      }
> 
> Thanks for sharing. Sigh... Personal note for the future: If something
> should be opaque blob for userspace, don't forget to encrypt the data
> before handing it over to userspace. :-P

Yeah, honestly, that's what we should probably do. Use some hash
function or something.

