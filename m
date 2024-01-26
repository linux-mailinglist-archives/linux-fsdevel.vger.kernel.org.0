Return-Path: <linux-fsdevel+bounces-9108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D0083E3E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6B2B22025
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 21:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC1824A09;
	Fri, 26 Jan 2024 21:27:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA95250E2;
	Fri, 26 Jan 2024 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304447; cv=none; b=EZJIsK2ssxE5an0ufuCuEj2N1tBGMuK+7i15+3N3LVV6l3/soAABcA/oVLHv1apxGwDjGGeOBGlMycugvOLqGuJi1pOrDXgddWwUhvyDqHRTn+JllOUEdY+Vtq92gkuU8OoFhoq9F6qpJjO7hcnMT4LuEkZ8ItpR8R4L62ycCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304447; c=relaxed/simple;
	bh=0Ibpzu52pa7xZyWfPXdiBU7biXDc1fNDD9XSBAy9kds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0j8c/tPAdQvXWFgt5vJJbucRTotxyjt3giIfdI6DfFhGsDlFQE1ScnBN9Tfk8agsQcuJvz8PxqgTKq9tzlaTYrMh1KOogcO/ZIfVBnEJVte9HHG+HO8LAB7ehGpEXUDWd5PFrzjhtfBmDuvw7ji8sUWkK3ZrsUsGxSPGswzFDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A4BC433F1;
	Fri, 26 Jan 2024 21:27:25 +0000 (UTC)
Date: Fri, 26 Jan 2024 16:27:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Christian Brauner <brauner@kernel.org>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [RESEND] [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240126162728.786e56dd@gandalf.local.home>
In-Reply-To: <e3548c86-7422-432c-8b72-8de99fa9772f@efficios.com>
References: <20240126151251.74cb9285@gandalf.local.home>
	<e3548c86-7422-432c-8b72-8de99fa9772f@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 15:24:17 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-01-26 15:12, Steven Rostedt wrote:
> [...]
> > diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> > index e1b172c0e091..2187be6d7b23 100644
> > --- a/fs/tracefs/inode.c
> > +++ b/fs/tracefs/inode.c
> > @@ -223,13 +223,41 @@ static const struct inode_operations tracefs_file_inode_operations = {
> >   	.setattr	= tracefs_setattr,
> >   };
> >   
> > +/* Copied from get_next_ino() but adds allocation for multiple inodes */
> > +#define LAST_INO_BATCH 1024
> > +#define LAST_INO_MASK (~(LAST_INO_BATCH - 1))
> > +static DEFINE_PER_CPU(unsigned int, last_ino);
> > +
> > +unsigned int tracefs_get_next_ino(int files)
> > +{
> > +	unsigned int *p = &get_cpu_var(last_ino);
> > +	unsigned int res = *p;
> > +
> > +#ifdef CONFIG_SMP
> > +	/* Check if adding files+1 overflows */  
> 
> How does it handle a @files input where:
> 
> * (files+1 > LAST_INO_BATCH) ?
> 
> * (files+1 == LAST_INO_BATCH) ?

Well, this is moot anyway, as Linus hates it.

-- Steve

