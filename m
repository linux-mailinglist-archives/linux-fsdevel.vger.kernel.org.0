Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AEE52BEA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbiEROwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 10:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbiEROwB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 10:52:01 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1539613CA2D;
        Wed, 18 May 2022 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aUbk6KbikG/NrB2A/Jq5RScJLrcT2oDE1hZbmG6RHrI=; b=UwEgvS7IC3JI6fwDjXuFCqElmc
        xoJNxTuW/eYzUiacfls+oUD5ZMhEvayGh9YqVMOr+Nl8ZEDyGKvB4u22r5GcDUQUvji1XPLcHCl3B
        diM411NwYpZSW/xqHheCVHiZc4Q3tf1miJzatG2FR0YWS1WdIUL0gDpDSgWjDDO8onzUvVUucgNq0
        6fkXiuDjY69MlZdD7CJdmvpy0KdKZ3Sw+sz4Zj7DnpRstQZIDlNcAjYX357nPLh83HigrYnQw9vtX
        /1UAuLMK3jYTWzanmHkQuU/ZzUqC4eoAmwyVtT11KEtUDuYmw/AQZB6MrT7AUOZzbEFORrMNgdwny
        kjDCoXig==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrL1p-00G3Uc-Nl; Wed, 18 May 2022 14:51:57 +0000
Date:   Wed, 18 May 2022 14:51:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH -next] fuse: return the more nuanced writeback error on
 close()
Message-ID: <YoUIDcOmfJ5lppu3@zeniv-ca.linux.org.uk>
References: <20220518145729.2488102-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518145729.2488102-1-chenxiaosong2@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 10:57:29PM +0800, ChenXiaoSong wrote:

> +	/* return more nuanced writeback errors */
>  	if (err)
> -		return err;
> +		return filemap_check_wb_err(file->f_mapping, 0);
>  
>  	err = 0;

As an aside, what the hell is that err = 0 about?  Before or after
that patch, that is - "let's make err zero, in case it had somehow
magically changed ceased to be so since if (err) bugger_off just above"?
