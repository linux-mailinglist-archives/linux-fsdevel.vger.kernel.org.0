Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A01703D03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 20:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244409AbjEOSuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 14:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243617AbjEOSuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 14:50:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A62A14927
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 11:50:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so19384073a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684176620; x=1686768620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ws6NzIXMgc6mtuL0Ev2TC7sDhpQ3niamKuQOa97Pto=;
        b=dNQf4mNQJGstaRt5HFm9NY1Z9cFlJtDx4rn4A6O1o9q2ytyz8Di4tln28hmXeMJjmY
         /OSWZHH37cvw1IJpldtRT00/l2c6li4yWoexs2ZIVXdBQAZf9y0tHdEXylJTYYngWuZ3
         8Lbewy36CG0002QuQawB1vuA0fRdseLywhGBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684176620; x=1686768620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ws6NzIXMgc6mtuL0Ev2TC7sDhpQ3niamKuQOa97Pto=;
        b=iDSf0eaPgWmbcTYw3e2uIp908Rs/cp06gZEnJA5oIWrgK5+JhG1yktF/5jFwaPf5OG
         na2a2I+uPpGNnHihcj+HA9Q8GbqlkIbouRkSs+moKgRiunaYmbOTKmkBvg4QcUlmRENr
         zb9k//WHUpsZMXpNJKTunxsgPHOOa2HrGZiitErSmfGf99QyRbd8QjAURSQRFjhYu1yr
         K7ta8f/B9vJvD3MbaXqQJzieZ2LIa2K9NJ+YirszeKRraezCQ40cvyqGnzuY147xFZ3v
         VdvNhbOSxZyIzrLrRLZ7jygsNLMLaLWEjqMMR6yl0cew0PV+WdCS9TrED0yETXXiBbfv
         QU0A==
X-Gm-Message-State: AC+VfDxZA2pKMw9Ej54G332OmS2xxEoDn+pMTNj5mVjCmmxmQ/pmXiEh
        Q8JhtM3+mG1QLa4q+vK3hVShhhPef3e8QM+4dpxQbjRV
X-Google-Smtp-Source: ACHHUZ7E8EJvaOm/bSpokUv6oeWprWjk+4bFF5SiNoVG42PlXAoClTequHlE4VW+dZX7MGRBzueIxw==
X-Received: by 2002:a05:6402:3d7:b0:50b:d861:50b3 with SMTP id t23-20020a05640203d700b0050bd86150b3mr26750374edw.4.1684176620273;
        Mon, 15 May 2023 11:50:20 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id n21-20020aa7c695000000b0050bdd7fafd8sm7637159edq.29.2023.05.15.11.50.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 11:50:19 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so19384041a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 11:50:19 -0700 (PDT)
X-Received: by 2002:a17:907:7251:b0:969:cbf4:98fa with SMTP id
 ds17-20020a170907725100b00969cbf498famr24087257ejc.65.1684176619210; Mon, 15
 May 2023 11:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230420120409.602576-1-vsementsov@yandex-team.ru>
 <14af0872-a7c2-0aab-b21d-189af055f528@yandex-team.ru> <20230515-bekochen-ertrinken-ce677c8d9e6e@brauner>
In-Reply-To: <20230515-bekochen-ertrinken-ce677c8d9e6e@brauner>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Mon, 15 May 2023 11:50:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRmfEmUWTcVPexUk50Ejgy4NCBE6HP84eckraMRrL6gQ@mail.gmail.com>
Message-ID: <CAHk-=wiRmfEmUWTcVPexUk50Ejgy4NCBE6HP84eckraMRrL6gQ@mail.gmail.com>
Subject: Re: [PATCH] fs/coredump: open coredump file in O_WRONLY instead of O_RDWR
To:     Christian Brauner <brauner@kernel.org>
Cc:     Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ptikhomirov@virtuozzo.com, Andrey Ryabinin <arbn@yandex-team.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 15, 2023 at 10:55=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> So that open-coded 2 added in commit 9cb9f18b5d26 ("[PATCH]
> Linux-0.99.10 (June 7, 1993)") survived for 23 years until it was
> replaced by Jan in 378c6520e7d2 ("fs/coredump: prevent fsuid=3D0 dumps
> into user-controlled directories").

Hmm.

I can *not* for the life of me remember anything that far back, and
our mail archives don't go that far back either.

It's strange, because the "O_WRONLY" -> "2" change that changes to a
magic raw number is right next to changing "(unsigned short) 0x10" to
"KERNEL_DS", so we're getting *rid* of a magic raw number there.

Which makes me think it was intentional, but I don't know why it
wouldn't have used O_RDWR instead of "2".

Back then we did *not* have O_EXCL in the core file creation flags, so
I'm wondering if it was some half-arsed thing as in "do not allow
core-files to overwrite non-readable files in-place".

They'd still have to be *writable*, though, so that still seems more
than a bit odd.

I have this *dim* memory of us having had filesystems that required
readability for over-writing existing file data (because we'd do a
read-modify-write for the page cache, kind of like how you can't have
write-only pages on many architectures).  But while we didn't have
O_EXCL, we *did* have O_TRUNC, so that should be a non-issue.

I don't see a problem with making it O_WRONLY. Like it was 30 years
ago. But that unexplained "O_WRONLY" -> "2" annoys me. It does feel
like there was some reason for it.

                Linus
