Return-Path: <linux-fsdevel+bounces-58690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84423B30883
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 23:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C313D1884DD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 21:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2334A2D7DC9;
	Thu, 21 Aug 2025 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="j+CWHnfR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9/IsVbr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239832D6E65
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755812372; cv=none; b=bWRRVk6Xe8SX6sGXamJnYNLbpepFnad7f1cPXO+3T4HTnyN9PxJZPDrhdtT+4jD1DEp7zFP76Mi3p5Mw3BxJQ9EoNNo2G0dj8ugvc+VxL5FQZo3Lc0u4Ucky7Jnqpk28a6a5eIYxGQqgOH94BH02Zvomo9MHQ0T6P9YXRJaue5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755812372; c=relaxed/simple;
	bh=59AIgVh3nqvz7Uj8kjTXlNX/H0Be2MeLs8nD/AUyCyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAXQaY1VPf0Db+zTUXmtmXWSHDa9keDA/uByOqvifq7gz781wN7U3nwNFElIR9h+TjTOFD9UcD1JvZ9IIkrteRd6XlfCVOJy+HnjbZSN69vQh2tq9He95UDlt6Z9Q2DJEdDm2V74IMyZP4WmhSnNTRJzZLocjrRV7Qqf6Y23uV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=j+CWHnfR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J9/IsVbr; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 44A78EC0917;
	Thu, 21 Aug 2025 17:39:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 21 Aug 2025 17:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755812368;
	 x=1755898768; bh=zAh1QX0KyFWIAEZnTn/0vUANMjFJi+EEEbMQzqVna5I=; b=
	j+CWHnfRR60rIPKAg1sLc6gIWNwPTIe2Cpq6U4LT3kYM6K8ksJJ56FJwWM/thwbE
	AKiSejguJXXfyVrW58l6oPDHrwAdW1scNJac5KFtx62Mh0tfALZ7vR0b5HEnZoF3
	EAIFGTlP3+rQJw6lt8UrtOs9Vn8l76YgwY9yrbAhOI+oM3fYK1B49gwvxCu2BIQF
	IgLQAiDzzgjC3dc1v5QREXaGzRijTsoMO8MXsdgpflZ8IZt3D9sl9/z8bPNGoevt
	Fi381KnP4BcEFSukREvRcOyxxsoHtGD7BcDpZzSQ+W0KqmdSQF9+vvLWOj3ZlY6H
	uycnwwLCWv6KuHNLwcogGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755812368; x=
	1755898768; bh=zAh1QX0KyFWIAEZnTn/0vUANMjFJi+EEEbMQzqVna5I=; b=J
	9/IsVbrGrzHrJOrBtwATwQttUWOmL1LlLHl2SCH40RHbvdahOE8RGttYs9Pin7CD
	smb/61NYm9LgcpZf6c9e+njMJyjCKH3x6UtPSInwa6M49T8eXErbk0jaB1IfiSG4
	G7DjkN9SuD30hFrLInvJgYOyNzwh9+qVZw1+uyr/UaRqND73AaxWSjdyamlFixW/
	en3n2KUqzRk6ZL5sJYbjBqlLzGstqqTXXSx/4vwXS8Y9RFe1giepNvpXn/coQb6T
	fcjyOzSQ+flYPafFQo6nNANCoMXu/+g70nn6ULTZyyQyUUGYkBtNrb4boYaUedrg
	pp9L5TIThsy8F7+O/zWNA==
X-ME-Sender: <xms:D5KnaNELiapyyEvH4jsFGpqpecBp-V9idQbx_xsuQfeIiHcIFQjlQg>
    <xme:D5KnaDA8U27qAxpnutaVx_Ah_oMZy6sJYOVcNFteEto8m6kSJPeCr5c4npuBq1DOM
    sQBms068gdXLeof>
X-ME-Received: <xmr:D5KnaNWUeCU-5y8Q-kMLRxrsEEtdIyHrc3aA1BXzKGhcHxTqVmNBRA71miy2jG49k-FI58-RYEs8q3tvFIvo6eAgacGfsA-7grkSKoMD-CVNRBt51ijc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehjohhhnhes
    ghhrohhvvghsrdhnvghtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtg
    hpthhtohepnhgvrghlsehgohhmphgrrdguvghv
X-ME-Proxy: <xmx:D5KnaHocuIbZ1Q0SLUMFg7sXv5o1ukM0brSnlIOqvqq2Y4kCD1c3hw>
    <xmx:D5KnaJQXTEYyjXrkXYLkBlro6T3hn5KqeU5rI2fDMMQaREq6CeSskg>
    <xmx:D5KnaB39be5s3lpFTwAy32HFp4fxQA_7yt-aisGHHQNQsMr_0gxc9g>
    <xmx:D5KnaFCRhWZZAPXi-VVl5m5fz9FA2oCqoH2KDCsrm1CPXeyby_z0Dw>
    <xmx:EJKnaJ5TPKJnkfmlfReG1SYo-7l1AGuuykFAkU7Vkb6S1dItcyiFHLrf>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 17:39:26 -0400 (EDT)
