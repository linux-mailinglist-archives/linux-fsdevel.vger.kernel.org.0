Return-Path: <linux-fsdevel+bounces-20137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FDB8CEAE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 22:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E881C21014
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 20:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EB27E792;
	Fri, 24 May 2024 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NUxhJpQH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D48529429;
	Fri, 24 May 2024 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716582987; cv=none; b=ZUOrC3xi3AtiUVrCpyXwhKerh87pd9CvUsinBpizbJI4KMoOBwA5ySBFDGJ48K4+OZLGPgocjA739EsCmGUp6Pkc+XpmoQI5rp53vUHEQm8OvqgdH2w+b/tqwdeVaesxbZkg6reYYwXnMXwvEugZFBtCpp7/7eillUdldGVXX9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716582987; c=relaxed/simple;
	bh=VQHmXG+j7PIHbzuECBnhhjZXJ0/jfoHRjIEPxqgUvcc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=V/IPEBvVh6fzRNHdWXB/NDKqe+1XxicVXAMMX9MC0lpm0J/wEEZ92Mwy7+HKIs70hswVgMJij1HUq4/SHJmGosmVBkBpnqu/OjwXRocRbf1hjD8tgNlh58BIMT4J3eZXoHSRacUwNoRcdj+1/YB5z/Gflbpv7MlZ+zHFfUxPjk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NUxhJpQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFC6C2BBFC;
	Fri, 24 May 2024 20:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716582986;
	bh=VQHmXG+j7PIHbzuECBnhhjZXJ0/jfoHRjIEPxqgUvcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NUxhJpQHXzT8PNJ83TzM/Wyp7kA/0w4J+WQYT+Wu4k0sa3m8G8xl3BNOMp37SP9HV
	 0tgzjDAHHTu1wYhzBuKAm1A4vXPKn0utxjLaLRdE0uImOu002lRbNx60dcMIMxqcLP
	 MkK89kBjNagawGOzBfTC1B9llYq6VCsrbxXyANoc=
Date: Fri, 24 May 2024 13:36:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Rientjes <rientjes@google.com>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
 gregkh@linuxfoundation.org, rafael@kernel.org, mike.kravetz@oracle.com,
 muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
 rdunlap@infradead.org, chenlinxuan@uniontech.com, yang.yang29@zte.com.cn,
 tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com,
 pasha.tatashin@soleen.com, yosryahmed@google.com, hannes@cmpxchg.org,
 shakeelb@google.com, kirill.shutemov@linux.intel.com,
 wangkefeng.wang@huawei.com, adobriyan@gmail.com, Vlastimil Babka
 <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 surenb@google.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
 weixugc@google.com
Subject: Re: [PATCH v12] mm: report per-page metadata information
Message-Id: <20240524133624.9d9e3935a0c99700b67cee5f@linux-foundation.org>
In-Reply-To: <1e1b89af-3b7a-7400-cfd7-d22a101955de@google.com>
References: <20240512010611.290464-1-souravpanda@google.com>
	<45fb4c94-dd77-94c3-f08f-81bf31e6d6d2@google.com>
	<1e1b89af-3b7a-7400-cfd7-d22a101955de@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 13:00:06 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> This would be a very useful extension to be able to provide observability 
> of per-page metadata overhead and the impact of things like HVO on the 
> overall footprint.  Today, we don't have observability for this memory 
> overhead.
> 
> Andrew, anything else that can be addressed before this is eligible for 
> staging in MM unstable?

I've asked Sourav to prepare a v13, largely to see if we can get a few
more eyeballs onto this.


