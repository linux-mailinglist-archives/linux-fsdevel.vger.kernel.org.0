Return-Path: <linux-fsdevel+bounces-36850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D909D9E9CFC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 18:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3870A2817F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 17:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1EF153BF7;
	Mon,  9 Dec 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IG2UAj+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8263914B97E
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765035; cv=none; b=QAqblR1Tt/5dGHPjKAc6nwkNFxaWOVrJOARmKwCOcRD+AKuG0YH6AV29ihd46JZVjfdMGFd81o/SpzNzMJzz7L/YjmxMr7hnCIHQEt14B2ITcRS9CWKm/gKW6Q0IwRsJZDsirByFTiOPg5JnkIyecjSXvBJyoTBm8QjBjER9Wfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765035; c=relaxed/simple;
	bh=4YnqW/jKn0fAUvDsRoj37EkCK02U7lFjTh0ZSZpd9wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9YCkOPHgAjMca5Lbs8KwY+O/LfRfvnFkR0g7CKtkzwZxyTVE2D+/tuds7sFr7ISar7dZ+3aUeMhYuLoaFFZLURHD/G4vIaUruo535gFXAxWrAUd/PO1guiLv9wZXbQ21Q08h2RphswYOkbMnPmw2vdhTPNTax1PHEUStzdfkbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IG2UAj+8; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 9 Dec 2024 09:23:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733765029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msf3HhvsL+KxigNSQ6eQBzyMF6o7UjHTe7eCzRa74Y4=;
	b=IG2UAj+8Ks1/+YHDBuYdqqPj+ktktQluhmWvjtAMd90txlHsSWlGYZT/73nuH0d17xVc8e
	4I6yIBfTHn/G49kEuYYB3m4vjnuIsW8SHPN2kUX9vMZUingxVprHrf0jcpwGwD5gvefqQ/
	FLNch9Qjyv4CAhVmkcs8jDyFjCmHou8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v2 00/12] fuse: support large folios
Message-ID: <mm5vj4tzyoby3m3qhpami5zav7looctnhoeykqvxzhl7thued2@fqbn3pbp2qsf>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
 <f9b63a41-ced7-4176-8f40-6cba8fce7a4c@linux.alibaba.com>
 <CAJnrk1bwat_r4+pmhaWH-ThAi+zoAJFwmJG65ANj1Zv0O0s4_A@mail.gmail.com>
 <spdqvmxyzzbb6rajv6lvsztbf5xojtxfwu343jlihnq466u7ah@znmv7b6aj44x>
 <CAJnrk1ZLHwAcbTO-1W=Uvb25w9+4y+1RFXCQTxw_SQYv=+Q6vA@mail.gmail.com>
 <k5r4wheqx4bwbtnorrzath2n6pg22ginkyha4vuw342tvn4uah@tjy5j2kvbuxk>
 <Z1N71FJYYIqF0P8_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1N71FJYYIqF0P8_@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 06, 2024 at 10:33:56PM +0000, Matthew Wilcox wrote:
> On Fri, Dec 06, 2024 at 02:27:36PM -0800, Shakeel Butt wrote:
> > For anon memory or specifically THPs allocation, we can tune though
> > sysctls to be less aggressive but there is infrastructure like
> > khugepaged which in background converts small pages into THPs. I can
> > imagine that we might want something similar for filesystem as well.
> 
> khugepaged also works on files.  Where Somebody Needs To Do Something
> is that right now it gives up if it sees large folios (because it was
> written when there were two sizes of folio -- order 0 and PMD_ORDER).
> Nobody has yet taken on making it turn order-N folios into PMD_ORDER
> folios.  Perhaps you'd like to do that?

I was hoping the mTHP work for khugepaged (haven't checked the latest
their yet) would add the necessary building block and adding file
support would be trivial. I will check the latest there and see what we
can do there sometime next year.