Message-ID: <9730e948-75ca-4259-9344-cee4742e27cc@bsbernd.com>
Date: Thu, 21 Aug 2025 23:39:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libfuse: don't put HAVE_STATX in a public header
To: "Darrick J. Wong" <djwong@kernel.org>, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 miklos@szeredi.hu, neal@gompa.dev
References: <175573710975.19062.7329425679466983566.stgit@frogsfrogsfrogs>
 <175573710994.19062.1523403126247996321.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <175573710994.19062.1523403126247996321.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/25 03:01, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> fuse.h and fuse_lowlevel.h are public headers, don't expose internal
> build system config variables to downstream clients.  This can also lead
> to function pointer ordering issues if (say) libfuse gets built with
> HAVE_STATX but the client program doesn't define a HAVE_STATX.
> 
> Get rid of the conditionals in the public header files to fix this.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  include/fuse.h           |    2 --
>  include/fuse_lowlevel.h  |    2 --
>  example/memfs_ll.cc      |    2 +-
>  example/passthrough.c    |    2 +-
>  example/passthrough_fh.c |    2 +-
>  example/passthrough_ll.c |    2 +-
>  6 files changed, 4 insertions(+), 8 deletions(-)
> 
> 
> diff --git a/include/fuse.h b/include/fuse.h
> index 06feacb070fbfb..209102651e9454 100644
> --- a/include/fuse.h
> +++ b/include/fuse.h
> @@ -854,7 +854,6 @@ struct fuse_operations {
>  	 */
>  	off_t (*lseek) (const char *, off_t off, int whence, struct fuse_file_info *);
>  
> -#ifdef HAVE_STATX
>  	/**
>  	 * Get extended file attributes.
>  	 *
> @@ -865,7 +864,6 @@ struct fuse_operations {
>  	 */
>  	int (*statx)(const char *path, int flags, int mask, struct statx *stxbuf,
>  		     struct fuse_file_info *fi);
> -#endif
>  };
>  
>  /** Extra context that may be needed by some filesystems
> diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
> index 844ee710295973..8d87be413bfe37 100644
> --- a/include/fuse_lowlevel.h
> +++ b/include/fuse_lowlevel.h
> @@ -1327,7 +1327,6 @@ struct fuse_lowlevel_ops {
>  	void (*tmpfile) (fuse_req_t req, fuse_ino_t parent,
>  			mode_t mode, struct fuse_file_info *fi);
>  
> -#ifdef HAVE_STATX
>  	/**
>  	 * Get extended file attributes.
>  	 *
> @@ -1343,7 +1342,6 @@ struct fuse_lowlevel_ops {
>  	 */
>  	void (*statx)(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
>  		      struct fuse_file_info *fi);
> -#endif
>  };
>  
>  /**
> diff --git a/example/memfs_ll.cc b/example/memfs_ll.cc
> index edda34b4e43d39..7055a434a439cd 100644
> --- a/example/memfs_ll.cc
> +++ b/example/memfs_ll.cc
> @@ -6,7 +6,7 @@
>    See the file GPL2.txt.
>  */
>  
> -#define FUSE_USE_VERSION 317
> +#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
>  
>  #include <algorithm>
>  #include <stdio.h>
> diff --git a/example/passthrough.c b/example/passthrough.c
> index fdaa19e331a17d..1f09c2dc05df1e 100644
> --- a/example/passthrough.c
> +++ b/example/passthrough.c
> @@ -23,7 +23,7 @@
>   */
>  
>  
> -#define FUSE_USE_VERSION 31
> +#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
>  
>  #define _GNU_SOURCE
>  
> diff --git a/example/passthrough_fh.c b/example/passthrough_fh.c
> index 0d4fb5bd4df0d6..6403fbb74c7759 100644
> --- a/example/passthrough_fh.c
> +++ b/example/passthrough_fh.c
> @@ -23,7 +23,7 @@
>   * \include passthrough_fh.c
>   */
>  
> -#define FUSE_USE_VERSION 31
> +#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
>  
>  #define _GNU_SOURCE
>  
> diff --git a/example/passthrough_ll.c b/example/passthrough_ll.c
> index 5ca6efa2300abe..8a5ac2e9226b59 100644
> --- a/example/passthrough_ll.c
> +++ b/example/passthrough_ll.c
> @@ -35,7 +35,7 @@
>   */
>  
>  #define _GNU_SOURCE
> -#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 12)
> +#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
>  
>  #include <fuse_lowlevel.h>
>  #include <unistd.h>
> 


Thanks, I'm going to apply it to libfuse tomorrow. I think the version
update in the examples is not strictly needed, but doesn't hurt either.


Thanks,
Bernd

