Return-Path: <linux-fsdevel+bounces-47616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52630AA12A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 18:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DCD1BA46A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582722528E8;
	Tue, 29 Apr 2025 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0fkmEwu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ADA2512D9;
	Tue, 29 Apr 2025 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945648; cv=none; b=bfLwmJ7HvD+QB1FIIp2ifQLm+/+MQF7QA8J1CRSK1jZdRj+WGYXOh3AxETk6T6tPrMwUcKu5CwJPlLR2y+WJFbK3u4WW6G5/C578oLKQiDjwIjZTpmSgEm+15e6Tw5m+Ob8Qc2M0qvz0V/m6sTe0BG66vjPFnVQElL8q+HBzuEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945648; c=relaxed/simple;
	bh=9EpGsEydVO4ujP3VhHPeJjQ0b0EshPfB4gOYpmpqVbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UADGiFessVLUIUPr9F1madSVgwtbMesZTtzMs7pfeBuNyHcyZ2IQW3CD9mqrBbCKp/fU1yX1NxGyKGtJxAXdHDEMh/m5tasl7InoLel8O+pt5KIYjtZkwjLmIXj9m6oWcAq2gVfIg47H6Ev52stPeE54oOBe4/hcvB6U1ABTJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0fkmEwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7BCC4CEE3;
	Tue, 29 Apr 2025 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745945648;
	bh=9EpGsEydVO4ujP3VhHPeJjQ0b0EshPfB4gOYpmpqVbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0fkmEwucjzGJrbCZcqAz9g9wpYGiz9/6Mf5/Mm+tz+iJC7GxmMXZTKbJDxv/gX4x
	 djEbPCk0DVuSOxASTbYWccPSVrzDAGMZQlIEHWaTgVcRCKwOhT9zhptJImI+vgy6oG
	 GF20Zpaiss+p57IsbfhZ6iOGVHDv6GTJD0iSJjdjxf5Zkh352IDP0RmN4kGyjXS2ly
	 ZacVNWLXVa30JYuTuBR7ukIIP0XqCBtOFq4Tx3LHAiJqtACL1GaqLQmsiK25eUQHfu
	 Q/NX2ktzM2vNbYmHKzHzq1UyK75W87hwtLVnd70q8nDKQrsFGH3hoovsRk1GJrQCHE
	 QXWaB+qxw6Frg==
Date: Tue, 29 Apr 2025 09:54:04 -0700
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mm: abstract initial stack setup to mm subsystem
Message-ID: <202504290954.EE741AB@keescook>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <118c950ef7a8dd19ab20a23a68c3603751acd30e.1745853549.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <118c950ef7a8dd19ab20a23a68c3603751acd30e.1745853549.git.lorenzo.stoakes@oracle.com>

On Mon, Apr 28, 2025 at 04:28:15PM +0100, Lorenzo Stoakes wrote:
> There are peculiarities within the kernel where what is very clearly mm
> code is performed elsewhere arbitrarily.
> 
> This violates separation of concerns and makes it harder to refactor code
> to make changes to how fundamental initialisation and operation of mm logic
> is performed.
> 
> One such case is the creation of the VMA containing the initial stack upon
> execve()'ing a new process. This is currently performed in __bprm_mm_init()
> in fs/exec.c.
> 
> Abstract this operation to create_init_stack_vma(). This allows us to limit
> use of vma allocation and free code to fork and mm only.
> 
> We previously did the same for the step at which we relocate the initial
> stack VMA downwards via relocate_vma_down(), now we move the initial VMA
> establishment too.
> 
> Take the opportunity to also move insert_vm_struct() to mm/vma.c as it's no
> longer needed anywhere outside of mm.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

