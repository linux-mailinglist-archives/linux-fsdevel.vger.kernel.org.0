Return-Path: <linux-fsdevel+bounces-25402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3702A94B89E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 10:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4571F2177E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273071891D6;
	Thu,  8 Aug 2024 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iTP5pJGa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uMWvH9Pr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iTP5pJGa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uMWvH9Pr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58151188CC8;
	Thu,  8 Aug 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104658; cv=none; b=m0hYrfjcY4ULNhC2ZB1LImhv3MpomKGe50RW3TFD2j0+NwbJWSJnxyTy2KmTH6phLwXPKmO/Bmu7dsVNTgyPayoi4yXX7JNHWcKDyMvDDOffyV3H0++J7ZGIGL33EMLvB7marh4M1Pf3WrPLT0tD2JMKRf8gG+xxCh7g5hmUgI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104658; c=relaxed/simple;
	bh=nZb+v5iQAu5u13sDbZHZwQROvFaAhSpLjjl8IQURW54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjLR+Vo38JgmVtxA4GnauoqSe+VXjSsdqj35iMcBN2B10ZmsO1aIHBvOT4kklCn5qzF8zvUw0fd8AZ5Dg0ekrHHr5eAlW4L9S6gcu9S5nMOQUaeJGwRldhwYJvySmkGum2Z2uicG+hKqfELaHANnpKSpnHhjX00Fe+aNOMsaSDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iTP5pJGa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uMWvH9Pr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iTP5pJGa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uMWvH9Pr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D71921A87;
	Thu,  8 Aug 2024 08:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723104654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7ar+Qyb3sNz9btGz7e6XzjvxLxKENT5IcPn6MjtNJuE=;
	b=iTP5pJGamI1KI1OZhVTQiCo1TQGQ2fk3+65YdELLoVBfLGsttFVEQEzBpc7IIvZRBMBIUW
	+iJhdiGX30zWCzKGxetoX6pcFn1NY82pMCI2fRULe+FN796bGOozMwzKmIE3N0+vRcPCYB
	ap4vvW26XjpBsj6/vkj73WxAxXVQevU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723104654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7ar+Qyb3sNz9btGz7e6XzjvxLxKENT5IcPn6MjtNJuE=;
	b=uMWvH9Prjv/lXfTtS5cABsnRh0QhtMU1PA0gZ1GtCHzJbwflh0lLvmNAgXYFsoAH6grHTm
	XswF1KiT/zUyRwBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723104654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7ar+Qyb3sNz9btGz7e6XzjvxLxKENT5IcPn6MjtNJuE=;
	b=iTP5pJGamI1KI1OZhVTQiCo1TQGQ2fk3+65YdELLoVBfLGsttFVEQEzBpc7IIvZRBMBIUW
	+iJhdiGX30zWCzKGxetoX6pcFn1NY82pMCI2fRULe+FN796bGOozMwzKmIE3N0+vRcPCYB
	ap4vvW26XjpBsj6/vkj73WxAxXVQevU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723104654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7ar+Qyb3sNz9btGz7e6XzjvxLxKENT5IcPn6MjtNJuE=;
	b=uMWvH9Prjv/lXfTtS5cABsnRh0QhtMU1PA0gZ1GtCHzJbwflh0lLvmNAgXYFsoAH6grHTm
	XswF1KiT/zUyRwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 334CB13946;
	Thu,  8 Aug 2024 08:10:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 39wTDI59tGYLCwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 08 Aug 2024 08:10:54 +0000
Message-ID: <0a6afdd6-def0-4ecf-83a2-e9bb0f8cf663@suse.cz>
Date: Thu, 8 Aug 2024 10:10:53 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] userfaultfd: move core VMA manipulation logic to
 mm/userfaultfd.c
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Pengfei Xu <pengfei.xu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Brendan Higgins <brendanhiggins@google.com>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 syzkaller-bugs@googlegroups.com
References: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
 <50c3ed995fd81c45876c86304c8a00bf3e396cfd.1722251717.git.lorenzo.stoakes@oracle.com>
 <ZrLt9HIxV9QiZotn@xpf.sh.intel.com>
 <3c947ddc-b804-49b7-8fe9-3ea3ca13def5@lucifer.local>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <3c947ddc-b804-49b7-8fe9-3ea3ca13def5@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.29
X-Spam-Flag: NO
X-Spam-Level: 

On 8/7/24 14:03, Lorenzo Stoakes wrote:
> On Wed, Aug 07, 2024 at 11:45:56AM GMT, Pengfei Xu wrote:
>> Hi Lorenzo Stoakes,
>>
>> Greetings!
>>
>> I used syzkaller and found
>> KASAN: slab-use-after-free Read in userfaultfd_set_ctx in next-20240805.
>>
>> Bisected the first bad commit:
>> 4651ba8201cf userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
>>
>> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240806_122723_userfaultfd_set_ct
> 
> [snip]
> 
> Andrew - As this is so small, could you take this as a fix-patch? The fix
> is enclosed below.
> 
> 
> Pengfei - Sorry for the delay on getting this resolved, I was struggling to
> repro with my usual dev setup, after trying a lot of things I ended up
> using the supplied repro env and was able to do so there.
> 
> (I suspect that VMAs are laid out slightly differently in my usual arch base
> image perhaps based on tunables, and this was the delta on that!)
> 
> Regardless, I was able to identify the cause - we incorrectly pass a stale
> pointer to userfaultfd_reset_ctx() if a merge is performed in
> userfaultfd_clear_vma().
> 
> This was a subtle mistake on my part, I don't see any other instances like
> this in the patch.
> 
> Syzkaller managed to get this merge to happen and kasan picked up on it, so
> thank you very much for supplying the infra!
> 
> The fix itself is very simple, a one-liner, enclosed below.
> 
> ----8<----
> From 193abd1c3a51e6bf1d85ddfe01845e9713336970 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Wed, 7 Aug 2024 12:44:27 +0100
> Subject: [PATCH] mm: userfaultfd: fix user-after-free in
>  userfaultfd_clear_vma()
> 
> After invoking vma_modify_flags_uffd() in userfaultfd_clear_vma(), we may
> have merged the vma, and depending on the kind of merge, deleted the vma,
> rendering the vma pointer invalid.
> 
> The code incorrectly referenced this now possibly invalid vma pointer when
> invoking userfaultfd_reset_ctx().
> 
> If no merge is possible, vma_modify_flags_uffd() performs a split and
> returns the original vma. Therefore the correct approach is to simply pass
> the ret pointer to userfaultfd_ret_ctx().
> 
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Fixes: e310f2b78a77 ("userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c")
> Closes: https://lore.kernel.org/all/ZrLt9HIxV9QiZotn@xpf.sh.intel.com/
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 3b7715ecf292..966e6c81a685 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1813,7 +1813,7 @@ struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
>  	 * the current one has not been updated yet.
>  	 */
>  	if (!IS_ERR(ret))
> -		userfaultfd_reset_ctx(vma);
> +		userfaultfd_reset_ctx(ret);
> 
>  	return ret;
>  }
> --
> 2.45.2


