Return-Path: <linux-fsdevel+bounces-14085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7698778B8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 23:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC73F1F21733
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 22:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E933B794;
	Sun, 10 Mar 2024 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN2K/mcf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD273B2A1;
	Sun, 10 Mar 2024 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710108982; cv=none; b=WiTwbuh9v3g4DGHnmmCnpO4mBagMx3EiELDNHbmWbcMrdYJDrrsyOrqqf4cvkmYY8KPtDlxYs5S4244O9PsJXZTgDiRvqnEH9pVVsB0dO2UbQmZ6ws14BPcXwX3dAbykYE6KuweNSY+P1ikaIwpOkv1atIgQ4wSRvqB4QKmUiyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710108982; c=relaxed/simple;
	bh=NgSfBYH1LNsnELYmNLDEDEzlrOCpMpxpZ7PR46inh14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEW6Jp590V2KCTwEmHpWoSJgnTZR6WW8gFB0R+vinx7XGeQlYi6jK/uIai74jUF+vJdcILE682gAcP+SGGHYQal50oOo45MIhrtq4zcI8v6HMPuJlrFOYdc1tAESyuHVo66V+tqdcwZpyj7hKqpwMWq/G7/c92ibFCQY0c1dTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VN2K/mcf; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d09cf00214so36340651fa.0;
        Sun, 10 Mar 2024 15:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710108979; x=1710713779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dc3StepsO+Kwx79HUWIFjCgTbcngrQSPw+SNx+WUt0k=;
        b=VN2K/mcf2XdJdux1OgCtykoK4xtRZDjjWulbtD1aLkiRJ0yTJegy9AqPKOJSjrZK9g
         xNM8lbaESX6xZ46qQRNTg4d1Jzgw4LSX675jLUVbGOBd59r8m8FutuWRV3aDjJJnjUKc
         rEeUNLNFbqF4srFQtb+47Ll2wOz9u+bBwPLrS5jnacy1fK5rN8stX0ghbJHtc+QoWK4r
         yQWs6Ghkcwbi80DDDOoUAryJ1XfCKMnMBPb0cSl/3/U28OiBulh6ZetZabDzQy1RvnWe
         zbCrkCLLQjWXrQKdn6YiKAiw5kUBFr87ww43hIIRQPb57RNhmnhe6qsaPXoJnyqLKSmS
         Q1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710108979; x=1710713779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dc3StepsO+Kwx79HUWIFjCgTbcngrQSPw+SNx+WUt0k=;
        b=AFFF9Ons8Y/p5XwKw/l9UgUsVNJL8fVCi/crPMZfpUp8C/XyL7UNifuCc82bLTBLwV
         Tk9/7p/M+jTcaT9cqOfCOoIaZr3Zup7jufjfBUE1Kl2fSb1OLbiPGnFrOCEXtvKhsXyZ
         B8e3pKLxe2vPFhawxp0ScGbyaVUYtPLVsipuYKsWl7rgJGKP+DMJClXZMS2bM8qC4lnj
         0i98XQYR0BpiBHSOWH6S73rzW3lzhlszAnGOqCGy82wvV20XRsJMsLkh7Krum3O4cLmA
         bO5EkoDw4R4L1XoeXWeCb02LRhnMtjQo+cbr18oplmJ3jFAy2biBvJmOWFvU1p+zB3/n
         iInA==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZRL6aq34X9Qr+8Mafwj9B7bBtApDoK1CgIKFS+zU35lw5JXAS3EgYwoHprsms6q2IwiCQCra1KERyhpSvXEtWi4avuTX8TVYC32DN4TOavgTTOJr5Ox3iAACbzJMXkznNDzf4k0elN1WGW3GKOg+0BajDtyGjVghvsGWvyxph9w4rj9n6A==
X-Gm-Message-State: AOJu0YyZ0gnvWgTS0ee6qZiyC6R/F+uAev9VWY9FQoEIDCM9dv+Wzn9d
	auRggicd4BKA7l/+5agEYSFk/hibrdhljQu+TxY3fGPjct3DndpOgPdY6/S+
