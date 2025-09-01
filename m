Return-Path: <linux-fsdevel+bounces-59836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DB6B3E4CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15806188A33B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D172D663B;
	Mon,  1 Sep 2025 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVERd+mC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D077322770
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733108; cv=none; b=extpR6nc8jtWbPYkkbkUIE6Wy68DMnfRx3aOkcRXe/kn+qiJmx/QloDEvqVV432Go3lXm0GEVx/ZCuFX1wwpRChbm2iBcH6ttrs62ELIjr+2NLm+bbQyyc8U1GQRoc7wV56szaAB5UbkburtR1ofedkvtEFFvJk5eKqVsBBluHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733108; c=relaxed/simple;
	bh=ZMWh7VlysqqH7ClG4jbYNE3AZIc3W/HmNezuBGSEOJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1cn1JRAbTUVhkANKK3SoJFRUE74VFqE5OY7M0qAaM64xBKFDQMU/orXWmj613hNHUvVKjF4kz8axtGPG+KzgxRFSNMkpWYLJYbMmj6XVoi5gPyO9EQ0zTRZzU7eZCPVdFFfd8rvSo8BQoTLq+lc8T351zrBsUwlPHBI7NOrFbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVERd+mC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756733104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tnXepClSCa4TtmpEoW4LNnvfPXJBpj0jhMGD19t2OsQ=;
	b=PVERd+mCExzDiKOXtcatrllKxPoCJO2KgRuWOhtqBXPZeK/JDySlxuRtD9zO0fHphr45kz
	kuKsi8o6GWR0Ce/WwJOZuQUpAOuvYahT3JnkdkW0us3BGFXMMZPB2Vl//KDFI78DcBlUde
	wzSUhqWhotcRmBTw9rIVWfV9YDH6H78=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-bGUJSlBkNiu5ZMbOqopEYg-1; Mon, 01 Sep 2025 09:25:03 -0400
X-MC-Unique: bGUJSlBkNiu5ZMbOqopEYg-1
X-Mimecast-MFC-AGG-ID: bGUJSlBkNiu5ZMbOqopEYg_1756733102
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b71eef08eso21858915e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 06:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733102; x=1757337902;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnXepClSCa4TtmpEoW4LNnvfPXJBpj0jhMGD19t2OsQ=;
        b=kczzDW56zxX1P1vheDWRfaIU6pRRf2CT4u39p5olAptu+AkADYnEiWIl+7f6o+EuZp
         9W+z2zhf6vzJjYf1OKgsS+cYGVm+mboP4DJkJ0y2dNOXmG6eLp2SZ9sOGEFECjGXkmhH
         cv5X9vIKI/02tqntyqALvPMrMtVm7Vm50GvNvggCONmtVNwUSEsJr5wrkRwwh2s9bwAe
         9YYtGZFDjTnDIij6REbIYG2fVaj4M+2V/A/7y2rv/KBk32eP6qrm2cr/EZ2ridHcCYi5
         v4B5nF8orLVLldMIqwjgbfBYd8vr0h9yXdpIKu/mst4woYOlTmrhdO0buB5bM/KG1IHe
         0Jcw==
X-Forwarded-Encrypted: i=1; AJvYcCXmhmeRKnw0I4JiB1oESWu0l7oAkzFUsgdhuU7tyC8kVord79jR7E2HjZqsjU9fXcp/YDHXZCbIhL2jpgdC@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmfsMH4KFutiVgoci0J+I1a11C372reNCtfaEso9kDdCIBJ/n
	QmFUFXWzvTevusYaqOBCiKJW7f+QJFA+9mgL0bOUiKQLF7vc+XoQHYRKc/v5ViMInWxIO7kn1CD
	U9WVAIkemKV+YY0Bz/AX/VuyXRnXW2KvHSsHXkRwWLRiqv6np9lwxc+gtoDzn0wRJN0Q=
