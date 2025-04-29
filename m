Return-Path: <linux-fsdevel+bounces-47619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B31AA12D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 18:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DC918879F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 16:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3367A2512DE;
	Tue, 29 Apr 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYga2AQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D4250BFE;
	Tue, 29 Apr 2025 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945722; cv=none; b=gEYlq17psbOQZl0MPEbYE5QTceLaneb2MECIdfE+id4aOiGuViBOBIQizRR00/hymGKZZdO/VWvZ7zR++I8oTOUPlLztkz+ON2bWMHzMRAYIgezW0OcO34YqxZW7YIrOefuaf5rXd98ehiuYQTAOCoOkBA9FPcP34a/BgZcZuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945722; c=relaxed/simple;
	bh=zOfFyoWEGxCDaELYIHhgqtimzYsmJUad3XFMv+J9Gww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrcSHM3HMr3nlQT2oJUTLF6I2DQ1guAosaWzxLYiitEc0H2T6tC/cv8UCa/STApHDL2DAZBNmaoIoJvWCJKBxuNr4d6L5QA0BXRsoViuha2xRu8hGrG487wFFCaIT+u4BEG5VpaXp4mnRu5sfjR9ePpAKvp5Hyn1iXcXkvJss28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYga2AQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EF4C4CEE3;
	Tue, 29 Apr 2025 16:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745945722;
	bh=zOfFyoWEGxCDaELYIHhgqtimzYsmJUad3XFMv+J9Gww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYga2AQ/n5CMnGfLO0FrGw4hYy0VS9DZAsGKM8g3JMDjgTvyqNtaCRzsd86TIL2tl
	 LMq5LcvAYc1YEiGMhkue/+b6Nz7EChrQhsPzOnTdbUDGhtPC7ZjUe9Q7VAU5ufb9qF
	 EmQByFib7oHXtw1nYB33UXQXD/IJxGTiuNjzHsrqV0drlM/NwrBG1fk4pvaq+Ch4Nz
	 5B12gH/ch0V0XfCs+y6OBJnjld6CMqzRQOC3X7yEyLFe/i7y5Ox/jwVVlgKMkn4Z/4
	 GJlzvH5StU9voS8WmcFy9X3YqP2460VMS67lyI3O+uMdhEdoulaiIw5x0UWFRKKue8
	 usES8/yRhdO2g==
Date: Tue, 29 Apr 2025 09:55:19 -0700
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] move all VMA allocation, freeing and duplication
 logic to mm
Message-ID: <202504290954.C391C2B@keescook>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <044b4684-4b88-4228-9bf6-31491b7738ba@suse.cz>
 <e5564971-b632-4619-829e-342cdad02e25@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5564971-b632-4619-829e-342cdad02e25@lucifer.local>

On Tue, Apr 29, 2025 at 11:23:25AM +0100, Lorenzo Stoakes wrote:
> On Tue, Apr 29, 2025 at 09:28:05AM +0200, Vlastimil Babka wrote:
> > On 4/28/25 17:28, Lorenzo Stoakes wrote:
> > > Currently VMA allocation, freeing and duplication exist in kernel/fork.c,
> > > which is a violation of separation of concerns, and leaves these functions
> > > exposed to the rest of the kernel when they are in fact internal
> > > implementation details.
> > >
> > > Resolve this by moving this logic to mm, and making it internal to vma.c,
> > > vma.h.
> > >
> > > This also allows us, in future, to provide userland testing around this
> > > functionality.
> > >
> > > We additionally abstract dup_mmap() to mm, being careful to ensure
> > > kernel/fork.c acceses this via the mm internal header so it is not exposed
> > > elsewhere in the kernel.
> > >
> > > As part of this change, also abstract initial stack allocation performed in
> > > __bprm_mm_init() out of fs code into mm via the create_init_stack_vma(), as
> > > this code uses vm_area_alloc() and vm_area_free().
> > >
> > > In order to do so sensibly, we introduce a new mm/vma_exec.c file, which
> > > contains the code that is shared by mm and exec. This file is added to both
> > > memory mapping and exec sections in MAINTAINERS so both sets of maintainers
> > > can maintain oversight.
> >
> > Note that kernel/fork.c itself belongs to no section. Maybe we could put it
> > somewhere too, maybe also multiple subsystems? I'm thinking something
> > between MM, SCHEDULER, EXEC, perhaps PIDFD?
> 
> Thanks, indeed I was wondering about where this should be, and the fact we can
> put stuff in multiple places is actually pretty powerful!
> 
> This is on my todo, will take a look at this.

Yeah, I'd be interested in having fork.c multi-maintainer-sectioned with
EXEC/BINFMT too, when the time comes.

-- 
Kees Cook

