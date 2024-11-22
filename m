Return-Path: <linux-fsdevel+bounces-35560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8A09D5DD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A086BB24E06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 11:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581951DE4C4;
	Fri, 22 Nov 2024 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjwnYW1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C352AE96;
	Fri, 22 Nov 2024 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273998; cv=none; b=HFnDaIHVa8MKEwN/M5s4e/+JCCQYznSDZ59pQJ/t0epNji6+lwK8lV4InjjyqpQ1G+yzIboJNuptUUFZ3/dexRyJA0iRVK6Vy8SYsU2r1dXT+AXaYbI0zhGjTXNxprb9Xb6qX0Qgam27okNI9KpMR0QaHb4k2/JRVO+brf9KxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273998; c=relaxed/simple;
	bh=mmW81WZyW41/yYnw1uQ9uMixjGsqJo2w9zVdsuUGqic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLBM1AdpSEQruFroNqJrA3FixjPFJu9ly71P4LOJpQldXS3lz9PPhRqFKNN+7+PV4zsyp2lXEb9yiTEiOnn64+K7EjKX77RvoftUz11aR54WlHoXjwc5P6rBpqfhytz/O0mvcmIY9l4f8byqEQxcPcvPYcWGboNanhf5wuKBUMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjwnYW1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58966C4CED1;
	Fri, 22 Nov 2024 11:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732273997;
	bh=mmW81WZyW41/yYnw1uQ9uMixjGsqJo2w9zVdsuUGqic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjwnYW1emYpWBFXpwydmFdw2cVBDFHp8qCXw+2Aj0mwbEHfDMTjoSFSQ8QDwIe1bB
	 2FZFmDo9ahx198bWcoHdit0alIz6S+96RyPtl9BnrAh9QKE1naHkiJwJEzLpPmNfta
	 Y/fN3TXGv6C2cnulOKEzFeB4qyjOjVWFTAmKZDNrKguXlsmH4xzlMS2tRHjBzMbV8v
	 dkwx50LZAjEID0vdNolnXX4c76bWxq/xwDpgosQjGKcwtiBlYlJGOvUVqPvAV13lhW
	 c0t6hJJ864NHPaEDb/ztsr0TsMoR9+i446Yr+ONW+vPxrxkq76KXkyZ0VTMnKOaixH
	 Xb3bLnSzfWwBA==
Date: Fri, 22 Nov 2024 12:13:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Subject: Re: [PATCH v2] fs: Fix data race in inode_set_ctime_to_ts
Message-ID: <20241122-streben-ansetzen-c4488f78ab3f@brauner>
References: <20241121113546.apvyb43pnuceae3g@quack3>
 <20241122035159.441944-1-zhenghaoran@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122035159.441944-1-zhenghaoran@buaa.edu.cn>

On Fri, Nov 22, 2024 at 11:51:59AM +0800, Hao-ran Zheng wrote:
> V2:

This doesn't apply because the functions you change have changed with
the vfs-6.14.mgtime merge. So please base your patch on current mainline
or vfs.fixes and resend. Thanks!

