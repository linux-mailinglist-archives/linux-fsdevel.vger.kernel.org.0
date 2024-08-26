Return-Path: <linux-fsdevel+bounces-27086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D9A95E756
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 05:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32F5B20DE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 03:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B320C4AEEA;
	Mon, 26 Aug 2024 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mqDuUSd6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE26C41C6D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 03:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724643147; cv=none; b=unZFpwNtKDlBQgqWR75sYJCvqeeUMLsM78OyinWhBSFWmFj1dhT59zzzoa+FV/BbHtD+UhQkixsqcFtrxFJ7ex8QrkbN9G5tMTcOskTS8moiMgSSTbSvH3Xoqvub+einPziRkHp0Zvlnp60Nq0unFGHLsUJDFOuNDFqBAQI7YcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724643147; c=relaxed/simple;
	bh=UvfgadhcslqGk6VVX3LUkkJ/RvCws9F2sKx+6ZBX/ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtkhJJSvvELMTBj9BRFx7OwV1KpTzf6qWs48b0MvbEdJszP8lS7kjxTxMiuEuMaE1HTEzOVDSuoDVtpCQQvVPXRRpvLCGP9eYv+tjATb+W6Eo5wdYb9A5Db7p7ofb4HcRfL3MykybLKJBt4u93nZ0U8sxQDlpJ1Sz0CcGzPOd1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mqDuUSd6; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 25 Aug 2024 23:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724643143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UvfgadhcslqGk6VVX3LUkkJ/RvCws9F2sKx+6ZBX/ZE=;
	b=mqDuUSd6QjANLuKeawxXs5IynoQvSMMa3kCl24fEaaS9Ldl970LDWO52bCd2Ys3OUYuMaq
	gHlcgq3i1TkMmqwTOV2mrB/qGbbsaXVb4XUDj48XE5nOmsg9AYeaecqJIPiR8/ICoFYCKg
	/GNIhI57pfBCT3nQ2REhGVTcbRoIAZQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: david@fromorbit.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 02/10] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <ivjo62ghagmcoacjdtoute7mzwkcj3gu6hgdygjry5x7uiqgid@6axrxbn5auvy>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
 <20240824191020.3170516-3-kent.overstreet@linux.dev>
 <122be87e-132f-4944-88d9-3d13fd1050ad@bytedance.com>
 <h4i4wn5xnics2wjuwzjmx6pscfuajhrkwbz2sceiihktgzuefr@llohtbim43jg>
 <4733d230-0935-4bff-a17e-8c6735ad16b4@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4733d230-0935-4bff-a17e-8c6735ad16b4@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 26, 2024 at 11:10:08AM GMT, Qi Zheng wrote:
> The shrinker list may be very long, and can you guarantee that shrinkers
> other than bcachefs won't do anything blocking? ;)

It's not worth making this code more complicated.

If you'd written a clean simple iterator for RCU iteration it might have
been different.

