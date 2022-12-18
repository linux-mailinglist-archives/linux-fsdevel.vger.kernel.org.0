Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCBC64FF29
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 15:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiLROtb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 09:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLROt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 09:49:29 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B296594;
        Sun, 18 Dec 2022 06:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=FhwTnOar5E14fmDvz361JNUqxa1iYpvEeC/ZXN7P74g=; b=WYIc75aPc04gsM7HJ9Kgfr3pRs
        XmQ7NeX1380snfJFNGklSkNPAKQVBLQdVliBFnhI3Zc7XxUmzWiJK/qfw4xkNzmWf31nbDd3JZzpJ
        C9azxSymoJ1yQPsQy8cNVZLbYjleDD1tyQLBBkPbTxrOEyCmxR+ylLNZvD/LbkoKYTfsYhHoQQhsx
        BTcEPhGYENXJjIjSCHpU29w8yVt0LfR9rgK8eHM42eHYU2rWVLT43oReWC0MeAi8A8JIaiyNwPwCM
        ivvyAiMDeYiO7y29hkVZUYWnbqWHUu1UreQDjwaufYV2rOEUBlkevtRWJFGT8gwy1za3bojG1cQwd
        yYYPg8tWF/jtjVT3KEFkTOZWspSKaf4vYNnSq0b5P47UnGl5UuR4eIqNv8d2Sq41D14WGyhztoRvL
        i1kduah4TUqiPJ4MKGi49XeydIcjPDb95BimDEHSlUS7LIobW2OkTzjGReydebLM+Z1zCZUJZcNJ+
        2fMk+tZ29X/4bCNvhPHrX9rFac5qyLFZOCMlyFtf/vGq5x7D7VvZPy3pIZUxk8l2ltnT/kFBLKIQe
        4Ky9X69AYX4I8xCyy/xZ8zFkWD2+tVdVTEwDlt2vs+QI2bbsqK0WEh3FLWDzyrjXY4lpoxwY3dPyx
        AkwNLmvxvp8f3z4Z4srFuUcppor+fxfWIqEPvfDNM=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Subject: Re: [PATCH 1/6] Adjust maximum MSIZE to account for p9 header
Date:   Sun, 18 Dec 2022 15:49:18 +0100
Message-ID: <4530979.Ltmge6kleC@silver>
In-Reply-To: <20221217185210.1431478-2-evanhensbergen@icloud.com>
References: <20221217185210.1431478-1-evanhensbergen@icloud.com>
 <20221217185210.1431478-2-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Saturday, December 17, 2022 7:52:05 PM CET Eric Van Hensbergen wrote:
> Add maximum p9 header size to MSIZE to make sure we can
> have page aligned data.
> 
> Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>
> ---
>  net/9p/client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index fef6516a0639..416baf2f1edf 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -28,7 +28,7 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/9p.h>
>  
> -#define DEFAULT_MSIZE (128 * 1024)
> +#define DEFAULT_MSIZE ((128 * 1024) + P9_HDRSZ)

Adding 7 would make what page aligned exactly, the payload? And how?

>  
>  /* Client Option Parsing (code inspired by NFS code)
>   *  - a little lazy - parse all client options
> 



