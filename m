Return-Path: <linux-fsdevel+bounces-20772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A70A8D7A7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 05:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441631C20E3B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 03:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24BA101E4;
	Mon,  3 Jun 2024 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bNIFtfnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E897D271;
	Mon,  3 Jun 2024 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717386069; cv=none; b=L778CkyIxZ0x9WNmpVjEab/m7GAhNs9Movoy0GlRbxxayCBrosBfJTiEdmwagUaq4vIUXsSa6mbvB8CNZIZe5fULW0yADRD2Csd7fTBvyn36y+yDAVCSerY05xY6+cVKqkIWV5V9TMmgB3nuDYLEpZtyLPPSADG+3tBc0Y1HAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717386069; c=relaxed/simple;
	bh=qhOdS37CSAz5kEDZhCfPQ3VlbrqMMSx7enccrII8eBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdaNHhV4Aorb8Fb6Goz510vHNgCm6u4DqJPKTOhar79tEcRxKPw3NAd3nq8Gduuzoy4JUzqYUKHgbuhlDLiKEgIGy+Xx4CmSAG8JsFMI8LKAYFeEgquUPFli53DIUu/gcwg4wR8uzs4y8RWg3E70GRM3OE2R5DngH8US0WYVdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bNIFtfnC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JBJPVZtxP6EfzexbhZIaZFG/RSUHAxjmZiqygSOGvlw=; b=bNIFtfnCKa7dPGCg1I/Kru1k9D
	1myZ0/JgSGamDZc+LcBdKaXJnV7mIgmGS47vulUr0eZe8zRT87kSg7g/kJZhwdnuHVrZ4daPwB0hR
	D8zyiO7jxxCaekRKBG75fxexEbovhkEkgYL/qZUusiK/Y2YjRyIHEVayVjGL2W6CMTgyPaZtPUXdv
	1u/IpH55NU/LhYGuV34oHYfe4uWB5g+6UK4m02HebZLbLsVvYz2LafLei9y6yZfsDdnsVT7s1vQao
	aMUjiV5eYwOIUtKSyGAVuqrbbPes8QMknDn598YZVIjXFcjih0YFfKXsjUSew41vCRnqvnz8CmGjh
	YDLXL/Aw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sDyZ5-00BLOK-2I;
	Mon, 03 Jun 2024 03:40:55 +0000
Date: Mon, 3 Jun 2024 04:40:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Baokun Li <libaokun1@huawei.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] get rid of close_fd() misuse in cachefiles
Message-ID: <20240603034055.GI1629371@ZenIV>
References: <20240603001128.GG1629371@ZenIV>
 <80e3f7fd-6a1c-4d88-84de-7c34984a5836@linux.alibaba.com>
 <20240603022129.GH1629371@ZenIV>
 <49210e35-1cca-4d5a-a099-5a2d7b0390d0@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49210e35-1cca-4d5a-a099-5a2d7b0390d0@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 03, 2024 at 10:33:38AM +0800, Gao Xiang wrote:

> > Anyway, your variant seems to be correct; feel free to slap my
> > ACKed-by on it.
> 
> Hi Christian, would you mind take Al's ack for this, and
> hopefully upstream these patches? Many thanks!

FWIW, another thing that would be nice to have there is
removal of now-pointless include on linux/fdtable.h

