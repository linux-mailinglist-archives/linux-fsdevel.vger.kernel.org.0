Return-Path: <linux-fsdevel+bounces-67211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEB8C380F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 22:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3B704E6C71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 21:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3992DECCB;
	Wed,  5 Nov 2025 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml0XQbcG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FFC2DF141;
	Wed,  5 Nov 2025 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378736; cv=none; b=AFWStp95yejFRX2C+Xjr+vRt0UKaiQBE7805I6SSahDNhe/vGiWn5du4ArPz+RxlSC7tcTHAeNOPGZumUUegErlVGbgc/mK43U2mRSScvIZIlyDGkdIr73en7WmcTZTyny0lBJvVilWXnGvSFTNL4WeQ3Irh88a49Km0Ki0DX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378736; c=relaxed/simple;
	bh=xfMxF7RJqMp/U35x5Qb8xJcQ59UFp9oCFcL0rXtzeXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmLX5Qj/F/XFT4NfBsp8bArabXOn8CS2dDl/7fhIuGVlWz5R7CEfSoNF1oll4gpcsNywugpcdmlJWjsj6Dceyk83VquD1OTWQJNrxZ8pW/lI5Qdz0AuGTgpKgVuZYJMPQDvLmJviTsMQ0jlduQKgTagbdg2LRRPHBbVr1fygrco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml0XQbcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFE1C4CEF5;
	Wed,  5 Nov 2025 21:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762378736;
	bh=xfMxF7RJqMp/U35x5Qb8xJcQ59UFp9oCFcL0rXtzeXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ml0XQbcGGuiLwCLdDg8r53j5HzYL33Ao6m9BgkSJEMxiXiwQK4LeuWa2yW0qkgNRG
	 WhlKlC15hOYLvUb9Czfxs9ZMT2S7tHNgQ2k+y7KRuHXEQvYVK4DRpJmGKO5DJHYPuM
	 FvO8OWn3R2Hkv5jM8ryWES+16LO5sX6bZ1HCw8/9BK7V5o6jZMjlKFO5+5Z/TtEVqZ
	 FNhabcqCcqj4Ku0v6hJ/Ny9IB+FYM5ykLQTqBXVVkSWkui1buygjE+iK0eYvcAjZUQ
	 0IPETHH++vovZljs250Mb9rZ7tZJ5h9Mqi/n81lxoiBlUFgvMlcmGqO+qF9H7kJFcS
	 66QIVhHaP0vZw==
Date: Wed, 5 Nov 2025 13:38:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Luis Henriques <luis@igalia.com>, Bernd Schubert <bernd@bsbernd.com>,
	Theodore Ts'o <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>,
	Matt Harvey <mharvey@jumptrading.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
Message-ID: <20251105213855.GL196362@frogsfrogsfrogs>
References: <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
 <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
 <20250916025341.GO1587915@frogsfrogsfrogs>
 <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
 <87ldkm6n5o.fsf@wotan.olymp>
 <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
 <87cy5x7sud.fsf@wotan.olymp>
 <CAOQ4uxjZ0B5TwV+HiWsUpBuFuZJZ_e4Bm_QfNn4crDoVAfkA9Q@mail.gmail.com>
 <87ecqcpujw.fsf@wotan.olymp>
 <CAOQ4uxg+w5LHnVbYGLc_pq+zfAw5UXbfo0M2=dxFGKLmBvJ+5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg+w5LHnVbYGLc_pq+zfAw5UXbfo0M2=dxFGKLmBvJ+5Q@mail.gmail.com>

