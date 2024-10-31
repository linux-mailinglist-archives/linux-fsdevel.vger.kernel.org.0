Return-Path: <linux-fsdevel+bounces-33325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37C69B74D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 07:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C2A1C2486A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603761487C5;
	Thu, 31 Oct 2024 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DIrIH/RC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F79C13B7B3;
	Thu, 31 Oct 2024 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730357826; cv=none; b=P/5L2HC72LYfCBdKENpUuuNZCA+Wypkq7fX2KCgNHovdlRjGXLIQMTvzKp9rdfjqBluT0yqWWB7qezDKN8O0pej69cWIGm0TamJYYPuHyiNbzzDSfWbUbyZstyBvFvED8Udy+5h9uMZSryeM8MsgsaXmD2Ze1xlLhYMpGgVtR4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730357826; c=relaxed/simple;
	bh=Jmvrf9ZI96zexvYrHrmIPqjjaxC03xEAYW4iJcytiio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkWyFV8VvOa3545kmkXcs22zD1TRf8V8dw4G7omkdBC18+j3ObZ89OGCH48Cp40YXMOWYGVFG7SqMfVfBlV1nT983Xck2800Wty9BhZk9lOswj8ipYpqDl7DfCW0jsa0V09E5S/9LBI3EnEotTOCpPpsRPGz0lxK0QtcxMh3qFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DIrIH/RC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Ag2Vrp4HzlTG/ZKHKyjX9Y5ayRe/E+c2VIy3nR4Dic=; b=DIrIH/RCL/X/GzftQUrI7K0dr4
	BmMfTCQVIlrOgJvbSdk/OhMggB7/2mIWVuwhuL8X3BTjOvr1oAQABGAGHm9pen719x4vQ7NGb934g
	DsE/UJCUvhAHJ6qT85aCJzA+kXa3+ev6U2pOYuUrSGwOjzNjy1JbIjhQUwgmlN+9236ls4Fis+Bsw
	n/aHiKwiTQXJPaQ2SAiegw3D6D8VWMdCplAjUYj6+DsvwtfDl9ePOSrIkodI6N3wjK/DQACNj5PSb
	6A6+a7TsrrOsfraEJlg1oHdKuMnXs/+Wx4yAqpQquWDaeMPb4es/7kPRwVcOq/yf3iSVjIbmwiK3X
	W5pfIRtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t6P75-00000002jZZ-0Y2t;
	Thu, 31 Oct 2024 06:56:59 +0000
Date: Wed, 30 Oct 2024 23:56:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Song Liu <songliubraving@meta.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>, KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Message-ID: <ZyMqOyswxw1s1Jbt@infradead.org>
References: <Zw34dAaqA5tR6mHN@infradead.org>
 <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
 <Zw384bed3yVgZpoc@infradead.org>
 <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
 <20241016135155.otibqwcyqczxt26f@quack3>
 <20241016-luxus-winkt-4676cfdf25ff@brauner>
 <ZxEnV353YshfkmXe@infradead.org>
 <20241021-ausgleichen-wesen-3d3ae116f742@brauner>
 <ZxibdxIjfaHOpGJn@infradead.org>
 <41CA4718-EE8E-499B-AC3C-E22C311035E7@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41CA4718-EE8E-499B-AC3C-E22C311035E7@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 30, 2024 at 08:44:26PM +0000, Song Liu wrote:
> Given bpf kfuncs can read user.* xattrs for almost a year now, I think we 
> cannot simply revert it. We already have some users using it. 
> 
> Instead, we can work on a plan to deprecated it. How about we add a 
> WARN_ON_ONCE as part of this patchset, and then remove user.* support 
> after some time?

As Christian mentioned having bpf access to user xattrs is probably
not a big issue.  OTOH anything that makes security decisions based
on it is probably pretty broken.  Not sure how you want to best
handle that.


