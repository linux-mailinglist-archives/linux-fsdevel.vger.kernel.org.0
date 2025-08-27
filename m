Return-Path: <linux-fsdevel+bounces-59409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C568B38825
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 18:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D14E1C21127
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5E52ED85E;
	Wed, 27 Aug 2025 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf7/0Js9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED22BE65E;
	Wed, 27 Aug 2025 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313965; cv=none; b=r2oi0gSI9irEGSQeWhPkpAZe9fVnp2ZnXRw0F4u9Ed6LQIjBnrTS0YypAMaFWjSHZiZ2si4qv1On5Gsm5cCaOs0ujI1QYztlJNYXJBMuzET6oCAQTJwNxicPCzjkNzwVs9sCJrmmozr5+k8N8/7N+a0CG0isJPmB6GIWbayVh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313965; c=relaxed/simple;
	bh=HP+oCFjbaV0ErYQHYOSOr3F3umYVDZHj90JBCgWCcms=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIvMdXL2aP2v/bzQdVJIKI/Y9ZWXRdyNW560ii21ibwt2KTiGvfC1LcaCeEihbBDEjR120qEgvQ1n0utLobbOU2Kri7llQndnjbIM+WYRztLY+aPg9BlVUAxMeDseA9VAyr9dL5t6BqViJ9qlqWWsvcBHlHp59oUZM7WFmla+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf7/0Js9; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3366f66a04cso424171fa.1;
        Wed, 27 Aug 2025 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313962; x=1756918762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSz+0Jdl3rsxgIMqjiE4eLITB/Ptqi8xoIkjq9Q3i9w=;
        b=Pf7/0Js9wTzUbA2z9j1s0We4psrMER+tLAPobYT1Uzur7QQR2hxzkJL6SIZaCkRpyr
         w0bEYYDQXU377H4/trsEniu3lKkDLdddYLuMkZrAeA9YNihsGnmSBHkZQr+e0qI/3JIK
         n2NZUmbXNiwzYYqAFp8DCLW22VfdO7/lh+5TgG1hIpWVlwIL9jCaCGuzk4Og1P1cjWOc
         yamlOUyOSAxDaF0N9w4lK3tya9CAmHFBFSB1aBS8c3JeZAt0EMbsPpWGgRmT73XDCkbU
         JKOEPG98pX1Qd89EIVAVIFHuiDZCN8bPc6Oax7u02yUihzLtuTLAstJWLM8lvS9mBbOm
         fjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313962; x=1756918762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSz+0Jdl3rsxgIMqjiE4eLITB/Ptqi8xoIkjq9Q3i9w=;
        b=Z2UHbZQQYFhnAjEFn+9q5xU36xXyqiRxvkk85DUNFY+N+mgdf/JU4I0pGM+4p33Rvs
         jYN4MWYiNJxX5C+VPFfUSnu9YO6yPwruGXmRFSPtCldceTqV/OpMVX+Jkx3eCGqjBAUs
         NuRUe5LK4/+KqDz8tLK1HKqpTv+ABxVAGvYPDgISsB7bC4sF/8jq3POJpi4PYqWbOn3c
         qBbe8sIFvPggj4ioOb01nKICgkBSi+MENWiiyAJH/p7QPtMfgysGRJxX1GrmEf+qYJhJ
         hqR/tGIV8HTjnN8zwXaXrU5FwK7ZE2Hfn9dTKvYjqovd+tlznLw79ANU6kHC7AANWKor
         rQ6A==
X-Forwarded-Encrypted: i=1; AJvYcCUdpn0dhMcBQ+tCH0oNc5b76ZJA5+QqZuYFhZwQxrJWtX/HMpVkJsAmt5bkwseehCwj5i2yCCe0NUWr@vger.kernel.org, AJvYcCUwg6yK+H5GckWR4Vx8Sw5pBzLPHhsab2sO3wROGMNnxUcN5o/BK+BwsedAyMr7aDkY1pg=@vger.kernel.org, AJvYcCVZR65+YMzi9fFsW/8VIKYkLYkuJGcBwwRz1zQ4JA0jniHn6TEcKJO1Mx3LTa2YiWci9yGlX0dJOS9bjpNwRgMmmtmT@vger.kernel.org, AJvYcCXTFe14OJKe/TxdFgwXZVfKeTqLo5lD9SMrN4Ivwr3zxF23re/5xuXLNUMgjVlel+BTvqgTcLCLkPYultSZZw==@vger.kernel.org, AJvYcCXUL+gLHCNVWJspvaxv1bEreKzmqGXQGhGRb4u2GtYQLPc0rtj6KKXbiXCT6a/4y+cFL6drwBS3TKpL1Wnw@vger.kernel.org, AJvYcCXfTETBDKEpCzfIDz2I51gCSDpsWLBkOzxTrP+TvAUI5jopTuZPLlBcRToOIiXNNqP/mqt546XNQLzUSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/lvOZ2PAfasnZtt5sk80EN915m+AF8QkdmUrzGu9jz+3LJ63R
	Ev+Uk9fRoTSYQb7t7Wrc/Xn+vv+QZz27g0ceezp4H5ppuFZLbWYo/5D/
