Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82416F5DF2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjECSaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjECSaF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:30:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD5D83C0
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 11:29:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1062962466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683138568; x=1685730568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKqR2DGNy5P181vP5/oL8+jtEnGqbzk0DswhgBhpOjQ=;
        b=ZVQ1sxNtqw1RaAZBE9mujyzisTqwBypxILrp46qiawseDsQ39TRILvads96CyyPEdN
         zW29Csw+vRnNDcJdzF7U4P9nRw/+gte09HmBymPWlGumJ/dZxr8/tmyAKXPg0B/cKh17
         jmmTVczW18Jx2/hJusH6JVlkOXcryE4Psum+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683138568; x=1685730568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKqR2DGNy5P181vP5/oL8+jtEnGqbzk0DswhgBhpOjQ=;
        b=GQ6CNWZ0WHA7eSWvX5tFk5lZHa/zyqh621N0hTfakSXByTsCbOhS/5jJFe4ecms+yw
         yRPpOLf8aUFmNuuZ2AM00eyVKDGIMgStmYcPCF4FcDC589NpB+JQ/ZszAhbWx2VYhMLe
         8VhxEwnn4tgklBZzI9FyGwobmQz46kv60oZX654RaaavXUc+buBisO7tMRVUS3FqsWAo
         pIqaf5vANkTetAFnPAQSq9c3M5JUxXPruEhVfg8Ip00BZHg7S87h+myHPyoVOKcUmBTM
         9kXR9beGRZaR8EThgzH890wrDPX4nUnFhkVMzS9Zqnq3JpDhynsf23kZ/Wi36ojBoW8u
         OaeQ==
X-Gm-Message-State: AC+VfDzwun/+mluwMeHs5bSFjxAN9eO8LuS11GqS+uzuQCIcXov1Jmmz
        GitnsGwnS+AwJalu9ts8egTbzjUjcDD8r+4jQ9q3lg==
X-Google-Smtp-Source: ACHHUZ7/SK9qb74yDXRvBO6ydO8kCweowqDlB3YZ1JOnrwMHsPPdZ3AFrw3vBV5CH7zm3Iq00pl01w==
X-Received: by 2002:a17:907:25c5:b0:931:95a1:a05a with SMTP id ae5-20020a17090725c500b0093195a1a05amr3766036ejc.62.1683138568148;
        Wed, 03 May 2023 11:29:28 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id ce17-20020a170906b25100b009532427b35asm17674240ejb.7.2023.05.03.11.29.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 11:29:27 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9659f452148so13315566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 11:29:27 -0700 (PDT)
X-Received: by 2002:a17:907:74d:b0:94f:250b:2536 with SMTP id
 xc13-20020a170907074d00b0094f250b2536mr3524559ejb.28.1683138566776; Wed, 03
 May 2023 11:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230503023329.752123-1-mcgrof@kernel.org> <ZFKKpQdx4nO8gWUT@bombadil.infradead.org>
In-Reply-To: <ZFKKpQdx4nO8gWUT@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 May 2023 11:29:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGT-jpLRH_W+k-WP=VghAVa7wRfULg=KWhpxiVofsn0Q@mail.gmail.com>
Message-ID: <CAHk-=whGT-jpLRH_W+k-WP=VghAVa7wRfULg=KWhpxiVofsn0Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] sysctl: death to register_sysctl_paths()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        ebiggers@kernel.org, jeffxu@google.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 3, 2023 at 9:24=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> On Tue, May 02, 2023 at 07:33:27PM -0700, Luis Chamberlain wrote:
> > You can give it a day for a warm fuzzy build test result.
>
> 0-day gives its blessings.

Well, it's not like I can pull anyway, since you didn't actually say
where to pull *from*. And I don't want to randomly apply patches when
I know you have a git tree for this.

So please do a proper pull request.

              Linus
