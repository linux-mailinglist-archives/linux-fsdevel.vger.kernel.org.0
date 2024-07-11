Return-Path: <linux-fsdevel+bounces-23580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 198B392EBCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 17:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97A31F242AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305A616C687;
	Thu, 11 Jul 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="JZjIQ+2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE11662FA
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712352; cv=none; b=SvGbzJFZ/1t2ym89BtLAiY54Cvs5BMUBq7tPL3Kra+G5/wpnB95cC1tW9Wi/zsBRW9BnbGkdFz1C3b1h+mSveXiJrNLKC51WSw1/OK6fJavaFR2WW9p4aq0N5chjc2BKoZtLxS/sCelYF6mZnnPQqWNbnZ30RkkYQAUteC/s3CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712352; c=relaxed/simple;
	bh=dFJIGiqHV4d3r8M1N1PfdLB2SJcDUaIfCpmMQazRXsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J18f9w+NIcT0twGGyphOTNW3koRKvMXNMk54oggbTLjRGx4bvK6mSf/+8UqpOHtZH5rR+nzaUdO01AQRI9njCHhoD6obAepzfosZ5pJ0KfVWyO1+TtlVvbzjAof3wizWOEkR8xAjV9PgVzfLCynE8BskFdnePYlNP9spXLQilqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=JZjIQ+2D; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46BFckhb027062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 11:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720712329; bh=/VcXrUB/psK9av802puqgz29sb9AUiGCnoz6Lc0LMWs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=JZjIQ+2D3s8AfkdBXGGl1f2nnEtby//R36w/PG9DoIGDaGjPW6XxLsYJbsfIW4Wuo
	 M8KJZl3DjojaVk68g6yYOojz4W9ySCu9fWtz/gId+UR5X7XdhdYHCg28K/iZRzrzTx
	 nj1LMfV5S1mVHZu51HoLJ0ZZx2mwcGEDFsE4txWmpDqYTzrMi+R6J9RwiUw+XdE0a+
	 aqG4OaRGK83+XF3Cy+vUKwzOTm/rjl/qooEdHaeeymkgseLK8lfkBT8VHP+OYxOjuO
	 S+fzltx+Af8mQbrrXct4KNSrArQcE1UmCQ325NOCVYWQ2+WZrLsQ9EatJ8sND8WSOj
	 AbIq19Eq3ew3g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8740515C0250; Thu, 11 Jul 2024 11:38:46 -0400 (EDT)
Date: Thu, 11 Jul 2024 11:38:46 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        max.byungchul.park@sk.com, byungchul@sk.com,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Subject: Re: Possible circular dependency between i_data_sem and folio lock
 in ext4 filesystem
Message-ID: <20240711153846.GG10452@mit.edu>
References: <CAB=+i9SmrqEEqQp+AQvv+O=toO9x0mPam+b1KuNT+CgK0J1JDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=+i9SmrqEEqQp+AQvv+O=toO9x0mPam+b1KuNT+CgK0J1JDQ@mail.gmail.com>

On Thu, Jul 11, 2024 at 09:07:53PM +0900, Hyeonggon Yoo wrote:
> Hi folks,
> 
> Byungchul, Gwan-gyeong and I are investigating possible circular
> dependency reported by a dependency tracker named DEPT [1], which is
> able to report possible circular dependencies involving folio locks
> and other forms of dependencies that are not locks (i.e., wait for
> completion).
> 
> Below are two similar reports from DEPT where one context takes
> i_data_sem and then folio lock in ext4_map_blocks(), while the other
> context takes folio lock and then i_data_sem during processing of
> pwrite64() system calls. We're reaching out due to a lack of
> understanding of ext4 and file system internals.
> 
> The points in question are:
> 
> - Can the two contexts actually create a dependency between each other
> in ext4? In other words, do their uses of folio lock make them belong
> to the same lock classes?

No.

> - Are there any locking rules in ext4 that ensure these two contexts
> will never be considered as the same lock class?

It's inherent is the code path.  In one of the stack traces, we are
using the page cache for the bitmap allocation block (in other words, a metadata
block).  In the other stack trace, the page cache belongs to a regular
file (in other words, a data block).

So this is a false positive with DEPT, which has always been one of
the reasons why I've been dubious about the value of DEPT in terms of
potential for make-work for mantainer once automated systems like
syzbot try to blindly use and it results in huge numbers of false
positive reports that we then have to work through as an unfunded
mandate.

If you want to add lock annotations into the struct page or even
struct folio, I cordially invite you to try running that by the mm
developers, who will probably tell you why that is a terrible idea
since it bloats a critical data structure.

Cheers,

					- Ted

