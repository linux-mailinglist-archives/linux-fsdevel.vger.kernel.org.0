Return-Path: <linux-fsdevel+bounces-6328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 556F8815CA7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 01:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1C0B21B4C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 00:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4329ED0;
	Sun, 17 Dec 2023 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kC2ct2d4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2143EA29;
	Sun, 17 Dec 2023 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=49WEMktJZzZnrc7NcYvQXYQTLTaAK6hXzQVTPjEh4lg=; b=kC2ct2d4n5wKDgv0zPRyvS8fwX
	s7n6UCugZnNFJv/ial9cqwbNXJt2VphiRvsfIqyLmWkXWgYBmOwKiWdtBNkvYm4s1+bBXohChAmKF
	8OXaj2/wz+1ffYi8uDw9C0EoF15htXC9/fa+yr3GxclMxc+9F6rXWvup6OVK2I/y9uUD26aNXcUag
	sanI9e86tv6pWL0AOzOekCKDkjr6wStwBZCdUgYL3Qjc/s8uXfhnJADf3cTFDakVFQxtgpmeh6kvG
	kCAhsfWSLc7XkzICjNROiUsK+W5MJYCdMoCaul9WbdlzYMJdY1POzA3OX2KjQLPZo9CMbQIzWiXLz
	mywFEqyA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEeeE-006sbG-1w;
	Sun, 17 Dec 2023 00:04:46 +0000
Message-ID: <82ed43c2-2a9d-4c5e-8ccd-8078397b7953@infradead.org>
Date: Sat, 16 Dec 2023 16:04:43 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 46/50] preempt.h: Kill dependency on list.h
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Matthew Wilcox <willy@infradead.org>
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
 <20231216223522.s4skrclervsskx32@moria.home.lan>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231216223522.s4skrclervsskx32@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/16/23 14:35, Kent Overstreet wrote:
> On Sat, Dec 16, 2023 at 06:13:41AM +0000, Matthew Wilcox wrote:
>> On Fri, Dec 15, 2023 at 10:35:47PM -0500, Kent Overstreet wrote:
>>> -	INIT_HLIST_NODE(&notifier->link);
>>> +	/* INIT_HLIST_NODE() open coded, to avoid dependency on list.h */
>>> +	notifier->link.next = NULL;
>>> +	notifier->link.pprev = NULL;
>>
>> Arguably INIT_HLIST_NODE() belongs in types.h -- we already have
>> RCUREF_INIT() and ATOMIC_INIT() in there.
> 
> I think I'd prefer to keep types.h as minimal as possible - as soon as
> we start putting non type stuff in there people won't know what the
> distinction is and it'll grow.
> 
> preempt.h is a bit unusual too, normally we'd just split out a _types.h
> header there but it's not so easy to split up usefully.
> 

I don't feel like I have NAK power, but if I did, I would NAK
open coding of INIT_HLIST_HEAD() or anything like it.
I would expect some $maintainer to do likewise, but I could be
surprised.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

