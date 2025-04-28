Return-Path: <linux-fsdevel+bounces-47547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1100A9FD85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 01:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F2172166
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 23:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157162135A6;
	Mon, 28 Apr 2025 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KhpSKhcJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5876E15748F;
	Mon, 28 Apr 2025 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881697; cv=none; b=o4siQsOItt8xaAeHuXg1C/sHO0odCc+NgyCBj9XMsI/qOwh259i7XVmRuHoC1vXgKzwSh+7w26VjJYGfCdj7wPPz8lwIldJz77KrCx6oIT4fQlgh5/fdtNwQWkTbDosOi/u4PlfT1GynObQ5EeN1rc+LlJWf2rMC7t4xwVez5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881697; c=relaxed/simple;
	bh=cyGaRLUbBPhSr+SqUrBD2v7h/JKFq6eNGXZvwINMlNU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S9/h873bGtc2mXvwlB253j3FOZ6nOh1shx5ODSUkeBUILxVF+3/HGp41oT7L3BhQrm6mkq6pVFTVsapn8Jy4w/aClHZDIfDJbGms9ipZY74xhoyj8IAGCKygyvqcw9R5aTRK4lRbquaMVaczF0nOVi3ugZpEuzq/jMH/49dZb/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KhpSKhcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C0FC4CEE4;
	Mon, 28 Apr 2025 23:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1745881697;
	bh=cyGaRLUbBPhSr+SqUrBD2v7h/JKFq6eNGXZvwINMlNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KhpSKhcJ6mRifNfGmUMNN/Xv9rawRjL5CiC/TvEkCv8U99vzeBex+4s2mQR+qoxmt
	 U7dE1FpvJ+Ue2kF5pT0SQOA6MBjVt3Ygzy1TuhnITVV26a6PjFCRT5nxdwyj2ynMYy
	 jdsHtR7f0vVJIXPsR5wxrxqNrsl620eSlGQssI9g=
Date: Mon, 28 Apr 2025 16:08:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, David Hildenbrand
 <david@redhat.com>, Kees Cook <kees@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mm: establish mm/vma_exec.c for shared exec/mm
 VMA functionality
Message-Id: <20250428160816.3a22676dacd34055fd2568b7@linux-foundation.org>
In-Reply-To: <80f0d0c6-0b68-47f9-ab78-0ab7f74677fc@lucifer.local>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
	<91f2cee8f17d65214a9d83abb7011aa15f1ea690.1745853549.git.lorenzo.stoakes@oracle.com>
	<p7nijnmkjljnevxdizul2iczzk33pk7o6rjahzm6wceldfpaom@jdj7o4zszgex>
	<CAJuCfpHomWFOGhwBH8e+14ayKMf8VGKapLP1QBbZ_fumMPN1Eg@mail.gmail.com>
	<80f0d0c6-0b68-47f9-ab78-0ab7f74677fc@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 21:26:29 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Andrew - I typo'd /* vma_exec.h */ below in the change to mm/vma.h - would it be
> possible to correct to vma_exec.c, or would a fixpatch make life easier?
> 

I did this:

--- a/mm/vma.h~mm-establish-mm-vma_execc-for-shared-exec-mm-vma-functionality-fix
+++ a/mm/vma.h
@@ -548,7 +548,7 @@ int expand_downwards(struct vm_area_stru
 
 int __vm_munmap(unsigned long start, size_t len, bool unlock);
 
-/* vma_exec.h */
+/* vma_exec.c */
 #ifdef CONFIG_MMU
 int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
 #endif
_


