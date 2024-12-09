Return-Path: <linux-fsdevel+bounces-36754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDABC9E8E82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 10:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FD91886B32
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 09:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0334216393;
	Mon,  9 Dec 2024 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VqN7UVgc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6B121507C;
	Mon,  9 Dec 2024 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735801; cv=none; b=uWFsWrxNqn0nzcRASZ8Wq7pfWlmD4JZNc2BGVQ2VjhUo1EpWJl/wQWVws2a+ymS3Br2ZxL/hsbJW9fYqZl7HhunVzTwu+DrZBqQcyb6WJTxT2upxFUZePYxAxx6V6Mcksqxnky9nxyZ36PelMDtoHJJSFs2FOE4Txr2FvEIwz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735801; c=relaxed/simple;
	bh=6zEI0fnH2MWuOqjTxFluz6Nz7/IcjRdpU/fhK6IB+Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cR22m6RHVuXoXMNPtnCKRqgJWme3Qxx05GETseQ38roIxJc7HY1oplrefGj+KftsulRhlsRODSG0GM4ACUsmpgd9PNLETNEjXnbB1FMtJt7W87QdSX+HjbvaVrmtiXpdi81H3AiAQ74sb0kRhLSPGFJxNge/seml4FH0QcD8oRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VqN7UVgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34CEC4CED1;
	Mon,  9 Dec 2024 09:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733735800;
	bh=6zEI0fnH2MWuOqjTxFluz6Nz7/IcjRdpU/fhK6IB+Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VqN7UVgcmr4Eh3znaBT6L1ZRtnJe+qr2+7PBHClkZwfJY529jzb6GlS91NQyLCdlU
	 hQD3ugUXMnhbYWFZJ6hByVPuGjKdI2B9EJarG7ipAhCFWQ408LKDEjf6NzK/i61i5c
	 e9N2Zm8eYMIlV9uE2mXA0enDXlRy5Yaa+oIYfmMc=
Date: Mon, 9 Dec 2024 10:16:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable <stable@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export
 operations as only supporting file handles
Message-ID: <2024120942-skincare-flanking-ab83@gregkh>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <Z1D2BE2S6FLJ0tTk@infradead.org>
 <CAOQ4uxjPSmrvy44AdahKjzFOcydKN8t=xBnS_bhV-vC+UBdPUg@mail.gmail.com>
 <20241206160358.GC7820@frogsfrogsfrogs>
 <CAOQ4uxgzWZ_X8S6dnWSwU=o5QKR_azq=5fe2Qw8gavLuTOy7Aw@mail.gmail.com>
 <Z1ahFxFtksuThilS@infradead.org>
 <CAOQ4uxiEnEC87pVBhfNcjduHOZWfbEoB8HKVbjNHtkaWA5d-JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiEnEC87pVBhfNcjduHOZWfbEoB8HKVbjNHtkaWA5d-JA@mail.gmail.com>

On Mon, Dec 09, 2024 at 09:58:58AM +0100, Amir Goldstein wrote:
> On Mon, Dec 9, 2024 at 8:49 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sat, Dec 07, 2024 at 09:49:02AM +0100, Amir Goldstein wrote:
> > > > /* file handles can be used by a process on another node */
> > > > #define EXPORT_OP_ALLOW_REMOTE_NODES    (...)
> > >
> > > This has a sound of security which is incorrect IMO.
> > > The fact that we block nfsd export of cgroups does not prevent
> > > any type of userland file server from exporting cgroup file handles.
> >
> > So what is the purpose of the flag?  Asking for a coherent name and
> > description was the other bigger ask for me.
> >
> > > Maybe opt-out of nfsd export is a little less safer than opt-in, but
> > > 1. opt-out is and will remain the rare exception for export_operations
> > > 2. at least the flag name EXPORT_OP_LOCAL_FILE_HANDLE
> > >     is pretty clear IMO
> >
> > Even after this thread I have absolutely no idea what problem it tries
> > to solve.  Maybe that's not just the flag names fault, and not of opt-in
> > vs out, but both certainly don't help.
> >
> > > Plus, as I wrote in another email, the fact that pidfs is SB_NOUSER,
> > > so userspace is not allowed to mount it into the namespace and
> > > userland file servers cannot export the filesystem itself.
> > > That property itself (SB_NOUSER), is therefore a good enough indication
> > > to deny nfsd export of this fs.
> >
> > So check SB_NOUSER in nfsd and be done with it?
> >
> 
> That will work for the new user (pidfs).
> 
> I think SB_KERNMOUNT qualifies as well, because it signifies
> a mount that does not belong to any user's mount namespace.
> 
> For example, tmpfs (shmem) can be exported via nfs, but trying to
> export an anonymous memfd should fail.
> 
> To be clear, exporting pidfs or internal shmem via an anonymous fd is
> probably not possible with existing userspace tools, but with all the new
> mount_fd and magic link apis, I can never be sure what can be made possible
> to achieve when the user holds an anonymous fd.
> 
> The thinking behind adding the EXPORT_OP_LOCAL_FILE_HANDLE flag
> was that when kernfs/cgroups was added exportfs support with commit
> aa8188253474 ("kernfs: add exportfs operations"), there was no intention
> to export cgroupfs over nfs, only local to uses, but that was never enforced,
> so we thought it would be good to add this restriction and backport it to
> stable kernels.
> 
> [CC patch authors]
> 
> I tried to look for some property of cgroupfs that will make it not eligible
> for nfs such as the SB_KERNMOUNT and SB_NOUSER indicators, but
> as far as I can see cgroups looks like any other non-blockdev filesystem.
> 
> Maybe we were wrong about the assumption that cgroupfs should be treated
> specially and deny export cgroups over nfs??

Please don't export any of the "fake" kernel filesystems (configfs,
cgroups, sysfs, debugfs, proc, etc) over nfs please.  That way lies
madness and makes no sense.

thanks,

greg k-h

