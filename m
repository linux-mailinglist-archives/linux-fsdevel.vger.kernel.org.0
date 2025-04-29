Return-Path: <linux-fsdevel+bounces-47559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B313AA0422
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 09:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A987A4DD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD1E2741B2;
	Tue, 29 Apr 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="joQ4XPYf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d05QraI5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="joQ4XPYf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d05QraI5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327513A3F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745910734; cv=none; b=QoiMn1DJRXl3ZguV+CXWwrUGiaApC+TfzuRatrXihElzXpUpEOF60HSG69UgwnkVgrUcvKlGsw9x5OjYt3UGkkgxIekk/0/p4ibgzj+XESFln0iM0UAMUI0xoFWaTXt6ynnZMbEF7Mx26LIdBep0Cm5qHxTqMv0/YTHOW/RRuG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745910734; c=relaxed/simple;
	bh=m4KOHjxc2m1aPBLsfGsEdOS3x4H8QGIaXyxw2p2H0K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkJB/SloeIT/Q+W4WeJFMXD55BrnwbVS4g7H2fvIdRs1l5rujEN+2WVVAL8irRR36twlli5Zx4P7vgYWtcHa69VmBVhxz65sSWHL7jSnYi0OKnYSE8PJsjKbXFPclM0YfJrbvY8a/4vhCotPg6tmI8buI31L0Fc/8Jh+ADk/hSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=joQ4XPYf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d05QraI5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=joQ4XPYf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d05QraI5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48CE01F7B2;
	Tue, 29 Apr 2025 07:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745910731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAnYvCRSuq+beLh1M6IqxzqwtA7wBRCze/1dQn8xZDs=;
	b=joQ4XPYfC+pQXhTmWBn8j5YFUS9dQ+/nsyS8bs+rIIExXLaBFTOOERizH6vGeMejHAvM/n
	qQXRlYvZwkCsYhttDg/Fee6KGSsf4m7PRsrnRt/AODB5XoPUx2c0N3HEIiPRlZQcFy3dWV
	vhNYBloE6ev+j0tn6rpUEsxI9Y5Qw0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745910731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAnYvCRSuq+beLh1M6IqxzqwtA7wBRCze/1dQn8xZDs=;
	b=d05QraI5DeF27vBcG/1hGnTpoYMhrotyg7eo54RlFd/bmK2SOLp3JwmG+i+wDmFtxLizlv
	hC5K0hPvJvWCjQCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=joQ4XPYf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d05QraI5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745910731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAnYvCRSuq+beLh1M6IqxzqwtA7wBRCze/1dQn8xZDs=;
	b=joQ4XPYfC+pQXhTmWBn8j5YFUS9dQ+/nsyS8bs+rIIExXLaBFTOOERizH6vGeMejHAvM/n
	qQXRlYvZwkCsYhttDg/Fee6KGSsf4m7PRsrnRt/AODB5XoPUx2c0N3HEIiPRlZQcFy3dWV
	vhNYBloE6ev+j0tn6rpUEsxI9Y5Qw0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745910731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAnYvCRSuq+beLh1M6IqxzqwtA7wBRCze/1dQn8xZDs=;
	b=d05QraI5DeF27vBcG/1hGnTpoYMhrotyg7eo54RlFd/bmK2SOLp3JwmG+i+wDmFtxLizlv
	hC5K0hPvJvWCjQCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DCE21340C;
	Tue, 29 Apr 2025 07:12:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AZLgCst7EGhkbAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 29 Apr 2025 07:12:11 +0000
Message-ID: <d57366ae-3a6a-4f2a-867a-3d34cd93c865@suse.cz>
Date: Tue, 29 Apr 2025 09:12:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mm: move dup_mmap() to mm
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
 <e49aad3d00212f5539d9fa5769bfda4ce451db3e.1745853549.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <e49aad3d00212f5539d9fa5769bfda4ce451db3e.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 48CE01F7B2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/28/25 17:28, Lorenzo Stoakes wrote:
> This is a key step in our being able to abstract and isolate VMA allocation
> and destruction logic.
> 
> This function is the last one where vm_area_free() and vm_area_dup() are
> directly referenced outside of mmap, so having this in mm allows us to
> isolate these.
> 
> We do the same for the nommu version which is substantially simpler.
> 
> We place the declaration for dup_mmap() in mm/internal.h and have
> kernel/fork.c import this in order to prevent improper use of this
> functionality elsewhere in the kernel.
> 
> While we're here, we remove the useless #ifdef CONFIG_MMU check around
> mmap_read_lock_maybe_expand() in mmap.c, mmap.c is compiled only if
> CONFIG_MMU is set.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Suggested-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


