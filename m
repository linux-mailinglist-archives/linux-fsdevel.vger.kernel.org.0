Return-Path: <linux-fsdevel+bounces-25256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CFF94A51E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08FC8B26274
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BDA1D4152;
	Wed,  7 Aug 2024 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enncBNMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C621C7B92;
	Wed,  7 Aug 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025365; cv=none; b=lpBySZtjMD/JM177/nRtP8w3vFcrb6UeCiGMNRJnzntknfsnuT6DtzYYHmyuukqIMW1mtBrj4L7zQrKWPOE6uWv6ZZNft4in2dfot/GOe26TMlWoGpu5NMWqrbNWo3YmVYc8jjkRSKFNizuSlOUUwTWhER6vMOO2yYpA2X8Payw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025365; c=relaxed/simple;
	bh=/DQMUfCgfYBrk3ZIK2aFdLPtLn0/Wud0X8OPVfWjH24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEdd3CdC3CmpA4PTph6lXoPLUns8IhDmhBAQTH+xqS9T6hlRsWHGRYIjljnLlk6KWJCrJE0NBPZbRu45udS0EPTgoL/8+fYgmxQqWY9H6kyea8AqUZX1m6AAUvAO6emX5CnoDwyZHsVvrjrO378bdu7Gcp9X5jm8DIlL45J/S9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enncBNMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F858C32782;
	Wed,  7 Aug 2024 10:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723025364;
	bh=/DQMUfCgfYBrk3ZIK2aFdLPtLn0/Wud0X8OPVfWjH24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enncBNMoWKqShv0uieGJMl+I8rMxRiKt4wKU5KdScwNQgJECCVUlwbIED6DwvLk1V
	 H+89e5K9CmsjNYI30RyD7S0naw1LAZltuwC+e2XxQvxr0wYHnp5QKn+1Zdl2pn1khq
	 Bhvl9a15dumvfLrMATIRVh9Y4haeCw4Ckb2f1S9nc0fpQ3VbOoO6XT2Ec+o4HJ95OH
	 wAv4vcIo9UhsnLtX5f/S2VKsZwRoGXo6A0mufHa9rKo8OE9Q3f2AQM5yMEZDl/q9XM
	 R1muGixUyooKZnG1ajPrbRuK7KqljCGzmeNDZA7YuaXKzevsWeGiUIcutLbjCb8fO7
	 pRHGSBDXW7FIA==
Date: Wed, 7 Aug 2024 12:09:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 04/39] add struct fd constructors, get rid of __to_fd()
Message-ID: <20240807-bewohnbar-kurzweilig-232c3b61711c@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-4-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-4-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:15:50AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> 	Make __fdget() et.al. return struct fd directly.
> New helpers: BORROWED_FD(file) and CLONED_FD(file), for
> borrowed and cloned file references resp.
> 
> 	NOTE: this might need tuning; in particular, inline on
> __fget_light() is there to keep the code generation same as
> before - we probably want to keep it inlined in fdget() et.al.
> (especially so in fdget_pos()), but that needs profiling.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

