Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30266F281A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Apr 2023 10:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjD3I5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 04:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjD3I5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 04:57:06 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A147198A;
        Sun, 30 Apr 2023 01:57:05 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-42c38a6daf3so1216989137.3;
        Sun, 30 Apr 2023 01:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682845024; x=1685437024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUB0ZCgq7Eu2qwsPwj7EOgIJn0k0QzLGub9moHFprfg=;
        b=IKzMwuqCXqYo7KPZ0aOneffwkOjNhrCOy/Wucxu6h+1JX6Y/TAlsJopjbeV0hhxwsd
         wnhjqXIX8e+g05MN9FQpE5UDIZjjONwvuXpcAY5mogLejPv1V/dTXbz26JcG2akS0f5z
         WpBIu+uPIjvNryFK2/6xeLCLPMafSOLixvWq1ABeTpGRivB1SuFpL6xBTz6KzjlR1yfJ
         Zc2Lkx0rcKZxtIl/t8+YfGDPervChOsk7jn090O0VGMSoNqiv19WNblI28cXWLFiQhBk
         zCrfjjkd/0wASLaN7wMzKjPyasBnjiBxyNrr4+tK73OIhHAUjRukqfo3nAKYs/G4hNIF
         hFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682845024; x=1685437024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUB0ZCgq7Eu2qwsPwj7EOgIJn0k0QzLGub9moHFprfg=;
        b=Jqt2ZDunA2JhO1subQbvzFl6+OcuCjTnY0nL7HZjEM4z8Ek2tRY0x5F31/NPo3UT0Z
         qq/79kV2lQ9eCROtnhzbwd87skGoTPZvphOQz+TqAsVVcPy6hcZ39ZnK3NA4ezZgRuAm
         6wzWJftQTI7C8ok6D8nCXGd/ZHfiH+Bi27GxhHzLxQctzsUWur5qVSv3eyiDNCc85NU5
         b7z9swmcRkvCwZF8K+NQdD/eXMOn+uFTwVenTaoW4ivjhCQbW93USHARIgqRgd4MxaBP
         Myoz0Pq07fSMBhtj6Bp/JqmC08vDZ6irwXixq6EvS3qoSfbNj2tVhEBiktmvjbPOm12S
         xaZg==
X-Gm-Message-State: AC+VfDzSKwkhWqZ+GEYi44sWS9eJYoNhYihr3306nJTyDxQ3jpw9N/Va
        8fUKKykfk1gsuKCyWb1M4F78Rwno8r92K3jELy8=
X-Google-Smtp-Source: ACHHUZ7TzXRW1JQTChKRJRNGkUYctSNDbhTbILvFz8rAKVy9G5YV10tEQNOn9aCGjzsbyrm/1InzGAhX+Broblv2hn0=
X-Received: by 2002:a67:f88f:0:b0:430:6bdc:ee24 with SMTP id
 h15-20020a67f88f000000b004306bdcee24mr4748660vso.18.1682845024244; Sun, 30
 Apr 2023 01:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006de361056b146dbe@google.com> <ZE4LZP5V/TGMoRwz@mit.edu>
In-Reply-To: <ZE4LZP5V/TGMoRwz@mit.edu>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 30 Apr 2023 17:56:47 +0900
Message-ID: <CAKFNMonK2VcZx=KEG8cz61bhwMvChEJ=T+FecxpGg1QiRCcZhA@mail.gmail.com>
Subject: Re: INFO: task hung in lock_mount
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     syzbot <syzbot+221d75710bde87fa0e97@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 30, 2023 at 3:59=E2=80=AFPM Theodore Ts'o wrote:
>
> #syz set subsystems: nilfs
>
> Per the information in the dashboard:
>
>         https://syzkaller.appspot.com/bug?extid=3D221d75710bde87fa0e97
>
> There is no mention of ext4 anywhere, and nilfs does show up in the
> stack trace.  So why this is marked with the lables "ext4", "nilfs" is
> a mystery.
>
> Fix it.

I don't know why it got the ext4 tag.
As you say, it looks like an issue on the nilfs2 side.  I will
identify and fix it.

Regards,
Ryusuke Konishi
