Return-Path: <linux-fsdevel+bounces-503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79BA7CB6A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 00:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E41028176F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CCC347A5;
	Mon, 16 Oct 2023 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KdwJiWvh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D109D328A6
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 22:43:17 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959D195
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 15:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=omD9ln1E5+fKJwEQjo6x1zEyoxhYRXPhqjkRl53Qz20=; b=KdwJiWvhPu6Ol1d1Di8D3XSCBy
	HTwZ8g0d+ztloctebGqitsoJuGVLBXoin/e+DO2WrpKWh8hUn0RV6xqBebH7m82RFVPjEmLpKQO0L
	Xo80v+1TX2NBBoLeFaJRCieqZJoeFpE9KkstE7M5Gng2snck7irdG7cUDF6FppEtAWUcjJjdpMpzV
	QuYr35wYaMsSIBuRoNG21057PFjFeCFOmRtdBDf3pdbZy2qsY4gxiqKCT+7bxjjKfgiF+s30aKqJg
	quOnv6LX9aBPGHcqzUR36eL5KaWph6lJgICBnGhmdSqJnxY7a9L40f1BtsHjyYJoO+K/2Kkpki7lA
	MDCazOfQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qsWIp-001s7J-2M;
	Mon, 16 Oct 2023 22:43:11 +0000
Date: Mon, 16 Oct 2023 23:43:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] chardev: Simplify usage of try_module_get()
Message-ID: <20231016224311.GI800259@ZenIV>
References: <20231013132441.1406200-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231013132441.1406200-2-u.kleine-koenig@pengutronix.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 03:24:42PM +0200, Uwe Kleine-König wrote:
> try_module_get(NULL) is true, so there is no need to check owner being
> NULL.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  fs/char_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index 950b6919fb87..6ba032442b39 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -350,7 +350,7 @@ static struct kobject *cdev_get(struct cdev *p)
>  	struct module *owner = p->owner;
>  	struct kobject *kobj;
>  
> -	if (owner && !try_module_get(owner))
> +	if (!try_module_get(owner))
>  		return NULL;
>  	kobj = kobject_get_unless_zero(&p->kobj);
>  	if (!kobj)

I wouldn't mind that, if that logics in try_module_get() was inlined.
It isn't...

