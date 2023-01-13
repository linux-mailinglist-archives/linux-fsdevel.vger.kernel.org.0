Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DEE6688A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 01:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbjAMAqR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 19:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjAMAqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:46:13 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600DC61455
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 16:46:13 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id jr10so10674257qtb.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 16:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2NTaM5u/ATlZU8U3e3WvV5gfzoNU+qW6R9htWny5BOo=;
        b=JoBSiJ5WmBrGf5rLKSnrJyBODh9urLGI6Wrozq8w13amzHGmJLCIBNjhwil1+JiTd9
         Mifocp28Xk6jGJoTQZeb8EdPYmi8ZC+hx7nuzLHDp0CiWD5gj+YUNdZGTpd/M7iDknuI
         +Q5T0QzxFSIXFcGfNIeJ/Er3TJJvFiw09OuR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NTaM5u/ATlZU8U3e3WvV5gfzoNU+qW6R9htWny5BOo=;
        b=R923j/nTXfYTxsKJILnlclh/NZ8dS7E3wRr1GgpkThOHuXLmJGyiQOwqzq8fSWKltM
         cYh1kWrAeAjaXl9pay6ZmwgAQLIxuOkrLVJdRBp2Ubn6nRI5RG/6AYu2pK4i7FkTFoxy
         FllV/AitK5Ic5D4MjH+1yQvTHX4XYDJsnV4GSaTS/Iq0XYECgCiK6N8k1GKlfzs6Uxz/
         1ahrk4xHBa1C28lg+IDWqe3BTxDX1EZtD1UGhjn3X3RHvRFdXmXFFwSJZMYx12a7NiPj
         xXkdlAIOJ9pkiPYY9Y1s7bYV5kcx0YH8Lt1OvGN8KjSefPjIPN3H7qluf68jNKa7ahXx
         tSbw==
X-Gm-Message-State: AFqh2koH8PU/SRJ5OxQdkMxOAVEMr0Su8l0NecfWrgo/YhV4poMxN2TZ
        IHPgvBr1WmRz1RhDkIQYnE0Hqsr6o1oo6iMFtQ4=
X-Google-Smtp-Source: AMrXdXsgZRB+ZeTVvPSwM4iPeJxQyHmHnowFxmsjaWUGm3YGq/ANGIymtDbGZvSzBhvLBVzJBBzqyQ==
X-Received: by 2002:ac8:5213:0:b0:3a9:87fa:533a with SMTP id r19-20020ac85213000000b003a987fa533amr105028535qtn.1.1673570772275;
        Thu, 12 Jan 2023 16:46:12 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id hg20-20020a05622a611400b003a81eef14efsm9778647qtb.45.2023.01.12.16.46.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 16:46:11 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id m12so11787133qvt.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 16:46:11 -0800 (PST)
X-Received: by 2002:a0c:f38d:0:b0:534:252f:b091 with SMTP id
 i13-20020a0cf38d000000b00534252fb091mr369358qvk.130.1673570771350; Thu, 12
 Jan 2023 16:46:11 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com> <SJ1PR11MB6083368BCA43E5B0D2822FD3FCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083368BCA43E5B0D2822FD3FCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jan 2023 18:45:55 -0600
X-Gmail-Original-Message-ID: <CAHk-=wg6opc5nb1qMuCO-R36Pfz_JJbx1DsU1P0cvLAeM2+eLQ@mail.gmail.com>
Message-ID: <CAHk-=wg6opc5nb1qMuCO-R36Pfz_JJbx1DsU1P0cvLAeM2+eLQ@mail.gmail.com>
Subject: Re: lockref scalability on x86-64 vs cpu_relax
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Jan Glauber <jan.glauber@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

On Thu, Jan 12, 2023 at 6:31 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> There's not much "simultaneous" in the SMT on ia64.

Oh, I forgot about the whole SoEMT fiasco.

Yeah, that might make ia64 act a bit differently here.

But I don't think anybody cares any more, so I don't think that merits
making this a per-architecture choice.

The s390 people hated cpu_relax() here, but for them it was really
because it was bad *everywhere*, and they just made it a no-op (see
commit 22b6430d3665 "locking/core, s390: Make cpu_relax() a barrier
again"). There had been a (failed) attempt at "cpu_relax_lowlatency()"
for the s390 issues.

                  Linus
