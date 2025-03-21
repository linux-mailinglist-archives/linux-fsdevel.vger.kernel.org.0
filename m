Return-Path: <linux-fsdevel+bounces-44727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0628A6C029
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 17:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213767AA37B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD8022CBC8;
	Fri, 21 Mar 2025 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tP54emZE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A924E22B8D2;
	Fri, 21 Mar 2025 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575113; cv=none; b=gfzlvynwYUOEZuhtWCi83N3K0QiDnwM5liOYmjLLldUFRBSVS+joP/FBkgie4bQkmKNiEZ8sU3B252+Nw7ES1D7AgarZ2MYwRDs0dwaCjZ/GgxnLb+u/9cbQFd9O64vUXxakl1wAa3Ugpt9SJ9w03p8MA5DfT3LejQy0QSkKE+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575113; c=relaxed/simple;
	bh=Bwj3Dd///MDVuZOMw5IYTxU24l2EtuF3vsGvy3H4+hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dctSudpyLpjXhlL6fca/AjsYSnQiBXt0vU0dLi7vQalNyRX93h2k+jYBAG3EMVYJ8gYUoVCAXzDuclDSSDu+DR5HpaL60iALqtAqQVs4qoPIhXpGqtNuz+S5PqwaftJScxevP3kOeWcfHr7lMMDTY3eJqUPr7zk6ogj7yii5MG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tP54emZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AD2C4CEE3;
	Fri, 21 Mar 2025 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742575113;
	bh=Bwj3Dd///MDVuZOMw5IYTxU24l2EtuF3vsGvy3H4+hI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tP54emZE1wWBK22hIUoOLPRX2o6qAgnuHZxrYyG+LEwZtFAexsRSP4q6SZ90qvUNo
	 DRPl3/33re+7pd/TfcLCcEP9i04g8elL2bl4oZvtiVKAGR8EHCzAtvfJ8ZEtNeoGwN
	 xTj2BcA3q72Livr24KKPiT+cHp7nLMHcutoYipGwb0lt1AGEIqxIaGtHpdXKtBJt0o
	 2t2Gw+7kemQ5aVh9kGF24Gqgq6YGZ2GisPTBi417lITsF9R3sXZhvuifKWeMi5khu3
	 nKrjfjkXToHvBsBuuI3EChpSjL22UsDi7MFS9qTysVuE2GrnvLoLeSk7g3vwz6c/bB
	 9F3BtIBVdmqiw==
Date: Fri, 21 Mar 2025 10:38:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org, david@fromorbit.com,
	leon@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	joro@8bytes.org, brauner@kernel.org, hare@suse.de,
	willy@infradead.org, john.g.garry@oracle.com, p.raghav@samsung.com,
	gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <Z92WBePJ620r5-13@kbusch-mbp>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
 <87o6xvsfp7.fsf@gmail.com>
 <20250320213034.GG2803730@frogsfrogsfrogs>
 <87jz8jrv0q.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz8jrv0q.fsf@gmail.com>

On Fri, Mar 21, 2025 at 07:43:09AM +0530, Ritesh Harjani wrote:
> i.e. w/o large folios in block devices one could do direct-io &
> buffered-io in parallel even just next to each other (assuming 4k pagesize). 
> 
>            |4k-direct-io | 4k-buffered-io | 
> 
> 
> However with large folios now supported in buffered-io path for block
> devices, the application cannot submit such direct-io + buffered-io
> pattern in parallel. Since direct-io can end up invalidating the folio
> spanning over it's 4k range, on which buffered-io is in progress.

Why would buffered io span more than the 4k range here? You're talking
to the raw block device in both cases, so they have the exact same
logical block size alignment. Why is buffered io allocating beyond
the logical size granularity?

