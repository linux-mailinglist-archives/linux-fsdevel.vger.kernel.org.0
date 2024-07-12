Return-Path: <linux-fsdevel+bounces-23604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2833292F4CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 06:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20A51F22103
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 04:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E7C179A7;
	Fri, 12 Jul 2024 04:59:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A9510F7;
	Fri, 12 Jul 2024 04:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720760383; cv=none; b=OwqIaUdHstfeGYpokvHVNYBSRiNYfGeqpkYi6ssX9r1zw1pNquw/wl/C+6lBUhjF7OBHZqZRY4NI2i1EDNga1tZpowwhDpaTQ1CYhG5SGAN8lmD+4d6toH+ygL1Pzwum73nKSZJcfhzydCb5yeigblo3ynyq3WBiEdCzTGHU2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720760383; c=relaxed/simple;
	bh=238pF0xvpe44pucH/X7LCeolZ+r002xEb3ctIqbVwss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXnL+f5m9D3bQS7hEi0vin2jj7dN4AYzEZj+ZIRHunVDbKcLQKIt9o+IQnI1ek66Hu/6TNkTz73l/MdF52u5w4xnPGm0/3vAIJ/gtAnlvxA6O1KcOQXYB3KQwX8v6+n32l/4+eTejUhDVhWd5E0SRoaG3gs2CQpUtNt1Vv2/MLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-32-6690b4a9ed96
Date: Fri, 12 Jul 2024 13:44:20 +0900
From: Byungchul Park <byungchul@sk.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	max.byungchul.park@sk.com,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	kernel_team@skhynix.com
Subject: Re: Possible circular dependency between i_data_sem and folio lock
 in ext4 filesystem
Message-ID: <20240712044420.GA62198@system.software.com>
References: <CAB=+i9SmrqEEqQp+AQvv+O=toO9x0mPam+b1KuNT+CgK0J1JDQ@mail.gmail.com>
 <20240711153846.GG10452@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711153846.GG10452@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsXC9ZZnke7KLRPSDGbOU7KY2GNgcfH1HyaL
	mfPusFns2XuSxeLemv+sFq09P9kd2Dx2zrrL7rF4z0smj02fJrF7NJ05yuzxeZNcAGsUl01K
	ak5mWWqRvl0CV0bvvG62gqmSFQ8+/2RqYDwr3MXIySEhYCKx8s9bVhh7/upnYDaLgKrErVWf
	2EFsNgF1iRs3fjKD2CICihK3Wr4A2VwczAINTBI9n7cxgiSEBRIkXsw8DWbzClhIbDr4AaxZ
	SKBY4tP3VcwQcUGJkzOfsIDYzAJaEjf+vWTqYuQAsqUllv/jAAlzCuhKHDvdD1YuKqAscWDb
	cSaQXRICG9gkzhyezwJxqKTEwRU3WCYwCsxCMnYWkrGzEMYuYGRexSiUmVeWm5iZY6KXUZmX
	WaGXnJ+7iREY0Mtq/0TvYPx0IfgQowAHoxIPb8D1/jQh1sSy4srcQ4wSHMxKIryeZ4FCvCmJ
	lVWpRfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGKNuthtOzPbmFJ3s
	PVUo99HDHcfv6k+06zhwOv3ZW9NJsw458JceebEj5v2JZS+nKiu7/Ws83P5RmPGW0Y1yQe77
	nWyHNh9Ujzydsvcy+0HBIz+OFDB0LfjbNVFZ69sF8wfyF47ttqr28N+VtSTW9i0nw2WL3X9N
	1fSe1lxZ+XB3+wM9a9Efv1SVWIozEg21mIuKEwErOwYXZAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsXC5WfdrLtyy4Q0g3O7xSwm9hhYXHz9h8ni
	8NyTrBYz591hs9iz9ySLxb01/1ktZrTlWbT2/GR34PDYOesuu8fiPS+ZPDZ9msTu0XTmKLPH
	t9seHotffGDy+LxJLoA9issmJTUnsyy1SN8ugSujd143W8FUyYoHn38yNTCeFe5i5OSQEDCR
	mL/6GSuIzSKgKnFr1Sd2EJtNQF3ixo2fzCC2iICixK2WL0A2FwezQAOTRM/nbYwgCWGBBIkX
	M0+D2bwCFhKbDn4AaxYSKJb49H0VM0RcUOLkzCcsIDazgJbEjX8vmboYOYBsaYnl/zhAwpwC
	uhLHTveDlYsKKEsc2HacaQIj7ywk3bOQdM9C6F7AyLyKUSQzryw3MTPHVK84O6MyL7NCLzk/
	dxMjMFyX1f6ZuIPxy2X3Q4wCHIxKPLwB1/vThFgTy4orcw8xSnAwK4nwep4FCvGmJFZWpRbl
	xxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTDulfI6FJlyo+X/0Y2tRod1
	hY7xnpf3iK45VRuX89QtQawpRtVBPrpC+C6n7VK9+MXmmZs+6JwWc3TdtPdMyfqDKS/LdFTO
	i4v6maat+PEo7lSY/1XBH38KbtkULnZw1nFttSv0WDZH5Nnm5arsB8T+iNt6bA4yuCvxv+72
	FAbPJ8ttUg79iFViKc5INNRiLipOBAC+MjDuUwIAAA==
