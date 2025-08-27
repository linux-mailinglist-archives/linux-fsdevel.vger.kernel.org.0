Return-Path: <linux-fsdevel+bounces-59437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372EDB38A8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 21:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC211364A29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B51E2ECE8B;
	Wed, 27 Aug 2025 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5LlrHtm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8CB273810
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324634; cv=none; b=a9Nv0Ttofypj8myVQ0xaUo7aht/K7iLDhIncDrZkbKR5OAvnLdW3ZIcwIbNjvUrtV0MKNAAegapHSDe+dz2Iq5vR8PwrmBQLnrr+hPCQUzJQ2Wqy8NYCR4Blt+tFamDnldCb53lcjOO05lg4Zlwohgq4qssZCHqqb9zcqXSEa4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324634; c=relaxed/simple;
	bh=j65qgSbcORyR6mUhxelh/nAXSvHcmnZ7Hmr1KsAs19Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaFuWCnk67hiX4N7Jua6Vo6CLzOJCmSgg2/9QTtbcEfTki+TvwubBWsZ8TxwGuCMRm9pbYbBy85bGN38g8RzJnyK5alSFoTZS4y/A9tOQ3E4obT4x6FLWlHKhe99q0qBee9EiCvQ7wQtYFzeS84HFZDSM/3K4eDmHHGX4zVpCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5LlrHtm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756324632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WeO0im/QGecZr0be3griSovPXhUrYcztVBMRyg2pzV8=;
	b=d5LlrHtmhs9/xkVo2glGMwloqYTRs0u3pRs4oJIrf1YUWJ70shWY86p21OHh+BznV/Nkit
	mNsHcsCn1OSolKne/F5+H5tEad3NLHxu5LRMy+DWu93LVpCvoPoK1n4XNVFMH9rxO1WdFX
	Ez/perLuphiLIO5RiJUkUU4O70cY7Yg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-hZ9ue5B9MbyIx-Bf_K7Sdg-1; Wed, 27 Aug 2025 15:57:10 -0400
X-MC-Unique: hZ9ue5B9MbyIx-Bf_K7Sdg-1
X-Mimecast-MFC-AGG-ID: hZ9ue5B9MbyIx-Bf_K7Sdg_1756324629
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ccfd9063a0so60114f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 12:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756324629; x=1756929429;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WeO0im/QGecZr0be3griSovPXhUrYcztVBMRyg2pzV8=;
        b=AFnbKOBKHCN5VJrtIebu7OD3r8brxtouCZql4UNEKjlLNrsh1C5gODiAjmOy5hqxu3
         Et7OYQ5F7kJCl2aRhsXhFbcU90TWjxUfEKMlpXZJZ0+ylCjNG+FOjR/7HFNbOh37Y+qS
         C/bSct/NfHOFnjynjo7R8KYRvlJWGJpYq8ZZjLNBiQn5ipFxvL0xDtmqlvEzpjobBAxS
         R9VaBiWwS+ooX3B//lMZ6dDmV8mQRensFQwP1TfPUVBnlEQD9RHBZZp94sd+75bEu/bH
         ycLc2RxVF/U5Z9WrYh+Erp7SsQnRyDHS7lop9DOKNINLWmnIpPjn5OUFJIzc9tvL+nYZ
         DAYA==
X-Forwarded-Encrypted: i=1; AJvYcCWmsvMF7pMmrx9kZ1BzunbfvGHo4+Aw5ecjGCi64ryty09gGYk1EGHIE9/Eqg2JI+2ddprvcu0dyXBChLq3@vger.kernel.org
X-Gm-Message-State: AOJu0YzYyYKspgsoACh1iahf7wjWFMKyl4omDerKIdP12EUOT9G83kG8
	bJTxmHKBViLQYlw2qpymsIwmrU2ofH+V96SeiwCESEfbypbQNnooNTOMEBi1IwPgnZXs9iLlkkX
	qA+g+AnbNZphlhDFASNdoEFV2rN2YI8mQyPFywadBu7E9/wP70dBtmUKTypHujTdSnsA=
X-Gm-Gg: ASbGnctAYhrIT0EkMRCnSWUPjuMTPeU21z2U3DwbOpwSw22VBooSb6YPZF4LEfH6Iig
	CWZxH6VCuv9bUGFsx9gNXJ+GXQVnZOEhnqpzG7NXFheQomXiqTLqctawCXyzuluve0dLkpNZ/+V
	x5V1FxCyAz5BbaTJKUNCqjvlsYmpO1UrB7B3zONGsCZa9LRQddoMusSPlVanXDWDcPwel4CrcJS
	x/QQMpeAR6Y6enUPnEKQLarQ3MzB0qAB8hwFF3PGMhQ4cV+BglJdRgm1bPmXJXrR86gi3Un74Fj
	we60c235n8y4bfP/rePr92uO8+8zmbWc2qOm4uqeqQ9nfty7tdlAGuBvlVynZUgsPQ4LVls=
X-Received: by 2002:a5d:5f4a:0:b0:3ca:5708:2b0a with SMTP id ffacd0b85a97d-3ca57082f7bmr6237661f8f.4.1756324629118;
        Wed, 27 Aug 2025 12:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw8SR9bQ8n/6/JMeWtNWjuCDZmep5VhDu+OqVpD982EgtQAreXteDUKqZxzqH1dML5SdFe7g==
X-Received: by 2002:a5d:5f4a:0:b0:3ca:5708:2b0a with SMTP id ffacd0b85a97d-3ca57082f7bmr6237649f8f.4.1756324628685;
        Wed, 27 Aug 2025 12:57:08 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1fc83.dip0.t-ipconnect.de. [79.241.252.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cb901975adsm7882053f8f.8.2025.08.27.12.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 12:57:07 -0700 (PDT)
Message-ID: <345d49d2-5b6b-4307-824b-5167db737ad2@redhat.com>
Date: Wed, 27 Aug 2025 21:57:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix lockdep issues in writeback handling
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Miklos Szeredi <mszeredi@redhat.com>, Joanne Koong <joannelkoong@gmail.com>
References: <CGME20250826131210eucas1p21a27a684042f37080b7a19599f479b7a@eucas1p2.samsung.com>
 <20250826130948.1038462-1-m.szyprowski@samsung.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250826130948.1038462-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.25 15:09, Marek Szyprowski wrote:
> Commit 167f21a81a9c ("mm: remove BDI_CAP_WRITEBACK_ACCT") removed
> BDI_CAP_WRITEBACK_ACCT flag and refactored code that depend on it.
> Unfortunately it also moved some variable intialization out of guarded
> scope in writeback handling, what triggers a true lockdep warning. Fix
> this by moving initialization to the proper place.

Nasty

> 
> Fixes: 167f21a81a9c ("mm: remove BDI_CAP_WRITEBACK_ACCT")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


