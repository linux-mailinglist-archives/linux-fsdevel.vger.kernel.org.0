Return-Path: <linux-fsdevel+bounces-47561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2690CAA0479
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 09:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3B81B6451A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 07:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA480276048;
	Tue, 29 Apr 2025 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HhbgTS9i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zLGjcyQa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SpArUjJh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e/Q+QaS5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49542741C6
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 07:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745911689; cv=none; b=AHAvPZcFnWHc6z5wfJdvSAMWf4/1JOexDQjhlY48/PjZnkKNSw1Sca1B/lR6FQbTKpUyk0gA620oEEZ0S24CnIxWF6C0lVy9pJmeCs0PBvBB1EjLQJCvYzgSB9J+vuTAt/d12mL6Lk8n6PmGXD/3T1p8yrBNfwjz84zmCKOkTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745911689; c=relaxed/simple;
	bh=46HHIGCzwnNLPpAINs75A8m+fMD3+uz33+iaV8vmgjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKubk2cqqdurelGWBsljdGKcN7roZMek2ixeU42RSwvNivygSCRBnNlwcdX2Cmu5gyiHw4PjcscvsSPsZcQISMCjYWEvzD1A2G8ijsvMM8qOaya63StCRo4tGpUnWC5/lab1M87+BzzIPlzE5X3x+YDvjlGOrgAYDaguoRpnobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HhbgTS9i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zLGjcyQa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SpArUjJh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e/Q+QaS5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F1ACA21C30;
	Tue, 29 Apr 2025 07:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745911686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qn7RezL+ZodhNPZz0XE4F8zD560Td22qMXGm4ahQV1Y=;
	b=HhbgTS9iZ/ZveR6EsfJ+0v8KW9pesTHOmVlkWB3Mn9wNR+Plw9FsfveuOY2h+Pf/0V2ZTZ
	zJXHXkw3avsUOeyXE4nOiNisAnaVHtIHoiY6FkIhBbaGaDWFTi0F9XmFJgDilxVM9Ok2tz
	/VzHuhtsQDetteY/7XQfhBRFCSdB9Ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745911686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qn7RezL+ZodhNPZz0XE4F8zD560Td22qMXGm4ahQV1Y=;
	b=zLGjcyQau3o5t/fSlEsPVia9CsBtIvo797gcHFCITw2aKIAt+LM7rtxu1ZMg1xlcorpsZv
	6MDJQVUBsSo8MVBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745911685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qn7RezL+ZodhNPZz0XE4F8zD560Td22qMXGm4ahQV1Y=;
	b=SpArUjJh55/qe7tZb1aGaFjJRt70ELvKKD5Ha0f10UWBAcnNggkBJ1LOsREnerTlc3MZQL
	iT1wuaElsLWJbRfrK3tLKmjOtlebv89BBJ6zPsw432mxPIOWoMoZ8BVmVH74h1FAqxkXdc
	cVkDIDaAm8wWSV2OI3e/K/mQZKrrObY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745911685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qn7RezL+ZodhNPZz0XE4F8zD560Td22qMXGm4ahQV1Y=;
	b=e/Q+QaS59zd31uC/opKdcty8jJKZoleO8IXouA1gM62sXwgUI34vGlg2sUwkuAA71Gbmag
	xwl71RlCXOieMHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A1391340C;
	Tue, 29 Apr 2025 07:28:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9JIiJIV/EGimcQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 29 Apr 2025 07:28:05 +0000
Message-ID: <044b4684-4b88-4228-9bf6-31491b7738ba@suse.cz>
Date: Tue, 29 Apr 2025 09:28:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] move all VMA allocation, freeing and duplication
 logic to mm
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/28/25 17:28, Lorenzo Stoakes wrote:
> Currently VMA allocation, freeing and duplication exist in kernel/fork.c,
> which is a violation of separation of concerns, and leaves these functions
> exposed to the rest of the kernel when they are in fact internal
> implementation details.
> 
> Resolve this by moving this logic to mm, and making it internal to vma.c,
> vma.h.
> 
> This also allows us, in future, to provide userland testing around this
> functionality.
> 
> We additionally abstract dup_mmap() to mm, being careful to ensure
> kernel/fork.c acceses this via the mm internal header so it is not exposed
> elsewhere in the kernel.
> 
> As part of this change, also abstract initial stack allocation performed in
> __bprm_mm_init() out of fs code into mm via the create_init_stack_vma(), as
> this code uses vm_area_alloc() and vm_area_free().
> 
> In order to do so sensibly, we introduce a new mm/vma_exec.c file, which
> contains the code that is shared by mm and exec. This file is added to both
> memory mapping and exec sections in MAINTAINERS so both sets of maintainers
> can maintain oversight.

Note that kernel/fork.c itself belongs to no section. Maybe we could put it
somewhere too, maybe also multiple subsystems? I'm thinking something
between MM, SCHEDULER, EXEC, perhaps PIDFD?

