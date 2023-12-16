Return-Path: <linux-fsdevel+bounces-6321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBC9815B40
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 20:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B431C20A94
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 19:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC26331A81;
	Sat, 16 Dec 2023 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uPIsM4sT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9B72FC24;
	Sat, 16 Dec 2023 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9I9jmriNkRRhZzL8LAvE/UO9XO8ynzIkcjc6Pnubh3Q=; b=uPIsM4sTCLJq9Lw5+wpQ3YaDTt
	7/B8oCiQV5HSzRgH5yQktxmUe/2Ss49tYD9j0FBfdD/yp+Ndn3SVodYw48ngCU2omJX+lkvFJClZ3
	WUEBS8QBRARpxjZ0yVyNkQ3HjX5XxDt2IVN1pdISmgNEPKzrcDIIglYPwtXVS11LKtyTrWE2Dtnxv
	m4mY4KHmu1BvP3xJKwutGwfcM0YWhAUrxzt+SUDyggQbni0kDiyW87t1XwgYrQhAWZ1f3CBh+fDnN
	IPVvPCIWXA6srVzqkUaAc1UC9V4BKU4Ll6PzVzYUVSv8hUSmCleQH0puJF9UejiS7KQZH7weShRzl
	IZ1p85CQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEaEF-006bv4-2t;
	Sat, 16 Dec 2023 19:21:39 +0000
Message-ID: <7d5d85f9-a78a-453d-8d1f-01189eb21c2f@infradead.org>
Date: Sat, 16 Dec 2023 11:21:39 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 46/50] preempt.h: Kill dependency on list.h
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
 tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
 paulmck@kernel.org, keescook@chromium.org, dave.hansen@linux.intel.com,
 mingo@redhat.com, will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
 brauner@kernel.org
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-3-kent.overstreet@linux.dev>
 <ZX1AFVAWXMfbo+Ry@casper.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZX1AFVAWXMfbo+Ry@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/15/23 22:13, Matthew Wilcox wrote:
> On Fri, Dec 15, 2023 at 10:35:47PM -0500, Kent Overstreet wrote:
>> -	INIT_HLIST_NODE(&notifier->link);
>> +	/* INIT_HLIST_NODE() open coded, to avoid dependency on list.h */
>> +	notifier->link.next = NULL;
>> +	notifier->link.pprev = NULL;
> 
> Arguably INIT_HLIST_NODE() belongs in types.h -- we already have
> RCUREF_INIT() and ATOMIC_INIT() in there.
> 

That would be far better than open-coding it.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

