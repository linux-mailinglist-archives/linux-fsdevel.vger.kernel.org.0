Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FFB55ADDA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jun 2022 02:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiFZAzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 20:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiFZAzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 20:55:08 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178D113F5D;
        Sat, 25 Jun 2022 17:55:08 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id e7so5741785vsp.13;
        Sat, 25 Jun 2022 17:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7i2SuC8HvNtahBs650x0F3fQo07SPvotbyo5SUsyEo=;
        b=j4hwxhBRkaYlDGySlH1XIgFQNXIK9ATmdGShdYo70CMyTQnTpuIK6AaffgHi0G1WrS
         yspw0QmAkmZ+iT/Nub2aifqTd4dOAiH7Zrkyz18m+TOJlcJ85Ghitwt3fmbszBv/5dv3
         Nf0gAoWEmgph1ZDEtglkh3fkTU+oa1kCE2ohk9yzbmUVabXa4mrtk+F7c3JxxpcR2xrZ
         DsUBBz5u6n7VFxCYdh1Iq0IFrNMur9GFNvcAes4cBOBps/KxbmXD6bHGHP5skNXm8hno
         UpS9/rL0oAG8itWHNbeFGk1qiZhYUx52WO0ixtR0WATnm6VM7Dq2qJ1o29zn65PN9xFv
         ++Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7i2SuC8HvNtahBs650x0F3fQo07SPvotbyo5SUsyEo=;
        b=OpsTIVpjCgSYG/i+ED5Esw/Tfgh7R/oBuXJtfX0QlrayCgbRy+XI4rAJGSlqyzP3Ej
         2/0XPVKo9D+aWfp6AdaU+Xm068nN7YXMklTwanAkACCS0xdeCnLF0Qp12S+wWz1lZ+Jx
         7cyNKfJIbeBz7li3i2rlcTgDU2SOYkLsdYJ4HB4G2wxqYFznmyy6ewiG5zPZI0X3YthE
         1sDddd27lRsfMW4kwOlSSpK7ncwMVWAPCFObRZREHnEdnJ4ASvAg44JyyOCtl0hiEx3s
         m+dQN8gasIZ0n0hMAtO0Jgauu3g7ds1ZoalQz+YCiDLqLDlyM0MKd9YydqwzdsND58ZK
         4A9A==
X-Gm-Message-State: AJIora/frAiki0I63rBim2WTqkEQvuzECjCkdAyaI22bMiAn6Kb9elax
        WTTURy1Ks0sWsAlAekV85z8w+1oEUgS7cu3AVcw=
X-Google-Smtp-Source: AGRyM1sx07oRPPmVD6FBxstCQUdbIJr5W1yPGVjkxJvEzPIyyaUN8U+dd9tpRk7sIYCyobHgA77nN1ZqRIQMrLqTsIw=
X-Received: by 2002:a67:cb88:0:b0:354:432f:1258 with SMTP id
 h8-20020a67cb88000000b00354432f1258mr2473730vsl.17.1656204906624; Sat, 25 Jun
 2022 17:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220625110115.39956-1-Jason@zx2c4.com> <20220625110115.39956-2-Jason@zx2c4.com>
 <YreI9h957ZWv99OR@zx2c4.com>
In-Reply-To: <YreI9h957ZWv99OR@zx2c4.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 25 Jun 2022 19:54:55 -0500
Message-ID: <CAH2r5mt1LSaRSSPx6xUxC=S4tATFNqdxmS-yWmfcPp+vibVRxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] ksmbd: use vfs_llseek instead of dereferencing NULL
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Steve French <stfrench@microsoft.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I just added it to ksmbd-for-next

Thx.

On Sat, Jun 25, 2022 at 5:20 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Steve,
>
> On Sat, Jun 25, 2022 at 01:01:08PM +0200, Jason A. Donenfeld wrote:
> > By not checking whether llseek is NULL, this might jump to NULL. Also,
> > it doesn't check FMODE_LSEEK. Fix this by using vfs_llseek(), which
> > always does the right thing.
> >
> > Fixes: f44158485826 ("cifsd: add file operations")
> > Cc: stable@vger.kernel.org
> > Cc: linux-cifs@vger.kernel.org
> > Cc: Steve French <stfrench@microsoft.com>
> > Cc: Ronnie Sahlberg <lsahlber@redhat.com>
> > Cc: Hyunchul Lee <hyc.lee@gmail.com>
> > Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
> > Acked-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> This commit has been reviewed by Namjae and acked by Al. The rest of the
> commits in this series are likely -next material for Al to take in his
> vfs tree, but this first one here is something you might consider taking
> as a somewhat important bug fix for 5.19. I marked it for stable@ and
> such as well. Your call -- you can punt it to Al's -next branch with the
> rest of the series if you want -- but I think this patch is a bit unlike
> the others. This occurred to me when I saw you sent some cifs fixes in
> earlier this evening.
>
> Jason



-- 
Thanks,

Steve
