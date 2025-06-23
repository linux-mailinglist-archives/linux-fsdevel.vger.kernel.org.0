Return-Path: <linux-fsdevel+bounces-52585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 250E0AE4664
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 584257AA364
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA842580E2;
	Mon, 23 Jun 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZFkX2qR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC1257444
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688232; cv=none; b=rNUIOM4x8HpFBI5RwIglq/AR0TxX3w1wUc1nrvjAKc1GuNk6NMrU825xUEREm7MDwtpq3Yl+Zar2gTogK6pk+ckNGtN+UBvB/nIY4VVvQcG4OAtAXigsbgzN5NHKGKNlD9iGYqZOnMbDVsEX7S38JJZxJWCLPbIi7HPOmomAG90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688232; c=relaxed/simple;
	bh=cFKZeL+hYNuWQhIXij5F912cJ1wz6SXdUpucQjuTNnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0zZ4JcUT0RX9VP3xTHOPMvSkZC6rMHTfA/ex4y3PGizoH5oo2A5qGgjJXheqLHgMtcxQCdiyHP2oHTVeAojeAPYu1EhWBDZgIhs0yDLkhG+K4mYmLSm3WhVz/i6+tEIBWdLdbAL+7kUwUpc17SMGmPHwh/aA+7O/+0NnFK7sns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZFkX2qR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750688229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h8Olqgg5wM7szEFmj8uTM5sjPX8xuFrJrmZyG5BlKBM=;
	b=dZFkX2qRS4KFMraqKHUnwNQOXzHHcOzS0czxP4C/BpMqTrd8HJv03fbJzPWex36dvFrxJF
	OskNjDjh2eNa5EV5cLUAZi4UA3e79w7gsDug+iOPDfpuf/Q38WMH2htQX3iuGVqoEU6Y0u
	xwXIOp3P524K50aE5SCGGVUfgIyaXPo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-s7ftKNocO4CfUDM3QT3uVQ-1; Mon, 23 Jun 2025 10:17:03 -0400
X-MC-Unique: s7ftKNocO4CfUDM3QT3uVQ-1
X-Mimecast-MFC-AGG-ID: s7ftKNocO4CfUDM3QT3uVQ_1750688222
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso1752958f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 07:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688222; x=1751293022;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h8Olqgg5wM7szEFmj8uTM5sjPX8xuFrJrmZyG5BlKBM=;
        b=m9+0wUrcQgIYDaxkSwmBZnIcgJ/oCBzCWMrrpRkYhpeKJCJM/p2HXi6F3/DUsPfr/y
         VT+b8AXncFOMIOzOaeejN5QsdBHgDsVKaWNIS4th8DfDhMpmSajDgWzWezg8IZgXBqdw
         loYFFIgIfhFDECz4TAj+cpIhVFGH2heva9QC+raMxriz0HEPW0+A3615WcQU3kG8ciQ8
         fKcvaFEgnrgfUfmGejyNujDso+6FOLlBK2mDj7OxDqdA8fKUG/wYvWgkx8o/Lx0wmv7p
         KO/5p4jjIZX/iA2DIcaxRLQ7OHz0TXreS9gtIGdV57CYmOSvb5Sy74z5Alf0en9RyM32
         T6XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcQZYXQM/TkCEVXzyuYEXvPRlq5CJ8InH3jJusGxN2rL6e1y3tYojKROjcxqKLeCIz5+QoPABCZnHSsxY1@vger.kernel.org
X-Gm-Message-State: AOJu0YwSS9ZiJnv+s0WIfLh5YBPngsnvpIbb6cBkGv/0ws1wHzTh9mc9
	H9ektfmUggP9EzQlnCnFfdZhRbI94mk3ioJuX4XPqv4LVy04yo18jPIn2zQ0uo2IFbtwC4kA5n/
	wmhzAqrZ9mrvdWmkuzddF1wfx9/EAuYVoqUYYDb6RqKTFLdVDq4arOa1fPwAv2a1P5ys=
X-Gm-Gg: ASbGncvY0MX8t3nVRnzKwxM1Zy/YcRhvuebC2/SoW53ZPTyrzqDYGAi078w0SmIaKuv
	n2lBwZ2TKCcfaK1V13raTcFA95VcloCmTFr8mWPi1S9Ztzi9Fv1z9/lzJ5CqNr2cOOOM8fPmNxN
	55gdg/r3L7I9SQU+8h+uICz753Y3E+1jgmB2mEAseK9L7t57juZcx5YwXMNjJavM4YbNxCag2fR
	pBmi0v+BNMdj+/7JUOF0+YHQhtzcd7Ik6qa8HgLV7jRoSHLyHwbPLpWHicaysmXqlo3V8QGjawn
	8YNrHFuVsVYxNAqWXlzqPZotxz95apZUL6ogs+FpHxXU3uRWsooXR58h5lEWeaGGHSzePw1cX5Z
	VRJXS9Aqeb+MrnLWKpKbZUoRT0B74cOIsbTLxx+wg76L7+c50sg==
X-Received: by 2002:a5d:5f87:0:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3a6d12eb182mr10399968f8f.53.1750688221768;
        Mon, 23 Jun 2025 07:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8dR6X7fHQaI9fQSh9DO1Tx6U+p+mGsBYH7hTQ0+BF5CKnFOIsqhzs0NiVKWgUUywR+JX//A==
X-Received: by 2002:a5d:5f87:0:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3a6d12eb182mr10399861f8f.53.1750688221154;
        Mon, 23 Jun 2025 07:17:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97a908sm145737335e9.4.2025.06.23.07.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 07:17:00 -0700 (PDT)
Message-ID: <702c58b1-7b07-4cc9-a5b3-8d3f33aba02b@redhat.com>
Date: Mon, 23 Jun 2025 16:16:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: change vm_get_page_prot() to accept vm_flags_t
 argument
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
 <552f88e1-2df8-4e95-92b8-812f7c8db829@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <552f88e1-2df8-4e95-92b8-812f7c8db829@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.06.25 14:25, Lorenzo Stoakes wrote:
> Hi Andrew,
> 
> I enclose a quick fix-patch to address a case I missed and to avoid any risk of
> circular dependency in a header include.
> 
> Thanks to Vlastimil and Oscar for spotting this! :)
> 
> Cheers, Lorenzo
> 
> ----8<----
>  From d66fe0b934098ccc2ba45f739277fffe86c91442 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Thu, 19 Jun 2025 13:21:15 +0100
> Subject: [PATCH] mm: add missing vm_get_page_prot() instance, remove include
> 
> I missed a case for powerpc, also remove #include (that is not in practice
> necessary) to avoid any risk of circular dependency.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


