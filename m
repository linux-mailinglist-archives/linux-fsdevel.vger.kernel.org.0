Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357B36C2473
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 23:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCTWRu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 18:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCTWRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:17:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C385036470
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 15:17:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn12so7065781edb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679350627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPrDTO6iMVUmjsFudsdQ6YBX68bwKPdUhbwstJv4XRI=;
        b=Np6qEHO9voE7U22P996b3r7yR776TvxEhHp76fMnrlk6RVjxDJJ7c00Tg/LRky+UFp
         aHD51lSKBYo/vUXG/Y02MD7FfkKaxZbqbMoQoSZhrnMAXrosZ+csacZqdCFfExV4P+Yd
         pDnftu0zAKQr8fbspXKRMvEqn0TelHl28lrEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679350627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPrDTO6iMVUmjsFudsdQ6YBX68bwKPdUhbwstJv4XRI=;
        b=5pjhocPthp+bhybViEzDAhKZmCPVG/EukeEqJPV4z7cU2N0+HHZ2/G63aUnjZfktxh
         5YscClcZ2N3XOLmFiOQexflug8/YnUlEmEckXutK5peTHZzWEpJZU0bDzO4TbAuoFNw/
         DLt6EGQZPmytZWHsNNUWsk/DCJCOG0fxTWYQw46r3yS9mKN4XrIAbTdwwZERYfVZgRG6
         7Os+EnT1Xavn95g7YT772UCX/6OXgjGjaiGg9gZAKr/81+dgRWgZ4B5IiX88KcSDJTof
         wZWSwOmWvqwbwpAew+hsh7Ti2wA53yqxvS5dy8WDhGQDeKg09s2/Bq/roU1TpbDcmPTF
         jKHQ==
X-Gm-Message-State: AO0yUKUCidOg6AMtpg1idapaSD9jNlAtIdzT6TKIWAKKKT6A0eRykJBV
        IPIKcNw46/1jXRveUWIJdO6qLwWUI2W3spqwqI9/91hy
X-Google-Smtp-Source: AK7set/Egh8M3S8HoTIfXAl4QyeKuCJ+2nxuZxyBT1AV2pe98s6YGkufZ27iY5AY3dDax4/tgdeR2Q==
X-Received: by 2002:a17:906:9bd3:b0:931:85f8:6d00 with SMTP id de19-20020a1709069bd300b0093185f86d00mr551571ejc.47.1679350626852;
        Mon, 20 Mar 2023 15:17:06 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709061c8700b0091f5e98abd5sm4948633ejh.133.2023.03.20.15.17.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 15:17:05 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id w9so52738461edc.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 15:17:05 -0700 (PDT)
X-Received: by 2002:a50:9546:0:b0:4fb:2593:844 with SMTP id
 v6-20020a509546000000b004fb25930844mr582214eda.2.1679350625492; Mon, 20 Mar
 2023 15:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230320205617.GA1434@sol.localdomain>
In-Reply-To: <20230320205617.GA1434@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Mar 2023 15:16:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com>
Message-ID: <CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com>
Subject: Re: [GIT PULL] fscrypt fix for v6.3-rc4
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 20, 2023 at 1:56=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
>       fscrypt: check for NULL keyring in fscrypt_put_master_key_activeref=
()

Side note: please just use WARN_ON_ONCE() for things like this, not WARN_ON=
.

If it's triggerable, it should be triggered only once rather than
flood the logs and possibly cause a DoS.

And if it's not triggerable, the "ONCE" doesn't matter.

I note that fscypt in general seems to be *way* too happy with
WARN_ON() as some kind of debugging aid.

It's not good in general (printf for debugging is wonderful, but
shouldn't be left in the sources to rot for all eternity), but it's
particularly not good in that form.

              Linus
