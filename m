Return-Path: <linux-fsdevel+bounces-12748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDF586694D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 05:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6196DB22F4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 04:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5B91B299;
	Mon, 26 Feb 2024 04:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ffjvstIF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19505199DC
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 04:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921050; cv=none; b=gChlm6Kc01MZKzuM2FYlebYnbaYTn/GsxetqzvD2oObtyyjd3Orvwa43DCnfKJm0gDygtr+UPPNE2yiEsdBOLk5KbxCNJAe2J5+vdn7f7Q7odQ7Sk+B8tLkJtZPPFixuU3u6f2f98OB8viF4gEUbu6ATmqoNx51CKxhOYx+sjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921050; c=relaxed/simple;
	bh=ziwH+pCDyxYjIjzxKHTTOC6YVZoo9ph8PGei9tUW5js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXycfyLJTL5ckq2gFndFfWYhLbSBOVZn1vUNoFXX7D3g5K7rwTz0DHbE2Th4bi8tcaZVbFPa8R3fZuuBelJd5aq7tJzl9oXUbD8nwx54EiCEo2ZvvV2ac93uZDBUmLmVkZu+CcXLdwFtSwUgXbVCe5M+5mfE1iO79iYNHQfvKR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ffjvstIF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AfPdFaaO0ss9W2FTGy/OIpGc9dhnW6C4bijmtKmUVl4=; b=ffjvstIFEwMPH6JF1oTEJp/Qnx
	k/b7TV/HQxF5wyheY1z//ZlmmX99XLgRtg+oTOVJYRNW925+DNFFLFW68O4DCJLBt1ziA4AZBcdBB
	Kp0UMmsITJBz0zwdn0eqN9oi3tt/mT9xH7z9AFu9YKOn5v5J4GryiNX7tqDf+vXvl3+3CrUR6FmdQ
	1ZEPcO6XVnSgV77YqpILDFX8o3aYdYq3h4krqIWwzJdflPbTYZnu35CwDR/99wRU2vm8ffgam88X6
	DlYTBXvMHushLxfLI/jaTY1hVlYmh6WiFqOivDCHL7yv9uKW+sXsBnN4qlmc8js36sDfrGFO2psvg
	tn1x/64g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reSQa-0000000G6VL-13FM;
	Mon, 26 Feb 2024 04:17:20 +0000
Date: Mon, 26 Feb 2024 04:17:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: Add reclaim type to memory.reclaim
Message-ID: <ZdwQ0JXPG4aFHxeg@casper.infradead.org>
References: <20240225114204.50459-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225114204.50459-1-laoar.shao@gmail.com>

On Sun, Feb 25, 2024 at 07:42:04PM +0800, Yafang Shao wrote:
> In our container environment, we've observed that certain containers may
> accumulate more than 40GB of slabs, predominantly negative dentries. These
> negative dentries remain unreclaimed unless there is memory pressure. Even
> after the containers exit, these negative dentries persist. To manage disk
> storage efficiently, we employ an agent that identifies container images
> eligible for destruction once all instances of that image exit.

I understand why you've written this patch, but we really do need to fix
this for non-container workloads.  See also:

https://lore.kernel.org/all/20220402072103.5140-1-hdanton@sina.com/

https://lore.kernel.org/linux-fsdevel/1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com/

https://lore.kernel.org/all/YjDvRPuxPN0GsxLB@casper.infradead.org/

I'm sure theer have been many other threads on this over the years.

