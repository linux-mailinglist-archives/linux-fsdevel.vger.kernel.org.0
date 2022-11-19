Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DCC630908
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 02:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiKSB71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 20:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiKSB6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:58:25 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA0149099
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 17:51:40 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id x21so4720338qkj.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 17:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RcbkdWEcAAxTUYWy4fuskHUKudEfBBNjhxkYAZX9BH4=;
        b=Nwaa67ge0ieIUVjETu/pRbe/sOEsWc1H2Vz8TMcbQTgYvJUhzJCEGWAlU5X+WiHp9L
         NEKkntyxWdV/jZp5tGqJM/sTcSiYoCYUTvm+dvQschprW5iz7oMbLITpfc40PXEDCtZf
         ck3Xa4MDHWk7eo29faq+bggpSSYH5xsN+Ygl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RcbkdWEcAAxTUYWy4fuskHUKudEfBBNjhxkYAZX9BH4=;
        b=B662196PvjGP3NmaiDYoNdnLFs8kpg8KCUKGnRj4xUiT4/e5/80csBDZF/7LrlhgXJ
         QYX3bYoLDnaqUW1WE2Wbx5nbqFOIhDjw0hQIdqGBOjZN+keINutfMaUijYIwHY4djG50
         /T99jhfpgX1nA6hLsE9BzTcoy6A3OPGOJuI75txDjEeUerNeO9KtE/BjS/taJcN8pHYj
         IcGNVGQ/zilcKH7J/C8JaGqFHyJdzcTMeezg3Iu9iamYemiUirTMc/hKxwGMve9PIfWh
         mSGWTeohMKeMt89D1Kz2qlLpNtdH80qGjsLfkYXrH7vg8agsCjGslOTq/DobQjklnWCC
         iy5A==
X-Gm-Message-State: ANoB5pltLcKUjScF313PFd8GQBmW4sMGm3XtZnsbYlnV9oAG0R08RQXe
        soa8f4/wiZS1YR4DPeQxXxwWhO1zDbtAYw==
X-Google-Smtp-Source: AA0mqf6seggpSXvZo+Zs2IOAUsJajqmIkEXFM1zef78yUzXsE9KaQlGvSMSVCUH8HgvVM8ATIAqecw==
X-Received: by 2002:a05:620a:22a2:b0:6fa:2ec7:3e0 with SMTP id p2-20020a05620a22a200b006fa2ec703e0mr8366173qkh.392.1668822699047;
        Fri, 18 Nov 2022 17:51:39 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id f14-20020a05622a114e00b003434d3b5938sm3024193qty.2.2022.11.18.17.51.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 17:51:38 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id k2so4672878qkk.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 17:51:38 -0800 (PST)
X-Received: by 2002:ae9:e00c:0:b0:6f8:1e47:8422 with SMTP id
 m12-20020ae9e00c000000b006f81e478422mr8415207qkk.72.1668822698109; Fri, 18
 Nov 2022 17:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20221119010906.955169-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wiUq50yc7MavtZXcFiv9VxW9YyJDMB2ht1sHnDBieVB5w@mail.gmail.com> <f66fadb2-335e-b9d2-5df8-6178692bab5d@opensource.wdc.com>
In-Reply-To: <f66fadb2-335e-b9d2-5df8-6178692bab5d@opensource.wdc.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Nov 2022 17:51:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWTW+f84jnW=4+3EJYksxv=ZfffXvBnXaCOo179BsNkQ@mail.gmail.com>
Message-ID: <CAHk-=wiWTW+f84jnW=4+3EJYksxv=ZfffXvBnXaCOo179BsNkQ@mail.gmail.com>
Subject: Re: [GIT PULL] zonefs fixes for 6.1-rc6
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 18, 2022 at 5:48 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> Thanks. It looks like it was some random delay. I can see it in lore now.

Yeah, and as a result pr-tracker-bot seems to be back on the job.

                    Linus
