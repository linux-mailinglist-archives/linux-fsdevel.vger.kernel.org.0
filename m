Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DB07282BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 16:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbjFHObp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 10:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbjFHObo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:31:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EDA2D4B
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 07:31:40 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QcRNk6ZjSzqTp3;
        Thu,  8 Jun 2023 22:26:46 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 22:31:36 +0800
Subject: Re: [PATCH 3/4] ubifs: Use a folio in do_truncation()
To:     Matthew Wilcox <willy@infradead.org>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <20230605165029.2908304-1-willy@infradead.org>
 <20230605165029.2908304-4-willy@infradead.org>
 <ZH4VxTWB3d9oNW5X@casper.infradead.org>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <18c1b662-8cd3-56ce-a54b-9db6fead425e@huawei.com>
Date:   Thu, 8 Jun 2023 22:31:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ZH4VxTWB3d9oNW5X@casper.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ÔÚ 2023/6/6 1:05, Matthew Wilcox Ð´µÀ:
> On Mon, Jun 05, 2023 at 05:50:28PM +0100, Matthew Wilcox (Oracle) wrote:
>> Convert from the old page APIs to the new folio APIs which saves
>> a few hidden calls to compound_head().
> 
> Argh.  This fix was supposed to be folded in.
> 
> 
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index 1b2055d5ec5f..67cf5138ccc4 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -1161,7 +1161,7 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
>   		struct folio *folio;
>   
>   		folio = filemap_lock_folio(inode->i_mapping, index);
> -		if (folio) {
> +		if (!IS_ERR(folio)) {
>   			if (folio_test_dirty(folio)) {
>   				/*
>   				 * 'ubifs_jnl_truncate()' will try to truncate
> .
> 


Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
