Return-Path: <linux-fsdevel+bounces-47786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5BFAA57A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811B41C24465
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC562609D1;
	Wed, 30 Apr 2025 21:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IHKlWHF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D96270ED2;
	Wed, 30 Apr 2025 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746049358; cv=none; b=GcBnGviS+YpmB8FGq10C2OdLamiKgI91d81HJTzJW3lvZ7pWaheVIvZ2NkYIpcIwVou8lAqoP0kQK8h2N91aDVqIDh7wN+dSztVWFPO1GjDKOygbyyhcsi+lHPMoWAJfSv0vCe0ln/cAzWbBnLuh373zQwXI3emQ4ZY3U/xnodU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746049358; c=relaxed/simple;
	bh=k4XAgtgtNwr9oyFp+a3TQG0lb5TNlovWMjxoS8bejdo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DcRczdU8MESAyaHMLFW02vp2LzAHy8Alv2DXWHJy2HpP8KqBPbDJIzvfAX4XJ+jQBFdUcuq9Pmg0a+2jfypNDLTb5orN6PjyfynnB0nysqm3TRR92WSDnN33ChxJN3MPMjfT2q6MJ1KkjugU7x0fpxuN/jtXBMUTNrP4GSWDhe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IHKlWHF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F1DC4CEE7;
	Wed, 30 Apr 2025 21:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746049358;
	bh=k4XAgtgtNwr9oyFp+a3TQG0lb5TNlovWMjxoS8bejdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IHKlWHF/kenWw9YiMtSsyWAvMScIeHKeQzzOtmvITzsFr2DdkjoR4GgWm6qPAliRz
	 vmQDNeJGdbwxMeXxAFa6cwYzS8l0o3nGQop2a/OJGs0oT5HtFU8GbKOwBlMA9XX9g5
	 rml9acqyEdWI8fkqQWvmMPJFDuWPAmb08vJOlENw=
Date: Wed, 30 Apr 2025 14:42:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>, Kees Cook
 <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Suren Baghdasaryan
 <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mm: perform VMA allocation, freeing, duplication
 in mm
Message-Id: <20250430144236.1877ef24177b40cc6a007874@linux-foundation.org>
In-Reply-To: <5edc96cf-4f48-447f-b5a3-7e38679fa3f0@lucifer.local>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
	<f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
	<c1acc2a7-5950-4c56-8429-6dc1c918e367@suse.cz>
	<5edc96cf-4f48-447f-b5a3-7e38679fa3f0@lucifer.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 10:20:10 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Tue, Apr 29, 2025 at 09:22:59AM +0200, Vlastimil Babka wrote:
> > On 4/28/25 17:28, Lorenzo Stoakes wrote:
> > > Right now these are performed in kernel/fork.c which is odd and a violation
> > > of separation of concerns, as well as preventing us from integrating this
> > > and related logic into userland VMA testing going forward, and perhaps more
> > > importantly - enabling us to, in a subsequent commit, make VMA
> > > allocation/freeing a purely internal mm operation.
> >
> > I wonder if the last part is from an earlier version and now obsolete
> > because there's not subsequent commit in this series and the placement of
> > alloc/freeing in vma_init.c seems making those purely internal mm operations
> > already? Or do you mean some further plans?
> >
> 
> Sorry, missed this!
> 
> Andrew - could we delete the last part of this sentence so it reads:
> 
> Right now these are performed in kernel/fork.c which is odd and a violation
> of separation of concerns, as well as preventing us from integrating this
> and related logic into userland VMA testing going forward.

Sure.  The result:

: Right now these are performed in kernel/fork.c which is odd and a
: violation of separation of concerns, as well as preventing us from
: integrating this and related logic into userland VMA testing going
: forward.
: 
: There is a fly in the ointment - nommu - mmap.c is not compiled if
: CONFIG_MMU not set, and neither is vma.c.
: 
: To square the circle, let's add a new file - vma_init.c.  This will be
: compiled for both CONFIG_MMU and nommu builds, and will also form part of
: the VMA userland testing.
: 
: This allows us to de-duplicate code, while maintaining separation of
: concerns and the ability for us to userland test this logic.
: 
: Update the VMA userland tests accordingly, additionally adding a
: detach_free_vma() helper function to correctly detach VMAs before freeing
: them in test code, as this change was triggering the assert for this.


