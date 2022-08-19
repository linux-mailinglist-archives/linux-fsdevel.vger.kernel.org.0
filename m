Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE2A599A96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 13:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348760AbiHSLON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 07:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348762AbiHSLOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:14:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29FDC3F6A;
        Fri, 19 Aug 2022 04:14:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s11so5218663edd.13;
        Fri, 19 Aug 2022 04:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Sx9SlBHLsTj9fAFHZm02u/sabG6vSGKEbbaKRYbRUOU=;
        b=cTV7O7ZHNMJTb7hLnpCD4W9Poa3CmWMNi4C7SPsigI9hU9bs/MFfv0Z5uDFDJArXQ/
         pEV+PfjemhSdL7kT9JTo0NJ3oPF+zcwzHWDfbwPKyh+cJKsH4KDU19cfIM0JILFiPUQB
         eQPWlJs3/j4C3gYMBdR+A80Brxejb+xBsQ+eC+TDje4M1Z0u7VogYJggAX8l56c/Oym5
         hTECKO2kMZROIPCsbe+auJjPYAnHQbFRNMr5g2mlm4HS7ZwPnAG/dasNXNIwEdKMdE2G
         sohJtpySMRo6hwaPSchb/XIu28XU5iBx/eZdii/STBUJ+M72hyIrSaXiWmJ6OiCgJ+EH
         4c2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Sx9SlBHLsTj9fAFHZm02u/sabG6vSGKEbbaKRYbRUOU=;
        b=55tSgk/7R+/QilJunw4IQCAq52rP8iLOc9uBYW8KQM5YNVJSwjoPCqif0VmHVM9+iE
         BxZ1STcQeeyKAigGGK7kggVBQMsNvZtaluhTY9uc1zuYNR7NODq/g7Ywlc0i7gRecYUi
         JhnfucBGkbZRNY7UfO6DwuQjz/OfEaD6MWT1+Y8YsNVjBI8iizFtlunN0Xzf6bA0+sqP
         eWRXW1Vo+eulksOfIlZB+aU9xRQfSdvaCz0ceZORur2XG1vatynJeEEfQJUaaljYA/eF
         4N/bKNG9N5SlY5v1okcaHzFr1/FsjPbRM7O+BTU0Ux8cRepwgusmwJe/SRtMb81s/ehV
         l/oQ==
X-Gm-Message-State: ACgBeo1qztu5wOJGhXHEB6a/G+Dk25hWm67ZSMgsvdWRINqRxejYIx9T
        fougijnajWZL4kva3h3/XTkhVjIGs3c=
X-Google-Smtp-Source: AA6agR4HpdgdiIUl9gdT4zG5+8q1hRLBTcDOpV7nt8ZB4ggvCfMmB7T/76+O/wkJiuC7HwWKK/1oHQ==
X-Received: by 2002:a05:6402:35c:b0:43c:8f51:130 with SMTP id r28-20020a056402035c00b0043c8f510130mr5637575edw.393.1660907647505;
        Fri, 19 Aug 2022 04:14:07 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090632c800b0073cd7cc2c81sm1010753ejk.181.2022.08.19.04.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:14:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-fscrypt@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] fs-verity: use kmap_local_page() instead of kmap()
Date:   Fri, 19 Aug 2022 13:14:03 +0200
Message-ID: <2851124.e9J7NaK4W3@localhost.localdomain>
In-Reply-To: <20220818224010.43778-1-ebiggers@kernel.org>
References: <20220818224010.43778-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday, August 19, 2022 12:40:10 AM CEST Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Convert the use of kmap() to its recommended replacement
> kmap_local_page().  This avoids the overhead of doing a non-local
> mapping, which is unnecessary in this case.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/verity/read_metadata.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

It looks good to me...

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

Fabio

> diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
> index 6ee849dc7bc183..2aefc5565152ad 100644
> --- a/fs/verity/read_metadata.c
> +++ b/fs/verity/read_metadata.c
> @@ -53,14 +53,14 @@ static int fsverity_read_merkle_tree(struct inode 
*inode,
>  			break;
>  		}
>  
> -		virt = kmap(page);
> +		virt = kmap_local_page(page);
>  		if (copy_to_user(buf, virt + offs_in_page, 
bytes_to_copy)) {
> -			kunmap(page);
> +			kunmap_local(virt);
>  			put_page(page);
>  			err = -EFAULT;
>  			break;
>  		}
> -		kunmap(page);
> +		kunmap_local(virt);
>  		put_page(page);
>  
>  		retval += bytes_to_copy;
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> prerequisite-patch-id: 188e114bdf3546eb18e7984b70be8a7c773acec3
> -- 
> 2.37.1
> 
> 




