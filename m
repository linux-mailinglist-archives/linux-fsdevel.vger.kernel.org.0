Return-Path: <linux-fsdevel+bounces-61881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F48B7D4AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D41F1676D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 07:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1D02F7469;
	Wed, 17 Sep 2025 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTrZ8pul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E742741AC
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093917; cv=none; b=eB+nMKWmMvv4yiF27+BoHfn00BDL2YgSSZdXuHhNDNxStN8wKxoPDY/adOPSwAsHPhe1XvvkiiKDrTWXrXccdFNUhrZaMk97q4zgp/j4dGcdWJD2zY1neaB/ztIAAgVywO/4/Niy/aPYrAj0KSBDB34pmThMOOZq7TIz7j9lbM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093917; c=relaxed/simple;
	bh=lL9WGtLG0lD6VwUWg0hduKnAFIffiHBhssrKStYn+NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fak0K6vzMFllASLKDBCljCSSJKbXoOpgWJKpWs5rmqsdL81UhadFJ1xfnwOw9o0JzH1PgIkiJIUVe+cygGWbnK0w1Ni9L/EZm0H3M3S5XzW1DE1pZCAt14nFT9XfI+KUBb11i20wWOPTsGEibafVUjTe6fpdMoP4GJQT957Cwq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTrZ8pul; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758093914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dxO4as0Q5XxTHNvaMG0p9FD9iYcKS+h7Cf1+/OhamkI=;
	b=TTrZ8pul1fq0AfyJTB69hzXWb8wwqgpOypKf1qs3PnGCmyQ7JL2iVN5osR0LZaQUY6dnml
	BGmt/bltagzOWaqaiMduLnNh/kxjjqD9WPdCEtIQWxtHS5FwyCoa4OAgC0waHApp8HCaJi
	Dox98hoPPplyAt7E/gHNw9tzAuIi0Kk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-JcrsxHosPOC7dI0gitUNXQ-1; Wed, 17 Sep 2025 03:25:13 -0400
X-MC-Unique: JcrsxHosPOC7dI0gitUNXQ-1
X-Mimecast-MFC-AGG-ID: JcrsxHosPOC7dI0gitUNXQ_1758093912
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3eb2c65e0d6so1569919f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 00:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758093912; x=1758698712;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxO4as0Q5XxTHNvaMG0p9FD9iYcKS+h7Cf1+/OhamkI=;
        b=htT2z1SaJReS/POx/Z4nl967dv6rBIyBw7x5MW37hG6sRSYlS8EW6Wap2+yqM24PnZ
         4b3JRDIxMLgJREpDKWsZ3sDosorE2lh0OtgeZfs4fKTXy7QjTAyN2ZDHcgxCCRB3WoGS
         xweousqVEIrYFDrDeBF4OAatLYADe5K/7hmCqoyAKcjuwKwjBX79dUXlH2KbF/93oay8
         l3dFDzLSyPDwwxSp7T9wD6v/ibM3Xiez85vuZ/BvWwzPJa/Dv6N3BnAuj33OFlvH6BYm
         YMVKmu/F9UW1+NBHReVs9K7dHgGagR9oONEcjZZw5XsteXVzbVJ3vUZ11YtZ/nXKP78+
         M+FA==
X-Forwarded-Encrypted: i=1; AJvYcCUr7NaUSv2dyG+66F3XrSHoRwwRBsUEW1KUvSNrtNlIlF5r03m6fwYyrq95vafEyD2nFxIFeG4Yuw+UkovJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+oY0RB1kLWMdBBYkVF/vjtnDLvZKyLwP+hDWYvkoTiN5tIKR1
	QzlS0wGQSbA3ZjSBZX/sefdMw8n1jUa+4mieHY1rp6mmlZD4+6ULqS9bJn/lCLFVkX4E/SgAuPu
	910+90otOjVqxviMNn9iu894K+NJQcQzD1a9F1LUNwxLTpgKsrVhDUIr/33AJEazbxW8=
