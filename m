Return-Path: <linux-fsdevel+bounces-16069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ABB8978CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 21:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81DD2877DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9573F154458;
	Wed,  3 Apr 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ab29Awgi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E3146D62
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171224; cv=none; b=D1G1Zcs2GUJ1GUDnHfbre58cbyeTkxr0yRL54wuWjXrfMCOY1dCyX5gpOJ5pz4GUkHbHODjnuDFd0saQu6khFYJk23UHi4YmFhFYRjjzwlbPMI2YfUDBuH/zYbrTZumzIjrm9Lq4hjqlXgayYO8L7XzxFRKsOBwNrj5OMkMHP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171224; c=relaxed/simple;
	bh=DmbUJaU7fvPvxuhQjMUT+PZdyRm/OezzMypWogtG338=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYkteRyr46cEM9P3Cf5/fyWWzfxI35Hk5NwL5iEiA9dhzGyja8U5Dcjdg619AQ2MUFttFXGmscDGJVQFiOnl/AJpncTNyLNcpI3lPyeNwpcYOakxsXZGP5P2VqtM8LSaw4SWmHYDG9FqBuBhlxtCgeF1hpSve5V1P/NtNtmX2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ab29Awgi; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 3 Apr 2024 15:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712171220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MPufZuIJuTLIDu10Urps9fsUQXIz9rznyNkrrZnyWEM=;
	b=ab29AwgidGYXl/9pYqDFJfdDItXW7t4LUhM3Qj9YVwhcTDaF8J7UEropu/nN8V+SnlrPp/
	+SrSQ2f18s9M0jQ8SgPaaB8J5ogz82i+9eN08TaGx4gkgjN0F4Euhr/MbcHZN6rMiDbbtt
	T9FLbyOJvoCIqIyAx5v/kURkMzbxliU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	akpm@linux-foundation.org, willy@infradead.org, bfoster@redhat.com, dsterba@suse.com, 
	mjguzik@gmail.com, dhowells@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <qemects2mglzjdig7y5uufhoqdhoccwlrwrtfhe4jy6gbadj6n@dnnbzymtxpyj>
References: <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>
 <ZgXFrabAqunDctVp@slm.duckdns.org>
 <n2znv2ioy62rrrzz4nl2x7x5uighuxf2fgozhpfdkj6ialdiqe@a3mnfez7mitl>
 <ZgXJH9XQNqda7fpz@slm.duckdns.org>
 <wgec7wbhdn7ilvwddcalkbgxzjutp6h7dgfrijzffb64pwpksz@e6tqcybzfu2f>
 <ZgXPZ1uJSUCF79Ef@slm.duckdns.org>
 <qv3vv6355aw5fkzw5yvuwlnyceypcsfl5kkcrvlipxwfl3nuyg@7cqwaqpxn64t>
 <ZgXXKaZlmOWC-3mn@slm.duckdns.org>
 <20240403162716.icjbicvtbleiymjy@quack3>
 <Zg2jdcochRXNdDZX@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg2jdcochRXNdDZX@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 03, 2024 at 08:44:05AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Apr 03, 2024 at 06:27:16PM +0200, Jan Kara wrote:
> > Yeah, BPF is great and I use it but to fill in some cases from practice,
> > there are sysadmins refusing to install bcc or run your BPF scripts on
> > their systems due to company regulations, their personal fear, or whatever.
> > So debugging with what you can achieve from a shell is still the thing
> > quite often.
> 
> Yeah, I mean, this happens with anything new. Tracing itself took quite a
> while to be adopted widely. BPF, bcc, bpftrace are all still pretty new and
> it's likely that the adoption line will keep shifting for quite a while.
> Besides, even with all the new gizmos there definitely are cases where good
> ol' cat interface makes sense.
> 
> So, if the static interface makes sense, we add it but we should keep in
> mind that the trade-offs for adding such static infrastructure, especially
> for the ones which aren't *widely* useful, are rather quickly shfiting in
> the less favorable direction.

A lot of our static debug infrastructure isn't that useful because it
just sucks.

Every time I hit a sysfs or procfs file that's just a single integer,
and nothing else, when clearly there's internal structure and
description that needs to be there I die a little inside. It's lazy and
amateurish.

I regularly debug things in bcachefs over IRC in about 5-10 minutes of
asking to check various files and pastebin them - this is my normal
process, I pretty much never have to ssh and touch the actual machines.

That's how it should be if you just make a point of making your internal
state easy to view and introspect, but when I'm debugging issues that
run into the wider block layer, or memory reclaim, we often hit a wall.

Writeback throttling was buggy for _months_, no visibility or
introspection or concerns for debugging, and that's a small chunk of
code. io_uring - had to disable it. I _still_ have people bringing
issues to me that are clearly memory reclaim related but I don't have
the tools.

It's not like any of this code exports much in the way of useful
tracepoints either, but tracepoints often just aren't what you want;
what you want just to be able to see internal state (_without_ having to
use a debugger, because that's completely impractical outside highly
controlled environments) - and tracing is also never the first thing you
want to reach for when you have a user asking you "hey, this thing went
wonky, what's it doing?" - tracing automatically turns it into a multi
step process of decide what you want to look at, run the workload more
to collect data, iterate.

Think more about "what would make code easier to debug" and less about
"how do I shove this round peg through the square tracing/BPF slot".
There's _way_ more we could be doing that would just make our lives
easier.

