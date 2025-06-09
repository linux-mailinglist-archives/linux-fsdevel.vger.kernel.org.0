Return-Path: <linux-fsdevel+bounces-51007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E862AD1B61
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 12:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58DC37A4284
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6242253931;
	Mon,  9 Jun 2025 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="11zMFZTr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+q5k/oef";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TZJRvWOL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6Xknxy53"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D87525334B
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749464334; cv=none; b=kO84QECJnTYF35YII1gN/97/nMOl/nnApHDsPFiINnvClhCQ6J+LQfQCLiQFx6hGm63YqAy6KPoSddxUKlr9cYCG2eRPC0sefP4c/adKF9kDhI6gejqYPLvmWwEgPC3XXA4heVPjK1GlLLRnOnX8HTwtj8/+asuPfd+A21fDzbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749464334; c=relaxed/simple;
	bh=gqrG3kDXX6amBLmj8ZiEul8WbOQjT0KTZPO0eco16Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyI08g9GnNk9Ga5tR1XNc5jQr5YCmFX7IpJcw/UnqrQdwzW6gQuNs2E7q0o+t7YirL0NzV7VkHFVXyPivIPmGlL5tFOrSFR0V5IRn3lo0x6xfyWelhnXsXrxrAOwzJDLgATMYZsKYt7ChdnbjPhCb4E0DF+0JJBqGQD1DfNs+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=11zMFZTr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+q5k/oef; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TZJRvWOL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6Xknxy53; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DBD8221185;
	Mon,  9 Jun 2025 10:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749464325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLu2PYhhLFvmoqjPyHQGzIdkpfrvEfN1IyEqTgHPDIs=;
	b=11zMFZTroGbF22Zg57HPIzEniGUNzzxFEO+QdSdFJLwBFIiP6BrIQKDv3FmUPDu1wbx1tg
	pzN2XpUE6OP4tM2t61iso06AJyOY2lU0nez5iCXNYtA8PiPDtlXyV+h15v0wkHaDKKQzbB
	Z1mQWtlrysEIg7ApZP9JXyuDsOvSYRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749464325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLu2PYhhLFvmoqjPyHQGzIdkpfrvEfN1IyEqTgHPDIs=;
	b=+q5k/oefSrPJTTw0Jm+a8ikAhhJnqE199XEawSQO0F9ooChMOXSDcGbq1c6+9ds2vx2K5Y
	rnlbN3II2uDGsXCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749464324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLu2PYhhLFvmoqjPyHQGzIdkpfrvEfN1IyEqTgHPDIs=;
	b=TZJRvWOLkN69a6/fSj+CRJ/fvUSyuBZ7Qh/OfdRdSH+5278i6oBTOlfiCEp6QHWdfgsGer
	fVVbPdT2jUKfix2dVX3NqUhUQOEGeVm81/PtNSHNCfrVhKNJvdy9VJkgWRr7vTCQj2uz1X
	CxFBE8xBc4hxyk6eLZ+YOi0qnBtEgfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749464324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLu2PYhhLFvmoqjPyHQGzIdkpfrvEfN1IyEqTgHPDIs=;
	b=6Xknxy53gri1TPO7vGTjGnLn5m7Mm/lDvulWPOW+asRzDm3S4xr+AQtXjtm+9pNxFgitQL
	DplbhbAZRhFHqCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B476F13A1D;
	Mon,  9 Jun 2025 10:18:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pwyPKwS1Rmg4KAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 09 Jun 2025 10:18:44 +0000
Message-ID: <30533e96-75f9-4568-add8-05a0be484cfe@suse.cz>
Date: Mon, 9 Jun 2025 12:18:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: add mmap_prepare() compatibility layer for nested
 file systems
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 

On 6/9/25 11:24 AM, Lorenzo Stoakes wrote:
> Nested file systems, that is those which invoke call_mmap() within their
> own f_op->mmap() handlers, may encounter underlying file systems which
> provide the f_op->mmap_prepare() hook introduced by commit
> c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
> 
> We have a chicken-and-egg scenario here - until all file systems are
> converted to using .mmap_prepare(), we cannot convert these nested
> handlers, as we can't call f_op->mmap from an .mmap_prepare() hook.
> 
> So we have to do it the other way round - invoke the .mmap_prepare() hook
> from an .mmap() one.
> 
> in order to do so, we need to convert VMA state into a struct vm_area_desc
> descriptor, invoking the underlying file system's f_op->mmap_prepare()
> callback passing a pointer to this, and then setting VMA state accordingly
> and safely.
> 
> This patch achieves this via the compat_vma_mmap_prepare() function, which
> we invoke from call_mmap() if f_op->mmap_prepare() is specified in the
> passed in file pointer.
> 
> We place the fundamental logic into mm/vma.c where VMA manipulation
> belongs. We also update the VMA userland tests to accommodate the changes.
> 
> The compat_vma_mmap_prepare() function and its associated machinery is
> temporary, and will be removed once the conversion of file systems is
> complete.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reported-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/linux-mm/CAG48ez04yOEVx1ekzOChARDDBZzAKwet8PEoPM4Ln3_rk91AzQ@mail.gmail.com/
> Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").

So this is a hotfix for 6.16-rc1 but doesn't need cc: stable.
Also probably nothing wraps yet the filesystems with .mmap_prepare? But
good to have this handled within 6.16.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


