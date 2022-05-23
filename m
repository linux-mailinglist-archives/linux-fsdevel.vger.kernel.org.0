Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C416531DE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 23:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiEWViH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 17:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiEWViG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 17:38:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024153DA71
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:38:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id wh22so31384743ejb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+pDB7M6X0Bo+ckmLhNnRpVGTZouHeg25AL10b8YNt/o=;
        b=cWo7Dr7bYrxAjD0PkifptFtVrBNucnAsRedwML58x/SE1Ue9j8yjI37ttZUlFziXDc
         XD1X+7iynb7SyPiTuf4aNcG3T3O7Dfd32WdGNKhQH4H8mgraz2vDVe+U13w4vyZfTi7I
         yulr9l27/ALpuACmJZpxA6H7NgS+mLP5rI4is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+pDB7M6X0Bo+ckmLhNnRpVGTZouHeg25AL10b8YNt/o=;
        b=U8I+DRqk8YQS3u3589QgHQPRv8qFuQT2jItXKDnDDCxyENDhzYkhGsPOTqDmlOr4RT
         988BSYknuboq/VQ1FHAcj1KFz2ZnEEtRjQNHL/i/+SG/meltUtGOU4Gf1q+3nIEw51wk
         UxN92cIfqPyHDj+H8FumbWcD5MxdpPAu6EVzR7Ov+2D/UUv/8kW+tuRIC59rrknyQtcB
         b+JhzuxbXzaBrXOV/WhbP896KingFJON4HNz6hUKI9XnkRifE05ruJ0Np4qAkbFAcr53
         1WY+18ubGkRUBfQjv2d7gv5NbKL3e04EGG1lD8pzA/1vlEk2VzJAZc4E3HWpDu6Qk7/X
         O33Q==
X-Gm-Message-State: AOAM533bXUX+fFmOIwKaTp2gf5PKOsOJquJoTZucI8zGRXwk49LgNipI
        odf3jO57afhWcYGYZjzZi2CpRQ3IkvNtAPepspI=
X-Google-Smtp-Source: ABdhPJw0mbp9qVpyOVahh6f7V9JCI11YZSdfB7ZVeCiEZPavseBdA2bllwMRx2SCMbwLx/CKmtUF4Q==
X-Received: by 2002:a17:907:948e:b0:6fe:27b:bc8f with SMTP id dm14-20020a170907948e00b006fe027bbc8fmr21808947ejc.715.1653341883234;
        Mon, 23 May 2022 14:38:03 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id de22-20020a1709069bd600b006fe9ec4ba9esm4736897ejc.52.2022.05.23.14.38.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 14:38:02 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id u3so23146024wrg.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:38:02 -0700 (PDT)
X-Received: by 2002:a5d:58cc:0:b0:20e:643d:e46a with SMTP id
 o12-20020a5d58cc000000b0020e643de46amr19861690wrf.97.1653341882363; Mon, 23
 May 2022 14:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220523050144.329514-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220523050144.329514-1-damien.lemoal@opensource.wdc.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 May 2022 14:37:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4zrBLr+2qN+se+F-FKRc9dUfYnv18szvtZiJiVemWOQ@mail.gmail.com>
Message-ID: <CAHk-=wh4zrBLr+2qN+se+F-FKRc9dUfYnv18szvtZiJiVemWOQ@mail.gmail.com>
Subject: Re: [GIT PULL] zonefs changes for 5.19-rc1
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 10:01 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> Note: I made a mistake during this PR preparation and inadvertantly deleted the
> for-5.19 branch used for this PR. I recreated it and prepared the PR using this
> newly pushed for-5.19 branch. All patches have been in linux-next for a while.
> I hope this does not trigger any problem on your end.

Grr.

That seems to be the cause of repeated commits, which in turn then
caused conflicts because you had further changes.

IOW, I already had gotten

  zonefs: Fix management of open zones
  zonefs: Clear inode information flags on inode creation

from the block tree (your commits), and your branch now had different
copies of those commits.

And you don't actually list those commits, which makes me think that
you then did some manual editing of the pull request.

The duplicate commits with identical contents then caused commit
87c9ce3ffec9 ("zonefs: Add active seq file accounting") to show as a
conflict, because the different branches did *some* things the same,
but then that commit added other changes.

And honestly, I think that commit is buggy.

In particular, notice how the locking changes in that commit means
that zonefs_init_file_inode() now always returns 0, even if
zonefs_zone_mgmt() failed with an error.

The error cause it to skip "zonefs_account_active()", but then it
returns success anyway.

Was that really intentional?

I've merged this - with that apparent bug and all - because maybe it
*was* intentional. But please double-check and confirm that you really
intended zonefs_init_file_inode() to always return success, unlike the
old behavior.

                  Linus
