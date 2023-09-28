Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4377B1C8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 14:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjI1MfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 08:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjI1MfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C32191
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 05:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695904466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pz9+aLwO3boCmhUHkoiKHilkJ0jwAfADc/jLRJkriTs=;
        b=ZFz0KjdLQBipMzZdpxMHI16GofcV+16JtpmiHCdKCyrmXMmB9F/TH0yrgNbq/2BuV+PT6/
        bt9raNNpDNCZEXs8rbylRZTD4JLnPoJRD5gvatLFrETClpRqZBHpcddBwhaQv5upUmmtIV
        /77L806kGQVMtQBq4ymYNF2L04AUKuQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-7CCIeUAjOoS8dKRob476eA-1; Thu, 28 Sep 2023 08:34:24 -0400
X-MC-Unique: 7CCIeUAjOoS8dKRob476eA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5344aaf2703so5451879a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 05:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904463; x=1696509263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pz9+aLwO3boCmhUHkoiKHilkJ0jwAfADc/jLRJkriTs=;
        b=Y6Boj9X4soiP0FD8a5NP2uqYpeTaFOdnL/1LJz7bYdqtINYbWnO0RJCA7q0C9tRwVZ
         /1sX+LkvJ33Q31R3XGUFbFFfxFbm8JxUr2bxP2xoy/0qZRZLoAomV0QYhDZpzZ+Y62jW
         0LPX42NvP0vTBQyc2Ms02Lx/Kf5X+Y+LJJSi88nLgbasIbIsIny3S8DvEbuAdkX7XEbD
         vYD0ePRbtVPuOxbwaHAm78rKRHkqZDrbgpa5EhHltxURi+jwVlVeesNK+oMtm14z6kpF
         PJIRNKd3/5ZEM/rSrOmFWDpAIrwHdOcWKGf+YditvCa+8cJ0H6CF+FjrFvKtIyBjWZru
         euZw==
X-Gm-Message-State: AOJu0YySsp4uGbVxF3T4+0MMyX83W8bUrvZmuRwxrXeZel9v9TfpUFBc
        Qtx0X8ZjjMcmIq9BH7a7j0i47YzzbRczpdqpkojTxVPxhhwaMn59MlAVCtDaDP3/VhJ9hcqcf9R
        JYMjG75sHLLpRO03DWe3/xhLOpw==
X-Received: by 2002:aa7:d911:0:b0:531:1f3b:cb36 with SMTP id a17-20020aa7d911000000b005311f3bcb36mr1081150edr.9.1695904463602;
        Thu, 28 Sep 2023 05:34:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy3zTx63aKhEZOCz9dfuONcvcSvF95cloaLji0PzHkDKnjkBnlmZE+UKYx/FVQHCRDv8etkg==
X-Received: by 2002:aa7:d911:0:b0:531:1f3b:cb36 with SMTP id a17-20020aa7d911000000b005311f3bcb36mr1081134edr.9.1695904463316;
        Thu, 28 Sep 2023 05:34:23 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.138.103])
        by smtp.gmail.com with ESMTPSA id d7-20020a056402516700b0052f3471ccf6sm9653815ede.6.2023.09.28.05.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 05:34:22 -0700 (PDT)
Message-ID: <7e492ce3-6955-af46-9588-1f803280afdf@redhat.com>
Date:   Thu, 28 Sep 2023 14:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/87] drivers/platform/x86: convert to new inode
 {a,m}time accessors
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
 <20230928110413.33032-9-jlayton@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230928110413.33032-9-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff,

On 9/28/23 13:02, Jeff Layton wrote:
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks, feel free to merge through one of the fs / vfs related trees:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/platform/x86/sony-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
> index 9569f11dec8c..40878e327afd 100644
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -4092,7 +4092,7 @@ static ssize_t sonypi_misc_read(struct file *file, char __user *buf,
>  
>  	if (ret > 0) {
>  		struct inode *inode = file_inode(file);
> -		inode->i_atime = current_time(inode);
> +		inode_set_atime_to_ts(inode, current_time(inode));
>  	}
>  
>  	return ret;

