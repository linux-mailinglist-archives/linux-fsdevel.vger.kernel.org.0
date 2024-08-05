Return-Path: <linux-fsdevel+bounces-25020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ACD947C7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 16:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E221C2143D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEB980BFF;
	Mon,  5 Aug 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo6UiL95"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9087278685
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866867; cv=none; b=SCRZgMKg/znW48jMzYslIpdyMgzbdGHA2f5Vonw+kjaMa7gb64Tu8ZmPzFoDBmkiDFawzWmnLOb+3cHdcYj1j13kUCLtCTPG4ReGJm2mj6TlqCexKjmVN3gxrx7UULsVKJ9xXkXdlGJ1MJLiFL3at0D2IUVrvQwOYz0YHcdmYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866867; c=relaxed/simple;
	bh=An3Mhx2Us4ODfTBKPOHv0FM2sqzKuPXsMd6KpbYll0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oA6QYZfr5UUuLdwNurQW7GfAku0LRFgzolCXIp7idhoFaypj1q79kaBUuXEYXiN+PpXh7gVdYRaP3k8buL9ui4/PkD3R/tfEKyY6ElLGty+TdjW/kwPr5CRERIzCsxL6mgJZKWntOkME803F0QwY1iSyqVz1BxWtfdix7DMRReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo6UiL95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692CAC32782;
	Mon,  5 Aug 2024 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722866866;
	bh=An3Mhx2Us4ODfTBKPOHv0FM2sqzKuPXsMd6KpbYll0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jo6UiL95rNcnoTxdpnZbvlgDr2V8jG3YF5W/HrThMgyJzq2QIDNQLJ5ZsfD7nJ3y9
	 ckATzMK7pnFu/vo8G1IH/ykkz+sV6XVspyLMx0XBWw7CPaqpb/JRzVoIpBJFzY8IQf
	 X4jWOAiWkjD78dD5kCbMUCx6q9j9tbXWCjhHVuOrOBy+1LfICN/G1o8mThlgMKiOOM
	 QQQfIfB3Gge+NvC3Ny5HZoY9GNG3DjILlU7JHVhzyQealTjUxnITHK3qNKrbUqzwt7
	 gVHzaOGCgm+qGAuFhZZZi41KrEE899J45MRtBVZe/BMDUBJAa44TgXEkn3On0BVEII
	 7PFcH/fpSu16g==
Date: Mon, 5 Aug 2024 16:07:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Yafang Shao <laoar.shao@gmail.com>, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
Message-ID: <20240805-murren-privat-e858d5799052@brauner>
References: <20240804080251.21239-1-laoar.shao@gmail.com>
 <20240805134034.mf3ljesorgupe6e7@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240805134034.mf3ljesorgupe6e7@quack3>

> Thanks for the detailed explanation! I understand your problem but I have to
> say I find this flag like a hack to workaround particular XFS behavior and
> the guarantees the new RWF_IOWAIT flag should provide are not very clear to
> me. I've CCed Amir who's been dealing with similar issues with XFS at his

I agree. I tried to make sense of what exactly this flags was supposed
to guarantee and it's not really clear.

