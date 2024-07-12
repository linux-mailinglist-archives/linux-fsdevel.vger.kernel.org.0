Return-Path: <linux-fsdevel+bounces-23605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796DB92F518
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 07:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8591F227BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 05:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A229F1805E;
	Fri, 12 Jul 2024 05:32:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B7110F9;
	Fri, 12 Jul 2024 05:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720762324; cv=none; b=AVDcuLlhw4kOznEZ0cjdas7SLHRX9NKL7nmj+cS7PjKtmigBNM1jGi3jBfLuONdO9vZN3HiNaVp3acBEjPvn0rphkjv3e6j+/7p/svUkQOhL4S2jaSvzxFY/mDa0rgV5Q1kr5hWuqPc5WAzww2plxhjRM07AIZOIeLLXgzD18EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720762324; c=relaxed/simple;
	bh=Gy421bWm5KiSbZbVH/3moq7hpAacU1PFjfK/0/i2ylM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGJ+xP6wvo9YtGFUgsbfwdofqZ1VRTY1lJ4A7al8FggRNBCoYs38VwLsY0GN0IJyb2Z9koZrBrLrVYtsWOmoHwQ2oEOdBNFHe3UPFkms54TkxN4dWaJQt/ZdJGLgl0s3liprEM48qyDQEFO2JM+m16xARbTtrmTcwmXJ5fRmPag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-32-6690bfcb4415
Date: Fri, 12 Jul 2024 14:31:50 +0900
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
Message-ID: <20240712053150.GA68384@system.software.com>
References: <CAB=+i9SmrqEEqQp+AQvv+O=toO9x0mPam+b1KuNT+CgK0J1JDQ@mail.gmail.com>
 <20240711153846.GG10452@mit.edu>
 <20240712044420.GA62198@system.software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712044420.GA62198@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXC9ZZnoe7p/RPSDCbN0bWY2GNgcfH1HyaL
	mfPusFns2XuSxeLemv+sFq09P9kd2Dx2zrrL7rF4z0smj02fJrF7NJ05yuzxeZNcAGsUl01K
	ak5mWWqRvl0CV8bc9dPYC+5IVxzdtoutgXGTaBcjJ4eEgInExrbVTDD2mkNPWUFsFgFViQlv
	v7GB2GwC6hI3bvxkBrFFBBQlbrV8AbK5OJgFGpgkej5vYwRJCAskSLyYeRrM5hWwkFj68y4T
	SJGQwCJGiTPTL7JDJAQlTs58wgJiMwtoSdz49xKoiAPIlpZY/o8DJMwpYCmx6+NMsMWiAsoS
	B7YdB5sjIbCFTeLG9ctsEJdKShxccYNlAqPALCRjZyEZOwth7AJG5lWMQpl5ZbmJmTkmehmV
	eZkVesn5uZsYgSG9rPZP9A7GTxeCDzEKcDAq8fAGXO9PE2JNLCuuzD3EKMHBrCTC63kWKMSb
	klhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoFR+X/HL1bx+2YS
	jCybbgmcnKobE/yvadXBjrTlj5qVJmhONLNQW+V0o/kg26m7KeL14hrzQsNM73c8CvzkovXv
	WsGKBTFnAngZzy8/58HYYZJVy7O68v7uOY4TQ/P0pjodmF228OUd4x/CIZ3yF5+6R8iJ2//f
	HWb8XE0jLX59u/jx5qBrW5cpsRRnJBpqMRcVJwIA6+xvU2UCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsXC5WfdrHt6/4Q0g0lLFC0m9hhYXHz9h8ni
	8NyTrBYz591hs9iz9ySLxb01/1ktZrTlWbT2/GR34PDYOesuu8fiPS+ZPDZ9msTu0XTmKLPH
	t9seHotffGDy+LxJLoA9issmJTUnsyy1SN8ugStj7vpp7AV3pCuObtvF1sC4SbSLkZNDQsBE
	Ys2hp6wgNouAqsSEt9/YQGw2AXWJGzd+MoPYIgKKErdavgDZXBzMAg1MEj2ftzGCJIQFEiRe
	zDwNZvMKWEgs/XmXCaRISGARo8SZ6RfZIRKCEidnPmEBsZkFtCRu/HsJVMQBZEtLLP/HARLm
	FLCU2PVxJthiUQFliQPbjjNNYOSdhaR7FpLuWQjdCxiZVzGKZOaV5SZm5pjqFWdnVOZlVugl
	5+duYgQG7LLaPxN3MH657H6IUYCDUYmHN+B6f5oQa2JZcWXuIUYJDmYlEV7Ps0Ah3pTEyqrU
	ovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGxrv7jK66yWz1+dnIseFx
	xaM1l2qPCp5om/R259wbW07HP38q0lN2vsPci6Vj55S2qQXbeLZEvTr4NiH9wIvS96L3Jvus
	Ur0TPafBQWP5+//XtIv+HxD691DkegUfi6TdB8XXUekz5x+7VWDXYVGheLNqcvpmdeaLwQt8
	H4fIf7CXn5OVrqcda6PEUpyRaKjFXFScCAAmLZNlVAIAAA==
