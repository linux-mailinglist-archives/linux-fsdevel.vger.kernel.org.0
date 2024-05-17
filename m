Return-Path: <linux-fsdevel+bounces-19631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB408C7F6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 03:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D92B1F22384
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 01:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF4B10F9;
	Fri, 17 May 2024 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A7704XwV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79073622;
	Fri, 17 May 2024 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715908421; cv=none; b=CPo26vxIWBBQIDBCczBkdb0kmKFHsiI+sh3cz2EOg++e+qRD1I6iuFYUHUc2gcUu+TYYcYAPo2afsTryaisTcV+3ZFQdFQUfTl55gV501aQdfpPhAQVIXiyQKnFeXQJBVUXw8JbSXIuJnySSPvAzUPGdFpGZhxFB1IGS5Zn3Q+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715908421; c=relaxed/simple;
	bh=/vvsswAoAmgw2yBWUNu63T1F+yzlmKWlMthqEIrZGhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRviwlOHwYfAov46QCIfGVBHyuqNUHdKk0f3ZwTsqowpsi66iEUFbbGOa0c/3Yv8YoGr4K2/baDrbBTGbG1LsqtRfHJ6bvC8MVJWPcKJjHvfsmUHcXzWH2ABkJjWMvaNRCyivTf9JcuBGqpoTGCZdkFy3tkZCuHKnzG/7nSWDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A7704XwV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bAaTm4i8GbKAujXZw/Nj794uuuDBMkfyY62rPnCcTt4=; b=A7704XwVQCJKlO1iLZQaTR2qje
	EiMO3ljg1j6WybniFFv/rcE8vASAIHIhyyHefq4J3zxkct5KzEbth8Huy7neQoSfIjxpyyif1c/lp
	eHBV0OS/yk8sWPrm/TfbZ+1n17Yl2ZNwCok56KL5MulmWYGI6EJNYlIrRG2mVXEmikpODYJDl/NUl
	ATNntx+hFn1MQfqUDKsSONlTGnEwiXVSN1RaNzXCo19AUpMkWKuBLH7XB7CHj5h5j+47EKAahS1qf
	iEpTdS+FCwQMQij6LjOcxrncpS94Z1a/TB6uphrr954Va2B3fAdKCrTYtP5Jq9JbK+n9iW8wteePr
	HhONV66w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7m9y-0000000CRRv-2uiS;
	Fri, 17 May 2024 01:13:22 +0000
Date: Fri, 17 May 2024 02:13:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] fs: fix unintentional arithmetic wraparound in offset
 calculation
Message-ID: <ZkavMgtP2IQFGCoQ@casper.infradead.org>
References: <20240517-b4-sio-read_write-v3-1-f180df0a19e6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517-b4-sio-read_write-v3-1-f180df0a19e6@google.com>

On Fri, May 17, 2024 at 12:29:06AM +0000, Justin Stitt wrote:
> When running syzkaller with the newly reintroduced signed integer
> overflow sanitizer we encounter this report:

why do you keep saying it's unintentional?  it's clearly intended.

