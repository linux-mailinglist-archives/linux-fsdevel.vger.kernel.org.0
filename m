Return-Path: <linux-fsdevel+bounces-36646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC809E74D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2CF2871CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F171CD1FB;
	Fri,  6 Dec 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jEJffToa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30FE80BFF
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500007; cv=none; b=X26Yv0Y4+tNr+FZmU975kCD71GPVPxUzAlILO7RTib7GQHmRzHdwVZgxeYapVRV3yuXdl7HUdYRqA767CfhfQmh++QRVxbgnHpcBz2QzqbbhcJpjvvxVh4LlUAG3ppvomU4tyCFAXB3kq9GI60MA+8OqxysL7JdM90tk2VKVwGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500007; c=relaxed/simple;
	bh=pzjUG+QTJG0XEIMXWAxArvqRWmHuSZw2ZnUskolS4Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4f3hgGX/FlEMpNlGsaUPz3CzYS09HBnorvGTJaijNh5VPG/I3uYwKBP/M3kTRLfe1b0DNriBP2zuQBUWIBVCRC19Bm8BDaGIcW71i2C4Q9amSmsqFtbsCXvlxkapbSOCu2SQu5LHHeMI+YftaM/RQjcD/scd7yl6gHwV5XUfpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jEJffToa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Uwzhy1fPrpz6eX6xmgzUWDZ6lFtpdUkiEa3bfJ7yPZM=; b=jEJffToarNJpGdtcSuIep+ZBcY
	2vySsBp3A6x4o9SlUqj/TzPPiDVunAbuzJvJX2J7EA8UeT5G8eUtAba0gGq4pG/r5IHQcZCfIkU66
	agLMQYKtnf/cu+Efa61N3OPaJE+M6CT/IbggnUrOMF8e+C1U9hr5AP9LVS4LvOQWTzdhbB2N+qloR
	5MX27oTBhIX5Q7zlFwkKDMZcW8riORyoOFN2q4Gzhh2hkRXu41wciZWCF6mf430cqMiCJtVgrgwxm
	10kyCu4PeDLVfICagU5emUicIsqwJz8MoJns2Gtd6LGZqtDBSfkr623T+W/wSTmuFvrLt66UkPxIi
	hP2aCabw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJaXN-0000000EerV-2CvS;
	Fri, 06 Dec 2024 15:46:37 +0000
Date: Fri, 6 Dec 2024 15:46:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC] pidfs: use maple tree
Message-ID: <Z1McXVVPJf4HztHU@casper.infradead.org>
References: <20241206-work-pidfs-maple_tree-v1-1-1cca6731b67f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-work-pidfs-maple_tree-v1-1-1cca6731b67f@kernel.org>

On Fri, Dec 06, 2024 at 04:25:13PM +0100, Christian Brauner wrote:
> For the pidfs inode maple tree we use an external lock for add and

Please don't.  We want to get rid of it.  That's a hack that only exists
for the VMA tree.

