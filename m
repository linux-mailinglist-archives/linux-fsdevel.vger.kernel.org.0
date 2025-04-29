Return-Path: <linux-fsdevel+bounces-47631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679D7AA17C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 19:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAD39874F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894DD2512E0;
	Tue, 29 Apr 2025 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DZpbKQHI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wV7ytHRp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DZpbKQHI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wV7ytHRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171021ABC1
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948835; cv=none; b=LZwlQCclW8R1Ge4nzUGGlpDZaXafi0bBzcQ1QnaAWciJnxagR6TVkNlXDWx3cuAETKkUUQFPTu/uaTou7EodwlcPc3MSPVFn+o7T/BqKeXegaAf9ThsC/ZopHstt2Lkmujv0RoHbmRNCFU7FsgwMSn6QqV0I1pb6L/IRy2qXJ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948835; c=relaxed/simple;
	bh=Cu21U8I0Wc0296g7qL7IR3Ck0MFf1FOYLgjhyHkmmdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6DD9hPJDr6xQCeA5QfOaXmU9P1FZr3rmrb76kvGs4oHtsUUNzfanGf2F1WYILO6Ea39MPzHcAS385wYiNz8+Mi3sWbkYqLG9f97HBOcrYtKitu1Yai05lizhCnvP5QwCDzM711NBUa8z4rM6+XWjM5zR+mPdt6rRkMR95l7ZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DZpbKQHI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wV7ytHRp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DZpbKQHI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wV7ytHRp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E9CE211F5;
	Tue, 29 Apr 2025 17:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745948831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+Om/2yyVlzIC8pM2MuKpNu5aVo4/a/X0+JQIku2ilU=;
	b=DZpbKQHITozUhLgxkVSgGpSaezGeuWPjXHt6eLxJZwDXjg8QfZ3AYWG01ZU4CgrEJwZH4V
	Hfth/J4TJIVSVLFHj7Iun5m9q+cgQUKGqiR8Gq1HXMSHhTmMswWj9yJ1cWOCk5y9wkgEQ/
	AzWa2wOprwarpPUzH/JUdd3s7uFVzEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745948831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+Om/2yyVlzIC8pM2MuKpNu5aVo4/a/X0+JQIku2ilU=;
	b=wV7ytHRpM4jKkrlHatQ01JRYGx0Ii04wSMPJR3OBfkooyYEcoMMBgZJ1XD4JqkbGYQCRba
	YNs/FswGbDHoZHAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DZpbKQHI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wV7ytHRp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745948831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+Om/2yyVlzIC8pM2MuKpNu5aVo4/a/X0+JQIku2ilU=;
	b=DZpbKQHITozUhLgxkVSgGpSaezGeuWPjXHt6eLxJZwDXjg8QfZ3AYWG01ZU4CgrEJwZH4V
	Hfth/J4TJIVSVLFHj7Iun5m9q+cgQUKGqiR8Gq1HXMSHhTmMswWj9yJ1cWOCk5y9wkgEQ/
	AzWa2wOprwarpPUzH/JUdd3s7uFVzEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745948831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+Om/2yyVlzIC8pM2MuKpNu5aVo4/a/X0+JQIku2ilU=;
	b=wV7ytHRpM4jKkrlHatQ01JRYGx0Ii04wSMPJR3OBfkooyYEcoMMBgZJ1XD4JqkbGYQCRba
	YNs/FswGbDHoZHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55BF11340C;
	Tue, 29 Apr 2025 17:47:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5JyuEZ4QEWjkNQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 29 Apr 2025 17:47:10 +0000
Date: Tue, 29 Apr 2025 18:47:08 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mm: perform VMA allocation, freeing, duplication
 in mm
Message-ID: <ozu7p2u72csonqksep3xd324hpiwo4ukvn53egr6jdkvx7ttjc@brcjkc7h2h7h>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
X-Rspamd-Queue-Id: 3E9CE211F5
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email,suse.de:email,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Apr 28, 2025 at 04:28:17PM +0100, Lorenzo Stoakes wrote:
> Right now these are performed in kernel/fork.c which is odd and a violation
> of separation of concerns, as well as preventing us from integrating this
> and related logic into userland VMA testing going forward, and perhaps more
> importantly - enabling us to, in a subsequent commit, make VMA
> allocation/freeing a purely internal mm operation.
> 
> There is a fly in the ointment - nommu - mmap.c is not compiled if
> CONFIG_MMU not set, and neither is vma.c.
> 
> To square the circle, let's add a new file - vma_init.c. This will be
> compiled for both CONFIG_MMU and nommu builds, and will also form part of
> the VMA userland testing.
> 
> This allows us to de-duplicate code, while maintaining separation of
> concerns and the ability for us to userland test this logic.
> 
> Update the VMA userland tests accordingly, additionally adding a
> detach_free_vma() helper function to correctly detach VMAs before freeing
> them in test code, as this change was triggering the assert for this.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

