Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B165A797D98
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 22:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbjIGUwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 16:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239373AbjIGUwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:52:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49E01BCE
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 13:52:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9936b3d0286so178426566b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Sep 2023 13:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694119929; x=1694724729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D+L9op70z4Tpmb4XlT5693A5llhh03vxW4gvGPs2i44=;
        b=AArLCjcbLc2cQGPDtIHz8MDWZwtvD675aYPWuf/aEjpGAmrBsGa1iSXreWEbR0IgJg
         KGfwWK/+FunAjqoJRXLggPuDbxU9rLDwrds5pR/uCeCYG7jyiOFlQ0pCoMwaZ1cuwS4P
         MZuAmmVNloi19QGas0WaHZhBfEzD1PQo8RYQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694119929; x=1694724729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+L9op70z4Tpmb4XlT5693A5llhh03vxW4gvGPs2i44=;
        b=Fp2Uzpcf4dxtGAn/b4QLGzE/iCA0/f7sqr2OQxMMaZRskugHu+1Ukij1GbVZkYpUY7
         hkKllt+GJSo84/0X6rczB2jHTUZlkwPHj3kiJycqBKfs2z6DlJ0EtN0NkaX4znOpYIMb
         nm42f/GNdT2pkjlBwmKbUB599nIFcFFpcxjo1bIosm30yDiwNKGrxRnecoSa9kT1dIo7
         jnqEpLCzovwpGMxpNh+D3h/FaJncZ2M1drstehbqZYAbd6QuR89AOojZCihkupKt91cQ
         4df/M6qF9Nu0cQO+QwZqhvrsuVi0Ps0DsSisx2JES0z7ifdrAm9Ung1cTGPhKYMIE+Jz
         7WSw==
X-Gm-Message-State: AOJu0YxGXHnRgJSvY+wgAzMvWdX12wsBFMp9tuPXta5zxWFKbAsHLTL3
        lP16cmuIhr/840Rf4MlZBgodnHUa7tAH6R1Em0REcGjC
X-Google-Smtp-Source: AGHT+IFGnR7K8piQmT18btkhijkpSFCXUb6zc4ScQ2vnLv6TQhdqXOyYCuTZ98zvWg7htRkCjCDs9g==
X-Received: by 2002:a17:906:32c7:b0:99b:d0dc:7e68 with SMTP id k7-20020a17090632c700b0099bd0dc7e68mr371935ejk.72.1694119929168;
        Thu, 07 Sep 2023 13:52:09 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id e14-20020a1709067e0e00b0098f33157e7dsm105870ejr.82.2023.09.07.13.52.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 13:52:08 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso1852905a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Sep 2023 13:52:08 -0700 (PDT)
X-Received: by 2002:a05:6402:156:b0:52d:212d:78ee with SMTP id
 s22-20020a056402015600b0052d212d78eemr314041edu.25.1694119928158; Thu, 07 Sep
 2023 13:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com> <20230907203718.upkukiylhbmu5wjh@moria.home.lan>
In-Reply-To: <20230907203718.upkukiylhbmu5wjh@moria.home.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Sep 2023 13:51:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnjyOOU+NDcJy5Q7kQrA65UQQJCYUYADbr1Pz7up-8mw@mail.gmail.com>
Message-ID: <CAHk-=wjnjyOOU+NDcJy5Q7kQrA65UQQJCYUYADbr1Pz7up-8mw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
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

On Thu, 7 Sept 2023 at 13:37, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Linus, I specifically asked you about linux-next in the offlist pre-pull
> request thread back in May. It would have been nice if I could've gotten
> an answer back then; instead, I'm only getting a definitive answer on
> that now.

I may not have answered because it was so *obvious*.

Was there really any question about it?

Anyway, the fact that the code doesn't even build for me is kind of a
show-stopper regardless. It's the kind of things linux-next is
supposed to notice early, so that we aren't in the situation where the
code has not even been build-tested properly.

                   Linus
