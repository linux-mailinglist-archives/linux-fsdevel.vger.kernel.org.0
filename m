Return-Path: <linux-fsdevel+bounces-22116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3D5912716
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 15:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8825928665C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 13:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513E8171C4;
	Fri, 21 Jun 2024 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mO5OOz3S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C563D5;
	Fri, 21 Jun 2024 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978239; cv=none; b=iLxK5jwY8OV05o5xjxAA+xiKt9QOEp/BVZC2JfGyDd7hO5AQINXdWgvdt4RY60MB9OLaBkueuWAOoHVjWFr+mgnBnZjhk9NA3vey3bpHu1h4bc5OsorYyvphmjXmZrp6THefM+Mex2FH7/MF5LlSLAWXc+FmKHZJijv1zpMA3WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978239; c=relaxed/simple;
	bh=7D1XSOiDMq3J20D9eCQjvYB35cnbWTU/PoTWWvCb8rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNEIdPfiaoxTaDnkP+AlIW9zxKTkPv8hGyadXgy71KqzH9tyAEFSSt7QFyheeWrlrQ6xZ3vnZiFlALaHAIkk6PFAwOTEhg/zCTzg5B0zl+8/06IO2hGk72zJZS9tomHPrejl8Hmiory+tQFmzqnrh8mpfO2IMxQs16wSWtYSObg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mO5OOz3S; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7D1XSOiDMq3J20D9eCQjvYB35cnbWTU/PoTWWvCb8rY=; b=mO5OOz3SIWlYAssxOG0CRWoAp/
	L64OelAl2Iw5whZKQuTcpkXinUkOwVp6l9D5GRFVtsFuYWHJbBQqcL6FICt050IxsfQKfvDTuMZUl
	sg/akK8oWqgR8MYV/AbLrDQ+XphkyeSGmXCjIWigtkPjpD/CDpWQtAbhKMX40rz7r/GyVM0DxOx9+
	P/Iw1kTh7JIISPvnZNKF9qfyxMec91XW4JG7yjCBYqPKzTL2010UQ3WH533TC7+dN1/Xf253uALgo
	fhYiTSl6bxT3icrvO6qwt74jay6C/y7Vh1HtMRIeAsCDYzdVzh7C55AGfmBQlcK8p05Wp54FdJrQR
	CtGKSFng==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKelH-00000007G58-0bUT;
	Fri, 21 Jun 2024 13:57:07 +0000
Date: Fri, 21 Jun 2024 14:57:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com,
	alexei.starovoitov@gmail.com, rostedt@goodmis.org,
	catalin.marinas@arm.com, akpm@linux-foundation.org,
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 06/11] mm/util: Deduplicate code in
 {kstrdup,kstrndup,kmemdup_nul}
Message-ID: <ZnWGsw4d9aq5mY0S@casper.infradead.org>
References: <20240621022959.9124-1-laoar.shao@gmail.com>
 <20240621022959.9124-7-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621022959.9124-7-laoar.shao@gmail.com>

On Fri, Jun 21, 2024 at 10:29:54AM +0800, Yafang Shao wrote:
> +++ b/mm/internal.h

Why are you putting __kstrndup in a header file when it's only used
in util.c?

Also, I think this function is actually __kmemdup_nul(), not
__kstrndup().