X-Google-Smtp-Source: AGHT+IH9TQxVHx3jEkCPrv/L2i1YI7kr16M1lHlEq+Yn5rsKFooKGpixgfnlK6xwq3mmppJ6+za3Gw==
X-Received: by 2002:ac2:4644:0:b0:512:c9bc:f491 with SMTP id s4-20020ac24644000000b00512c9bcf491mr3009866lfo.47.1710108978913;
        Sun, 10 Mar 2024 15:16:18 -0700 (PDT)
Received: from localhost (host86-164-143-89.range86-164.btcentralplus.com. [86.164.143.89])
        by smtp.gmail.com with ESMTPSA id m38-20020a05600c3b2600b00412b6fbb9b5sm13627109wms.8.2024.03.10.15.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 15:16:18 -0700 (PDT)
Date: Sun, 10 Mar 2024 22:14:04 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Richard Weinberger <richard@nod.at>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	upstream+pagemap@sigma-star.at, adobriyan@gmail.com,
	wangkefeng.wang@huawei.com, ryan.roberts@arm.com, hughd@google.com,
	peterx@redhat.com, david@redhat.com, avagin@google.com,
	vbabka@suse.cz, akpm@linux-foundation.org,
	usama.anjum@collabora.com, corbet@lwn.net
Subject: Re: [PATCH 2/2] [RFC] pagemap.rst: Document write bit
Message-ID: <Ze4wrHL6DEQJl_Oo@devil>
References: <20240306232339.29659-1-richard@nod.at>
 <20240306232339.29659-2-richard@nod.at>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306232339.29659-2-richard@nod.at>

On Thu, Mar 07, 2024 at 12:23:39AM +0100, Richard Weinberger wrote:
> Bit 58 denotes that a PTE is writable.
> The main use case is detecting CoW mappings.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  Documentation/admin-guide/mm/pagemap.rst | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> index f5f065c67615..81ffe3601b96 100644
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -21,7 +21,8 @@ There are four components to pagemap:
>      * Bit  56    page exclusively mapped (since 4.2)
>      * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
>        Documentation/admin-guide/mm/userfaultfd.rst)
> -    * Bits 58-60 zero
> +    * Bit  58    pte is writable (since 6.10)

I really think we need to be careful about talking about 'writable' again
because people are easily confused about the difference between a writable
_mapping_ and a writable _page table entry_.

Of course you mention PTE here, but I think it might be better to say
something like:

    * Bit  58    raw pte r/w flag (since 6.10)

> +    * Bits 59-60 zero
>      * Bit  61    page is file-page or shared-anon (since 3.5)
>      * Bit  62    page swapped
>      * Bit  63    page present
> @@ -37,6 +38,11 @@ There are four components to pagemap:
>     precisely which pages are mapped (or in swap) and comparing mapped
>     pages between processes.
>
> +   Bit 58 is useful to detect CoW mappings; however, it does not indicate
> +   whether the page mapping is writable or not. If an anonymous mapping is
> +   writable but the write bit is not set, it means that the next write access
> +   will cause a page fault, and copy-on-write will happen.
> +

David has addressed the copy vs. anon exclusive remap issue, but I also
feel this needs some balking out.

I would simply rephrase this in terms of whether a write fault occurs or
not e.g.:

   Bit 58 indicates whether the PTE has the write flag set. If this flag is
   unset, then write accesses for this mapping will cause a fault for this
   page. If the mapping is private (whether anonymous or file-backed), this
   can result in a Copy-on-Write (though if anonymous-excusive the flag
   will simply be set). If file-backed, this being cleared may simply
   indicate that this file page is clean.

>     Efficient users of this interface will use ``/proc/pid/maps`` to
>     determine which areas of memory are actually mapped and llseek to
>     skip over unmapped regions.
> --
> 2.35.3
>

