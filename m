Return-Path: <linux-fsdevel+bounces-48807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EED94AB4CB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51FC77A78FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 07:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28571F0991;
	Tue, 13 May 2025 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7b2x7UO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584281E9916;
	Tue, 13 May 2025 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121378; cv=none; b=KQrTtDV728+d8IxixVs17q20QPG0s5iuM42PpDEjAzMRecctlegLWMuUUaF2KN6cl7WHQ/AGCgN5KuWVD6ZS7OabpyY/9IDXQBFoq2fWKKpigtWajwhokSWeV84kQKXy3u22cCoIXoO+MDLjjCRbm3yWKI1oSFqcYJSY+xOZ+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121378; c=relaxed/simple;
	bh=zvM9BKDMjiOqjOOat7uxFRXAuGwKutVEom7szpo0S80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHeA/DmFATiZ7guC6louUgYj/8oT3WPbCT+kFE9Hm+xKiKlitOBywuOq/qZ/9AJ1bulKrj2Sv36AmP/iS7HFK+l59omlhVADjn+MXMKXxdfHWZXnst4aVH3DMBhBEb+WaxgWu+mlSZk21uZFg5JcSn05Aid7RMhOS5qIMxNllUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7b2x7UO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA44C4CEE4;
	Tue, 13 May 2025 07:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747121377;
	bh=zvM9BKDMjiOqjOOat7uxFRXAuGwKutVEom7szpo0S80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7b2x7UO1+ZggNwW4RMcLRa6zBnzu7RMfKSk4D00FOL18Sy8by5j1VeYVhNGiDauu
	 zlxwsWm3UmWEjxb7lZeBKZ7k8iB8b3DHr4iPjirtooIJ/GFPpwiX9oI2+hH/Axwm3h
	 4oe/38Z07B4hKzjxmxe+F7uF+b9CGs1/FolArjZBWNQqCp4vYC6HRta1u2j3G6qWqC
	 C1c9j+ET2cXCE3YgOpoZiANyCCyk7UgRC+0RMpYe3EbVU4iFHziZky2mIZbOTRlafQ
	 mWGwDC0koeyFPAmDPqNAl3O8rjJvyrCTc/gQQIy7HXpcVy5MuyLx5zB/dObQDOHNaC
	 ry0g81H82qQYg==
Date: Tue, 13 May 2025 09:29:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/3] mm: introduce new .mmap_prepare() file callback
Message-ID: <20250513-trasse-flugobjekt-22ea7f851118@brauner>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
 <20250512-starren-dannen-12f66d67b4f6@brauner>
 <b33f05e8-9c5b-4be0-977d-005ca525d1db@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b33f05e8-9c5b-4be0-977d-005ca525d1db@lucifer.local>

On Mon, May 12, 2025 at 12:31:34PM +0100, Lorenzo Stoakes wrote:
> On Mon, May 12, 2025 at 11:24:06AM +0200, Christian Brauner wrote:
> > On Fri, May 09, 2025 at 01:13:34PM +0100, Lorenzo Stoakes wrote:
> 
> [snip]
> 
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 016b0fe1536e..e2721a1ff13d 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> 
> [snip]
> 
> > >  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> > >  {
> > > +	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
> > > +		return -EINVAL;
> > > +
> > >  	return file->f_op->mmap(file, vma);
> > >  }
> > >
> > > +static inline int __call_mmap_prepare(struct file *file,
> > > +		struct vm_area_desc *desc)
> > > +{
> > > +	return file->f_op->mmap_prepare(desc);
> > > +}
> >
> > nit: I would prefer if we could rename this to vfs_mmap() and
> > vfs_mmap_prepare() as this is in line with all the other vfs related
> > helpers we expose.
> >
> 
> Happy to do it, but:
> 
> call_mmap() is already invoked in a bunch of places, so kinda falls outside this
> series (+ would touch a bunch of unrelated files), would you mind if I sent that
> separately?

Sure, that's fine.

