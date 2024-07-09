Return-Path: <linux-fsdevel+bounces-23370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F8792B585
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 12:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E101F2214D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 10:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FE815699E;
	Tue,  9 Jul 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ffjJAooU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q3elC37S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ffjJAooU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q3elC37S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C47156885;
	Tue,  9 Jul 2024 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521617; cv=none; b=SErFTdZalw97FJR/gg0F8WxVbJWW6qn1oNMmmgI3PB1pItE26xUCMAK+v7214ZZzvjnnpWP77BjW3gVgSa25/pOvx742egCL6HEXhPeLioIq3QgakoiEetma2HvAvrV8xTvQa+CUU1nBFOynjn9AwCpTnnMKFprKYjVabiufdss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521617; c=relaxed/simple;
	bh=j4nAGjlqk0s6JCedOC+ToR9MmvhbH/VebVGhaGM/As8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5fDyB1aq6Ii8EMhZXeL4zRumOv5cwv77feSb537eLkjcbl3D61eMwVuW2ifCklzhfc/XD3diXwww3YUJtnR/ANDn3PyUxdIz+nA01FsZsN3rZyElrM7iyXoLufpdvbYc+hnWBOM4zSZQ27mjg2MpOd5sgU5U4S2JNUZEasQ75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ffjJAooU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q3elC37S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ffjJAooU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q3elC37S; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A25AE1F7AF;
	Tue,  9 Jul 2024 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720521613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xc1SEDVZfS6KIWmNHqHPZKqyWsRkfp+pqAh29HViIbk=;
	b=ffjJAooUkivBge2q56s/MzXHopSODh/RDYwRzvCKg7cMhityeC423NtMDuD0oy/1hSjloX
	PrF1VSXvb3Bxu9+EHL2mad0wAfy3io4OgYwGeJipEEr5HhWF+9sJCCl1/Nmtjq7HeC08LN
	136/9OpYH8mhfutEeUfMGktIYYbW060=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720521613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xc1SEDVZfS6KIWmNHqHPZKqyWsRkfp+pqAh29HViIbk=;
	b=q3elC37SiSo9auR+TlMos9AFrNWOwV4nUacnKBa7gUhVxn3aOucS00btYlZMtjyPX/v2L7
	5ZxAEdNPYDBrpqAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ffjJAooU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=q3elC37S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720521613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xc1SEDVZfS6KIWmNHqHPZKqyWsRkfp+pqAh29HViIbk=;
	b=ffjJAooUkivBge2q56s/MzXHopSODh/RDYwRzvCKg7cMhityeC423NtMDuD0oy/1hSjloX
	PrF1VSXvb3Bxu9+EHL2mad0wAfy3io4OgYwGeJipEEr5HhWF+9sJCCl1/Nmtjq7HeC08LN
	136/9OpYH8mhfutEeUfMGktIYYbW060=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720521613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xc1SEDVZfS6KIWmNHqHPZKqyWsRkfp+pqAh29HViIbk=;
	b=q3elC37SiSo9auR+TlMos9AFrNWOwV4nUacnKBa7gUhVxn3aOucS00btYlZMtjyPX/v2L7
	5ZxAEdNPYDBrpqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79EF21369A;
	Tue,  9 Jul 2024 10:40:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BZPxHI0TjWanUgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 09 Jul 2024 10:40:13 +0000
Message-ID: <f8658375-db8c-4fc1-9401-5e59b61c76a1@suse.cz>
Date: Tue, 9 Jul 2024 12:40:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] userfaultfd: move core VMA manipulation logic to
 mm/userfaultfd.c
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Brendan Higgins <brendanhiggins@google.com>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
 <76a0f9c7191544ad9ccd5c156d8c524cde67a894.1720121068.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <76a0f9c7191544ad9ccd5c156d8c524cde67a894.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A25AE1F7AF
X-Spam-Score: -4.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 7/4/24 9:27 PM, Lorenzo Stoakes wrote:
> This patch forms part of a patch series intending to separate out VMA logic
> and render it testable from userspace, which requires that core
> manipulation functions be exposed in an mm/-internal header file.
> 
> In order to do this, we must abstract APIs we wish to test, in this
> instance functions which ultimately invoke vma_modify().
> 
> This patch therefore moves all logic which ultimately invokes vma_modify()
> to mm/userfaultfd.c, trying to transfer code at a functional granularity
> where possible.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -264,6 +264,25 @@ extern void userfaultfd_unmap_complete(struct mm_struct *mm,
>  extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
>  extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
>  
> +extern void userfaultfd_reset_ctx(struct vm_area_struct *vma);
> +
> +extern struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
> +						    struct vm_area_struct *prev,
> +						    struct vm_area_struct *vma,
> +						    unsigned long start,
> +						    unsigned long end);
> +
> +int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
> +			       struct vm_area_struct *vma,
> +			       unsigned long vm_flags,
> +			       unsigned long start, unsigned long end,
> +			       bool wp_async);
> +
> +extern void userfaultfd_release_new(struct userfaultfd_ctx *ctx);
> +
> +extern void userfaultfd_release_all(struct mm_struct *mm,
> +				    struct userfaultfd_ctx *ctx);
> +

Nit: the externs are superfluous. AFAIU the tribal knowledge (or is it
documented?), we don't add them even if other declarations around have them,
but we don't also actively remove them unless the lines are touched for
other reasons. So the declarations are inconsistent but slowly move towards
no externs.

>  #else /* CONFIG_USERFAULTFD */
>  
>  /* mm helpers */


