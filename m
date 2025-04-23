Return-Path: <linux-fsdevel+bounces-47088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D576A989AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 14:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E297169E08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0162153D0;
	Wed, 23 Apr 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BLHo1FsW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E311E522;
	Wed, 23 Apr 2025 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410933; cv=none; b=Yh8NTtFjD1zpG0lqULCNx6r/mX9tcK/BWyUgqf1tErQth9Ue2wqE8S0Y5YtACJ/4wjHj65bWkUXCdavQtLZaO37IdwZH1YcFc2FQS71HBKDU8HPJpyzf/wdJlEUJkJsiXQNzjUsbq5679AjQtu1XcS3Lgc+19As9YK6e3L6K1bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410933; c=relaxed/simple;
	bh=QCm61VieQxpPevx/SjjmuDLkEjGYZGkn9RuPgTGXB2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0o8hh/rpvDga4ONMBnpRf/IdCHEw2VBFWZvutDm+VBdS8hJId2g5BXIOwGUClQHZ7cD87fUalML06ht6oFy/KKdaIpVu+lAM2ETO/5edQGeZ7xK2uU60BV90SL9DcLp15Xs3StAxyvyqLG1g1Nte5mUcYtRwNVBzzdsTQqj8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BLHo1FsW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m1xiJ9IzuYwcg+d6s9ghzDmz6oBr/yFCCp9TZPFW8PE=; b=BLHo1FsWFS5cCyuPpl01UPQKve
	g0wBBEGkdDbhiAmoapTKqpLZWSw9ALj8+8EaV7q3o8O0O/3HEGDoUcwgeb4EBwCSvCkUcSOsSSESw
	f7Rd8x/dTcTvy3i57HfVPotCNjPFGtPftIzT9Sh8/ReR3DsWJBOUKljga9RtDkOBGg3hx6K7W86yU
	DT0jN/gESowzhXyDvbn8P4N4PFd8u8TpKx9Q3b+yzr5J8USSHhKJaI5HZh8FRwUGJ/04hY1np4l/n
	lX8BNNCdEbLHPmT0O7U/wwvmWXC0G2B9ORh0c69ItEkIgEf9sFlLagfyEKkCKEETp9qN9M2mU54yk
	Di09XAQA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Z79-00000008qvc-3gDX;
	Wed, 23 Apr 2025 12:22:07 +0000
Date: Wed, 23 Apr 2025 13:22:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: xu xin <xu.xin.sc@gmail.com>, xu.xin16@zte.com.cn, david@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, wang.yaxin@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH RESEND 1/6] memcontrol: rename mem_cgroup_scan_tasks()
Message-ID: <aAjbb1fBR-tq1h93@casper.infradead.org>
References: <20250422191407770210-193JBD0Fgeu5zqE2K@zte.com.cn>
 <20250422111919.3231273-1-xu.xin16@zte.com.cn>
 <20250422162952.19be32aa8cead5854a7699a8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422162952.19be32aa8cead5854a7699a8@linux-foundation.org>

On Tue, Apr 22, 2025 at 04:29:52PM -0700, Andrew Morton wrote:
> Patchset looks nice to me, thanks.  I'll await reviewer feedback before
> proceeding.

I thought we had a policy against adding new features to memcg-v1?
Certainly adding the feature to memcg-v2 would be a requirement before
it could be added to v1.

