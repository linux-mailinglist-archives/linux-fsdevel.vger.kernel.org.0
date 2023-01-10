Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7C663CEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 10:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjAJJcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 04:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbjAJJcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:32:02 -0500
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C53F1741D;
        Tue, 10 Jan 2023 01:32:01 -0800 (PST)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id B9B3B2003FB8;
        Tue, 10 Jan 2023 18:23:34 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 30A9NXf3104299
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 18:23:34 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 30A9NXKF371088
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 18:23:33 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Submit) id 30A9NXwt371087;
        Tue, 10 Jan 2023 18:23:33 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH 3/3] nls: Replace default nls table by correct
 iso8859-1 table
In-Reply-To: <20221226144301.16382-4-pali@kernel.org> ("Pali
 =?iso-8859-1?Q?Roh=E1r=22's?= message
        of "Mon, 26 Dec 2022 15:43:01 +0100")
References: <20221226144301.16382-1-pali@kernel.org>
        <20221226144301.16382-4-pali@kernel.org>
Date:   Tue, 10 Jan 2023 18:23:33 +0900
Message-ID: <87v8leu4iy.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pali Rohár <pali@kernel.org> writes:

[...]

> -static struct nls_table default_table = {
> -	.charset	= "default",
> +static struct nls_table iso8859_1_table = {
> +	.charset	= "iso8859-1",
>  	.uni2char	= uni2char,
>  	.char2uni	= char2uni,
>  	.charset2lower	= charset2lower,
>  	.charset2upper	= charset2upper,
>  };

iocharset=default was gone with this (user visible) change? (nobody
notice it though)

> -/* Returns a simple default translation table */
> +/* Returns a default translation table */
>  struct nls_table *load_nls_default(void)
>  {
>  	struct nls_table *default_nls;
> @@ -537,9 +419,22 @@ struct nls_table *load_nls_default(void)
>  	if (default_nls != NULL)
>  		return default_nls;
>  	else
> -		return &default_table;
> +		return &iso8859_1_table;
> +}
> +
> +static int __init init_nls(void)
> +{
> +	return register_nls(&iso8859_1_table);
>  }
>  
> +static void __exit exit_nls(void)
> +{
> +	unregister_nls(&iso8859_1_table);
> +}
> +
> +module_init(init_nls)
> +module_exit(exit_nls)

[...]

Do we need to merge nls_iso8859-1.c to nls_base.c?

	obj-$(CONFIG_NLS)		+= nls_iso8859-1.o nls_base.o

Something like this (untested), maybe cleaner.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
