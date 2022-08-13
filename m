Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D2159183F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Aug 2022 03:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiHMBpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 21:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbiHMBo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 21:44:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70480AB05B
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 18:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ONldFfWNd/TJWmoaBWDHRWT36vMW5qjteW54FBO7fdI=; b=rFDPxSOrsTJxYml2VUWzhFgC95
        y3ngrSnAzD8oSb2ThIRH1Lvw/gXmkoQKTnyzKgDZHiRUtr9jwryGmnDDDkPo5oyNWHZ8VUHdyG9+7
        /OAal6ScTtTqLzXFjkvEfSomOZi77XMVLEoaRqaUOgW0AM2WGtClqNKqh9RQ/G86Gd8210Tmj1Hmp
        G5cAOc05WUR14YStx99or4q01gSPkCu0xLTn1XHRoPiGsj8XChTqxMp3m3UtlVcZH381YX0R3j0E7
        zqB0z/ns+/ZmnAvYPXl6CU7NZXEPB3WDw0C5aljMTxd9kqSIRQtJhxpA4HHHiNhbOD/xdkiRJV7zM
        ThRQRtPw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMgCu-002vao-G6; Sat, 13 Aug 2022 01:44:56 +0000
Message-ID: <db024202-93f1-7a58-970e-3565dc58c760@infradead.org>
Date:   Fri, 12 Aug 2022 18:44:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Doc fix for dget_dlock and dget
Content-Language: en-US
To:     Anup K Parikh <parikhanupk.foss@gmail.com>,
        skhan@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org
References: <YvYhuH66yfoi8Zxy@autolfshost>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YvYhuH66yfoi8Zxy@autolfshost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 8/12/22 02:47, Anup K Parikh wrote:
> 1. Remove a warning for dget_dlock
> 
> 2. Add a similar comment for dget and
>    add difference between dget and dget_dlock
>    as suggested by Mr. Randy Dunlap
> 
> Signed-off-by: Anup K Parikh <parikhanupk.foss@gmail.com>

Is Shuah going to merge this patch? I wouldn't expect that,
so please see Documentation/process/submitting-patches.rst:
"Select the recipients for your patch" and send the patch to
the appropriate maintainer(s) as well as the linux-fsdevel
mailing list.

Thanks.

> ---
>  include/linux/dcache.h | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index f5bba5148..c7742006a 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -297,12 +297,15 @@ extern char *dentry_path(const struct dentry *, char *, int);
>  /* Allocation counts.. */
>  
>  /**
> - *	dget, dget_dlock -	get a reference to a dentry
> - *	@dentry: dentry to get a reference to
> + * dget_dlock - get a reference to a dentry
> + * @dentry: dentry to get a reference to
>   *
> - *	Given a dentry or %NULL pointer increment the reference count
> - *	if appropriate and return the dentry. A dentry will not be 
> - *	destroyed when it has references.
> + * Given a dentry or %NULL pointer increment the reference count
> + * if appropriate and return the dentry. A dentry will not be
> + * destroyed when it has references.
> + *
> + * The reference count increment in this function is not atomic.
> + * Consider dget() if atomicity is required.
>   */
>  static inline struct dentry *dget_dlock(struct dentry *dentry)
>  {
> @@ -311,6 +314,17 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
>  	return dentry;
>  }
>  
> +/**
> + * dget - get a reference to a dentry
> + * @dentry: dentry to get a reference to
> + *
> + * Given a dentry or %NULL pointer increment the reference count
> + * if appropriate and return the dentry. A dentry will not be
> + * destroyed when it has references.
> + *
> + * This function atomically increments the reference count.
> + * Consider dget_dlock() if atomicity is not required or manually managed.
> + */
>  static inline struct dentry *dget(struct dentry *dentry)
>  {
>  	if (dentry)

-- 
~Randy
