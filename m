Return-Path: <linux-fsdevel+bounces-20550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BBA8D5104
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 19:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 252E5B23A9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 17:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD30846556;
	Thu, 30 May 2024 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="TdOth+r9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDFF481B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090088; cv=none; b=MIK7vAW5qlficCyecDaNY0SPCFyqsjSC9416CO0XsxCrAFHvzlQEMOW7pPmkRWrLZ4h4Y9yLRiy+E4z9C7Zz/AuMLEwixLlQZN9ivTaWtWGa6chXfmH6NstGFyCQoCfQM/R1sAv205M9yS4ea66BuEt5U3DgKuXPyh+AiJP3DFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090088; c=relaxed/simple;
	bh=PI46eCB4yZKtLa8v3+mNZJr2ivbez7uXjw8+2tdM4wQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Is/wSZHcuefq1C35X2+BsVmuhC+J+zcGKiGis7E2GpmjdpDYSwnfGYY7irc9XiOcJVBFoih/3oQQ7DtzU3FofIVmBNTkMiRo3TayTlh8XvU0ygCmk/wVbIerxSPrEKrdAoiCPeLUN6xH+inEJREqz9/xtPWKxVJ3mcpja5Yj8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=TdOth+r9; arc=none smtp.client-ip=208.125.0.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1717090084; x=1717694884;
	i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
	MIME-Version:User-Agent:From:Subject:To:Cc:References:
	Content-Language:Organization:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; bh=4dDEKgqaFMRPywzm35viCF7BQid0GTM7Vc
	2BfcyQt3U=; b=TdOth+r9pnnrgT689WLDeVGlenC6hSyknYw26sLo/BARRrYu/U
	t0iICoBHuR9g4Ppmvwo3lqhM3o10zDn4RAzYEBFJt7yvXDWRw4gY2E4YHMH6NMAz
	zyJnSQRxvtRoOkvIa6Hd204Kdadsnw5FxDnXwkpFfBbO+MLubCJcLT+F0=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 30 May 2024 13:28:04 -0400
Received: from [IPV6:2603:7000:73c:bb00:15fd:52c:fc39:4205] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v24.0.0) 
	with ESMTPSA id md5001003957181.msg; Thu, 30 May 2024 13:28:03 -0400
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 30 May 2024 13:28:03 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:bb00:15fd:52c:fc39:4205
X-MDHelo: [IPV6:2603:7000:73c:bb00:15fd:52c:fc39:4205]
X-MDArrival-Date: Thu, 30 May 2024 13:28:03 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=18808d123f=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Message-ID: <4afd6e76-6542-4452-bc92-7798f64c986d@auristor.com>
Date: Thu, 30 May 2024 13:28:02 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jeffrey E Altman <jaltman@auristor.com>
Subject: Re: [PATCH] afs: Don't cross .backup mountpoint from backup volume
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Henrik Sylvester <jan.henrik.sylvester@uni-hamburg.de>,
 Markus Suvanto <markus.suvanto@gmail.com>,
 Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stable <stable@vger.kernel.org>, David Howells <dhowells@redhat.com>
References: <768760.1716567475@warthog.procyon.org.uk>
Content-Language: en-US
Organization: AuriStor, Inc.
In-Reply-To: <768760.1716567475@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDCFSigsAdded: auristor.com

On 5/24/2024 12:17 PM, David Howells wrote:
> Hi Christian,
>
> Can you pick this up, please?
>
> Thanks,
> David
> ---
> From: Marc Dionne<marc.dionne@auristor.com>
>
> afs: Don't cross .backup mountpoint from backup volume
>
> Don't cross a mountpoint that explicitly specifies a backup volume
> (target is <vol>.backup) when starting from a backup volume.
>
> It it not uncommon to mount a volume's backup directly in the volume
> itself.  This can cause tools that are not paying attention to get
> into a loop mounting the volume onto itself as they attempt to
> traverse the tree, leading to a variety of problems.
>
> This doesn't prevent the general case of loops in a sequence of
> mountpoints, but addresses a common special case in the same way
> as other afs clients.
>
> Reported-by: Jan Henrik Sylvester<jan.henrik.sylvester@uni-hamburg.de>
> Link:http://lists.infradead.org/pipermail/linux-afs/2024-May/008454.html
> Reported-by: Markus Suvanto<markus.suvanto@gmail.com>
> Link:http://lists.infradead.org/pipermail/linux-afs/2024-February/008074.html
> Signed-off-by: Marc Dionne<marc.dionne@auristor.com>
> Signed-off-by: David Howells<dhowells@redhat.com>
> Reviewed-by: Jeffrey Altman<jaltman@auristor.com>
> cc:linux-afs@lists.infradead.org
> ---
>   fs/afs/mntpt.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
> index 97f50e9fd9eb..297487ee8323 100644
> --- a/fs/afs/mntpt.c
> +++ b/fs/afs/mntpt.c
> @@ -140,6 +140,11 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
>   		put_page(page);
>   		if (ret < 0)
>   			return ret;
> +
> +		/* Don't cross a backup volume mountpoint from a backup volume */
> +		if (src_as->volume && src_as->volume->type == AFSVL_BACKVOL &&
> +		    ctx->type == AFSVL_BACKVOL)
> +			return -ENODEV;
>   	}
>   
>   	return 0;

Please add

   cc: stable@vger.kernel.org

when it is applied to vfs-fixes.

Thank you.

Jeffrey Altman