X-CFilter-Loop: Reflected

On Thu, Jul 11, 2024 at 11:38:46AM -0400, Theodore Ts'o wrote:
> On Thu, Jul 11, 2024 at 09:07:53PM +0900, Hyeonggon Yoo wrote:
> > Hi folks,
> > 
> > Byungchul, Gwan-gyeong and I are investigating possible circular
> > dependency reported by a dependency tracker named DEPT [1], which is
> > able to report possible circular dependencies involving folio locks
> > and other forms of dependencies that are not locks (i.e., wait for
> > completion).
> > 
> > Below are two similar reports from DEPT where one context takes
> > i_data_sem and then folio lock in ext4_map_blocks(), while the other
> > context takes folio lock and then i_data_sem during processing of
> > pwrite64() system calls. We're reaching out due to a lack of
> > understanding of ext4 and file system internals.
> > 
> > The points in question are:
> > 
> > - Can the two contexts actually create a dependency between each other
> > in ext4? In other words, do their uses of folio lock make them belong
> > to the same lock classes?
> 
> No.
> 
> > - Are there any locking rules in ext4 that ensure these two contexts
> > will never be considered as the same lock class?
> 
> It's inherent is the code path.  In one of the stack traces, we are
> using the page cache for the bitmap allocation block (in other words, a metadata
> block).  In the other stack trace, the page cache belongs to a regular
> file (in other words, a data block).
> 
> So this is a false positive with DEPT, which has always been one of
> the reasons why I've been dubious about the value of DEPT in terms of
> potential for make-work for mantainer once automated systems like
> syzbot try to blindly use and it results in huge numbers of false
> positive reports that we then have to work through as an unfunded
> mandate.

What a funny guy...  He did neither 1) insisting it's a bug in your code
nor 3) insisting DEPT is a great tool, but just asking if there's any
locking rules based on the *different acqusition order* between folio
lock and i_data_sem that he observed anyway.

I don't think you are a guy who introduces bugs, but the thing is it's
hard to find a *document* describing locking rules.  Anyone could get
fairly curious about the different acquisition order.  It's an open
source project.  You are responsible for appropriate document as well.

I don't understand why you act to DEPT like that by the way.  You don't
have to becasue:

   1. I added the *EXPERIMENTAL* tag in Kconfig as you suggested, which
      will prevent autotesting until it's considered stable.  However,
      the report from DEPT can be a good hint to someone.

   2. DEPT can locate code where needs to be documented even if it's not
      a real bug.  It could even help better documentation.

DEPT hurts neither code nor performance unless enabling it.

> If you want to add lock annotations into the struct page or even
> struct folio, I cordially invite you to try running that by the mm
> developers, who will probably tell you why that is a terrible idea
> since it bloats a critical data structure.

I already said several times.  Doesn't consume struct page.

	Byungchul

> Cheers,
> 
> 					- Ted