X-Gm-Gg: ASbGncu1tgUGWeXBLTJEH0ZV3nJwZLfv2iKFlZsDuU42ZmkRLSZI2ojSWEG1T1AibKq
	pPj5cmYzaZDKXd+Pu0PMtTKVxIB4lcues6uMBMvwJMUBE7YnSIfzSDxPlVPrgIwHzfhikbEvFZL
	ZNGOTSzBLewkzWwBH/FhsON7SunEy3joyhNS2iXwruuizfMNK5+qIuOsnlXhODMxDbg1B/rajBl
	w2MD6uiW7igXDagOws1AX9pxJnNle1+XAIbprKNsFNy35JU99r/wX/Fd7IPj+i6Sj1HxnAs8s/J
	csEwSWQxAajHYy+mbYl2IRFi6BRNOZdEPE1/hWnjDfGtWrXK9h8erw9o1GcFVutIRfqohp52GQ9
	xaWAE6hoXrvDl+SJ/wFsa7dhwMQ4+P+Kvfl/xe0hDlmv/cpBJvMiJ
X-Google-Smtp-Source: AGHT+IG4BeCx/VIPO9rnbCc0YcRdZMlua4eVbdX3PpKt/fKDdzrBfr7yiiTFTWfK/4UfPVTpR7vpyQ==
X-Received: by 2002:a2e:be03:0:b0:336:7eed:2f8f with SMTP id 38308e7fff4ca-3367eed3c67mr29987221fa.32.1756313961794;
        Wed, 27 Aug 2025 09:59:21 -0700 (PDT)
Received: from pc636 (host-90-233-205-219.mobileonline.telia.com. [90.233.205.219])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e5da244sm27443611fa.58.2025.08.27.09.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:59:21 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 27 Aug 2025 18:59:16 +0200
To: Kees Cook <kees@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: update core kernel code to use vm_flags_t
 consistently
Message-ID: <aK85ZPVwBIv-sH85@pc636>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
 <aIgSpAnU8EaIcqd9@hyeyoo>
 <73764aaa-2186-4c8e-8523-55705018d842@lucifer.local>
 <aIkVRTouPqhcxOes@pc636>
 <69860c97-8a76-4ce5-b1d6-9d7c8370d9cd@lucifer.local>
 <aJCRXVP-ZFEPtl1Y@pc636>
 <aJHQ9XCLtibFjt93@kernel.org>
 <aJItxJNfn8B2JBbn@pc636>
 <202508251436.762035B@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508251436.762035B@keescook>

On Mon, Aug 25, 2025 at 02:37:11PM -0700, Kees Cook wrote:
> On Tue, Aug 05, 2025 at 06:13:56PM +0200, Uladzislau Rezki wrote:
> > I agree. Also it can be even moved under vmalloc.c. There is only one
> > user which needs it globally, it is usercopy.c. It uses find_vmap_area()
> > which is wrong. See:
> > 
> > <snip>
> > 	if (is_vmalloc_addr(ptr) && !pagefault_disabled()) {
> > 		struct vmap_area *area = find_vmap_area(addr);
> > 
> > 		if (!area)
> > 			usercopy_abort("vmalloc", "no area", to_user, 0, n);
> > 
> > 		if (n > area->va_end - addr) {
> > 			offset = addr - area->va_start;
> > 			usercopy_abort("vmalloc", NULL, to_user, offset, n);
> > 		}
> > 		return;
> > 	}
> > <snip>
> > 
> > we can add a function which just assign va_start, va_end as input
> > parameters and use them in the usercopy.c. 
> 
> Yes please! I'd must rather use some exported validation routine than
> having it hand-coded in usercopy.c. :)
> 
I will do it :)

--
Uladzislau Rezki

