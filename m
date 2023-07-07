Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5046F74A855
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 03:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjGGBFJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 21:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGGBFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:05:08 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9677172B;
        Thu,  6 Jul 2023 18:05:07 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b701e1c80fso19747241fa.2;
        Thu, 06 Jul 2023 18:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688691906; x=1691283906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYb8pkOBGP1EJ3nocPnr3UcOhKvcfSMeqRADnHqQHIQ=;
        b=a6AAN4KQP1uNvrWfmMjQtDbf3TiayxiwhBRrfP1MV0DQrUQ1UjQw0Y10mzbP9ttqtA
         3vCvil1gRMOgdX5mYLuNwekB64R740Kz675bOPHx7bylAq5dRPnwcFcUX/5PgCsP0MSQ
         1/wdp+uLUkP0huNUl/g5ngKrQPEJhMzm8+ysfZ/Eeo5BIN86cuKraeztVzd82gsCVeSE
         ne5pg1bMeww4o7tYx3sp4/3r0BGhX+mjyPA0yCP1VbmqQ/8uk/Hj1GCu423r9CIqHAWJ
         lCcYX1gJSzpZt+2lEtDpx+I3ngoGPmMNIbvO2eeZ+hsIPL84F+0fdnOnnTLAULb75fwu
         JFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688691906; x=1691283906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYb8pkOBGP1EJ3nocPnr3UcOhKvcfSMeqRADnHqQHIQ=;
        b=H2kY9FlfxkBLHQg2V0M++bvp6d2I8RnG/IHuVc9t6AqYuM17vkj9J24+Z27uv7ShN/
         8DNZwna9I7V+6blAgvP6TgQ0/CTYpR8KP30gut6zdlexAxsQVAxvKoqWD/oj4vMYHFGo
         CRe+jOgLZVpd3semwyRNHjyD6H4kPx9eySleIU4g/OSPd549ynFnBWW7X19KwsDubL7x
         FtVU7c4OjISlb/5sqlFns5s4e4YD5wk3QM9M+BLHW6pebEJI2+kqkW8CJ7unJQcnZGh1
         4AHrpMiImAzTvRPSqnt75rRqNZdjehYR0+Vh9mgUO9IMchSyrdJWbw9CjOOl5LTGfMzh
         TwhA==
X-Gm-Message-State: ABy/qLZt/VJDLHlVO771VOXnGN7QW8/daJfcv18rddRnOcfvqDLI6ofZ
        k4soL+CD0NkxHbg93IPS00s2JaDlA0rgpYNnND2rUMTvupQ=
X-Google-Smtp-Source: APBJJlGEVr3hVv7xnsr4Eu2o79CaQ4pQfHz/RROOupHu0mrsJa+ZG6dOt4pSO3yK9ERTc2upgBVrlUBMjKBM1+OE7rc=
X-Received: by 2002:a2e:98c7:0:b0:2b6:e2c1:9816 with SMTP id
 s7-20020a2e98c7000000b002b6e2c19816mr2806645ljj.20.1688691905689; Thu, 06 Jul
 2023 18:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <c35fbb4cb0a3a9b4653f9a032698469d94ca6e9c.1688123230.git.legion@kernel.org>
 <babdf7a8-9663-6d71-821a-34da2aff80e2@huaweicloud.com> <20230704-anrollen-beenden-9187c7b1b570@brauner>
 <CAADnVQLAhDepRpbbi_EU6Ca3wnuBtSuAPO9mE6pGoxj8i9=caQ@mail.gmail.com> <20230706-raffgierig-geeilt-7cea6d731194@brauner>
In-Reply-To: <20230706-raffgierig-geeilt-7cea6d731194@brauner>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 6 Jul 2023 18:04:54 -0700
Message-ID: <CAADnVQ+N4oiar+V7cKwTSZ9t8mnxnoVoXR3HCL8_65pLfZWwqA@mail.gmail.com>
Subject: Re: [PATCH v1] fs: Add kfuncs to handle idmapped mounts
To:     Christian Brauner <brauner@kernel.org>
Cc:     Hou Tao <houtao@huaweicloud.com>,
        Alexey Gladkov <legion@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
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

On Thu, Jul 6, 2023 at 12:22=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> push for. But you have to admit that this out-of-tree portion is very
> hard to swallow if you've been hit by out of tree modules and their
> complaints about removed EXPORT_SYMBOL*()s.

I don't remember a single case where somebody complained so hard
about unexport of a symbol that it was reinstated.
Instead there are plenty of 'unexport foo' in every kernel release.
Like commit 4bb218a65a43 ("fs: unexport buffer_check_dirty_writeback").
Surely they break some oot mods, so what? Complaining doesn't help.
