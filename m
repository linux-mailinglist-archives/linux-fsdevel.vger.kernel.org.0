Return-Path: <linux-fsdevel+bounces-7955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2679782DE84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A40E28201A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 17:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9420718041;
	Mon, 15 Jan 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g5zqmh8G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F918037
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Jan 2024 12:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705340142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dNtAUlRkyYLVTQPznCRONGm5Jz38xQOpixSg89srLA=;
	b=g5zqmh8G7dC9A/somfqTsYYNso1efXb5++gc/TQUzYXjWbw3BQudep+n/HKJxBEEYjQYUW
	TWn/sp2UnS0u4yf5dA9nnNHmxrHn1ZqHLhjt6q4kGfp5YJiAUiKXF6X17mLpnq4uLQF+7X
	NwCHlaH4hGGspf6n7wx+e2sGXbTDcY8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	naohiro.aota@wdc.com, Matias.Bjorling@wdc.com, javier.gonz@samsung.com, 
	bvanassche@acm.org, dlemoal@kernel.org, slava@dubeiko.com
Subject: Re: [LSF/MM/BPF TOPIC] : Current status of ZNS SSD support in file
 systems
Message-ID: <hqjm3bftitx2wpu74za4oq3sqifonpf7fc7mrwb4a7dbxzkm7h@stpm4dpahofc>
References: <20240115082236.151315-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115082236.151315-1-slava@dubeyko.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 15, 2024 at 11:22:36AM +0300, Viacheslav Dubeyko wrote:
> Hello,
> 
> I would like to suggest the discussion related to current
> status of ZNS SSD support in file systems. There is ongoing
> process of ZNS SSD support in bcachefs, btrfs, ssdfs.
> The primary intention is to have a meeting place among
> file system developers and ZNS SSD manufactures for sharing
> and discussing the status of ZNS SSD support, existing issues,
> and potential new features.
> 
> The goals of the discussion are:
> (1) share the current status of ZNS SSD support,
> (2) discuss any potential issues of ZNS SSD support in file systems,
> (3) discuss file system's techniques required for ZNS SSD support,
> (4) discuss potential re-using/sharing of implemented logic/primitives,
> (5) share the priliminary estimation of having stable ZNS SSD support,
> (6) performance, reliability estimation comparing ZNS and conventional SSDs.
> 
> Also, it will be great to hear any news from ZNS SSD vendors
> related to new features of ZNS SSDs (zone size, open/active zone
> limitation, and so on). Do we have any progress with increasing
> number of open/active zones? Any hope to have various zone sizes, etc?
> 
> POTENTIAL ATTENDEES:
> bcachefs - Kent Overstreet
> btrfs - Naohiro Aota
> ssdfs - Viacheslav Dubeyko
> WDC - Matias Bjørling
> Samsung - Javier González
> 
> Anybody else would like to join the discussion?
> 
> Thanks,
> Slava

There's also SMR hard drives to consider. For SMR, the much bigger zones
means that we don't want to burn entire zones on the superblock (plural;
we need two so that one will be alive while the other is being erased).

We've got provisions for variable sized zones, are SMR hard drives doing
anything with this? Or perhaps for a normal, random-overwritable zone at
the start?

