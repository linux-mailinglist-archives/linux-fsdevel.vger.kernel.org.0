Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB5666A71F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 00:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjAMXcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 18:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjAMXcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:32:00 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7038A211
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 15:31:58 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id e22so7919339qts.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 15:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FHJQSZN4Bz+51gS5J/dgy+JvIN/TZACnZnBolQHY7qg=;
        b=ap6EJUwREOlU5i8xCoqE59xQpluVaQp4H3tZIiWw7hYEabyjR5uVqMXZ9Z/5fcK8QE
         Z3f8Enc9PSFEd68x16B1jr3iTPdmgOfae8hFGFvidTcr6vuuJ/5gYGpYd+JjWFaB0wrn
         aUwHfh+rascZKjkcvsQmsyHAiD6RBZYebLg8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHJQSZN4Bz+51gS5J/dgy+JvIN/TZACnZnBolQHY7qg=;
        b=oS53yELdUH+hJgSeLQ5kPXMI1d7BcEQbwaTjmAtiZaazJPnmZDwPACjCeT1n98hgy0
         vdRjLDspfujhm9qQX7lfGuvBkfl+8Qo5k9uCgAV64fNnwehXovRvVxJ/8CKgvDWU7QZY
         eMtvMeGnrJOtP+NxYTnvNNBQGJfU8SjSXKheMbOB4ullsUm1RWTzXK1MuHLbPBQ7znEB
         hIoG7ynBF0nyAw6jijYGLwNEGi74bFzcK0ubaLSdoTczvo9nhnvr8TS+nEXQLmPgRIFT
         c6bMl+wST8X8qqRfBL2oMmlmHlWmFpotMz26Qpw9zFfgrgJvNvaK6W60Z0T6uuTiiZBR
         GdAQ==
X-Gm-Message-State: AFqh2krb+9lJsK2e+y31wS1kSFJiWxm75oxzR/dGx5aE8yCpkNhj3jfa
        N0E/Fpy3UQ0jRvOlbQocKIhIJUAnC+duE7dl9Mg=
X-Google-Smtp-Source: AMrXdXvS2MYrh3tzzcbtYfZZmSGc7sEBHxhZZmID9Pn3hIIq0nSanPiTX5aDxlIbuYGlRo1eYdio2A==
X-Received: by 2002:ac8:4d44:0:b0:3af:4d45:b73 with SMTP id x4-20020ac84d44000000b003af4d450b73mr20900698qtv.33.1673652717025;
        Fri, 13 Jan 2023 15:31:57 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id d8-20020ac84e28000000b0039c7b9522ecsm11235237qtw.35.2023.01.13.15.31.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 15:31:56 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id p12so11624005qkm.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 15:31:56 -0800 (PST)
X-Received: by 2002:a05:620a:4720:b0:6ff:cbda:a128 with SMTP id
 bs32-20020a05620a472000b006ffcbdaa128mr4443110qkb.697.1673652715770; Fri, 13
 Jan 2023 15:31:55 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
 <20230113184447.1707316-1-mjguzik@gmail.com> <SJ1PR11MB6083B48A2B2114EF833D69E2FCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083B48A2B2114EF833D69E2FCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Jan 2023 17:31:39 -0600
X-Gmail-Original-Message-ID: <CAHk-=wgTsc5z3cPo7+t2kRO1uRQML1w_o72nefyHOh8VMhqu0A@mail.gmail.com>
Message-ID: <CAHk-=wgTsc5z3cPo7+t2kRO1uRQML1w_o72nefyHOh8VMhqu0A@mail.gmail.com>
Subject: Re: [PATCH] lockref: stop doing cpu_relax in the cmpxchg loop
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "jan.glauber@gmail.com" <jan.glauber@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "will@kernel.org" <will@kernel.org>
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

On Fri, Jan 13, 2023 at 3:47 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> The computer necrophiliacs at Debian and Gentoo seem determined
> to keep ia64 alive.
>
> So perhaps this should s/cpu_relax/soemt_relax/ where soemt_relax
> is a no-op everywhere except ia64, which can define it as cpu_relax.

Heh. I already took your earlier "$ git rm -r arch/ia64" comment as an
ack for not really caring about ia64.

I suspect nobody will notice, and if ia64 is the only reason to do
this, I really don't think it would be worth it.

              Linus
