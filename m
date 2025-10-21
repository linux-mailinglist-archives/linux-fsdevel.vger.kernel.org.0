Return-Path: <linux-fsdevel+bounces-64842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D210BF5943
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8DBA4FFB5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB8329C77;
	Tue, 21 Oct 2025 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gU1Jd6o+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D4328B68
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039876; cv=none; b=pnhi3kj9jXFH73t8L9w5dWsMhubnWIBcR20q7lds2EMijEpyyMnSWfmkPO4nacbu6yp6fbNpXajhzYKbNyBZjteDEZLmuBWMrWtLedsllHQU8VQ+AX06CD8b0hOrtdUQACF00/t4SUBWz8nagcgTDgTi3xIEaor8rcXWdt0C4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039876; c=relaxed/simple;
	bh=U+eL5vMWuJx0rjIIppv98/UUTb9GjsW1G23VXXcO8So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svuBWxTBsqP9VAI0Wi568wzfMVzZKPNAFLrB9sE5hIUxnDCOiYQDyL4C1kxzqJSpTJAHCnLzI8Wj9OdXDTy/+pR5ER3nmwMZYlHSCZovwRMxVatyGcK7EVmNxmRUW0XG62Cl3alhhadfdm0vXjgyf9GsGCkp13L+m1Qoq5kipD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gU1Jd6o+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761039873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A7HVROVgx0bb5nBCxg5N7qerxadWj+WPkTkgih4XRWM=;
	b=gU1Jd6o+EY2rkh6l6eeN43pyBq4wAztQQ/a/J0m5lmxfUFI+25zSAH9Ra6+Y5t5InH8Pko
	EfqvaGkjUEZ/pLxINXsKHdNBZEagA959uJkLQ4DBGdtZ0AnvhRbTp+UKajqaqMmXVzv0QM
	uez+A6nFh6CDuRb1YC8OMjG3Du8Ke9Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-NoCTr9KmO06-nu3SMLnY3w-1; Tue, 21 Oct 2025 05:44:31 -0400
X-MC-Unique: NoCTr9KmO06-nu3SMLnY3w-1
X-Mimecast-MFC-AGG-ID: NoCTr9KmO06-nu3SMLnY3w_1761039870
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471168953bdso38734605e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 02:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039870; x=1761644670;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7HVROVgx0bb5nBCxg5N7qerxadWj+WPkTkgih4XRWM=;
        b=fFKKAdbqjZkm3sNHRzv+QOZJQ4LXVQY29VSP+5ymhG1iNxigiBGBhtgUpRPqPDMoSM
         IkXMcNBldGYnbyEnBnXOfBB6+Efd3r+ySySUg4666rqLSUrGpevvz4cgDtGPCL5YsNH4
         tPUUeC90WdbtZNdY/fO4DyYn2PiWrq/uWpPnlO9zjlKlAwXMxvEeiKns9ODLh26X60eq
         kTw5UjZfYO9D33Pw2kdDZN0yvSkt6kXLsnBSHLP9QTsmssu/2ykLEkiQ2iDtjr1XunKK
         HA0nci4kSKZ8bJzPYsIe5XMN2CFQl+BcaYOmN2Cvc0/PtjRpiEWcQ5iAe7BTpIWNMWwB
         qgmA==
X-Forwarded-Encrypted: i=1; AJvYcCX2eCbm0H9N8ldAlWFvrPqj2G6aiTFusbRkdIUU4CbgR6zKh0sUelJC/1ZyMpJVFK3seoqYQ3F6vldc4uF8@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUznhHwCyVPOfwwRhH5/Y2S+56SWhmsaymXp2lGSlecHgv9HB
	+1oRr/ekXKaI6asKWneyi64WSzQaNpi7nnXRDoPZ4+8CckktczIBmleclertHtLSTnHww8U5tMQ
	FN4g+9nk/B+fme0syR2L5nT1RcVEOs1myPY+NfvbEGaFoDVnbV3HGi//djtD6UFsoC6o=
X-Gm-Gg: ASbGncs4VeMdA0GrB2WDpZBSQamDEbe7ASmu6mMTUnZxWVVD59L6vr6SgwksykerPQb
	NHscybZDx7KcBsxfszTaG5qi/6loy0D/4GZ3/O5PV0VswxS4nJoOTI5CMBhCkRvss8s4SZKQpRp
	oAnXz4fk5Ym9gyVnslaSX6tzxEEa0ezsOS4znMZ1WASlvGr50pCChy7VnJVic/T2/6Gw878kQ7T
	DKXoPAciBbrw8h/TtzWzsjRWlDKy2B00eEZIKEUzlxlN2CZ5EOvQdmtgodjuSkqrXSeRbUnYzcQ
	zWCJ5sUcsUpbyF0mkE0/GpvReJdtz4JG9WKh6nOxuKGTgvdf3AnJuzdOQ7Yi7nAxa00zMBTrdma
	y6MsXNtTrPvTw014apxTte0EWZ4M6gvpnzXyjifL23IgnNpX3bp+pLoExY/ECWpbn2mRZZjeKv+
	fx9/lC7k3ZI0DFp7elEq82JYDJwwk=
X-Received: by 2002:a05:600c:45c9:b0:46e:37d5:dbed with SMTP id 5b1f17b1804b1-471172d7ee5mr122639935e9.12.1761039870380;
        Tue, 21 Oct 2025 02:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETXIw4CRBEm7c+CrRa7e7TiaCGIZ5364ZZEDG9h9Uqo1MIuOZe6REk/G99LmxJ95M7gJl8yA==
X-Received: by 2002:a05:600c:45c9:b0:46e:37d5:dbed with SMTP id 5b1f17b1804b1-471172d7ee5mr122639705e9.12.1761039869981;
        Tue, 21 Oct 2025 02:44:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4731c95efb9sm153935405e9.8.2025.10.21.02.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:44:29 -0700 (PDT)
Message-ID: <a013f044-1dc6-4c2c-9d9a-99f223157c69@redhat.com>
Date: Tue, 21 Oct 2025 11:44:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/truncate: Unmap large folio on split failure
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kiryl Shutsemau <kas@kernel.org>
References: <20251021063509.1101728-1-kirill@shutemov.name>
 <20251021063509.1101728-2-kirill@shutemov.name>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251021063509.1101728-2-kirill@shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 08:35, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> supposed to generate SIGBUS.
> 
> This behavior might not be respected on truncation.
> 
> During truncation, the kernel splits a large folio in order to reclaim
> memory. As a side effect, it unmaps the folio and destroys PMD mappings
> of the folio. The folio will be refaulted as PTEs and SIGBUS semantics
> are preserved.
> 
> However, if the split fails, PMD mappings are preserved and the user
> will not receive SIGBUS on any accesses within the PMD.
> 
> Unmap the folio on split failure. It will lead to refault as PTEs and
> preserve SIGBUS semantics.

Was the discussion on the old patch set already done? I can spot that 
you send this series 20min after asking Christoph a question in reply to 
pushback.

-- 
Cheers

David / dhildenb


