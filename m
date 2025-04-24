Return-Path: <linux-fsdevel+bounces-47159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54673A9A122
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76F2194656C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10F81DE8AE;
	Thu, 24 Apr 2025 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg/z+rJQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877D199948;
	Thu, 24 Apr 2025 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475274; cv=none; b=K39c8mskDSrsODITqrQ3p9V7LQmyLy0nhvJ6rKjEietCTg5BeWkBy2q80i4fjLvtcN2JQAWFyxEL8lfz9ygq6ohsfmrjrOwawiwxSNIyIMzR6Krep1tAx3WrMf9F9heHJu+T80qBxbBWIVl0o3FVXakIAWWpEi1vtsREbeFkeRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475274; c=relaxed/simple;
	bh=8RoLzbdmrPHybDtten93nhXbJHJr4s/PjDxGqiEiSQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHEDaNEHdrzEYwBik0nT1VhWOppbFsz64Me03pHbjzrEDe6+tTSS1H4j49hORhma5Eh5uLdZ73MC/zedEDpiD69bpdUg8/qt0evWJmKqLsPOj87Zx3UKrDOLMBM3g6dBGyPi8zuJe2BVemxAVEYiMz0upz70IjbPH5FaCW1IgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg/z+rJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605A9C4CEE3;
	Thu, 24 Apr 2025 06:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745475273;
	bh=8RoLzbdmrPHybDtten93nhXbJHJr4s/PjDxGqiEiSQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lg/z+rJQJ7yR54v40pakV/DEi5YTqAMNqnNflCVe5MqdrqJ58KB7/tVzY7nrHBXc+
	 PUvqGMoj6/t0c/5Yxu6Ik7FCc74BjML++PFMI97ippebx9mijEAEUFCftrMqpZI/pt
	 v/bZbL290ve7RqH/Ro6izN/0k19wm0XhnRl569tGEsdME2JVyPDXnxB9IrLCF7m7YJ
	 gLwaoO9VCcgZvPffta8DYYogNCCQckoZB2Az+moR5KVH5OLlWgzqi4PmagWlmQG9Su
	 JCEm/SMS11bF9lq1UQ2EnBhgK1FnOUyJACUTJHtBIhyFNxvXeKiir9xWopi/BRMVfN
	 nqtADdniE1svQ==
Message-ID: <227da5a0-c5fd-432a-8227-7a5d8883ca0d@kernel.org>
Date: Thu, 24 Apr 2025 15:14:29 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] bcache: use bio_add_virt_nofail
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-8-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
> bio_add_virt_nofail helper implementing it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

