Return-Path: <linux-fsdevel+bounces-75165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jG6IFh+pcmn8oQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 23:47:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 871716E488
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 23:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1BE53007AD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB893ACEF5;
	Thu, 22 Jan 2026 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="efb65WUp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000C8388872
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769122061; cv=pass; b=BxvLMXX7IUKD39W1hrHzQQfXzAHMVJljp89agA//zGpFS+XNt5ZhW8Hd0w/1qzPOJvXQJcHWErqAq1FOgSL4V5Vd2L+PuSqIKTyFGvhGVin1PRpSFDPwml8eo1j0Uz7o8cQ87JjlhGYq65XoZcmV7XwYHR8gn6B/lWOQuep54iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769122061; c=relaxed/simple;
	bh=xs+dLd9PKnX16GE3/TgauaKHwwAlEIk3gXFN84JGCiE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFIYwhwKsCgoZPkol8RIKPJCcSkKYiD6DeCpICAMvFjx7UbUceqjQgJG0ThMjFAujIrXtOvdIXMWvvgKZjIglq64/YV2tgy/LzMP2gyhfGGC/RLIlopNCizof7JC+myAMpDQL46JYzjCDbZlykz6iRwd0ywc5ukILZpsROtqLt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=efb65WUp; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9413e5ee53eso1125236241.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 14:47:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769122051; cv=none;
        d=google.com; s=arc-20240605;
        b=dfJP0gnaiZ9r1vKgBLMuuku3CQ/Z8SGQl8dcxzr6cCj/wT0wrnmt840CmdeitEmzjD
         3PjNeh/u63XlXjyhNq8+kvi2x265Svq5WzKiz5zRbRPWYvZH/+hxk+5RFcRXbl+c4c5F
         QkkKOvUOm3qC7M1ZhPae3XONq6DbPejHlpcUmxnuz+5sewOKnx1r1pTLazMqO4iA0ynW
         oMhdAMpFx2p2mrFLpuJyw9Mwj2vDYjHqEIkH4nMleqQHpa8+ruL3UMTf1rvKhtdYU6MJ
         rqsS2MA3yrMo3vDUzFQlt0oleODGP0xDQ+s2zLh9u3a2VbIG0oa+SP1Q4s2OY0xdWzwQ
         eb4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=xs+dLd9PKnX16GE3/TgauaKHwwAlEIk3gXFN84JGCiE=;
        fh=U5DlY436ynqu3yBrH1cuTEsHrzLmn84w8sA33bca7Ag=;
        b=Vt8ubXnTr5ZJgjGf+fa/GF9bN8SPvboUl9jaLRqrikBVQ29NtfrBIndsztFg55joGT
         JYhCz75sCZaYFiSZSsTAlywrSrcBLgRBLYDUhG7xuy/UPbmiDUNSmBz+pA0q4s+QJlOy
         XWSASkpjmhELWdWa/vL8uLQCab5RP7Mt7nWqSKAY2W7+SiTev31UkB9Aml+Dn+Nvv3yw
         eWp0RhTT3SrwsdhBv7lhXLPnUXqh/PdVaQHaaM7SkWi/eV2p/qI5pbTPyB4M7IpExGFH
         2e8+tOLX4fmxWBHFcJOdRf9veerbpSGfava30mill6kwGABhcT4WQXzubMKgcEMm5pLi
         ra9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769122051; x=1769726851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xs+dLd9PKnX16GE3/TgauaKHwwAlEIk3gXFN84JGCiE=;
        b=efb65WUpsdnX9MYn5Ketl7Aqg/S+LI5Twe86EAN0CJTXTQi0SV6Bc272kwWB7FV0YN
         VTMlkEUN8MS6bLkGYmILKii6n/XJ35CPl/ILj3DG7K3xM4+6SS49g6yrAvmzWytKVEOD
         T5SY7G9OaavZfDvBTD8//I95ljshXWVriDkG6Ob3ZNbZhhRFOml4NIXTj6qn7LZyAWAQ
         xVorS0Du0q+93wf+l2qMsTaHfD6Teinzsu04Csei+HRHvjEQI3gZYVMuVqWJCuRqmfuK
         4swpPyoAFWCfix/BNwv0dlaxb0vbG3lHkKG0G4CbblEPQTn6grdmtf9GRYYV07o3eWEX
         6TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769122051; x=1769726851;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xs+dLd9PKnX16GE3/TgauaKHwwAlEIk3gXFN84JGCiE=;
        b=Q6L1RDWO68SIYdua+1ZVjxApWmpSmcT3MIA/0krtnqN3/xz3/dp3Ghk+fjKkeFbIu6
         LjzrNVluVtfSOZFaabPB2AAr5AlR2z2eLfrDka58G2WLdrCQZRI6dT8M9r+ZfY+/uSjr
         ScSp2UGJvHGGMYlRDDNxRTccCXwesah37DB/ZM/M9pEPUd9JoAZ68ZOsAQKHohiw8OWx
         ZXhkhb2ElLw/ajwDrJNkA1ou0IDA4rr3GlSZ8T9q5Bf8iYCt515/9PwoI43YEJ4FvnEc
         cWie6IP+SkahiZIav5jQIzOX/Ubf3X84RqllbTCtROWP38rlamNGC32BPNyJA0FyjkLs
         mvcA==