X-CFilter-Loop: Reflected

On Fri, Jul 12, 2024 at 01:44:20PM +0900, Byungchul Park wrote:
> On Thu, Jul 11, 2024 at 11:38:46AM -0400, Theodore Ts'o wrote:
> > On Thu, Jul 11, 2024 at 09:07:53PM +0900, Hyeonggon Yoo wrote:
> > > Hi folks,
> > > 
> > > Byungchul, Gwan-gyeong and I are investigating possible circular
> > > dependency reported by a dependency tracker named DEPT [1], which is
> > > able to report possible circular dependencies involving folio locks
> > > and other forms of dependencies that are not locks (i.e., wait for
> > > completion).
> > > 
> > > Below are two similar reports from DEPT where one context takes
> > > i_data_sem and then folio lock in ext4_map_blocks(), while the other
> > > context takes folio lock and then i_data_sem during processing of
> > > pwrite64() system calls. We're reaching out due to a lack of
> > > understanding of ext4 and file system internals.
> > > 
> > > The points in question are:
> > > 
> > > - Can the two contexts actually create a dependency between each other
> > > in ext4? In other words, do their uses of folio lock make them belong
> > > to the same lock classes?
> > 
> > No.
> > 
> > > - Are there any locking rules in ext4 that ensure these two contexts
> > > will never be considered as the same lock class?
> > 
> > It's inherent is the code path.  In one of the stack traces, we are
> > using the page cache for the bitmap allocation block (in other words, a metadata
> > block).  In the other stack trace, the page cache belongs to a regular
> > file (in other words, a data block).
> > 
> > So this is a false positive with DEPT, which has always been one of
> > the reasons why I've been dubious about the value of DEPT in terms of
> > potential for make-work for mantainer once automated systems like
> > syzbot try to blindly use and it results in huge numbers of false
> > positive reports that we then have to work through as an unfunded
> > mandate.
> 
> What a funny guy...  He did neither 1) insisting it's a bug in your code
> nor 3) insisting DEPT is a great tool, but just asking if there's any
> locking rules based on the *different acqusition order* between folio
> lock and i_data_sem that he observed anyway.
> 
> I don't think you are a guy who introduces bugs, but the thing is it's
> hard to find a *document* describing locking rules.  Anyone could get
> fairly curious about the different acquisition order.  It's an open
> source project.  You are responsible for appropriate document as well.
> 
> I don't understand why you act to DEPT like that by the way.  You don't
> have to becasue:
> 
>    1. I added the *EXPERIMENTAL* tag in Kconfig as you suggested, which
>       will prevent autotesting until it's considered stable.  However,
>       the report from DEPT can be a good hint to someone.
> 
>    2. DEPT can locate code where needs to be documented even if it's not
>       a real bug.  It could even help better documentation.
> 
> DEPT hurts neither code nor performance unless enabling it.
> 
> > If you want to add lock annotations into the struct page or even
> > struct folio, I cordially invite you to try running that by the mm
> > developers, who will probably tell you why that is a terrible idea
> > since it bloats a critical data structure.
> 
> I already said several times.  Doesn't consume struct page.

Sorry for that.  I've changed the code so the current version consumes
it by about two words if enabled.  I can place it to page_ext as before
if needed.

	Byungchul

