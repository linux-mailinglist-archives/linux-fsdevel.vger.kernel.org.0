Return-Path: <linux-fsdevel+bounces-25515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A0994CFD4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014D31F2143C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 12:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F7A193099;
	Fri,  9 Aug 2024 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XA71Wsrk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3314D6EB;
	Fri,  9 Aug 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205463; cv=none; b=M/7OtM66cQesHM8QVpM1qQ+KdTTkBn0iG09zak93eMVeEYZSBwvorOSn9GZwy9EMz7U88/Ap+2yTbR1sdC0tdmEd5HKb0+1hWNqLa7p+JMZFMaPeki3QBql5F2gm8Xj6QBml177imVFsxq/MWxqEad4ZfhNjVhvIXEP5vBx8834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205463; c=relaxed/simple;
	bh=lhiYXA2wy51MqGeTfQuEG8S2GF5v8ocTucwFYb0tgOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns4sjZarCwyimhkK43O+CV/uDRfHeNflGjVmqC8okHyNM3nutq93i/M7aZ3wDbczV4BEiNsj6BqXXhH1zy20n//MWq9SjB9GIi/n8SVvKBwcWs426gifLXPCSBa/1bEfgEpDh7CqoOfTJiSc+rs49tXTuyY1YSZyStzl1rhYqH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XA71Wsrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9DAC32782;
	Fri,  9 Aug 2024 12:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723205462;
	bh=lhiYXA2wy51MqGeTfQuEG8S2GF5v8ocTucwFYb0tgOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XA71Wsrk2S52lHd+w4tBkwFGKzAp9da4T2wlzPTMGnnzsMsE9PNEtcqA5HJJ/xc9K
	 3JYthLwaxfhkFcnjlXcx7B5RzjCiMLjyLP3+/U+NgVaNA7e6pcKoKOzE19boKt0Yb7
	 YS+lYxp3Rmd6wnNU4uRaI40++Ly0Z7wVlBGgoXkxPD8fqdDPOC1kImu0U1OxpSoWjZ
	 DP9LpyjUZhbe2IQD3qkphC6m9NGJQJD6c5vCmNzW3dum40Sw09PjbB/gB8w92bNAwR
	 jfVUzG28tZusu6O5s5GWBY9mVHYnMWnROv2XXqFsla0QOqUg6Vl85Br1dz6ifCpJc3
	 4h9BgJqhiLYqA==
Date: Fri, 9 Aug 2024 14:10:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 10/16] fanotify: add a helper to check for pre content
 events
Message-ID: <20240809-trollen-postablage-b1417fe00eae@brauner>
References: <cover.1723144881.git.josef@toxicpanda.com>
 <531d057087b9430839ddd6082022e29a9066ef1f.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <531d057087b9430839ddd6082022e29a9066ef1f.1723144881.git.josef@toxicpanda.com>

On Thu, Aug 08, 2024 at 03:27:12PM GMT, Josef Bacik wrote:
> We want to emit events during page fault, and calling into fanotify
> could be expensive, so add a helper to allow us to skip calling into
> fanotify from page fault.  This will also be used to disable readahead
> for content watched files which will be handled in a subsequent patch.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

