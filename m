Return-Path: <linux-fsdevel+bounces-45044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D3CA709C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 20:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07097842856
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1B41F4190;
	Tue, 25 Mar 2025 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfOPRDuI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02651F2BAB
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928718; cv=none; b=nCBDwWZA1w1GQyb06dgAS51GoqnlR7p2NBWBJFYcYh46xlRASMVL11q+wbBk10tiGElthjs1hI8APYHeZUVU4tLw/fF4j90aw3JUP37Ydud3AyXaW3HA1RAlBTicDtWAOszFVVoKAZNn4nncdIo1aQUFd+VToSK+InPRfKHH6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928718; c=relaxed/simple;
	bh=2xXGFLVwkInmobcJUBE5/1UQyq/cvN0CxyPECWhZDZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=meyB85vECnzY6P76EWLL7rZG4UPG3UORhANVN2+u6iDuk4vFI4kRXIuBM3BwH2BtLsMiuKQ6cpotTxLj24JSEMdecYw8t0h0ua6i/KV/XQxIrpE4+W+yonHIZMgGzS8EKH6ODvwcIPOSKzvGdNZRH+mcEVrxO04toQFDbhiHWW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IfOPRDuI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742928713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t8j8FcQOo2vXT0+x/EC8FM0KhlfrmjmrMAU0Mg5SiOs=;
	b=IfOPRDuIJb6mcD26eVv03HxOHVXjlqMmW0qdvja63G+EVtDAVTS+71vN8WxEgkUXbDe99M
	F67N3MqKl7LwUKqlMCtKh+lQlo/4gADy46882U41Z5/rvMgl+tWjJ2qPpXZZMw7G37rYlA
	IDue9AQ4G+f8s20KPbZEqVHW7WgO2E8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-HaX77_8bN8aBi8NS0Mjf0A-1; Tue, 25 Mar 2025 14:51:52 -0400
X-MC-Unique: HaX77_8bN8aBi8NS0Mjf0A-1
X-Mimecast-MFC-AGG-ID: HaX77_8bN8aBi8NS0Mjf0A_1742928711
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8f6443ed5so1879926d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 11:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742928711; x=1743533511;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t8j8FcQOo2vXT0+x/EC8FM0KhlfrmjmrMAU0Mg5SiOs=;
        b=PfCfchkiEXiDZUqaBzWTH7gdc6hIMEE9KiBhwrB7619Sw0i8d4dTFkFV6bhs5GieOa
         fszdfjNe3XFXe4QwKE5/dXUJs2VJ62hWB+hIshFZXR7qdtOAMz5+sE+ZyjDYE5eCPgIQ
         xTKjv7ZWRUHl1wENmO8+vF93BjaiFcwWcXIbZRLqSesGeeMTL7ULd4TpW0BQvZBJbX2R
         qLzvlWi4U/JSAYJo2hzBYcIGEDBcyp/YVs5a8GT5rpJ5MBnyfR6Op5bGMHtOrNQs/x3j
         T8BhMgiHpuvzCNpaf6zTBNjdG1y/B9xRapfURRwId5CXAH2c9AC/0/4zujnBpMYfsAlT
         /sjw==
X-Forwarded-Encrypted: i=1; AJvYcCWvJpTa8KLlglZcmzul8vJVfSrt5oajb6TPM75gG2V7GvTUAcr+x2vdnYoaIAlL0M79aX5DYWds+FoaKPUQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyLfOPMbxoqDc58wuydDw5It38U5xtNnanQsXoOZP0bNyWMV/OU
	u0PrYtkk1E1awgY9ZGKHKKHiLD7XF2lMDkVDXssNWqYMfUNXdpsBmpDfUFrWsSjz2bStvAPO2q3
	pBQX2Ww4dSgUC9WKAV/kYQXGOGDMAF69SAXludXtYxf1BmTZkn9unbobR7NXmstM=
