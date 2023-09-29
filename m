Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A0B7B3217
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 14:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjI2MM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 08:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjI2MM1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:12:27 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8661AB;
        Fri, 29 Sep 2023 05:12:24 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4526d872941so6692454137.1;
        Fri, 29 Sep 2023 05:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695989544; x=1696594344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6AGwXiXnrUMPXklIL5nmsijRotoMkC208+2TMbjvG0=;
        b=RBxcuYGI1dv7jxQE9x20eY7D2XBeEyKX+eOQlUVeHfhGNW6j5272xeruDLqzWsxmcG
         pNQdEYcS5YDWSA9tF5hlmxQzIWbjk6OHZAfbFyoZMUUC6OftT3x8RNUcXL46gfV0YPJh
         iAUfGHY8WeZ43vGw9UPzRAKFDpQ2gATQ0UxlkFNry78m1MCTeeJ66YwUZdUqECNHsAKe
         okxM5KVvCano5BNaPaeoLWwUdsj6y0MYYR63ocSsz76Kv0+QaU6o2JU8Lf9UqoNd8Jov
         jpCFfNHGYp9fge/3fiKRHR07sNd70UXstiTEZMNP2EeckFTI/hvGOZ42YgxrMxjbZraG
         ROng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695989544; x=1696594344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6AGwXiXnrUMPXklIL5nmsijRotoMkC208+2TMbjvG0=;
        b=ea0BYpCgOXTkmWQpSsv36usDuLbvdjnSuHkylz82SLVVG49eGjJ1wxBvLJEww/wCVw
         xDwDDmbuj1RmU1oeEQ/D8/nLLSb7yM+UabBqXTvGWnhhF3Y7rPmg0rUPrxwMQ227Wys2
         Pylg9nuMdtM1oHpntvtSQZmp+ol4oqeFGXN4aXH6VkNhiJPbczH+t/JoiDbgaJ1Z4C6t
         HYzxjIO+n+FxcCY8jxXISYO8Y9Ru+iMdWKi4JKjetvl6+ZbtiAjXhTk8j5J5HcrX9rPK
         +76xbX+lRFvX54uxc/HnN5d9vH5BLELzVSw7j9YQvkw5Nbb9EivJMrDwI5d84WfnkyQ7
         lt/Q==
X-Gm-Message-State: AOJu0Yyt0DYVsqbNcJ4pFuSsT9yi3Rj3T0Ou5491BbpbB9i7IukYba5G
        gh/8E7XhQzUTyd5jPST8jzjgrE7h9DUdzot5bSU=
X-Google-Smtp-Source: AGHT+IFL72KqbSIw/G7vE5rVtmiJ3L3ZrqYM/4H/e5qUq9cV909l+/PBvNa7N1kRqgXb9QMyFQV3Xm6Xw7VpBFtehK4=
X-Received: by 2002:a67:ffc7:0:b0:44d:3bc0:f1bc with SMTP id
 w7-20020a67ffc7000000b0044d3bc0f1bcmr3884563vsq.18.1695989543918; Fri, 29 Sep
 2023 05:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230929031716.it.155-kees@kernel.org> <20230929032435.2391507-4-keescook@chromium.org>
In-Reply-To: <20230929032435.2391507-4-keescook@chromium.org>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Fri, 29 Sep 2023 13:12:13 +0100
Message-ID: <CAKbZUD1ojuNN_+x6gkxEMsmLOd5KbCs-wfJcMM==b8+k8_uD_w@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] binfmt_elf: Use elf_load() for library
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Sebastian Ott <sebott@redhat.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 4:24=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> While load_elf_library() is a libc5-ism, we can still replace most of
> its contents with elf_load() as well, further simplifying the code.

While I understand you want to break as little as possible (as the ELF
loader maintainer), I'm wondering if we could axe CONFIG_USELIB
altogether? Since CONFIG_BINFMT_AOUT also got axed. Does this have
users anywhere?

--=20
Pedro
