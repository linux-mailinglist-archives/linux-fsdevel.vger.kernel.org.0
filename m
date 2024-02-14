Return-Path: <linux-fsdevel+bounces-11607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF238553C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 21:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD53292A24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3832313DB9F;
	Wed, 14 Feb 2024 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RR1NvtO6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF51339B6;
	Wed, 14 Feb 2024 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941500; cv=none; b=gXZXt5xbXqRgD1CpdPIySE62tk7if53bFgnTWG7MnM6ThSy4vPr/7SW0kz7VJOTRQ5Y74+R87o+S3TVceEUV5gxUQHUd7aRzSdfQHPUjMkBrzpBk/PxeXCA31HBKj64LS3NgP157ZQmbNEVWQV+JKjYXvfpDajyMTgALTt4oZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941500; c=relaxed/simple;
	bh=ugMuiBhXaOfS6JO62Z0RIeo0yfNv3ZBX5Go5vrWXW3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ct22FMbDZROsQUe7VG/+yvBuCqB2+rdyJ3kXH7Jwd2mnNUhUvbQ0fVf4cfOeGZdHBslvIt4rTBEPfBLzjzdKTBDITaOiezLzgfI/TjZWyTrTq+tERR/2wuUUbK/fwFfICiLbu49w+nYXRiV7RLzlcwM/q02NfyyXCXhe+tbR9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RR1NvtO6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nzG+mcwtKVReimCU6zx6inAB8xN7+k5Rvm7slPc1wIQ=; b=RR1NvtO6ycswu7Qr0ZPqrP4PWj
	LNdeaqOqje4bdXi5DGOLcJDnCljck4gLPwvxmpGg8C/jn79uWuGkbeFakgpo4KvpoMMRm70tWfZDc
	h3a/ClEjQy04HJCqcZoIa/UuoeMoErlzWJoYqeLBdkmpqNldKK5Ug+mvnI8Vi5gGJet7oyeLsxC8z
	+uOHoreKUHyO7UI0Eg000CpPo780XBDKMyscM4NHbSlGKzsohlEU4AXPBnnT0TbasI2aUH2uGAqAv
	VT5RE0ttZFCIN/1yTreaWG+Pgjj3ls1T3klTMs2e08Bnya7OFeXFa6z3SYcbhGwmuray0OLL9Q41J
	vX72BgkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raLb0-0000000HUak-0HCQ;
	Wed, 14 Feb 2024 20:11:06 +0000
Date: Wed, 14 Feb 2024 20:11:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, liam.howlett@oracle.com,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
	paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 01/35] lib/string_helpers: Add flags param to
 string_get_size()
Message-ID: <Zc0eWURJL64C3vqn@casper.infradead.org>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-2-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:47PM -0800, Suren Baghdasaryan wrote:
> -	string_get_size(size, 1, STRING_UNITS_2, buf, sizeof(buf));
> +	string_get_size(size, 1, STRING_SIZE_BASE2, buf, sizeof(buf));

This patch could be a whole lot smaller if ...

> +++ b/include/linux/string_helpers.h
> @@ -17,14 +17,13 @@ static inline bool string_is_terminated(const char *s, int len)
>  	return memchr(s, '\0', len) ? true : false;
>  }
>  
> -/* Descriptions of the types of units to
> - * print in */
> -enum string_size_units {
> -	STRING_UNITS_10,	/* use powers of 10^3 (standard SI) */
> -	STRING_UNITS_2,		/* use binary powers of 2^10 */
> +enum string_size_flags {
> +	STRING_SIZE_BASE2	= (1 << 0),
> +	STRING_SIZE_NOSPACE	= (1 << 1),
> +	STRING_SIZE_NOBYTES	= (1 << 2),

you just added:

#define	STRING_UNITS_10		0
#define STRING_UNITS_2		STRING_SIZE_BASE2

and you wouldn't need to change any of the callers.


