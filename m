Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243234D1215
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 09:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbiCHIWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 03:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344987AbiCHIWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:22:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E06E03F33E
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 00:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646727688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPGV7ehpSQqx+IAZ6Q4UMs4eKXTc5SZkrFf2pOnvCvw=;
        b=B8A05Ej5vQsHIJa2+n7egRGyULP4kVvZUJ3T6+G3Y/oC5J0AZnCgotznZWag5hO9nXAS8+
        eHMpTeWBaPM+qbyWw46scIRQK9HiTt6DIAcD4rr1p55yEmSUTn0uLV3muxnu3ub4ySqgoJ
        9NRjD9KY3TKiHMbWLgzoAS0O8OdlBR0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-xUWBDiQjOkyyZgfxhNQhjQ-1; Tue, 08 Mar 2022 03:21:26 -0500
X-MC-Unique: xUWBDiQjOkyyZgfxhNQhjQ-1
Received: by mail-wr1-f72.google.com with SMTP id a11-20020adffb8b000000b001efe754a488so5203510wrr.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 00:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=TPGV7ehpSQqx+IAZ6Q4UMs4eKXTc5SZkrFf2pOnvCvw=;
        b=piNd2NbP0JRld2VcoIr/CvS6PhufTAae0y3i5YMkFfTPqh4u/OOD+qPNMEv+xfwGgk
         H9Zw2zv+e58TXF8qUkbaZlcA5BGowT/llDnbCJLEiqs2ffiMxzkyr6UYcX8vcvGuZWJ9
         /6UT0L2vlcA3cHy94wqyGCWzG91Vyt4nhyokxWTnCWS1qVdC+LGKELBzG+CmmFaKQcVM
         phbgOdUWjgJCDazKTOw/DB16FKOQtYedwnW1lIrQ9R+Lkkq5s3+6xiLN9ZTQXPd5epGQ
         Poh4XsUcr2/VrUI7+dbSNeSAE/ZvOnhCHcL9hFy4tHYfHlbFxw24CGjU+4BKDS/EFZJO
         0QtA==
X-Gm-Message-State: AOAM531pN1wz27fAIUbhU7uOCScIx2tZb7cNjzy/OHF5dQvoluUZmclA
        xorbnJAZNnCH+2jwmbJ1xyv0c07o9t1mDzCaVaV9IW0/rSXtEChQgIOG0u55F7q6hG18yHK8FxQ
        aOZlqcideKBPhIatXHShoLvWOGg==
X-Received: by 2002:adf:ea4a:0:b0:1f0:6501:80f7 with SMTP id j10-20020adfea4a000000b001f0650180f7mr11022649wrn.306.1646727685400;
        Tue, 08 Mar 2022 00:21:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIWBX20hLFQ6w9ka0x2WIFzYL3vL9HpkUa3WrvCMfxe9qTqYpiU8oGrTjavXY5gqT7TALjPw==
X-Received: by 2002:adf:ea4a:0:b0:1f0:6501:80f7 with SMTP id j10-20020adfea4a000000b001f0650180f7mr11022617wrn.306.1646727684938;
        Tue, 08 Mar 2022 00:21:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm13310899wrr.88.2022.03.08.00.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 00:21:24 -0800 (PST)
Message-ID: <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
Date:   Tue, 8 Mar 2022 09:21:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
In-Reply-To: <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.03.22 00:18, Linus Torvalds wrote:
> On Mon, Mar 7, 2022 at 2:52 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>>
>> After generic_file_read_iter() returns a short or empty read, we fault
>> in some pages with fault_in_iov_iter_writeable(). This succeeds, but
>> the next call to generic_file_read_iter() returns -EFAULT and we're
>> not making any progress.
> 
> Since this is s390-specific, I get the very strong feeling that the
> 
>   fault_in_iov_iter_writeable ->
>     fault_in_safe_writeable ->
>       __get_user_pages_locked ->
>         __get_user_pages
> 
> path somehow successfully finds the page, despite it not being
> properly accessible in the page tables.

As raised offline already, I suspect

shrink_active_list()
->page_referenced()
 ->page_referenced_one()
  ->ptep_clear_flush_young_notify()
   ->ptep_clear_flush_young()

which results on s390x in:

static inline pte_t pte_mkold(pte_t pte)
{
	pte_val(pte) &= ~_PAGE_YOUNG;
	pte_val(pte) |= _PAGE_INVALID;
	return pte;
}

static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
					    unsigned long addr, pte_t *ptep)
{
	pte_t pte = *ptep;

	pte = ptep_xchg_direct(vma->vm_mm, addr, ptep, pte_mkold(pte));
	return pte_young(pte);
}


_PAGE_INVALID is the actual HW bit, _PAGE_PRESENT is a
pure SW bit. AFAIU, pte_present() still holds:

static inline int pte_present(pte_t pte)
{
	/* Bit pattern: (pte & 0x001) == 0x001 */
	return (pte_val(pte) & _PAGE_PRESENT) != 0;
}


pte_mkyoung() will revert that action:

static inline pte_t pte_mkyoung(pte_t pte)
{
	pte_val(pte) |= _PAGE_YOUNG;
	if (pte_val(pte) & _PAGE_READ)
		pte_val(pte) &= ~_PAGE_INVALID;
	return pte;
}


and pte_modify() will adjust it properly again:

/*
 * The following pte modification functions only work if
 * pte_present() is true. Undefined behaviour if not..
 */
static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
{
	pte_val(pte) &= _PAGE_CHG_MASK;
	pte_val(pte) |= pgprot_val(newprot);
	/*
	 * newprot for PAGE_NONE, PAGE_RO, PAGE_RX, PAGE_RW and PAGE_RWX
	 * has the invalid bit set, clear it again for readable, young pages
	 */
	if ((pte_val(pte) & _PAGE_YOUNG) && (pte_val(pte) & _PAGE_READ))
		pte_val(pte) &= ~_PAGE_INVALID;
	/*
	 * newprot for PAGE_RO, PAGE_RX, PAGE_RW and PAGE_RWX has the page
	 * protection bit set, clear it again for writable, dirty pages
	 */
	if ((pte_val(pte) & _PAGE_DIRTY) && (pte_val(pte) & _PAGE_WRITE))
		pte_val(pte) &= ~_PAGE_PROTECT;
	return pte;
}



Which leaves me wondering if there is a way in GUP whereby
we would lookup that page and not clear _PAGE_INVALID,
resulting in GUP succeeding but faults via the MMU still
faulting on _PAGE_INVALID.


-- 
Thanks,

David / dhildenb

