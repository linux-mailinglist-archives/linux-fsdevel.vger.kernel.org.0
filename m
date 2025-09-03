Return-Path: <linux-fsdevel+bounces-60144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26808B41D9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 13:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E1F3B50C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8922FD1AB;
	Wed,  3 Sep 2025 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/TL5GfH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87A62FCBED
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900130; cv=none; b=EOkA5wbj0h0HWWIgvJ8uwF+dOXFX3c6DPit04oC5tzZXqDjfmozEd972a02S0xX5BIscBiq8o3dCBGSDKvOod/NZWGK5kBd0P8yW53lmysZ5LFoG97MBB69mW3m95uC436YGb38JPHBd7+jQCsfG9DaOKf9xIEF1xcT3lQGxYIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900130; c=relaxed/simple;
	bh=FuWjq/VGD+DJoMcm9tn6kq6gr2gGFfSFv5ELBSeha2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRe3Znbb48yfR8D5fpEIzznU7n8B43gveA4BSLvZcWxs9ihd+kSj83Mu5Lk7Z0J4DQo8Wnp0OvN2RtJwO9J94g5Y/ohZmZd6KvwEGyYOkwjPrtjtV+ITWwT7wiXwiFTH1Eayv8bwtWPy9PyHNIKxEneJ2V+QIlrJFEs2WFltIOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/TL5GfH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756900127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9fskFHFKy8pWtY68FDaB3pDM0GOCCbDHm7LYaE+YR5M=;
	b=Q/TL5GfHDNDR9HsUgW7RnbdDlbgSBSnzv3wDCTAFKXGiJbKsue024e1yLUKd5y+bCK581Q
	LsCXzR6ojsXwftPNfmUxFEsTcQ9vsgdDzgeIlZFzToujYcxNnOqmCo3aAmAcM8Ggumvo0V
	C8/IpnWsqFmDN6V4FXhHu95ZD3w/Kr8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-Az3eNjowMX6wtVY1UEB6NQ-1; Wed, 03 Sep 2025 07:48:44 -0400
X-MC-Unique: Az3eNjowMX6wtVY1UEB6NQ-1
X-Mimecast-MFC-AGG-ID: Az3eNjowMX6wtVY1UEB6NQ_1756900123
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb4f23156so5185735e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 04:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900123; x=1757504923;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fskFHFKy8pWtY68FDaB3pDM0GOCCbDHm7LYaE+YR5M=;
        b=YVu32VScZ7NUmvHrZTBW4maAWLN2ctlTGyhQGX+LEiyRetW469yX+rq8ru7Hi4Efv1
         lKPypIHwXo32r7BEQs+pByy2ZPic5C+Lg/ABVhpABBv2KIAVjCpmlqJFY9AgOapKuQcd
         RBFtBBnTaSIw3NeKiUHv/olTxrQxD2BbiO64LvvXlAWaTLeXVZCo7+pHvDPbMoxDC1Mr
         3C8lNMXPSnCTLDS75PSTx/WW4iE2nO0KR82fzMe9NQd5t4hVfxDVZUaZLgZEauDEJXQt
         ub1Q/MaslDiqG0rE9Ctwt11+I8TDjEjowghpsruTD4NrGg/z2ucaLQIICusLsTQ1BOWT
         3grw==
X-Forwarded-Encrypted: i=1; AJvYcCWzdu8yV+5eX/I66wkorYJKG5C0UxTlneH64QK5XsXxSKNYMuy9oqwJyjaGiJ+o6iTTXx/oMh4UtAjxg4QY@vger.kernel.org
X-Gm-Message-State: AOJu0YziP8H8PJDjQgfhsWttmOPz1sdBZiLvCxU/yNfAqMDrvUq+Ai/h
	rbRGMmtU1G8IBrWUEiAiOz6fiI9Lf8mS9Lp6vyIvRmqZhszdAfBSzGe+95/a/dAbozXvweNfNF/
	Ji/klhX2mWvHe2K//+NO4Jg3Y9RON0b6Kz8Dg89Ruj+lXxG9PbC4tG0R//mHtNxxBRGA=
X-Gm-Gg: ASbGncuJ/DCQUDc5eGbYdnvcOLnpfNjVvQs9hn68k1qcdIrST7coJknGqQsxQzW/gRr
	cakIMHm+O80PC/FEW5O3RcOVsbHDei3Ud251PUYXRYw31ZIqcdzHyvpuqp4MM7zxaKxcBpq3/tQ
	OtKODTbxOKAl0EXpbQgBwQjpOAFLlme6KitTZEkQGiw25BOKzXfB8WK9e5dWiKsRtQwtgR3zAbo
	YF3H6R+t/hwVdJ6+wsIehipYcl9kJ/xcQODQ3BX2gCEEwY31cBSk0dANyqUtdgkEmGc6V7YqmYM
	4pTVAS+9OnXjmeAlFc+cbRXn3PdoDv+HLyRRlL9Parskrvj8s5mLDjsSpr1enu+GV+M3RkiOCjn
	i0hA1SGH5PDT33VKbqY5xDT8AxBpJ7UeF7Zlg8J/XloekMsP94/9f47AvGP2QRBEZHss=
X-Received: by 2002:a05:600c:46c8:b0:45b:80ab:3359 with SMTP id 5b1f17b1804b1-45b8549c269mr122551645e9.0.1756900123474;
        Wed, 03 Sep 2025 04:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu6+SjXHIDgMWn6JMwXuHWuutLrnUaZBJPg9aph34ZLiYPxnSzFrJmXI+54wBD6epzcXeeEw==
X-Received: by 2002:a05:600c:46c8:b0:45b:80ab:3359 with SMTP id 5b1f17b1804b1-45b8549c269mr122551435e9.0.1756900123019;
        Wed, 03 Sep 2025 04:48:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:9c00:8173:2a94:640d:dd31? (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9c234b24sm52093845e9.16.2025.09.03.04.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 04:48:42 -0700 (PDT)
Message-ID: <e130c95a-103c-40ba-95d9-2da4303ed2fd@redhat.com>
Date: Wed, 3 Sep 2025 13:48:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] mm: pass number of pages to
 __folio_start_writeback()
To: Joanne Koong <joannelkoong@gmail.com>, linux-mm@kvack.org,
 brauner@kernel.org
Cc: willy@infradead.org, jack@suse.cz, hch@infradead.org, djwong@kernel.org,
 jlayton@kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
 <20250829233942.3607248-2-joannelkoong@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250829233942.3607248-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.08.25 01:39, Joanne Koong wrote:
> Add an additional arg to __folio_start_writeback() that takes in the
> number of pages to write back.

Usually we pass something like page+nr_pages so we know the actual 
range. I assume here this is not required, because we only care about 
using the #pages for accounting purposes, right?

-- 
Cheers

David / dhildenb


