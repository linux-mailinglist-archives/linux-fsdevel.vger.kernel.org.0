Return-Path: <linux-fsdevel+bounces-55137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5976FB0727F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98072188B032
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92A12F2C4A;
	Wed, 16 Jul 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z56YW7tU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D92F0E2D
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660278; cv=none; b=JxUPr6KvAN68wCfrSN0K65qpmjRKxSHN2PlF/U8h+ZOY3gaAz31sg1dWJCHVn8rb6KPmT63o2XZ9KozBBKjXcUCSR6MDdaUZurbMNiTJNqx9eTj9WvaeBAvNc2XnV/8v1Gy25MBvgwVtdKfNWMztEfApqiWjIxmzODeLRMN4OAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660278; c=relaxed/simple;
	bh=GzTkI91wkzl0CW34J8Ml4BC4dlssxS2qubsNYmJdVNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rol/UW+h+LLpw9GmAaRoUH1PT57qJaF4HfAZreGyU5ljpc9rINUCXktdcBVJpZ8IgYKy0jCN3Cst+wFFh2fPCYWW/mEa6upOsBcNMJzsoeCLVSCB6863JU2Qzra9er2PczzDa/ErEI4kKgAfo25Ogs9iQoMmarK0NbbLApntRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z56YW7tU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752660272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=thHVoW3ckHNKZ91eU3Sg0cEuktVVUYN0WORy8OgybuA=;
	b=Z56YW7tU8xkdxa1TDGeConmokhF+i7XfDnEdHprh8EE/QC895Ib7xQvDOpcx4o7nDsmPaM
	rKN6W5C2yGWOy2unbv2T3vrAMftQdD7yRYr9Mr6BEaU7lO/DOVIXp4kPbpm6Qtfz2f9ybm
	HzCjqnDNzSlzc2cPgEdSfwPvqqeH7LE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-tpdlSTG1O1GK06Y2L0C14g-1; Wed, 16 Jul 2025 06:04:29 -0400
X-MC-Unique: tpdlSTG1O1GK06Y2L0C14g-1
X-Mimecast-MFC-AGG-ID: tpdlSTG1O1GK06Y2L0C14g_1752660268
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b20f50da27so341555f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 03:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752660268; x=1753265068;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=thHVoW3ckHNKZ91eU3Sg0cEuktVVUYN0WORy8OgybuA=;
        b=XaKgYsyPHFjA8hEWe2Jj7XWxnNrYeTOWHpgRZ7I/tpJsJsPLaggyb0D5PnFyR1synk
         rTNhSa2tnW8md9D7RcEP9qfeM8tdGx6+7rLsEH/7U1sWGkE+rj+3qNqI1NdQnjD0hdEi
         NWEdbDmiK/bSjP/CnN+C/tjldBT707sC63JzL6XDlSy/dNrX56wCQaKHfm8mKfoMRtgR
         ceKxkYbSe1IiKPoh66YXsr9G7IkYx4+3bs8gHp89R7Cnzcz3xhaItVq8shWlF6zap6jB
         ipjt8L4lI1jS7PDS2CkOTTr9so6y0aji5VplQCnLP75nXIp4OuuucPZSjpaeRUNXvG7I
         T4Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUTMWF3DG9SHPPWaEWG+XvGw9uw+MZPyHZbOucC0EX/kXtyJmZK3E0Xi0LwQU8ipKCH6/RBrvPYDYo9V0bF@vger.kernel.org
X-Gm-Message-State: AOJu0YzNbtDn3oGjks84g49rRjxMid/tVfpghZ+jjR3GzzXezlIhPjZj
	yJa/mnB5RWi0wM/t64FuJlHi3fDwiupIUmrAQbBGWt27ztJdbrS0Tr7lSL8yM5uLRj+nLOBddSi
	2pjfSWEnwlgyIqs8o5I3CCpTWrR4jJUbCIXtsGpEtpcTWGRp82aTG2xLntY5f5pmoML4=
X-Gm-Gg: ASbGncvN7tkEo44KqLTFgTE5RryKOhVHwUhy0qdlsc0rXOdXEAFySga/yFaB8OIEAMl
	Jutrk0WaJL21n/NDqHuiTgswwqnd2cJHRLSH22mMPinpxiitomyzI0JEj6bYImQAn0PpUTEFWpN
	AgnWLK+Hq6VX1pWWHmSPzHsiBoOpaBuLUdN8xY9SD67/IJ4Bkc3zEzfs7qL3CJxEytRVFLj6qcO
	3zEFg9tDMrwp/JzQ14+jFVj5e8+mlKXrILi2vBlcNMWdn9XnbVE1TiZwKc6iFV9TIHiMr5RvFHh
	b+S5d6zmHFrOZNlILrwJSN4dUR2iLKLsWDdmHs9neExlAjz2RQPVIyTMS84iwNSjvAAeIGKxY/D
	oWSocxPcKBIxguD4yMnZUYczSnBj6WB87sSaHHnN/LWHU5Gt+EfIOm9QGB8B0ryJfU5o=
X-Received: by 2002:a05:6000:178d:b0:3a3:6478:e08 with SMTP id ffacd0b85a97d-3b60dd72d8bmr2069919f8f.23.1752660268280;
        Wed, 16 Jul 2025 03:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmZ7TggmyWMNim6dJ2U12/8Htb4derogTA/RMLqG7cA6zvZRaGViErj/H+kZRPjCEVgr00vg==
X-Received: by 2002:a05:6000:178d:b0:3a3:6478:e08 with SMTP id ffacd0b85a97d-3b60dd72d8bmr2069879f8f.23.1752660267771;
        Wed, 16 Jul 2025 03:04:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d758sm17075713f8f.49.2025.07.16.03.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:04:27 -0700 (PDT)
Message-ID: <7e0ec5b5-0359-4f79-aa5e-e1273f824057@redhat.com>
Date: Wed, 16 Jul 2025 12:04:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] selftests/proc: test PROCMAP_QUERY ioctl while vma
 is concurrently modified
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
 paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com,
 brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com,
 linux@weissschuh.net, willy@infradead.org, osalvador@suse.de,
 andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
 tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250716030557.1547501-1-surenb@google.com>
 <20250716030557.1547501-5-surenb@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250716030557.1547501-5-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 05:05, Suren Baghdasaryan wrote:
> Extend /proc/pid/maps tearing test to verify PROCMAP_QUERY ioctl operation
> correctness while the vma is being concurrently modified.
> 

Wonder if that should be moved out of this series as well. Of course, it 
doesn't hurt to have this test already in.

-- 
Cheers,

David / dhildenb


