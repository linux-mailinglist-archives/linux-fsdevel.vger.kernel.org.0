Return-Path: <linux-fsdevel+bounces-43813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D13A5E0AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05A517C0FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 15:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D0F252907;
	Wed, 12 Mar 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uhHJVxhZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F08425179D
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793992; cv=none; b=uOEeB9D/Hu2FcqK4XR6a9MYAa240wWcNC5kT3IPISGZFQxA6nKz/9rnwa5b+WFTFbMePBQO9eYZ1ai3w4k0fqvLaSWH4cqzwOACEdiLZXMLs9CRSsa0szTLvgBllwRAAjCOp629YfKPaHNslg0ar51/7NEf8UrW0IsNMafHfXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793992; c=relaxed/simple;
	bh=ID4kHIXFJP35o0TpoZETjYM+4340N5kqpkI9jg7XOdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX7C31PGnSKpysADN/cZu/w4q5I3wSeC0XyNZqyEO5gQqMUy3doSr3h+pgCVq7/kIyHbsLVzwGsnCdFWOppRwIrqcoISaL+L79lFNXZhc/+hE9L8pC1TA67EcwigPAV+iezuPFkiW6wYqjGlPFIU/wbLJLp0/znZ+AEqQb6TlFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uhHJVxhZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7XX+EcDhwxAq28z0lym/htVkyhSSRToF3QYW8CfJRxE=; b=uhHJVxhZv3XlkDmwkthcJRxebv
	ofpgBkUPJIsyB2H7hqn4b2dFbfStWuKXtJ4p/QLzMQo0MeAPiVpahp1RoCWH8N3X7WSVwD0eyETUN
	MvIUF7M+4ws9XsWZwtfxZxfe9B0hX6p+LQv3yrfZCphQaIvnZmGIdLFJMqikRJByJZf/FYlNzOWpw
	fB7tpfOW981UfgBCM4u56zFd86eOddJ3K5NowfG0GtQ+VmTmeMtSHtiITrb+/74zCYjZYO1Y8eAdd
	a8z6nfGqKXWcRSi2n5c7Xe/bfy4v4BlanrS7VCSLqP/kvo7kthcrk/lqmK7UxZbtCX65nVOjTp6I5
	jP1RI+kw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsOBR-00000008ttV-2PCp;
	Wed, 12 Mar 2025 15:39:49 +0000
Date: Wed, 12 Mar 2025 08:39:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sun Yongjian <sunyongjian1@huawei.com>,
	linux-fsdevel@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
Message-ID: <Z9GqxXvyXB_aR_Wu@infradead.org>
References: <ca00f758-2028-49da-a2fe-c8c4c2b2cefd@oracle.com>
 <2025031039-gander-stamina-4bb6@gregkh>
 <d61acb5f-118e-4589-978c-1107d307d9b5@oracle.com>
 <691e95db-112e-4276-9de4-03a383ff4bfe@huawei.com>
 <f73e4e72-c46d-499b-a5d6-bf469331d496@oracle.com>
 <20250311181139.GC2803730@frogsfrogsfrogs>
 <2fd09a27-dc67-4622-9327-a81e541f4935@oracle.com>
 <20250311185246.GD89034@frogsfrogsfrogs>
 <d0dc742a-7373-4e1e-9af4-d7414b1d3f4e@oracle.com>
 <vg5mnmd5qar5cck2qezeimkhjrs6cqgwb2xd6togm6sp6ac7or@dahqij46fml6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vg5mnmd5qar5cck2qezeimkhjrs6cqgwb2xd6togm6sp6ac7or@dahqij46fml6>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 11, 2025 at 05:47:18PM -0400, Kent Overstreet wrote:
> > guarantee that d_off will always increase in value as an application
> > walks the directory. That's an impossible thing to guarantee given
> > the way d_off values are chosen (at entry creation time, not at
> > directory iteration time).
> 
> Not sure why you're trying to cite POSIX when it's an actual application
> regression under discussion.

Because from what Darrick report they look very related.

> Sane d_offset behaviour is one of those "of _course_ things will break
> you screw that up and I don't want to be on the hook for debugging it"
> things to filesystem developers - you don't do it.

Yet the semantics are surprisingly underdocument, where the issues show
up is rather surprising and non-obvious and people do tend to get it
wrong surprisingly often (probably this thread, a whole bunch of btrfs
things showing up, the old v1 xfs format, etc).

I've actually started collection various issues in the past, the test
cases that triggered it and how it relates to writtent standards.  It's
a bit of a mess.  I hope to eventually have a coherent writeup on all
that.


