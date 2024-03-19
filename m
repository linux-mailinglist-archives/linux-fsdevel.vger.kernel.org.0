Return-Path: <linux-fsdevel+bounces-14816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8362288006D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 16:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388F01F23373
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 15:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E289657B2;
	Tue, 19 Mar 2024 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpZwVU2z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D262818;
	Tue, 19 Mar 2024 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710861585; cv=none; b=PlTUSBg0yDuDHjOyDKa5Zq1/KhpH54bNIW8L3lmLEf88VEbW93Gc1TTXqilY6c8ZutWPUJ1g3eOPrpzdbhnwrhFRsKcVVEWzM2HQyWEpBF82P/qK8B5aRbFZSwDMPYyjS6yFLm9vIFmA254/l5FvwCCnN4FiooTE6cJFEGekWgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710861585; c=relaxed/simple;
	bh=leEFZf49UqdW+c1gftsoWdS8fuY0dAZnqC7DrI2xoqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBnWjm1VoDOntin7+Nd4h+tIqrUBff6u0tFXVE2YD4GcIsW91K2Z7NFdCDhQkrVvZUndchJNP92sMB61aJ576dg3l8L70YKoFZLnn3RA1YXZR69ag1KGjIuJgPRl8xPc0FY3JDhinWw/vbf2mhGhsAxLQva0Cu7mNG/RFJI2CwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpZwVU2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4CFC433F1;
	Tue, 19 Mar 2024 15:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710861585;
	bh=leEFZf49UqdW+c1gftsoWdS8fuY0dAZnqC7DrI2xoqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpZwVU2zEctGKMyYbft7qQiCpSusqsPO/LfNUFWxNDInl1uTkJaOqp5niO6GSPL8k
	 f5CnJnbI+octlZom1TBCXKZhG0aZdrNhBv5u3lhpG3xamJoMfY3jBnKrwiTpVWVIqm
	 fcQLkHj2CQc7qR7kZiUi8Etb2UHQjx7z4cjqWDQHGIosmho8G8yuRSRMCsD7iMRfnA
	 JXYTFSwA9/WSDSlLivDkxMolUg8kd/EPXF2ExLqeNQeXzLX/pfbp/mG6WKDf1cXmBc
	 WzvFAAG9wWJjodkmqXKsX6qURNO6dTqsDJgrMr0fnUszgZ6NGlq7tAM6XshH//CSVq
	 xF9JsSsH0VKBg==
Date: Tue, 19 Mar 2024 16:19:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, Kemeng Shi <shikemeng@huaweicloud.com>, 
	tim.c.chen@linux.intel.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Fixes and cleanups to fs-writeback
Message-ID: <20240319-befugnis-zufahrt-b67936927466@brauner>
References: <20240228091958.288260-1-shikemeng@huaweicloud.com>
 <20240318171229.ftdwkh3a45r4y6j7@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240318171229.ftdwkh3a45r4y6j7@quack3>

> Christian, the series looks good to me. Please pick it up once your tree
> settles after the merge window. Thanks!

Thanks for the heads-up, Jan! I've picked it now so it isn't forgotten
and will rebase once -rc1 is out.