X-Gm-Gg: ASbGnctTKiYBbfPcTI/IIFhGwOeCl+r518nyL0YFh2H8rStPKtraqX4SLwyl8ucto19
	pAooKulswaBKhM0MyadlgUS7X3cZaPmC44X9nsIY/e+oTXl3tKEyuxIUo63HshcyymZRAHphC19
	h369ePhoI/lO/n9D5KHjqM3I1ewvce0huXWXiVhNcUjJOerNexddlsEahU9zk6AzbhkXsyCzo5b
	kS/99jNDHH64cE1o5cu5WE/qCRWIZrvJzXx802UXptuxSE/KmKHBMGe6XpiRrqGBY9AYkkIq2Cu
	+ACsCTNaVhpBO3hfLp+yPNsWAuQNf1jy7o8zEn0//7mXsftOGrdYXJ184/w7sKlyo1OEX1ayw1R
	Ee6vBDrJ72j6c9buTiDfNdzsAojwqgXUAtfuPwZ8fwSJRqMIQFQemfWQFSyiAciCc
X-Received: by 2002:a05:6000:4013:b0:3dc:45be:4a7f with SMTP id ffacd0b85a97d-3ecdfa3f966mr872691f8f.57.1758093911914;
        Wed, 17 Sep 2025 00:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEHva7vHUul9vtNQdESzjClBi0RsKFeJIXOBVMnY44/FxLP75Brxg4KOfMIxcyqeJlJmK3fQ==
X-Received: by 2002:a05:6000:4013:b0:3dc:45be:4a7f with SMTP id ffacd0b85a97d-3ecdfa3f966mr872646f8f.57.1758093911401;
        Wed, 17 Sep 2025 00:25:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ece1247bb5sm390090f8f.12.2025.09.17.00.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 00:25:10 -0700 (PDT)
Message-ID: <bc87f2a8-7a9c-4416-9106-bdf4b98e40a8@redhat.com>
Date: Wed, 17 Sep 2025 09:25:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 2/6] mm: userfaultfd: Add pgtable_supports_uffd_wp()
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>,
 Deepak Gupta <debug@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20250917033703.1695933-1-zhangchunyan@iscas.ac.cn>
 <20250917033703.1695933-3-zhangchunyan@iscas.ac.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250917033703.1695933-3-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.25 05:36, Chunyan Zhang wrote:
> Some platforms can customize the PTE/PMD entry uffd-wp bit making
> it unavailable even if the architecture provides the resource.
> This patch adds a macro API that allows architectures to define their
> specific implementations to check if the uffd-wp bit is available
> on which device the kernel is running.
> 
> Also this patch is removing "ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP" and
> "ifdef CONFIG_PTE_MARKER_UFFD_WP" in favor of pgtable_supports_uffd_wp()
> and uffd_supports_wp_marker() checks respectively that default to
> IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_WP) and
> "IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_WP) && IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP)"
> if not overridden by the architecture, no change in behavior is expected.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---

[...]

Taking another look.

>   /* mm helpers */
> @@ -415,68 +475,24 @@ static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
>   	return false;
>   }
>   
> -#endif /* CONFIG_USERFAULTFD */
> -
>   static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
>   {
> -	/* Only wr-protect mode uses pte markers */
> -	if (!userfaultfd_wp(vma))
>   		return false;

Isn't this indented one level too deep?

> -
> -	/* File-based uffd-wp always need markers */
> -	if (!vma_is_anonymous(vma))
> -		return true;
> -
> -	/*
> -	 * Anonymous uffd-wp only needs the markers if WP_UNPOPULATED
> -	 * enabled (to apply markers on zero pages).
> -	 */
> -	return userfaultfd_wp_unpopulated(vma);
>   }
>   
>   static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
>   {
> -#ifdef CONFIG_PTE_MARKER_UFFD_WP
> -	return is_pte_marker_entry(entry) &&
> -	    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
> -#else
> -	return false;
> -#endif
> +		return false;

Same here.

>   }
>   
>   static inline bool pte_marker_uffd_wp(pte_t pte)
>   {
> -#ifdef CONFIG_PTE_MARKER_UFFD_WP
> -	swp_entry_t entry;
> -
> -	if (!is_swap_pte(pte))
>   		return false;

Same here.

> -
> -	entry = pte_to_swp_entry(pte);
> -
> -	return pte_marker_entry_uffd_wp(entry);
> -#else
> -	return false;
> -#endif
>   }


-- 
Cheers

David / dhildenb


