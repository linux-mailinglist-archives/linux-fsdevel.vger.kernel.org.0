Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8063FEB4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 04:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiLBDTK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 22:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiLBDTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:19:09 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C47B9561
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 19:19:08 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s7so3498917plk.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Dec 2022 19:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DR+L2tCwBpbtmON02lrOLeywqLevQY+rlsopHl3s3M=;
        b=S0WOf5eNGX1uZihlupPUjVpXggq+A03gGaLnfTXB4hkSwl//dKBglznwTvyiHeXdS8
         CL1o3eNT/eJ73x631/tg5Zqm80cY4DpcHaul18Bl73zTDvOY5iAoumv6OPwG7VFxDC36
         ov7HiSiSG/DvxID+XPcVZNMjDn413ia/DA7uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DR+L2tCwBpbtmON02lrOLeywqLevQY+rlsopHl3s3M=;
        b=IqfkmQ5d6oqUTVcqU4/Qo1zJI1ksU/mM6u8xmRtgjnm9B/+TjRqQOXv8NpBRpLP682
         ZW3xYfZ5vs+2B61wZjLnSTbXdZa4H20bnY/GuKKNu6AZx2FJQmIzEkbRqZf6ngt37gvP
         zvkcwKuQb6NWDC7a7J6U3Fdj/B4+OG/19YKQ3s1aJd7fIZl73bijw2xCqAvCCKwYSTOX
         I4y4xOOYKK+eZ7BMigMHeg102urDFqzcNPYypip5JxF6mqcrGNlkf0IAmTEppCja8qQB
         F0czdbccxwJXGWl5I6loMi2uwXc8oklahHhouEfpP7ROovWiyrkETdM0ZFy89ZQLMatd
         DJZQ==
X-Gm-Message-State: ANoB5pkKQvrI7fc3OopoiokB4E3AyAat/h1ZIwrtnmQBrzyjhBC+jX3k
        hBOLILZikZ3Krz/HcUWRKsU3qw==
X-Google-Smtp-Source: AA0mqf6qogGYNDDIVKEeNlRHJYc1B/vG2knwocigpUMdI+SNURPnX0V8TcW/Srn61+M02viBMtVOng==
X-Received: by 2002:a17:902:7006:b0:181:b55a:f987 with SMTP id y6-20020a170902700600b00181b55af987mr51421386plk.67.1669951148107;
        Thu, 01 Dec 2022 19:19:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b0018999a3dd7esm4421641plh.28.2022.12.01.19.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:19:07 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     wangyufen@huawei.com, ebiederm@xmission.com,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] binfmt: Fix error return code in load_elf_fdpic_binary()
Date:   Thu,  1 Dec 2022 19:19:03 -0800
Message-Id: <166995114102.992719.2531794582605793355.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1669945261-30271-1-git-send-email-wangyufen@huawei.com>
References: <1669945261-30271-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2 Dec 2022 09:41:01 +0800, Wang Yufen wrote:
> Fix to return a negative error code from create_elf_fdpic_tables()
> instead of 0.
> 
> 

Applied to for-next/execve, thanks!

[1/1] binfmt: Fix error return code in load_elf_fdpic_binary()
      https://git.kernel.org/kees/c/e7f703ff2507

-- 
Kees Cook

