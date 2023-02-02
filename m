Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B735168761D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 08:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjBBHBP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 02:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjBBHBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:01:13 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F2C83244
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 23:01:11 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id t12so891920lji.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Feb 2023 23:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6RPkQZwzCSh98zsjzzoNHs7/CVVvqXi24+J6zt37CWU=;
        b=eQYQvVEeNh6GrV8MdWOCA/5ah+ioo03sXKFCDQYkNXEZmChGTT0z3qoR/kcWV3g1/T
         yuCzb7Q7boaK/I8eCnExwjdL/W+o8IFDb0hRa8ONF3OnyZ72Q8M4Esr6sdjkOsQTYPGH
         igbgzB/F7dfc87XMT37hVaFsRsSYBkWTiimHAabwnPuQ0UfI8GEbG+Hu74hmqriL4HJa
         9em3Sg8bCf9xZMF5dRPn+6PhkGlsEThmBfiOYWcQJ+NwQU6wUMyy1en6b6l3DW62ANit
         y+Aha6L22poHQZmn8wAiNXxTS9sJUbSyceUVWh7IIZGoGpvR4H4Cd4OrAQ5V8+DyvzgA
         2+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6RPkQZwzCSh98zsjzzoNHs7/CVVvqXi24+J6zt37CWU=;
        b=YCEUgQVxCznJI2tb/R9ZB+63P6URpwGZiBAVVZQueB8cPScyEsRirPlxgxLf9fINiD
         PB6aZF+dQKMqOG/XfCVmysOvswcgkCACcB2+XhenDHCoHc1F1Yrn6sEpjHyw9k/QzHPZ
         C8Ni3El7o294LlL6cpJFDgRF1EpDzz/wpsPF+MpkfFUACJDVlfrqDVu56a2d6ZrGbyXl
         qF+77Llzt2gQwXJMdxE+uJu/0etFL1bU4NH6ejNUTnLbAJNNaBbGii4Aj1DaGeHtp50n
         VToX/MUurNSCwD2bxHKnd8Bq/qeUUCNSgg1Vn+eVkIXzOTUmIYpLPcwzr7OBHvIkiNT/
         vkGg==
X-Gm-Message-State: AO0yUKW3Pvm3UhhWVYJlftRpMaKv/0BTv8jkzaNJNTlC/L3YOYGNJzLU
        BpUSQaPJa+YlPzRxNQQh4wWU/0O4+b8K95ag8bukXV1/TsMgogmQyy4=
X-Google-Smtp-Source: AK7set8eYoMskBn9g7b2mHv/miX35ovEm4VxCpwXRwArxQOTNJwt7VlGy2815FzYrrg+lVY75OJlVwNGKNf/NgHNLx8=
X-Received: by 2002:a05:651c:146:b0:28a:a1d3:572f with SMTP id
 c6-20020a05651c014600b0028aa1d3572fmr771155ljd.20.1675321269189; Wed, 01 Feb
 2023 23:01:09 -0800 (PST)
MIME-Version: 1.0
References: <000000000000fea8c705e9a732af@google.com> <00000000000047848f05f3a4a32f@google.com>
In-Reply-To: <00000000000047848f05f3a4a32f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 2 Feb 2023 08:00:56 +0100
Message-ID: <CACT4Y+Z1RhbV_=cQXSRtX94R0aUuFS2LXYQ5V7CySpPxMNzfTg@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: use-after-free Read in hdr_find_e
To:     syzbot <syzbot+c986d2a447ac6fb27b02@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, pjwatson999@gmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 1 Feb 2023 at 15:55, syzbot
<syzbot+c986d2a447ac6fb27b02@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 0e8235d28f3a0e9eda9f02ff67ee566d5f42b66b
> Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Date:   Mon Oct 10 10:15:33 2022 +0000
>
>     fs/ntfs3: Check fields while reading
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1268739e480000
> start commit:   55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
> dashboard link: https://syzkaller.appspot.com/bug?extid=c986d2a447ac6fb27b02
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164e92a4880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126f7ac6880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fs/ntfs3: Check fields while reading
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix: fs/ntfs3: Check fields while reading
