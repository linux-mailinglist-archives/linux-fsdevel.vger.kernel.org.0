Return-Path: <linux-fsdevel+bounces-37048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA65E9ECA6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 11:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F57188D0BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 10:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1486D1FDE00;
	Wed, 11 Dec 2024 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9EYKx0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709ED187872;
	Wed, 11 Dec 2024 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913294; cv=none; b=pWMKLiBK1wP2eKStUswOrfZHvV3JCg6qafKF0YgNwc78ieLxcr4P2QaH22m9kzOMQPpTjEmNLbiv8dY8tQQAsIS1WnQF6QtHZ+0Vplv7qufi+NrACb/0Z5uV+Z+RrEZWwFh5FQPtrC8yfKDChDtTcviYu/06fSP2AMbtUUYebGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913294; c=relaxed/simple;
	bh=jtPwb2c1cCqDJNNylVo+MQn9XrjgS45rZhHLPgSYvvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjWzhjrN4mPtP56+l0fEPrg2lvFBevDZpcESbAIGeFc8mJLcCVXfSHP9iEnyVbclQIlfiBTtFRLjMnIl3xZWLTcwZ/DCkONYTwkroWo67D9rqZg0tg4ZkvC+Fs6EFWN0DcI7LFuBuPz8VEPkJGhRb3fMnW4vl9kFF8JYGXAnx+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9EYKx0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F6AC4CED2;
	Wed, 11 Dec 2024 10:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733913294;
	bh=jtPwb2c1cCqDJNNylVo+MQn9XrjgS45rZhHLPgSYvvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9EYKx0DuzD3J99riCxhpfUzwu1tbNlA/DiTVKhufi5bKsm7cWB2WOQYjG7d+vnFV
	 isSsm4XtJU5EDcDsDfOehJ/fKQbMG9XASEO/jXDOUNPYDBnbJwh4sL+LQrgvN8bgGi
	 cbuyAyKhGverm5t92fcl2Z0oxSHGW2/IwHffgaJQzDE68MIGEPeM6TzZhLldjjW/Io
	 AE6hsAg6AdtnTJZbUI2N0E0Q9bL3JLMibOfejELBINPfSXWzPqaEtpAxvAQUiwR7jl
	 zvbDi51MhxoZnqzWDJjBrs8PXyA+5Y4Yc2IfyHnmueDvcW8J2Oj5M3eG74rXpyvZ0k
	 LFkcAnwdpsR2Q==
Date: Wed, 11 Dec 2024 11:34:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: djwong@kernel.org, cem@kernel.org, Long Li <leo.lilong@huawei.com>, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, yi.zhang@huawei.com, 
	houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v6 0/3] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <20241211-zugluft-andeuten-ae01e546ff6d@brauner>
References: <20241209114241.3725722-1-leo.lilong@huawei.com>
 <20241210-strecken-anbeginn-4c3af8c6abe8@brauner>
 <Z1goSBpgKTydaQAV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1goSBpgKTydaQAV@infradead.org>

On Tue, Dec 10, 2024 at 03:38:48AM -0800, Christoph Hellwig wrote:
> Can you please drop the third patch?  We'll probably have something in
> XFS that will conflict with it if not reabsed, so it's probably better
> to merge it through the xfs tree so that everything can be properly
> merged.

Done.