X-Forwarded-Encrypted: i=1; AJvYcCXKXSMaa0SnOUyEkfxeIFwTF2XMth4rZv4I+0i84AZ4/WwgUVuamSgcCDa6S9EQPkOjZpBmxeOvw89NRm8+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/vNHG/jVx0pY0o7n0lGN4HXK92bb1QnBH3wuyR5VYt/IhToQW
	PNp8Qdg/9hQ4OfyTmErvKmSCRkUJRCZ9RlpkMjORZ95RAO59+uIFbvYNMY4J8WFaWfCM1LYvWeK
	8fBEVVxAqqB9Nl+BE5FvpOXb+9VNpG8lSPOT5N/6h
X-Gm-Gg: AZuq6aKarPYVY932RamqaqH8b9fEKxYYKGJBBLARQ37HpXwypGqh04XsokOlkR1rFsI
	jPsYou0KzI9SMouuBuT+UaA/bKJ9hYxGEoY/1gHLWfU3OCZ2iUGDdKXQHNrRfWLkKhQ61Yx7DcJ
	07QtaeXP01NhcLvQmDiH1IuSNfA93I7i0SanQ55RCrmP+kkqtvPiMydUvhTkEg2jAdVW4GndcVp
	7QYx6ssii/CTk1JtifnaLq79laU/C6YKIhZVVXAzFOxrpzqVUEXZpXrkjGHJadyXM5O/tiUdqM8
	cGFAwwIAFEnLqgINFoTBb9ROS/4H5ko5c3I=
X-Received: by 2002:a05:6102:3a12:b0:5ef:7220:bcb2 with SMTP id
 ada2fe7eead31-5f54bc8224dmr480092137.28.1769122050230; Thu, 22 Jan 2026
 14:47:30 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jan 2026 14:47:29 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jan 2026 14:47:28 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ee9c649eed3893d852c3d20fb96bdc4904b7c295.camel@intel.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-8-kalyazin@amazon.com>
 <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
 <CAGtprH_qGGRvk3uT74-wWXDiQyY1N1ua+_P2i-0UMmGWovaZuw@mail.gmail.com>
 <8c1fb4092547e2453ddcdcfab97f06e273ad17d8.camel@intel.com>
 <CAEvNRgEbG-RhCTsX1D8a3MgEKN2dfMuKj0tY0MZZioEzjw=4Xw@mail.gmail.com> <ee9c649eed3893d852c3d20fb96bdc4904b7c295.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Jan 2026 14:47:28 -0800
