Return-Path: <linux-fsdevel+bounces-19849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD4B8CA507
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 01:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77141F22190
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 23:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA8213A25E;
	Mon, 20 May 2024 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="C/YA9Sy0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881F1139D14;
	Mon, 20 May 2024 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716247665; cv=none; b=BSNX6wgThGjXEXUS4t6BOB2Vg6+aemg+cu+C8ZLI70RyMvo7yfaSo9DKCkvS8j6cD+21QJKuHejyMaD6Upn+Tp8Rd+p860yVhjtrv5JpLA6pA40qHdR4sfVva0PqKekwsCLcQ2JUEAn2bctefeT5U2N7FM3iBl87kb4GHkvxYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716247665; c=relaxed/simple;
	bh=Nzt9qDt5h+70hQ0fqdsDup9j6gDQZjBLsr7H3jI9z+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNrD2Lz1FXwIp8cmORyinPYWEzPNCta80MvEISchJsxKZaVf4sA2hkFSCdE4X7zvKzG0ctlFViiTmMTyQNtuK2lEbEVg4ZD5PkYkxz1YV5gr1aaCj7qMjwoCFMbdyfkHcsAGO6aAw760GpGYjDftJ2XGhrzvM2Rh6zg86pvl//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=C/YA9Sy0; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vjtyl5Q4VzlgT1M;
	Mon, 20 May 2024 23:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716247657; x=1718839658; bh=Nzt9qDt5h+70hQ0fqdsDup9j
	6gDQZjBLsr7H3jI9z+E=; b=C/YA9Sy07IEM+qqgYqVbUuTT2eae7FaZjY67RglY
	xs8JIZ5fIEJmIi/4yguN7lWemkIY0lF1uW4HaGT1T7awti5GTnTBmHKQ04JxrUUa
	LSDC3OeoJbL4RngdRtaktFL03Ec7biVRlKEwJ2GVnG9wWiYUekcgidKdm8eayTXE
	glYavP90/fn4z+2DgVWcbXE9mLkd5i6gxajbPM/JL0vPaqHYUmeFuEWk2YtQcdn7
	oR8/laYOwODyy/CdsxFI5H8VGrTkV1ppmN28+l4eH5dYRW+sAmPhzOgwoDOKEyq/
	IlC4XiLikdRNeujS2eAqTmGSSddZuhR3GALg8lwyKmz5eg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ozaYIhn_TTJn; Mon, 20 May 2024 23:27:37 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VjtyW3wcTzlgT1K;
	Mon, 20 May 2024 23:27:31 +0000 (UTC)
Message-ID: <de16a905-3cc1-46e3-b9b4-494ad73cac07@acm.org>
Date: Mon, 20 May 2024 16:27:29 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 11/12] null: Enable trace capability for null block
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520103027epcas5p4789defe8ab3bff23bd2abcf019689fa2@epcas5p4.samsung.com>
 <20240520102033.9361-12-nj.shetty@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520102033.9361-12-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 03:20, Nitesh Shetty wrote:
> This is a prep patch to enable copy trace capability.
> At present only zoned null_block is using trace, so we decoupled trace
> and zoned dependency to make it usable in null_blk driver also.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

