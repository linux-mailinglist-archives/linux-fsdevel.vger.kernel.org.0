Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E47555EAF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 19:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiF1RXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 13:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiF1RWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:22:43 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A050F39150;
        Tue, 28 Jun 2022 10:22:41 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id j26so6279929vki.12;
        Tue, 28 Jun 2022 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3LqF8NENdv3ZbRw2Sj3/kRmJ0J3jtBc62PZoGx3otU=;
        b=L8NY4ZiWFjGE2TKXmM7XXAHnNVsfwk/uUmcUuSDDu+7scgids0LQm1nn8F0A1nPk/U
         DmodyKsqxv4HEnzKN5xCyE9X9KmusBZQTUOaUL/QrkbQMJYD9tndku+9oJO4qeEeBBGV
         cX2o0wm2CjrSCS1v9NOE/ZAIwT/MWDGB1ir4Qh3ipPN4u7w84/XdqJZKZiZ7fgxWDayf
         o9pSJKAfQj+0iIalZZmUoc3jYBxDfLTg8duFv7WbKVXAcupfVPQHWhFp1w4Duz6++PaM
         uFenfAIhI7kqziob3QZaimWI1zPUFKiPHjSnqTcSjPelNTpzfDAN8jH76z4uv63auGY3
         6D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3LqF8NENdv3ZbRw2Sj3/kRmJ0J3jtBc62PZoGx3otU=;
        b=SmlbU4q0n/MqYZWQNRCrnoOBY32E+22DQb7sicx3hsqhkIkNECzurkndHmu1PriFep
         aGjJF1jAGGC40OHLXaFM2PenmksrBalZ6at0HTMZ/jZWDDswhmgnqK3MZbYt/KkAnXWi
         DHbKxBID689vd9O6n2mBONKBjwYrIjJD2ZPMVdGERv4uayH68vvQB84z6uD22ZsvbhjZ
         rOgBXBCEx/Z3bNuOUaUx5rRRcJ3kQOoFcX/LvWIbG+ZDUceYawq3Q9TWJWLWD3m7c+XY
         gnJYhSH7pnLeEIzAhekQBLS8pGOEX0lH+ZGea9ZBB94CYmXSA2s2d+6hk85YTbqItDwY
         Zt5A==
X-Gm-Message-State: AJIora9AUlonZ3yrX+3mgHYGy1b4S5/PKH8kzKLZ4x0+3EqCuhH+nN9z
        XX7yuhQaGHKjlnC8BFFO7Vn1si1PonBLVd16Pvo=
X-Google-Smtp-Source: AGRyM1tMa9NH5pbykgk7C2ezmBN1dLxr/+bMphMin2oLfnJYA1n++THdM+mwLvXP24Rl85+wigGiGUs/Wb7NvbheyfA=
X-Received: by 2002:a1f:a094:0:b0:36c:e403:52eb with SMTP id
 j142-20020a1fa094000000b0036ce40352ebmr2214095vke.36.1656436960570; Tue, 28
 Jun 2022 10:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220627174719.2838175-1-amir73il@gmail.com> <20220628092725.mfwvdu4sk72jov5x@quack3>
In-Reply-To: <20220628092725.mfwvdu4sk72jov5x@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Jun 2022 20:22:28 +0300
Message-ID: <CAOQ4uxj4EFTrMHfVY=wFt9aAJakNVQA6_Vq-y-b7yvB0tEDsiQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: refine the validation checks on non-dir inode mask
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
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

On Tue, Jun 28, 2022 at 12:27 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 27-06-22 20:47:19, Amir Goldstein wrote:
> > Commit ceaf69f8eadc ("fanotify: do not allow setting dirent events in
> > mask of non-dir") added restrictions about setting dirent events in the
> > mask of a non-dir inode mark, which does not make any sense.
> >
> > For backward compatibility, these restictions were added only to new
> > (v5.17+) APIs.
> >
> > It also does not make any sense to set the flags FAN_EVENT_ON_CHILD or
> > FAN_ONDIR in the mask of a non-dir inode.  Add these flags to the
> > dir-only restriction of the new APIs as well.
> >
> > Move the check of the dir-only flags for new APIs into the helper
> > fanotify_events_supported(), which is only called for FAN_MARK_ADD,
> > because there is no need to error on an attempt to remove the dir-only
> > flags from non-dir inode.
> >
> > Fixes: ceaf69f8eadc ("fanotify: do not allow setting dirent events in mask of non-dir")
> > Link: https://lore.kernel.org/linux-fsdevel/20220627113224.kr2725conevh53u4@quack3.lan/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Thanks! I've taken the patch to my tree.
>
>                                                                 Honza
>
> > [1] https://github.com/amir73il/ltp/commits/fan_enotdir
> > [2] https://github.com/amir73il/man-pages/commits/fanotify_target_fid

Mathew and Jan,

Please let me know if I can keep your RVB on the man page patch for
FAN_REPORT_TARGET_FID linked above.

The only change is an update to the ENOTDIR section which ends up like this:

       ENOTDIR
              flags contains FAN_MARK_ONLYDIR, and dirfd and pathname
do not specify a directory.

       ENOTDIR
              mask contains FAN_RENAME, and dirfd and pathname do not
specify a directory.

       ENOTDIR
              flags  contains FAN_MARK_IGNORE, or the fanotify group
was initialized with
              flag FAN_REPORT_TARGET_FID, and mask contains directory
entry modification
              events (e.g., FAN_CREATE, FAN_DELETE), or directory event flags
              (e.g., FAN_ONDIR, FAN_EVENT_ON_CHILD),
              and dirfd and pathname do not specify a directory.

Thanks,
Amir.
