Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62ED59BA07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 09:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiHVHKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 03:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiHVHKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:10:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964ED2982C;
        Mon, 22 Aug 2022 00:10:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso13076917pjk.0;
        Mon, 22 Aug 2022 00:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=fOmZy3U9PAu2Ajzs2pnd09V97bF2APgIMcB5WGE/msY=;
        b=l0rfl+hQJU8zVVcx5/GcRWbx6XKPNgoV01l1peZrKI+YqbJO2X9Tnm2rb2SbwQLmcJ
         qgOzy38/kgzl9jOGBEHuclNE27yHqNgkyGJH/JVYJvWL6U8zmZqvnLT/qng+jsbfzigQ
         lUSNy+eTdQr8onBI1gKLH4GEkC3hw56XGv0QgCDhqGAPNWQgVJlC0SefVtUSs9kjckFF
         bHS5WrkEmRcIh394VLmk2hxLST75vcTK8irnYzDJjEU+Qt3//h+ICV3yCB1USR3zH+Op
         b3i82RzDrWWa+erAyZjNLNiUtaQ/4uG51/tOCOO1dhDApjNGs3M9MAsk9+jRB3DT8R/C
         cDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=fOmZy3U9PAu2Ajzs2pnd09V97bF2APgIMcB5WGE/msY=;
        b=g18pTpxHBPlcUL6rOYsPCE3aDeMn1pK/i8/Pl/Dgu0FKwkbxh3/vj+R30xW8Wkxswi
         in4F6wbeAXTEJQl52TPMQwysBwopuu73Wy3k30VJa77xEDItyxTb7yrG5i5liKQrKx8o
         MmeoMsgB3IMPgPJ3TgwyGWJRe6PA254Lm4cixBXPYkKNl5hCKdwiNBz/5rddQ6W2Hfvr
         kuN4N3ldi0mOCEtviiJIU1yhfucldOdMb6ZfPaNMsymQcwgxwGmkLgAXfR/GRQsg4j4O
         39CqrEdo3vNFIKxn6QKI7bFd+q66OQoGoy85g/035NuBvQ5H/j8Azn3VqY5ow2cY2y1/
         AYgg==
X-Gm-Message-State: ACgBeo1QkiUoGy0dvgehJjdzqfGKoe8bfhLtcvCcMVrVFW7jHjPmTxcp
        QXfOS8gF3xlmLcHhz6NxDXvYae8tl8o=
X-Google-Smtp-Source: AA6agR4R/hMkIZekPmcVEAmEcwTdz9V4Cr6/vB8WEPIhG7paM9h1ocAaUNVTjTpg/rL5DKDNgBQgMA==
X-Received: by 2002:a17:90a:5996:b0:1fb:fb6:2adc with SMTP id l22-20020a17090a599600b001fb0fb62adcmr8447156pji.177.1661152235745;
        Mon, 22 Aug 2022 00:10:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u16-20020a17090341d000b00172aa97b628sm7619421ple.186.2022.08.22.00.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 00:10:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 21 Aug 2022 21:10:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com
Subject: Re: [PATCHSET for-6.1] kernfs, cgroup: implement kernfs_deactivate()
 and cgroup_file_show()
Message-ID: <YwMr6X8X7Ncdm6V5@slm.duckdns.org>
References: <20220820000550.367085-1-tj@kernel.org>
 <78d464bd-94db-a1bc-d864-d85f2751dca3@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78d464bd-94db-a1bc-d864-d85f2751dca3@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Mon, Aug 22, 2022 at 09:58:22AM +0800, Chengming Zhou wrote:
> It's so nice of you for implementing this! I will rebase on your work to
> do per-cgroup PSI disable/re-enable and test it today.

Oh, I always kinda wanted it and am likely to need it for something else
that I'm working on, so it isn't all that altruistic.

Thanks for working on PSI optimizations!

-- 
tejun
