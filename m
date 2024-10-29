Return-Path: <linux-fsdevel+bounces-33158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315B69B52DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 20:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885A2B2341E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 19:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9DE207219;
	Tue, 29 Oct 2024 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="tBWtPBeH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cwl+J13t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C582076C6
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230817; cv=none; b=BrvbFgOIj3QLGTV4KxsrT7uBWyOAryIVGk47QLC91WUx+F0iCaOrEEWRiNRsb3Z3DTcgAGaTqfL2zvbg81R2/fJY4C2f+UUW+YP2FFgsQ8ClqnU8GMoD4LR9wkmXQtQeyHhRZ1q3wzclV1oah0pTVu0cREGoViOZSk/hN+nXE1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230817; c=relaxed/simple;
	bh=eO28iCN9LDC4caXkIXv5eQt4982F2dzCo+qvS+/4nCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYB/+bc6kPNHVXbCIzhF17Sc6M0eGAFrsf0trocboVS7CTugd4UQvVJu1Ik/vUthIY8FNNW+dAkJN9064R1X0et5Tc6SNe6nUnM+eGRNoYSgH9W1aA5/M7ZEYq0ROVX1e1Zc5Rqyhw5hR1bx9QBdeKEpsbsxvECfTR3lG7ITbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=tBWtPBeH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cwl+J13t; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D9E35138023B;
	Tue, 29 Oct 2024 15:40:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 29 Oct 2024 15:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730230813;
	 x=1730317213; bh=PNZYUdj+HNg6p1HDYnktqZ0JO7NS2RBp3fBY0Ea7IQw=; b=
	tBWtPBeHZ/MiGwfdzZkwE4eWUPUE4SsSvLyvSNRCQOW8XD/Gx7eG2c/0ytGGcSrM
	IEGZGoxTbaeCBBVmBKzJwNANP3xKdA5ZpeEZ/PVmpfzrYR16rI835AyB8aWVkCKh
	OyjogmUgzGErl1CCHyY2mxzE0/FhpeGMccQ6WkxrPVw+MdTYG7asOtvMaRfvisK6
	inL4jvBo9L/LaobmQkWb64qEOUSLe+SrSxhgg56lBZvlpcbJ+A/X84CoZb6WxtZb
	0fT79+RsaSEjVcFa24XEgUwFinf68AOZ4MjegEnWLSC3Oxs0dZWWufcZb6mWeZT4
	EZ+RqJHc8CndS23B0FjM1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730230813; x=
	1730317213; bh=PNZYUdj+HNg6p1HDYnktqZ0JO7NS2RBp3fBY0Ea7IQw=; b=c
	wl+J13t21czVaJ6dQkAshTiVRPL8jk/w8B2xxo6Oz1fF54HrNuMYNA3r+2KnRD1P
	5PhD41kT0HCxWMO7G09GsXAM2DMsmXP7AyzyT6aCWVrwqL55wLz6H0OoFshLMMWK
	N/x36vmEI0972IqQtlQO3JIfLwCU3Lwkl7yGI+9dyfftF73oFcDwDEz8faw0zEfv
	JcY/a5/jZvxwRI3TN8ctL59ZtynvUi5JbQbfxLOI1vv5FmdaQRA77tSPQx6HrQGA
	b8suPJDlvbXnt4ZLVi54iY93vznZz6SQ28pG6uYRVo+SKSMSqD1xknhXX2+i7de6
	SuuckSwbTHj8eI6uww7MA==
X-ME-Sender: <xms:HTohZ7xi9MblIEyvkc03NjyVKyNcr_tc-UPyQJgmGMlceDcEtToZGA>
    <xme:HTohZzQOCZzfyuUje_-LpZz2aLP_SBrpPZy6smmu1ib-SyvGmygYijI6lQssr9vQ7
    tlztVoEapaP-VYe>
X-ME-Received: <xmr:HTohZ1Uc7rkBUFYQ4_Or2iGWTAYiwZbHqeRlVN3-O68LvmRHG50z0fmvwMMWMzf9amsRbCOleYnxb1XVYekDMdemfvrhZ-meSHUTelUNv8VOp4ag94zF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    shgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtohepjhgvfhhflhgvgihuse
    hlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhgrohgrrhdrshhhrgho
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrd
    gtohhm