X-Gm-Gg: ASbGncsEO2/uZ/AZkSFVBbvOQNupdM64R1tr1kOtCuTaIvIP8FVSwUS2CjCuzHSg0rm
	9EE7oGs0++cSuzDnLJSIr2L2TYval6R5LzJU0ZvL1sEPeiIEwW22bs9l80kL7PiltqfBZVTQ6ix
	8HcuBW3jLPgOo5ELkVexAUCNl5g9EloE6pAxCIL2thESY7xgoRJ9IfrXeSHRXbbCRDAmfECE2ZI
	Hw1wOn9hWZP7rM78+2Rw5U9u0Vm+F7LYaMYzOjIgmW1LpUAhEHfxExnISEUCLEgkIJeu6KbDmoW
	Cu+QIdIFjutukoZhPKllAtDnfv+2/ENnVAdpM4QHQgK9WZ/Z2n9Fw1GI9SefXM71f3ySMoQl9TC
	HzptT24YtTb0Cu1Dvj5eGPkNvFVM+ZCc+RD9n01Lf0Gx8tfRbJtMOB7J7wcH+1w5zot8=
X-Received: by 2002:a05:600c:1c98:b0:45b:8cee:580a with SMTP id 5b1f17b1804b1-45b8cee5b84mr29479435e9.35.1756733101694;
        Mon, 01 Sep 2025 06:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn4DAGKD4/hR6ptaEjNoxJNELsNDQWoqjaZ80cydfGU/2h/6IoyZcnqEvOz4BgFx0o138wIQ==
X-Received: by 2002:a05:600c:1c98:b0:45b:8cee:580a with SMTP id 5b1f17b1804b1-45b8cee5b84mr29478885e9.35.1756733101175;
        Mon, 01 Sep 2025 06:25:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6dc1sm239218725e9.1.2025.09.01.06.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:25:00 -0700 (PDT)
Message-ID: <94ec640b-76cd-478e-9ee7-ff8597d1fafc@redhat.com>
Date: Mon, 1 Sep 2025 15:24:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] copy_sighand: Handle architectures where
 sizeof(unsigned long) < sizeof(u64)
To: schuster.simon@siemens-energy.com, Dinh Nguyen <dinguyen@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com,
 selinux@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, stable@vger.kernel.org
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
 <20250901-nios2-implement-clone3-v2-1-53fcf5577d57@siemens-energy.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901-nios2-implement-clone3-v2-1-53fcf5577d57@siemens-energy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 15:09, Simon Schuster via B4 Relay wrote:
> From: Simon Schuster <schuster.simon@siemens-energy.com>
> 
> With the introduction of clone3 in commit 7f192e3cd316 ("fork: add
> clone3") the effective bit width of clone_flags on all architectures was
> increased from 32-bit to 64-bit. However, the signature of the copy_*
> helper functions (e.g., copy_sighand) used by copy_process was not
> adapted.
> 
> As such, they truncate the flags on any 32-bit architectures that
> supports clone3 (arc, arm, csky, m68k, microblaze, mips32, openrisc,
> parisc32, powerpc32, riscv32, x86-32 and xtensa).
> 
> For copy_sighand with CLONE_CLEAR_SIGHAND being an actual u64
> constant, this triggers an observable bug in kernel selftest
> clone3_clear_sighand:
> 
>          if (clone_flags & CLONE_CLEAR_SIGHAND)
> 
> in function copy_sighand within fork.c will always fail given:
> 
>          unsigned long /* == uint32_t */ clone_flags
>          #define CLONE_CLEAR_SIGHAND 0x100000000ULL
> 
> This commit fixes the bug by always passing clone_flags to copy_sighand
> via their declared u64 type, invariant of architecture-dependent integer
> sizes.
> 
> Fixes: b612e5df4587 ("clone3: add CLONE_CLEAR_SIGHAND")
> Cc: stable@vger.kernel.org # linux-5.5+
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

(stripping To list)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


