Return-Path: <linux-fsdevel+bounces-34087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6FE9C2530
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 19:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9051F23D2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A671A9B4C;
	Fri,  8 Nov 2024 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DE48Isl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CEB233D96
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092189; cv=none; b=lb8x+aNPJdfIww6dBl4KMRWSFwMuSxlkR2wQiEf8QgDswgiU7m72tyDYbxTNcYNf5ANSFEnUgnRYpsl7Rs4HKMMMELk+ESR/AAJnV/eplZfReCJvFRM4F11DK9RdrJgnflS88Fv+u1wnvGEcJUopOBq3Va4/19TxDSLwu25rE6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092189; c=relaxed/simple;
	bh=crffLENpXBp7rOKAeIHZsYF1KIfcUa5qg6j6Hh7W/qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drJo8XKXgPpKmbkEq6MzhOqj49sYDilCe2qlT2hxIo7ZaFpEtxdUpWTC+u0qd7BYov6SIOLUYPfen5sPdjdFoa561q4PdgfiQSpZlTwhIj4+apKpT8WvFdSjCCQfLEdrbieW6LQaMxzc+m5VObLMPc9tyLas7B0c/t2g8I3c8/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DE48Isl7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731092185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J+I+5BFvbPCfW1HdQwPZPMhISIQ+GkdJt2xQbEb1CqM=;
	b=DE48Isl7K8++Hv7ulUtEhQclGn6a1w5ElKpvkMIrst925gkFrnJtjWzFp9qj0CoElhouW8
	yui/YrW5CV+Tx4mL7cbRKqN/aXQV8Py3dh7mNTKYwEhvkBLoqcdV4fpVw9wuoDngvfg1o5
	yAUC7iXklJfbj6dd6nfAJe6r+gf3fqw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-LZ0MKlf9NQqbS8DPnOO7cA-1; Fri, 08 Nov 2024 13:56:23 -0500
X-MC-Unique: LZ0MKlf9NQqbS8DPnOO7cA-1
X-Mimecast-MFC-AGG-ID: LZ0MKlf9NQqbS8DPnOO7cA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d462b64e3so1250551f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 10:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731092182; x=1731696982;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J+I+5BFvbPCfW1HdQwPZPMhISIQ+GkdJt2xQbEb1CqM=;
        b=Un8p9HiL7AgfYtrVSV90SmtbfQfRwb8e+jhFVVNgY/5b0bzu+blFtCna8O5Et+npPk
         q5xI3QuOQAqTjCOt7i0zq+G28hmfIA6vVyCAe1HextAXfoCW/C1rwZVmItIqOZYGlLFY
         H90wd4g3I9zhTKfnG3Do9n69i3sp5uS5dz11gaFOcpSfX/t8JC1VAbpWtDIv82J/0gtt
         04FTQPUYCnf3QVNYlSNpNiOWUbgwax0m6u4yEJc9ucNFM7aJGP+EMiOrSxSOWjMETzxB
         nT5iS8ZTCtxQp55wfmvpyvFiYglIlkM2Ro6Ljuy/L6gaBAMJZ4+1uzrDJ9fSc7H2N4Ui
         5RtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRjJAFGeYfuBCZG/aFglSA1HiHNmmHe5Blri+Yz9T5NNhU2ujnp5L6nEu/8E+YWZtCmK2gdMziWgvAwwBw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3iD1xtJS8B5TJ9HOgW2EEyY3c5+D+5e0jVYPHea+Q5yZlzzI
	EAmPpKOX6f+9Ao4m3dNv79tTEDUsI2Ibk6T61bwEXJE82TsOrTPmXjninBSDiIuxhOFY9WXToI9
	Xk8dLnVGGhVWQaiyDf4cZ9xbpuQgmlzql13yB6wAssCYeeSIBCjGmUkWZ5LPLHvY=
X-Received: by 2002:a5d:47ac:0:b0:37d:5134:fe1 with SMTP id ffacd0b85a97d-381f1866a6fmr3368497f8f.17.1731092182638;
        Fri, 08 Nov 2024 10:56:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAkYj6A739MwOXmyy4DiGBziQqRa5Lpca7nQqTSnnT5e1mZHOuOPwVv/xiuNor5sootscIeg==
X-Received: by 2002:a5d:47ac:0:b0:37d:5134:fe1 with SMTP id ffacd0b85a97d-381f1866a6fmr3368472f8f.17.1731092182317;
        Fri, 08 Nov 2024 10:56:22 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3a:cb00:3f4e:6894:3a3b:36b5? (p200300d82f3acb003f4e68943a3b36b5.dip0.t-ipconnect.de. [2003:d8:2f3a:cb00:3f4e:6894:3a3b:36b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea5e4sm5836870f8f.77.2024.11.08.10.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 10:56:21 -0800 (PST)
Message-ID: <04020bb7-5567-4b91-a424-62c46f136e2a@redhat.com>
Date: Fri, 8 Nov 2024 19:56:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] mm/memory-hotplug: add finite retries in
 offline_pages() if migration fails
To: SeongJae Park <sj@kernel.org>, Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 bernd.schubert@fastmail.fm, kernel-team@meta.com
References: <20241108173309.71619-1-sj@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241108173309.71619-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.11.24 18:33, SeongJae Park wrote:
> + David Hildenbrand
> 
> On Thu, 7 Nov 2024 15:56:12 -0800 Joanne Koong <joannelkoong@gmail.com> wrote:
> 
>> In offline_pages(), do_migrate_range() may potentially retry forever if
>> the migration fails. Add a return value for do_migrate_range(), and
>> allow offline_page() to try migrating pages 5 times before erroring
>> out, similar to how migration failures in __alloc_contig_migrate_range()
>> is handled.
> 
> I'm curious if this could cause unexpected behavioral differences to memory
> hotplugging users, and how '5' is chosen.  Could you please enlighten me?
> 

I'm wondering how much more often I'll have to nack such a patch. :)

On a related note: MAINTAINERS file exists for a reason.

-- 
Cheers,

David / dhildenb


