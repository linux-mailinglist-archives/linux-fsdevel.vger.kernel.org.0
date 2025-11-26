Return-Path: <linux-fsdevel+bounces-69908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883B6C8B7DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 19:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492353B8575
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996B33DECA;
	Wed, 26 Nov 2025 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="g3nS6R4b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEFC33D6C3;
	Wed, 26 Nov 2025 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183346; cv=none; b=KJihBXneVlW6aCjX2aa1OZTjHv7D2DLU2N5pYeGaOVIWPP2z6yk/f04aNfv69i3Ca7H95R3BAoTUMDtwWq5dSDgxiocru0l4VYM++2yGuRvlnH2h6OGyDL+qgYlPwRgPilbk1qNXW38189iWgCGc4ONVekvSJ7N5Fo9enbtQ7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183346; c=relaxed/simple;
	bh=uY7HaMSJsv6SKAaOVRzKVfCOgnFK8BFUcRzVE+a+wVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd2mwDjngZbJsTmHfeCduAiLlJmFiF1+91buHARo+Ws5/z7sllWuXdbQAxzMBW5hg0xB7zpdkWQc6XH34i07nB6yw/U69cnDeTVZdCW+XmXkBSU7qf4gijzss1tUsbjldtoqAn+CmpZLYZo5qHwKgm4FwwlBAsJ+it7wegb1fr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=g3nS6R4b; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MLgia25EvIAIBo0VY2I6S9Dk4/MSQiPdMJldJvpcdsU=; b=g3nS6R4bW6uQlx6Je24W9afEMH
	Em5LKt9oz497k9Gfvq/XJ6/fvEKedQW3YCWBUH4PKFDdicr4JXoufcWgeWK7ZSKU746ud4sumvmfV
	YFNnq6xLzJPiACvsBcuyfVcSUnV3OpxMuva5TL3RuNuU+TffZJW9CUynU/dVu/G8lWvJ3b7YIKkhz
	9yZ6mCKUXqeuIpWgtJErxKkaN0GEn3IPqwa/y96rIxsDaXZooIrwB2XiggY7muOwYj/KzbZGUgbxZ
	SF/CXLaEIOq6KfcuVZfyq7VCgkA0OMCSds/ICAlTsKJdpjSM1Wvsnw4PrjBCCA8I8x400e1Wrl1WS
	zsOaQ43Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vOKg5-000000007j8-2ErT;
	Wed, 26 Nov 2025 18:55:45 +0000
Date: Wed, 26 Nov 2025 18:55:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: jack@suse.com, brauner@kernel.org, hch@lst.de,
	akpm@linux-foundation.org, linux@armlinux.org.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	wozizhi@huawei.com, yangerkun@huawei.com,
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com,
	xieyuanbin1@huawei.com
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
Message-ID: <20251126185545.GC3538@ZenIV>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 26, 2025 at 05:05:05PM +0800, Zizhi Wo wrote:

> under an RCU read-side critical section. In linux-mainline, arm/arm64
> do_page_fault() still has this problem:
> 
> lock_mm_and_find_vma->get_mmap_lock_carefully->mmap_read_lock_killable.

	arm64 shouldn't hit do_page_fault() in the first place, and
do_translation_fault() there will see that address is beyond TASK_SIZE
and go straight to do_bad_area() -> __do_kernel_fault() -> fixup_exception(),
with no messing with mmap_lock.

	Can anybody confirm that problem exists on arm64 (ideally - with
reproducer)?