On Wed, Nov 05, 2025 at 04:30:51PM +0100, Amir Goldstein wrote:
> On Wed, Nov 5, 2025 at 12:50 PM Luis Henriques <luis@igalia.com> wrote:
> >
> > Hi Amir,
> >
> > On Wed, Nov 05 2025, Amir Goldstein wrote:
> >
> > > On Tue, Nov 4, 2025 at 3:52 PM Luis Henriques <luis@igalia.com> wrote:
> >
> > <...>
> >
> > >> > fuse_entry_out was extended once and fuse_reply_entry()
> > >> > sends the size of the struct.
> > >>
> > >> So, if I'm understanding you correctly, you're suggesting to extend
> > >> fuse_entry_out to add the new handle (a 'size' field + the actual handle).
> > >
> > > Well it depends...
> > >
> > > There are several ways to do it.
> > > I would really like to get Miklos and Bernd's opinion on the preferred way.
> >
> > Sure, all feedback is welcome!
> >
> > > So far, it looks like the client determines the size of the output args.
> > >
> > > If we want the server to be able to write a different file handle size
> > > per inode that's going to be a bigger challenge.
> > >
> > > I think it's plenty enough if server and client negotiate a max file handle
> > > size and then the client always reserves enough space in the output
> > > args buffer.
> > >
> > > One more thing to ask is what is "the actual handle".
> > > If "the actual handle" is the variable sized struct file_handle then
> > > the size is already available in the file handle header.
> >
> > Actually, this is exactly what I was trying to mimic for my initial
> > attempt.  However, I was not going to do any size negotiation but instead
> > define a maximum size for the handle.  See below.
> >
> > > If it is not, then I think some sort of type or version of the file handles
> > > encoding should be negotiated beyond the max handle size.
> >
> > In my initial stab at this I was going to take a very simple approach and
> > hard-code a maximum size for the handle.  This would have the advantage of
> > allowing the server to use different sizes for different inodes (though
> > I'm not sure how useful that would be in practice).  So, in summary, I
> > would define the new handle like this:
> >
> > /* Same value as MAX_HANDLE_SZ */
> > #define FUSE_MAX_HANDLE_SZ 128
> >
> > struct fuse_file_handle {
> >         uint32_t        size;
> >         uint32_t        padding;
> 
> I think that the handle type is going to be relevant as well.
> 
> >         char            handle[FUSE_MAX_HANDLE_SZ];
> > };
> >
> > and this struct would be included in fuse_entry_out.
> >
> > There's probably a problem with having this (big) fixed size increase to
> > fuse_entry_out, but maybe that could be fixed once I have all the other
> > details sorted out.  Hopefully I'm not oversimplifying the problem,
> > skipping the need for negotiating a handle size.
> >
> 
> Maybe this fixed size is reasonable for the first version of FUSE protocol
> as long as this overhead is NOT added if the server does not opt-in for the
> feature.
> 
> IOW, allow the server to negotiate FUSE_MAX_HANDLE_SZ or 0,
> but keep the negotiation protocol extendable to another value later on.
> 
> > >> That's probably a good idea.  I was working towards having the
> > >> LOOKUP_HANDLE to be similar to LOOKUP, but extending it so that it would
> > >> include:
> > >>
> > >>  - An extra inarg: the parent directory handle.  (To be honest, I'm not
> > >>    really sure this would be needed.)
> > >
> > > Yes, I think you need extra inarg.
> > > Why would it not be needed?
> > > The problem is that you cannot know if the parent node id in the lookup
> > > command is stale after server restart.
> >
> > Ah, of course.  Hence the need for this extra inarg.
> >
> > > The thing is that the kernel fuse inode will need to store the file handle,
> > > much the same as an NFS client stores the file handle provided by the
> > > NFS server.
> > >
> > > FYI, fanotify has an optimized way to store file handles in
> > > struct fanotify_fid_event - small file handles are stored inline
> > > and larger file handles can use an external buffer.
> > >
> > > But fuse does not need to support any size of file handles.
> > > For first version we could definitely simplify things by limiting the size
> > > of supported file handles, because server and client need to negotiate
> > > the max file handle size anyway.
> >
> > I'll definitely need to have a look at how fanotify does that.  But I
> > guess that if my simplistic approach with a static array is acceptable for
> > now, I'll stick with it for the initial attempt to implement this, and
> > eventually revisit it later to do something more clever.
> >
> 
> What you proposed is the extension of fuse_entry_out for fuse
> protocol.
> 
> My reference to fanotify_fid_event is meant to explain how to encode
> a file handle in fuse_inode in cache, because the fuse_inode_cachep
> cannot have variable sized inodes and in most of the cases, a short
> inline file handle should be enough.
> 
> Therefore, if you limit the support in the first version to something like
> FANOTIFY_INLINE_FH_LEN, you can always store the file handle
> in fuse_inode and postpone support for bigger file handles to later.

I suggest that you also provide a way for the fuse server to tell the
kernel that it can construct its own handles from {fuse_inode::nodeid,
inode::i_generation} if they want something more efficient than
uploading 128b blobs.

--D

> Thanks,
> Amir.
> 

