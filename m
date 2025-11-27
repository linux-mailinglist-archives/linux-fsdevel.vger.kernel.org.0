Return-Path: <linux-fsdevel+bounces-69959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0BC8CCA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 05:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68473B12A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 04:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11CB2D4B5A;
	Thu, 27 Nov 2025 04:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AP3I5dIw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35624886A;
	Thu, 27 Nov 2025 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764216621; cv=none; b=kUuSTKik6skAh57b9AtbGw1HqIgAVs5gcUN/vSe24LDbKJRe8NuwJbu9J2FQXGdjt3JAtg116Hf9/KYDobDd2VZaWmOKm13bOkY7BnX2272gecCKtFlXRlhNlJeDpWigRQrg2AI9Q7At4lC9nRidWxg1UrDgiw3Cv9cctVAF1ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764216621; c=relaxed/simple;
	bh=ooxdkvf2rxgsy0xRVRRnZiTwICu8IYYojYmiU6bahEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGYdPz6iJontL0/WjVY+AB3G+dSmKbIyjEvkBcxxOwvU/tkcMPX3zWNVkpzuUY4mhlY3uMyrucdIHwxdoxMY5cFunBmon0IJbFbfZ5RIinD5Bg5jiAGWWJXo3WAcLIB8SSPiPmmT1zkmXFpMRPD1CnukFwqV8C9nHBd79HrZDSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AP3I5dIw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9UH5HZWU7w1Qz5ka8h7XjqhmojO13fL0L+YMlTFhSDA=; b=AP3I5dIw8MUlt7xSzk3qgcc3sN
	AHu26Cs0wtwdgwSRwY+BmvEPRpHfoPjKAv6EqeaGAtEZ8MvH02yG8ScNHL7P49Rb/gM+u6ij5a6XG
	jy4hg3/q6KDo+jTVMSPbxO9fXKm9iGjW+uF8fMcq7GPSByWP3cICDpktaeP3bee4XCg1AvMMv/Moj
	YSEuEpY6zqKoGrYyt7uU+flpdycrYQcResJLx8oQU2IoaQaPpPfiBo/O1co/fExGrf5J1lFda0oK/
	nNuM2+NAvUP42wEG8HkfVsWnCKASM8uniovBmROKgYy8568Nvncst6z24djS+35maVgZIA3CoAYDO
	v2Mud80A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOTJl-0000000BB6Z-3S6J;
	Thu, 27 Nov 2025 04:09:17 +0000
Date: Thu, 27 Nov 2025 04:09:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	Barry Song <v-songbaohua@oppo.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Pedro Falcato <pfalcato@suse.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Oven Liyang <liyangouwen1@oppo.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Nam Cao <namcao@linutronix.de>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: continue using per-VMA lock when retrying
 page faults after I/O
Message-ID: <aSfO7fA-04SBtTug@casper.infradead.org>
References: <20251127011438.6918-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127011438.6918-1-21cnbao@gmail.com>

On Thu, Nov 27, 2025 at 09:14:36AM +0800, Barry Song wrote:
> There is no need to always fall back to mmap_lock if the per-VMA
> lock was released only to wait for pagecache or swapcache to
> become ready.

Something I've been wondering about is removing all the "drop the MM
locks while we wait for I/O" gunk.  It's a nice amount of code removed:

 include/linux/pagemap.h |  8 +---
 mm/filemap.c            | 98 ++++++++++++-------------------------------------
 mm/internal.h           | 21 -----------
 mm/memory.c             | 13 +------
 mm/shmem.c              |  6 ---
 5 files changed, 27 insertions(+), 119 deletions(-)

and I'm not sure we still need to do it with per-VMA locks.  What I
have here doesn't boot and I ran out of time to debug it.

