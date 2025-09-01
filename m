Return-Path: <linux-fsdevel+bounces-59807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5EBB3E18D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D47616C5F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13FB31A56D;
	Mon,  1 Sep 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyeNIdxo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E61931A569
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726189; cv=none; b=qFXKHGWp2BwtGe6ejdjZtaRWWKTCNjFYRgiMMuqexVVk3XbHnxdU1YFwTQK7n/VYz80uU2DksJjrMKUCFvg65z+5rHyECPrSwREBWwSO8GgYLQoVEp1uf6O4v9J/ju4i1XjUc10mVDVzbt9XXKZFy6ZjCPN5zkL1gU6ZC6Kr9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726189; c=relaxed/simple;
	bh=2e5m9mB3RKoHm8U7zhV6OHGopDBNa+8D4G1GHcI9Xo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiMlPa8zqMGz/h/yT6dpNOxKYNCSLEz4FwoMXmoJtmkjzPAdifdkvNUZE6exeJ3bQaR46uAtmtR3edmSOThnITxQ12Z/qFU+f0O/ZOK0EA3nj0Z0FilcVByAwx95p6lP64l6crBJwYFNckJgGRTv7c0rB3IH2jdZX5l8KxDcOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyeNIdxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD8DC4CEF0;
	Mon,  1 Sep 2025 11:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756726188;
	bh=2e5m9mB3RKoHm8U7zhV6OHGopDBNa+8D4G1GHcI9Xo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyeNIdxohasY5xjks05yeXD7lh2xccYSnyzVx2h/Wf5pLLLLuFvICNVI2MppqP9mD
	 vCMWR4Hg9Xuqb2LtmaDk9Dt8/22zuJHtLs7Qeku40feaFkZX6ZkL841XYWc6z4wdZq
	 8nGFRMug3fHIzSV4CZyG0hXM74dWFAy2rR7FSRBlgwNyevbaN67/gJ+ce026E6owWv
	 Unv3dKn3NruAWFijH2MQTqVdRm6S8i/YzcDh5QFWTeT4DBXyTt/9/OF0kbN8Jd1ZJr
	 7ajBJBNhZg4Tk/JM+eyEqTok8yVFhyczMflD1+I3+BmFTw56P4Oo3jlmkb1jPUBgj+
	 XqWDIlXCY5m2w==
Date: Mon, 1 Sep 2025 13:29:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 54/63] open_detached_copy(): don't bother with
 mount_lock_hash()
Message-ID: <20250901-firma-zurief-aa892083d30d@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-54-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-54-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:57AM +0100, Al Viro wrote:
> we are holding namespace_sem and a reference to root of tree;
> iterating through that tree does not need mount_lock.  Neither
> does the insertion into the rbtree of new namespace or incrementing
> the mount count of that namespace.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

