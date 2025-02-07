Return-Path: <linux-fsdevel+bounces-41172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7DAA2BF3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 10:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2112D188A41C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBE61DDC15;
	Fri,  7 Feb 2025 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XQ7pGDBZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+Z9gfUNp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XQ7pGDBZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+Z9gfUNp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8AE74059;
	Fri,  7 Feb 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920457; cv=none; b=CBDqfu8JbrEWZMXAr4KQFgM9ixdKZIG837lXOUQtBG8iyspGk7SBQXHgOq1VF1v/fRaohqMRsk/jhmAUkb33IOjGnmACqe8OrdzfcaLkwE13mgRgshCUAsFTEkvAevZw5+TksgwLN/KkZixIMIDnKqgcLcYXtzWG5tUEWfgC888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920457; c=relaxed/simple;
	bh=Cjg41zt3tu6A6sampuq3xFWQGGE2PJODjl/kVEM+1xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCJ6gjK/vd2VgwABS5a+FVj/Dk6u8PFLNxn7uYQF44RzFDyu2qksEgZWFsBeXyD+yXcKpkm4E3jiR4uwrKdsIS38hYfaGJev3KS//raro8rSJ8Un8I3/b2EQJOOA+m+297cMaXX6F8ZywSKl3NGfT9iWh1JOerToCusm4G9Wolk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XQ7pGDBZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+Z9gfUNp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XQ7pGDBZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+Z9gfUNp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 775AB1F38D;
	Fri,  7 Feb 2025 09:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738920431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/vhtL15V8lzJWJ74SEaJOEukiJU5OxDONdQQRQdk17w=;
	b=XQ7pGDBZptTA4/T7Wm2s45W21O6H15JOt+nMgp5cYjyoHfcXgONFsGj6C2snk2bpEUfvzd
	T0His087wisIom2qwMp/oOS1DcYmS3iAQD/govYJCHdE/WnHWwVjtYJqvGUzBeh5tmXeuW
	s6MDvJmwkNZavqUBjGHNZQVVMWOVNdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738920431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/vhtL15V8lzJWJ74SEaJOEukiJU5OxDONdQQRQdk17w=;
	b=+Z9gfUNpXGMvjzI1r4rplxWv//CjB6KF5Y4+mE85bC/bRF91WRf/CLRxZXUOQ4idrfZsLM
	BieK7g1ti1cCJBAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XQ7pGDBZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+Z9gfUNp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738920431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/vhtL15V8lzJWJ74SEaJOEukiJU5OxDONdQQRQdk17w=;
	b=XQ7pGDBZptTA4/T7Wm2s45W21O6H15JOt+nMgp5cYjyoHfcXgONFsGj6C2snk2bpEUfvzd
	T0His087wisIom2qwMp/oOS1DcYmS3iAQD/govYJCHdE/WnHWwVjtYJqvGUzBeh5tmXeuW
	s6MDvJmwkNZavqUBjGHNZQVVMWOVNdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738920431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/vhtL15V8lzJWJ74SEaJOEukiJU5OxDONdQQRQdk17w=;
	b=+Z9gfUNpXGMvjzI1r4rplxWv//CjB6KF5Y4+mE85bC/bRF91WRf/CLRxZXUOQ4idrfZsLM
	BieK7g1ti1cCJBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1992513694;
	Fri,  7 Feb 2025 09:27:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TGjfA+/RpWeQXQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 07 Feb 2025 09:27:11 +0000
Message-ID: <6543c6b6-da86-4c10-9b8c-e5fe6f6f7da9@suse.cz>
Date: Fri, 7 Feb 2025 10:27:10 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/26] mm: helper `is_shadow_stack_vma` to check shadow
 stack vma
Content-Language: en-US
To: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
 rick.p.edgecombe@intel.com
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
 <20250204-v5_user_cfi_series-v9-1-b37a49c5205c@rivosinc.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250204-v5_user_cfi_series-v9-1-b37a49c5205c@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 775AB1F38D
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.infradead.org,wdc.com,linaro.org,sifive.com,gmail.com,rivosinc.com,google.com,kernel.org,intel.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLisu716frudqkg98kczdd9eac)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 2/5/25 02:21, Deepak Gupta wrote:
> VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack

I see that arm GCS uses VM_HIGH_ARCH_6.

> VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow

And RISC-V doesn't define it at all, not even in this patchset, or did I
miss it somewhere?

> stack). In case architecture doesn't implement shadow stack, it's VM_NONE
> Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
> or not.

This looks like an unfinished sentence. As if it was to continue with "...
will allow us to ..." what?

I'm not against a helper but this changelog is rather confusing and also
code in arch/x86 and arch/arm64 isn't converted to the helper but testing
VM_SHADOW_STACK still.

> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>  mm/gup.c  |  2 +-
>  mm/mmap.c |  2 +-
>  mm/vma.h  | 10 +++++++---
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 3883b307780e..8c64f3ff34ab 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1291,7 +1291,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>  		    !writable_file_mapping_allowed(vma, gup_flags))
>  			return -EFAULT;
>  
> -		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
> +		if (!(vm_flags & VM_WRITE) || is_shadow_stack_vma(vm_flags)) {
>  			if (!(gup_flags & FOLL_FORCE))
>  				return -EFAULT;
>  			/*
> diff --git a/mm/mmap.c b/mm/mmap.c
> index cda01071c7b1..7b6be4eec35d 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -648,7 +648,7 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
>   */
>  static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
>  {
> -	if (vm_flags & VM_SHADOW_STACK)
> +	if (is_shadow_stack_vma(vm_flags))
>  		return PAGE_SIZE;
>  
>  	return 0;
> diff --git a/mm/vma.h b/mm/vma.h
> index a2e8710b8c47..47482a25f5c3 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -278,7 +278,7 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
>  }
>  
>  /*
> - * These three helpers classifies VMAs for virtual memory accounting.
> + * These four helpers classifies VMAs for virtual memory accounting.
>   */
>  
>  /*
> @@ -289,6 +289,11 @@ static inline bool is_exec_mapping(vm_flags_t flags)
>  	return (flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC;
>  }
>  
> +static inline bool is_shadow_stack_vma(vm_flags_t vm_flags)
> +{
> +	return !!(vm_flags & VM_SHADOW_STACK);
> +}
> +
>  /*
>   * Stack area (including shadow stacks)
>   *
> @@ -297,7 +302,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
>   */
>  static inline bool is_stack_mapping(vm_flags_t flags)
>  {
> -	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
> +	return ((flags & VM_STACK) == VM_STACK) || is_shadow_stack_vma(flags);
>  }
>  
>  /*
> @@ -308,7 +313,6 @@ static inline bool is_data_mapping(vm_flags_t flags)
>  	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
>  }
>  
> -
>  static inline void vma_iter_config(struct vma_iterator *vmi,
>  		unsigned long index, unsigned long last)
>  {
> 


