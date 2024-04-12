Return-Path: <linux-fsdevel+bounces-16832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6688A38D6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 01:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F87282BA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 23:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F53152530;
	Fri, 12 Apr 2024 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ryHVfP48"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774615218A
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712963538; cv=none; b=lGP0Yu3tCHY07GIfqM4EvdMuNHlqjEG+sT/EPVELRGQlg99AIBn3b1RyjoKP/+qbpJdUVDh23YvlrVbhre1RAMiVsOzgdzwIJENtxnbhd4xTH7J8rCwWtF2Qy8TasH1W/WWJdAw8JBd7R+5kTiUj3F/n8vUntmZ/a6YkFMGPqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712963538; c=relaxed/simple;
	bh=t7T0xUX6SniVYpel0hP608nE+DJbI//MvBA6GuVttqk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mm3YwjHzGCP75292G759BwMN1AWp232zUckI83U4zpkiY+F9C2Mzw71ajtsG5fmCuEAaKpMRwbWJkbOH1ikAtxgAifT0Ov4LOwDuCcWri+BJfOGaiS3sysPL7bkCOpxImj7G+GJ60mJaKyMsd8kk0UGqVGF5hdP9gpez2ukX36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ryHVfP48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A50C113CC;
	Fri, 12 Apr 2024 23:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712963538;
	bh=t7T0xUX6SniVYpel0hP608nE+DJbI//MvBA6GuVttqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ryHVfP48gEu+EgvrJZU57wrQwJlYnFO89A+jWZtVXfZlxEJf7louV3/kMenTc5kuu
	 wkr5XByITBs4wpv/JWAh+gCxbOnf96Wkk0lS8+HC9NzNVBPEaG19NjvVIy+fJ+9/5Y
	 d3QcZYCK8LX2sYEKGqMSAxN36hjyQ2p6guvf7EhM=
Date: Fri, 12 Apr 2024 16:12:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] mm: batch mm counter updating in
 filemap_map_pages()
Message-Id: <20240412161217.c7dc1af77babe5004bd3e71d@linux-foundation.org>
In-Reply-To: <20240412064751.119015-1-wangkefeng.wang@huawei.com>
References: <20240412064751.119015-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 14:47:49 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Let's batch mm counter updating to accelerate filemap_map_pages(). 

Are any performance testing results available?

