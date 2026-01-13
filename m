Return-Path: <linux-fsdevel+bounces-73496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 514A7D1AE7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03EAA30127AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6776E352F81;
	Tue, 13 Jan 2026 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LgBmokvl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252A352FB5;
	Tue, 13 Jan 2026 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330353; cv=none; b=Y37FPFJhaUk4y78e5gAIlY0p2JtCIk6sdg1uxad0K7d5syykRqyKTxolvz0K3stI+bvpR+YEJBaRa2Sl70AjMHsq+nKHTqO2Yn5bcRWjO6NO+S8Cdsu6Ljhrarftu7Z8ItQpl3NixBj3zNL7wHb2tFE0BD12iizuJZitHercGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330353; c=relaxed/simple;
	bh=dNDRuEVxea96d1Aj6mBGi+zKc0p3K4Y041XcfB9BcsM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmAUUuFLjcijkdZEmVHIbCDoIbGL8RlmWGcPv2c/9Pwm1MFXuatt6isRHO1QP/sVKO9SYtYovAzTXm7wHUMe6TF0gVdvk2e654HseYTFggFb6HEPbFmxdRoLNDPNrl14j80RUu//gFo6jYD8aXlCBZMguFCqMiTt+7kBo6VlGxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LgBmokvl; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DEN6j92410604;
	Tue, 13 Jan 2026 10:52:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=rwGnK0XG1cMO3SiCMi3ybbWXWNI7uUNJrpNbOpDI9KA=; b=LgBmokvlFzSD
	JbLJk9k2UhGnXkQ0PYNUN4/xnhQadwbQiPtX3bGJGssuI8U7AhzmP1+c8wXeH/R2
	BZnKgeDNB0Hmmydip/hXDpKK0wZ+taf8nLR/ahSYcVIXEhdTzyqlJuQFRv8epZnl
	LBcnevOLhJQcsJdRjnrq+cjzVZeg1eim/RWDRvguCs1DkG8UCTs/NWUi8o7BRtK7
	QYlYj9XfjEHVUxLu3BW1qw1X95/EVyxDe37eh/HJY+61z5lDhqVIG9dz9ErpvfAF
	Cj1HF1c/zJcKpOUPlVYvgsXsIjIQDgT5LvZ8E9HDgtAbIU7Cn0uahpsjIJgFIizq
	8LLBExl2Sw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bnqs2afpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Jan 2026 10:52:00 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 13 Jan 2026 18:51:55 +0000
From: Chris Mason <clm@meta.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Chris Mason <clm@meta.com>, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka
	<vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan
	<surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen
	<axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu
	<weixugc@google.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar
	<mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli
	<juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman
	<mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>, Kees Cook
	<kees@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe
	<jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Xu Xin
	<xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn
	<jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn
	<joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park
	<byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang
	<ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Pedro
 Falcato" <pfalcato@suse.de>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        "David
 Rientjes" <rientjes@google.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo
	<harry.yoo@oracle.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song
	<kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He
	<bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Johannes Weiner
	<hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>,
        Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin
	<lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich
	<dakr@kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] mm: declare VMA flags by bit
Date: Tue, 13 Jan 2026 10:51:37 -0800
Message-ID: <20260113185142.254821-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3a35e5a0bcfa00e84af24cbafc0653e74deda64a.1764064556.git.lorenzo.stoakes@oracle.com>
References:
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=HewZjyE8 c=1 sm=1 tr=0 ts=69669450 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=2wkDwbBoJs5KUjAQhisA:9
X-Proofpoint-ORIG-GUID: BS8X5kMHAv_lmQbWyESwWfjaYTVAoeoM
X-Proofpoint-GUID: BS8X5kMHAv_lmQbWyESwWfjaYTVAoeoM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE1NyBTYWx0ZWRfX3M0NHs1kukO+
 c1d5VmTZ+cKzVKyCoJevB8QxR3unXWf5zPurMIxcyuLcr82OOTuasFBakmFJxUV6pamhFlFUUTh
 9CzQ2jQRm0lD7xjIUQIMLkEkb0QBsN4EsfOzy8guhq+TNKO+NtjdaASgx3JrH2EemdhOAWH743o
 zQPezwfPQ7Ut2lBt4f5mtIlc9ty1guUb/kopR0ke9tNXNRKqVpug6r5quhJOjB1xWwejsudNid5
 0U0aq2rA/WuKbCItGhtViZEoQvXxM8L/Uf9Q6lLbe8kcAk7QgzLQGPV/80NfbtA8dqhXkSF2r6v
 aw8k01O82636geuSjjF5WZa4RC9nHmbJzQLwfSQ1fcwgrX5negm0JDyy9oNQodlP+nv11/0mi3d
 ebMMAZNNygtXtURpxOtLjeP5D/1HUu9OPD7B53VoB0xOr49/QSd+Ij/DqsfAo5zfjdETdF/+f7I
 XP21uI1d3Kf7dKVxvRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01

On Tue, 25 Nov 2025 10:00:59 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

[ ... ]
> 
> Finally, we update the rust binding helper as now it cannot auto-detect the
> flags at all.
> 

I did a run of all the MM commits from 6.18 to today's linus, and this one
had a copy/paste error.   I'd normally just send a patch for this, but in
terms of showing the review output:

> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 2e43c66635a2c..4c327db01ca03 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -108,7 +108,32 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;

[ ... ]

> +const vm_flags_t RUST_CONST_HELPER_VM_MAYREAD = VM_MAYREAD;
> +const vm_flags_t RUST_CONST_HELPER_VM_MAYWRITE = VM_MAYWRITE;
> +const vm_flags_t RUST_CONST_HELPER_VM_MAYEXEC = VM_MAYEXEC;
> +const vm_flags_t RUST_CONST_HELPER_VM_MAYSHARE = VM_MAYEXEC;
                                                   ^^^^^^^^^^

Should this be VM_MAYSHARE instead of VM_MAYEXEC? This appears to be a
copy-paste error that would cause Rust code using VmFlags::MAYSHARE to
get bit 6 (VM_MAYEXEC) instead of bit 7 (VM_MAYSHARE).

The pattern of the preceding lines shows each constant should reference
its matching flag:

    RUST_CONST_HELPER_VM_MAYREAD  = VM_MAYREAD
    RUST_CONST_HELPER_VM_MAYWRITE = VM_MAYWRITE
    RUST_CONST_HELPER_VM_MAYEXEC  = VM_MAYEXEC
    RUST_CONST_HELPER_VM_MAYSHARE = VM_MAYSHARE  <- expected

> +const vm_flags_t RUST_CONST_HELPER_VM_PFNMAP = VM_PFNMAP;

[ ... ]