X-Gm-Gg: ASbGncuzY8cMA59Mlv9XYg5QBV1GX3+FrN2/46JaIjVgkpABMgrqXfEsPXYM96JTWPw
	MjkLlVT4NyqFKy0cWHwR1nKekaSKpwS5ayiCN0isJzbFN3p45FcsIYczzXuWqK6gj1bUXRbCwfE
	xuMma+IS5eMNyXDj6OkU3K/GIzVc1tq5FwaxAe0U+MPzfyNwphpoEoP9aNZSeUsBe9yjsEc82du
	Qn0jhHiEtbulzKOeCdBkAF7hi3HmuX8u3y9e/aZWDPJjqtTkyx6uJ0BmlZSWOJnSBw3L0u7o04P
	mbBeSJLpgF/R
X-Received: by 2002:a0c:eb46:0:b0:6ea:d503:6cfd with SMTP id 6a1803df08f44-6ed16cde3f6mr12230336d6.19.1742928711421;
        Tue, 25 Mar 2025 11:51:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqYQjFn4K1j4fuehDL2vDnCV4xeKoEsPSC3k3g7nw2h2mfdx1DkNTmzNbOxS9v9bBBC08uag==
X-Received: by 2002:a0c:eb46:0:b0:6ea:d503:6cfd with SMTP id 6a1803df08f44-6ed16cde3f6mr12229966d6.19.1742928710955;
        Tue, 25 Mar 2025 11:51:50 -0700 (PDT)
Received: from [172.20.3.205] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efc5952sm58924306d6.83.2025.03.25.11.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 11:51:50 -0700 (PDT)
Message-ID: <0e1d8823-620f-420c-86a5-35495ccbd10f@redhat.com>
Date: Tue, 25 Mar 2025 19:51:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V3 00/43] rv64ilp32_abi: Build CONFIG_64BIT
 kernel-self with ILP32 ABI
To: Peter Zijlstra <peterz@infradead.org>, guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, anup@brainfault.org,
 atishp@atishpatra.org, oleg@redhat.com, kees@kernel.org, tglx@linutronix.de,
 will@kernel.org, mark.rutland@arm.com, brauner@kernel.org,
 akpm@linux-foundation.org, rostedt@goodmis.org, edumazet@google.com,
 unicorn_wang@outlook.com, inochiama@outlook.com, gaohan@iscas.ac.cn,
 shihua@iscas.ac.cn, jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn,
 drew@pdp7.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 ctsai390@andestech.com, wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com,
 josef@toxicpanda.com, dsterba@suse.com, mingo@redhat.com,
 boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn,
 leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com,
 samuel.holland@sifive.com, yongxuan.wang@sifive.com,
 luxu.kernel@bytedance.com, ruanjinjie@huawei.com, cuiyunhui@bytedance.com,
 wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, ardb@kernel.org,
 ast@kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-mm@kvack.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, maple-tree@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-media@vger.kernel.org
References: <20250325121624.523258-1-guoren@kernel.org>
 <20250325122640.GK36322@noisy.programming.kicks-ass.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250325122640.GK36322@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.03.25 13:26, Peter Zijlstra wrote:
> On Tue, Mar 25, 2025 at 08:15:41AM -0400, guoren@kernel.org wrote:
>> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>>
>> Since 2001, the CONFIG_64BIT kernel has been built with the LP64 ABI,
>> but this patchset allows the CONFIG_64BIT kernel to use an ILP32 ABI
> 
> I'm thinking you're going to be finding a metric ton of assumptions
> about 'unsigned long' being 64bit when 64BIT=y throughout the kernel.
> 
> I know of a couple of places where 64BIT will result in different math
> such that a 32bit 'unsigned long' will trivially overflow.
> 
> Please, don't do this. This adds a significant maintenance burden on all
> of us.
> 

Fully agreed.

-- 
Cheers,

David / dhildenb


