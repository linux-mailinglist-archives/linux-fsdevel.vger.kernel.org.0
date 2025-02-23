Return-Path: <linux-fsdevel+bounces-42361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9D8A40F0A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 13:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF0018929C1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61751204F66;
	Sun, 23 Feb 2025 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gRjDaoFo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637491E480
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740314881; cv=none; b=fSaL8RQ63QgGS/i0kLiGtJXU+VoBEA93H+iu4x4j7Gvd2ubEsvH+ytCtjiyOjWNy7eWoheVdtjj1rMoC0ofJrFq99/Itq7+GVLj7ul97WpcKvd92mJLNPJGE1iUPT3ADw2PWS37WPmG2YJ+9GQXAU8ocImOd094ehUoP0tDTB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740314881; c=relaxed/simple;
	bh=xuZP8v71qbCGLPCF+bW6uiv6JpAfZnjI5UZrdEdAqPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5sLNX06lp9G1E2qvoO5gNsKluZmKUEswiHppBfch2qsaGXuEKyzDEZQLGTfvRXqs7NiESiubxIrGaE60iYh/zjr7RNx5wJIGVobUTOLAafBn1SyIgCNcc+nMjQjFjaFhsvTtVZPlbUiYFt9W6MsR+AFUVpjasrkQuNwCrE5Ycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gRjDaoFo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xuZP8v71qbCGLPCF+bW6uiv6JpAfZnjI5UZrdEdAqPc=; b=gRjDaoFoyxczkCC628NDdHgA9a
	YncFRWrnB4o81jjOtXet0uLPz0qUl2hCwhWE4Cvcs9oVdet/kUAcOU7P6KpFEzEgmM8+yLTcv03to
	IG6wVRSRL60lsgZdpENmMP4Oec4CETschP3c7cRZej6oOLLr6+i87rFR9W/wJugqWBex6KeM6qb7F
	6Awctw2++Gl4bjUzK2IZWWKPV8UG/1cmFXfkN+HqkGa3xIb4uCn1KnAVwbwhK6TApBHfM+CC0gs8n
	M2rAcNVMVLbc9e46ptbKKSfYmdH4pvwTX1VkbrPLkP1I1nyuykUpAkjwgoagOaavWd064VoJ/ZZrX
	X2JunpiA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmB2Q-00000003W7i-0ZCT;
	Sun, 23 Feb 2025 12:24:50 +0000
Date: Sun, 23 Feb 2025 12:24:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kalesh Singh <kaleshsingh@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	lsf-pc@lists.linux-foundation.org,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	David Hildenbrand <david@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Juan Yescas <jyescas@google.com>,
	android-mm <android-mm@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead Behavior
Message-ID: <Z7sTkQAWt1X15wN0@casper.infradead.org>
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <dsvx2hyrdnv7smcrgpicqirwsmq5mcmbl7dbwmrx7dobrnxpbh@nxdhmkszdzyk>
 <CAC_TJvepQjR03qa-9C+kL4Or4COUFjZevv+-0gTUFYgNdquq-Q@mail.gmail.com>
 <31e946de-b8d5-4681-b2ac-006360895a87@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31e946de-b8d5-4681-b2ac-006360895a87@lucifer.local>

On Sun, Feb 23, 2025 at 09:30:57AM +0000, Lorenzo Stoakes wrote:
> It seems strange to me sparse regions would place duplicate zeroed pages in
> the page cache...

https://lore.kernel.org/linux-mm/Z7p-SLdiyQCknetc@casper.infradead.org/

