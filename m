Return-Path: <linux-fsdevel+bounces-55189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96681B08059
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 00:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080694E5AC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 22:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60CB2F0C6B;
	Wed, 16 Jul 2025 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjNCPRfn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA06A2EFD9C
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703990; cv=none; b=UYmUJeEfV1NtLd7SL77jp9ZOvxsZU6cK0eZsXzv/sv+VpyqE51bW/i0yyo8FFbibw9j5pSHv6qVpfKLeDDLYrWDnsw97FX8vk9j4jkdJCilFfqbI8l84B+PpLyraHaw0xqXOH2U71nD2rhX8TwvCndJhSmrKeH5O7DcWxV+12yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703990; c=relaxed/simple;
	bh=g/0rJDTh62fs1OuQGY6mWv2+fbtpd2JeUzuyMQjNtBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XppwYzFE5cUaE04pUGXwiP8MVAR2qFUY5B4OglgkCUsSYPiNmQJIG/XJPlc9TS5cBgZrNQV26GmbDUtDD3Eqq/cL2nNYDrEqBd1VWk9z2SvrquonXRP/3AUk9MLS1nPf8FB8EemWVuwyHQZtVqbAmRTMQu9MAjBKj/0y7JFgPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjNCPRfn; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748e1e474f8so415807b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 15:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703988; x=1753308788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yu1Y/WX4LI1/OWJ9l9Sh1nJTCwMnldh9Ue9QETFr+pU=;
        b=TjNCPRfnDZAx/rAVq50sJSDY/1JGILyDQJ64WF3SmoOKREXn8h9bnmAj6swjraIbn9
         2x7wQzlx4zDlQYrtU5lkx52nbYEfOFImklBGVG6lC20rTP7TNK3tFt7588WEwmjLPhZG
         lPr1bdXa7K0/QYeOSXvWmHGrytEAWlUt1fZKoPCTnBYZBaKQQYoaPQmTp9BXKV0DOs+x
         6/LnjZID8w6X+E68dj+Mrbs1LedOGp8FoRyXRtBl8DqrJpoJQqo0SJ/fvjir3rLO6lX7
         dr+O6sWw9XdFmBUJSnvB/xS5SMm1GmrnJLkxKE+EDFDx9BljP1mt2fJI0FdyaM8ENy5r
         YU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703988; x=1753308788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yu1Y/WX4LI1/OWJ9l9Sh1nJTCwMnldh9Ue9QETFr+pU=;
        b=eUMIf6maZwNycAd8uU3DjwGUMGRUMiQmIvqjmJfY3BBeUySXBKzC1wEUg5NJHCRAQN
         LTTzON+vlV3wajF7G/+qt8XiHc76mCcIBM7XzHI2jnQz0qgHUhLk84JUkno5X88Pabmi
         B/etx1lng4Ystl+5vxiqEZcGj/SYZvRR8YKnhA92hgp85yQBL4Zou1mVtmA38ljByqVd
         MgktIbBd6/A5tZUev0xizZ89SZR3sMrPfxP4jPa/ofVLCesUXpTiJDNfjqgkHP78WRhg
         DqHVjDY3WfEwYuc8rXNcdCN3E1q/FYnZhartPG1mYygCNbnhL3vqAYyir6XkUQB5LOTI
         xaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKxYDJWkpFZ1CaDz+NB+vgmHHdcorkl5fsbqBbCjThLUwoouNkwp0DkaS2+7vbO07RqaVtCYGS3A5ZggY9@vger.kernel.org
X-Gm-Message-State: AOJu0YyeoBcXC6CL6oY4+jgO/711Iu/spW/GOaY2416/gr7D/QcLOSqO
	oy8rtQxs/QrZXHdYYNCvHJ0256a7/lwvYGbI4ucH9mWXxO0AT0ZzkI09rEgKXRVzxRV5+Q0Txt8
	qCMOqlFuQgE3kuVDleqfVckiKWQ==
X-Google-Smtp-Source: AGHT+IFTIyctnARP6DvIQOo3ksRMBxmoodQwklk+iQs5yZAGv2sb7oP8liEWVf/ikHodKNA/Kg6t20noqC7nJOCkXw==
X-Received: from pfbcw5.prod.google.com ([2002:a05:6a00:4505:b0:748:f4a1:ae2e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d53:b0:748:3385:a4a with SMTP id d2e1a72fcca58-75724e89802mr5954852b3a.23.1752703988027;
 Wed, 16 Jul 2025 15:13:08 -0700 (PDT)
Date: Wed, 16 Jul 2025 15:13:06 -0700
In-Reply-To: <d0b582cc-0cf7-4cdc-b148-d8f61dea7253@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <e9aaf20d31281d00861b1805404dbed40024f824.1747264138.git.ackerleytng@google.com>
 <d0b582cc-0cf7-4cdc-b148-d8f61dea7253@linux.intel.com>
Message-ID: <diqza553hjil.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 33/51] KVM: guest_memfd: Allocate and truncate from
 custom allocator
From: Ackerley Tng <ackerleytng@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Binbin Wu <binbin.wu@linux.intel.com> writes:

> On 5/15/2025 7:42 AM, Ackerley Tng wrote:
> [...]
>>   
>>   	list_for_each_entry(gmem, gmem_list, entry)
>>   		kvm_gmem_invalidate_end(gmem, start, end);
>> @@ -776,6 +879,16 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>>   
>>   	start = offset >> PAGE_SHIFT;
>>   	end = (offset + len) >> PAGE_SHIFT;
>> +	if (kvm_gmem_has_custom_allocator(inode)) {
>> +		size_t nr_pages;
>> +		void *p;
>> +
>> +		p = kvm_gmem_allocator_private(inode);
>> +		nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(p);
>> +
>> +		start = round_down(start, nr_pages);
>> +		end = round_down(end, nr_pages);
> It's weird here.
> Should the end be round_up()?
>

Thanks, you're right.

I believe the current consensus is that fallocate() will only be
permitted for offset and lengths that are aligned not only to PAGE_SIZE
but to allocator page size.

In a future revision I'll check for allocator page size earlier on,
before this function will get called, so this rounding will probably go
away.

>> +	}
>>   
>>   	r = 0;
>>   	for (index = start; index < end; ) {
>>
> [...]