X-Gm-Features: AZwV_QhacTtf2zgQk3uMxNHfKwdT09Bqx79KDOGE5Z3VW9UujMTrgN_9VI-QiKU
Message-ID: <CAEvNRgEz0+ic9uvcsWYqWgR5EV=TfY0SAGC39zAL+n19SoBXmw@mail.gmail.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct map
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Annapurve, Vishal" <vannapurve@google.com>
Cc: "david@kernel.org" <david@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"jgross@suse.com" <jgross@suse.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"surenb@google.com" <surenb@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"riel@surriel.com" <riel@surriel.com>, "pfalcato@suse.de" <pfalcato@suse.de>, "x86@kernel.org" <x86@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "maz@kernel.org" <maz@kernel.org>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "ast@kernel.org" <ast@kernel.org>, "pjw@kernel.org" <pjw@kernel.org>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"willy@infradead.org" <willy@infradead.org>, "wyihan@google.com" <wyihan@google.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"jmattson@google.com" <jmattson@google.com>, "luto@kernel.org" <luto@kernel.org>, 
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "haoluo@google.com" <haoluo@google.com>, 
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "peterx@redhat.com" <peterx@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>, 
	"mhocko@suse.com" <mhocko@suse.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "song@kernel.org" <song@kernel.org>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "oupton@kernel.org" <oupton@kernel.org>, 
	"kernel@xen0n.name" <kernel@xen0n.name>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"jthoughton@google.com" <jthoughton@google.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>, 
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "itazur@amazon.co.uk" <itazur@amazon.co.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"gor@linux.ibm.com" <gor@linux.ibm.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, 
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "joey.gouly@arm.com" <joey.gouly@arm.com>, 
	"derekmn@amazon.com" <derekmn@amazon.com>, "xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"kalyazin@amazon.co.uk" <kalyazin@amazon.co.uk>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"jackmanb@google.com" <jackmanb@google.com>, "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "jannh@google.com" <jannh@google.com>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kas@kernel.org" <kas@kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "will@kernel.org" <will@kernel.org>, 
	"seanjc@google.com" <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,linux.ibm.com,suse.com,google.com,suse.cz,surriel.com,suse.de,redhat.com,dabbelt.com,ghiti.fr,linux.intel.com,linutronix.de,infradead.org,os.amperecomputing.com,linux.dev,linux-foundation.org,ziepe.ca,lists.linux.dev,oracle.com,xen0n.name,huawei.com,nvidia.com,intel.com,gmail.com,zytor.com,amd.com,loongson.cn,amazon.co.uk,iogearbox.net,lists.infradead.org,eecs.berkeley.edu,amazon.com,fomichev.me,alien8.de,lwn.net,kvack.org];
	TAGGED_FROM(0.00)[bounces-75165-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[96];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: 871716E488
X-Rspamd-Action: no action

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Thu, 2026-01-22 at 08:44 -0800, Ackerley Tng wrote:
>>
>> Can we disable direct map removal for errata systems using TDX only,
>> instead of all TDX?
>>
>> If it's complicated to figure that out, we can disable direct map
>> removal for TDX for now and figure that out later.
>
> In theory, but it still would require changes to TDX code since it does
> the clflush unconditionally today. To know whether clflush is needed
> (it's a different thing to the errata), you need to check a TDX module
> flag. (CLFLUSH_BEFORE_ALLOC)
>
> Gosh, you know what, I should double check that we don't need the
> clflush from the vm shutdown optimization. It should be a different
> thing, but for we gave scrutiny to the whole Linux flow when we did
> that. So I'd have to double check nothing relied on it. We can follow
> up here.
>
>>
>> > Then there is the clfush. It is not actually required for the most
>> > part. There is a TDX flag to check to see if you need to do it, so
>> > we could probably remove the direct map accesses for some systems
>> > and avoid temporary mappings.
>> >
>> > So long term, I don't see a problem. For the old systems it would
>> > have extra cost of temporary mappings at shutdown, but I would have
>> > imagined direct map removal would have been costly too.
>>
>> Is there a way to check if the code is running on the errata system
>> and set up the temporary mappings only for those?
>
> The TDX code today doesn't do any remapping because the direct map is
> reliably present. There isn't a flag or anything to just do the
> remapping automatically. We would have to do some vmalloc mapping or
> temporary_mm or something.
>
> Can you explain what the use case is for unmapping encrypted TDX
> private memory from the host direct map?

There's no use case I can think of for unmapping TDX private memory from
the host direct map, but Sean's suggestion
https://lore.kernel.org/all/aWpcDrGVLrZOqdcg@google.com/ won't even let
shared guest_memfd memory be unmapped from the direct map for TDX VMs.

Actually, does TDX's clflush that assumes presence in the direct map
apply only for private pages, or all pages?

If TDX's clflush only happens for private pages, then we could restore
private pages to the direct map, and then we'd be safe even for TDX?

