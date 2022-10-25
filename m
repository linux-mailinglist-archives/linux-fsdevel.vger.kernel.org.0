Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CD260D44D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 21:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiJYTCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 15:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiJYTCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:02:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FE32A95B;
        Tue, 25 Oct 2022 12:02:15 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y14so15122930ejd.9;
        Tue, 25 Oct 2022 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wdQpMJv+fAAdPj7JhNoObv56I8k+ulFEDb11lC7AivY=;
        b=lJlZT5zbsgVFeKCsWmbaL5DSMTf48Ru56giPGXdY/pQohgHr9azEIF3ixhn+tAWh/x
         pbaOZD2att0kTfKsdsTsl8C7ASExfvIysnxfEkWE1FEyNlSS/fOGJ8oBj4u4jptLgfaO
         q7rt7ptzzqwkXI+hgKYF1n/wNwKUYygRtFU+CjBdM19VG6l6OWopGfIGo9gDxokz6Oqw
         BUrWJ6U5FbwDcvIVNRqvvMTjxCiNqF4O/R2GlAoQdy11Zdyl1JlDOEy8a2PKTpxPIgdw
         fPw6db9HfDJgI6jLVrnWTwMMI+SftXJFg3N2zsQZVPtnbdaQy+RhWAWT4htQIZMRYQbc
         tLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdQpMJv+fAAdPj7JhNoObv56I8k+ulFEDb11lC7AivY=;
        b=Tja2TpcNVg0wBVrVuxbBIq3ijwsvAI+KZ8nwZMreymljgir2zZObZ42bwZoyeonpV2
         5hp7iDp91X1k9cUKD90ovHoisKXNqM+GWqq0/AEAmX5qV0IlrrgWvgmBObB1rJ42JUSB
         ek1Czjr/YsiTwNIiTtmncoUCMZXzu55toL4CmozfYji/2/S5w1FJjDQVKzVqccUSyrfs
         Xl+YGNv5djANx7RBTClD26L4Z7+horMecd9oCwgs96tFxRHjX6NEfvIwCichfn8pD61y
         feQb+lc0O4uVkWPjITqIV3scKuvw0d9QdpYWZux5r6FCGECCP7TSeuJs3Q4kVl5oj9FI
         UYrQ==
X-Gm-Message-State: ACrzQf3SXyZE/Gcveas5J8N8bihRp71D6DrlZqtyC7cCr6Gmio0KaR/H
        Vn73EKkMT+kwVLEozPYbsg==
X-Google-Smtp-Source: AMsMyM7fNS7fCUE8nEqacvdkW1wr5/+kQrklLGOYoO4TKyWPl5HmOInIjZOsek2fd6tLXWvZGAASlQ==
X-Received: by 2002:a17:906:5a6a:b0:7a6:bad5:8295 with SMTP id my42-20020a1709065a6a00b007a6bad58295mr11961592ejc.647.1666724534017;
        Tue, 25 Oct 2022 12:02:14 -0700 (PDT)
Received: from p183 ([46.53.248.70])
        by smtp.gmail.com with ESMTPSA id s5-20020a056402036500b004623028c594sm1031397edw.49.2022.10.25.12.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 12:02:13 -0700 (PDT)
Date:   Tue, 25 Oct 2022 22:02:11 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        yi.zhang@huawei.com, chengzhihao1@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/binfmt_elf: Fix memory leak in load_elf_binary()
Message-ID: <Y1gys5Cvjh8cREWB@p183>
References: <20221024154421.982230-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221024154421.982230-1-lizetao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 24, 2022 at 11:44:21PM +0800, Li Zetao wrote:
> If "interp_elf_ex" fails to allocate memory in load_elf_binary(),
> the program will take the "out_free_ph" error handing path,
> resulting in "interpreter" file resource is not released.

Yes :-(

> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -911,7 +911,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		interp_elf_ex = kmalloc(sizeof(*interp_elf_ex), GFP_KERNEL);
>  		if (!interp_elf_ex) {
>  			retval = -ENOMEM;
> -			goto out_free_ph;
> +			goto out_free_file;

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