X-ME-Proxy: <xmx:HTohZ1jaFTHyikA5CJM0sBiXxYEy20vsZwjepwIKhd3CCZ0QwwwOvw>
    <xmx:HTohZ9DL3F1uTUaYQqra6GQPJsk6kHg0Jik010mEXIT3fJDoPYM2hQ>
    <xmx:HTohZ-JDxhr52ePcze6V_go71dfcmr5aO6iRFxC6XWVmXhBEcTOIig>
    <xmx:HTohZ8CEXYrWZDfHR1NFmav3XfcJnIYY-zN6cbpQC4sq-RJTBOpf8Q>
    <xmx:HTohZ3CNYpLhxGa_eFhfTRqdY85QyZRtz36ke_QCvFe1AMMCg882njyc>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 15:40:12 -0400 (EDT)
Message-ID: <1876668e-eae3-46ec-a8e0-3b23e6289295@fastmail.fm>
Date: Tue, 29 Oct 2024 20:40:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, jefflexu@linux.alibaba.com, laoar.shao@gmail.com,
 kernel-team@meta.com
References: <20241011191320.91592-1-joannelkoong@gmail.com>
 <20241011191320.91592-4-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20241011191320.91592-4-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/11/24 21:13, Joanne Koong wrote:
> Introduce two new sysctls, "default_request_timeout" and
> "max_request_timeout". These control how long (in minutes) a server can
> take to reply to a request. If the server does not reply by the timeout,
> then the connection will be aborted.
> 
> "default_request_timeout" sets the default timeout if no timeout is
> specified by the fuse server on mount. 0 (default) indicates no default
> timeout should be enforced. If the server did specify a timeout, then
> default_request_timeout will be ignored.
> 
> "max_request_timeout" sets the max amount of time the server may take to
> reply to a request. 0 (default) indicates no maximum timeout. If
> max_request_timeout is set and the fuse server attempts to set a
> timeout greater than max_request_timeout, the system will use
> max_request_timeout as the timeout. Similarly, if default_request_timeout
> is greater than max_request_timeout, the system will use
> max_request_timeout as the timeout. If the server does not request a
> timeout and default_request_timeout is set to 0 but max_request_timeout
> is set, then the timeout will be max_request_timeout.
> 
> Please note that these timeouts are not 100% precise. The request may
> take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set max timeout
> due to how it's internally implemented.
> 
> $ sysctl -a | grep fuse.default_request_timeout
> fs.fuse.default_request_timeout = 0
> 
> $ echo 65536 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> 
> $ echo 65535 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> 65535
> 
> $ sysctl -a | grep fuse.default_request_timeout
> fs.fuse.default_request_timeout = 65535
> 
> $ echo 0 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> 0
> 
> $ sysctl -a | grep fuse.default_request_timeout
> fs.fuse.default_request_timeout = 0
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  Documentation/admin-guide/sysctl/fs.rst | 27 +++++++++++++++++++++++++
>  fs/fuse/fuse_i.h                        | 10 +++++++++
>  fs/fuse/inode.c                         | 16 +++++++++++++--
>  fs/fuse/sysctl.c                        | 20 ++++++++++++++++++
>  4 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
> index fa25d7e718b3..790a34291467 100644
> --- a/Documentation/admin-guide/sysctl/fs.rst
> +++ b/Documentation/admin-guide/sysctl/fs.rst
> @@ -342,3 +342,30 @@ filesystems:
>  ``/proc/sys/fs/fuse/max_pages_limit`` is a read/write file for
>  setting/getting the maximum number of pages that can be used for servicing
>  requests in FUSE.
> +
> +``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file for
> +setting/getting the default timeout (in minutes) for a fuse server to
> +reply to a kernel-issued request in the event where the server did not
> +specify a timeout at mount. If the server set a timeout,
> +then default_request_timeout will be ignored.  The default
> +"default_request_timeout" is set to 0. 0 indicates a no-op (eg
> +requests will not have a default request timeout set if no timeout was
> +specified by the server).
> +
> +``/proc/sys/fs/fuse/max_request_timeout`` is a read/write file for
> +setting/getting the maximum timeout (in minutes) for a fuse server to
> +reply to a kernel-issued request. A value greater than 0 automatically opts
> +the server into a timeout that will be at most "max_request_timeout", even if
> +the server did not specify a timeout and default_request_timeout is set to 0.
> +If max_request_timeout is greater than 0 and the server set a timeout greater
> +than max_request_timeout or default_request_timeout is set to a value greater
> +than max_request_timeout, the system will use max_request_timeout as the
> +timeout. 0 indicates a no-op (eg requests will not have an upper bound on the
> +timeout and if the server did not request a timeout and default_request_timeout
> +was not set, there will be no timeout).
> +
> +Please note that for the timeout options, if the server does not respond to
> +the request by the time the timeout elapses, then the connection to the fuse
> +server will be aborted. Please also note that the timeouts are not 100%
> +precise (eg you may set 10 minutes but the timeout may kick in after 11
> +minutes).
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index ef4558c2c44e..28d9230f4fcb 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -46,6 +46,16 @@
>  
>  /** Maximum of max_pages received in init_out */
>  extern unsigned int fuse_max_pages_limit;
> +/*
> + * Default timeout (in minutes) for the server to reply to a request
> + * before the connection is aborted, if no timeout was specified on mount.
> + */
> +extern unsigned int fuse_default_req_timeout;
> +/*
> + * Max timeout (in minutes) for the server to reply to a request before
> + * the connection is aborted.
> + */
> +extern unsigned int fuse_max_req_timeout;
>  
>  /** List of active connections */
>  extern struct list_head fuse_conn_list;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index a78aac76b942..d97dde59eac3 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -36,6 +36,9 @@ DEFINE_MUTEX(fuse_mutex);
>  static int set_global_limit(const char *val, const struct kernel_param *kp);
>  
>  unsigned int fuse_max_pages_limit = 256;
> +/* default is no timeout */
> +unsigned int fuse_default_req_timeout = 0;
> +unsigned int fuse_max_req_timeout = 0;
>  
>  unsigned max_user_bgreq;
>  module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
> @@ -1701,8 +1704,17 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
>  
>  static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_context *ctx)
>  {
> -	if (ctx->req_timeout) {
> -		if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->timeout.req_timeout))
> +	unsigned int timeout = ctx->req_timeout ?: fuse_default_req_timeout;
> +
> +	if (fuse_max_req_timeout) {
> +		if (!timeout)
> +			timeout = fuse_max_req_timeout;

Hmm, so 'max' might be used as 'min' as well. Isn't that a bit confusing?


> +		else
> +			timeout = min(timeout, fuse_max_req_timeout)> +	}
> +
> +	if (timeout) {
> +		if (check_mul_overflow(timeout * 60, HZ, &fc->timeout.req_timeout))
>  			fc->timeout.req_timeout = U32_MAX;
>  		timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
>  		mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIMER_FREQ);
> diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
> index b272bb333005..e70b5269c16d 100644
> --- a/fs/fuse/sysctl.c
> +++ b/fs/fuse/sysctl.c
> @@ -13,6 +13,8 @@ static struct ctl_table_header *fuse_table_header;
>  /* Bound by fuse_init_out max_pages, which is a u16 */
>  static unsigned int sysctl_fuse_max_pages_limit = 65535;
>  
> +static unsigned int sysctl_fuse_max_req_timeout_limit = U16_MAX;
> +
>  static struct ctl_table fuse_sysctl_table[] = {
>  	{
>  		.procname	= "max_pages_limit",
> @@ -23,6 +25,24 @@ static struct ctl_table fuse_sysctl_table[] = {
>  		.extra1		= SYSCTL_ONE,
>  		.extra2		= &sysctl_fuse_max_pages_limit,
>  	},
> +	{
> +		.procname	= "default_request_timeout",
> +		.data		= &fuse_default_req_timeout,
> +		.maxlen		= sizeof(fuse_default_req_timeout),
> +		.mode		= 0644,
> +		.proc_handler	= proc_douintvec_minmax,
> +		.extra1         = SYSCTL_ZERO,

There is slight whitespace issue here - spaces instead of tabs.


> +		.extra2		= &sysctl_fuse_max_req_timeout_limit,
> +	},
> +	{
> +		.procname	= "max_request_timeout",
> +		.data		= &fuse_max_req_timeout,
> +		.maxlen		= sizeof(fuse_max_req_timeout),
> +		.mode		= 0644,
> +		.proc_handler	= proc_douintvec_minmax,
> +		.extra1         = SYSCTL_ZERO,

And here.

> +		.extra2		= &sysctl_fuse_max_req_timeout_limit,
> +	},
>  };
>  
>  int fuse_sysctl_register(void)

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

