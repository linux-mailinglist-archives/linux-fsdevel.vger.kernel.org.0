Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DEA6DFB59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 18:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDLQ15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDLQ14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:27:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1487EDC
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 09:27:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id os24so652560ejb.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1681316871; x=1683908871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlbBUU3Heh2HbQgGaI5PMM5WO9GB4tDWoyyHCpBYNx4=;
        b=efCuKwNHI+e5ttjxepW1uvimCACd89PmCHF1VAnRqej2/xLnn9b8tpJu36F2CiP0yr
         Mep67bOSUqLiuHmV6LGR3innHFLBaL5lRzkYPl4+RyyWC7AGHf6ZvvLwLkZlMxLZ967B
         rsBZ88WVUh/FexU/p8WdLfDSH8dpH1Gbxfd/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681316871; x=1683908871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlbBUU3Heh2HbQgGaI5PMM5WO9GB4tDWoyyHCpBYNx4=;
        b=ZnkFKzj4fWtP/dgNHKAG/ie68IJklZTfuZ28ER8hiUyC/5MsGDil+HGpj2h2EHNYiS
         sz6u+VXVMMgeiP15p3Gxy5pfJ6zTfd4RkiNcztxJHQiNms5qwndSZFEc21MnIXMhGsKW
         JFy2sfoy+PU05OXGeDHeSC37OCWoyFj73cnW0SRvDi7FWoE55SFCycPDDkoNM+5lyBOM
         xtWxTXH/VrvNIGoZH26ri2oZmD41bmTQIPwmFrCYZyi2lIg630ey+LQsvOjx58kUpP+7
         UXzAJ0oKbV9DRY5FjSjT/pY2zf68dqvdSGAhikszTcry2NmjDJ8G55KkMLiutRIKsby1
         vKWQ==
X-Gm-Message-State: AAQBX9fTcDKwZ/Yzy5ivrBtdbca08PYWWiq5bAMXLXE4JAxqI1kgTF+A
        6oR6mlpeCMUO1K5S5T6H/rEbi7y/I0ZUMUT/SqsSzQ==
X-Google-Smtp-Source: AKy350ZShjUewaP0dI0mbr5BhC/0jX7Va2VbCckOlAeF9EbKuz//Us+Dm5XOGJAIqbM3jx3Ylwi49Q==
X-Received: by 2002:a17:906:aacb:b0:94a:682f:7744 with SMTP id kt11-20020a170906aacb00b0094a682f7744mr12520798ejb.16.1681316871268;
        Wed, 12 Apr 2023 09:27:51 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id o12-20020a1709064f8c00b0093f322187f0sm7411418eju.189.2023.04.12.09.27.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 09:27:50 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5055141a8fdso277171a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 09:27:50 -0700 (PDT)
X-Received: by 2002:a50:9fa2:0:b0:504:81d3:48f with SMTP id
 c31-20020a509fa2000000b0050481d3048fmr3195779edf.2.1681316870239; Wed, 12 Apr
 2023 09:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <110100.1681301937@warthog.procyon.org.uk>
In-Reply-To: <110100.1681301937@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Apr 2023 09:27:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJt-6_PJ=hm2_TzwVHcWSatMCiByrFiUizpteogGNibA@mail.gmail.com>
Message-ID: <CAHk-=wjJt-6_PJ=hm2_TzwVHcWSatMCiByrFiUizpteogGNibA@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix netfs_extract_iter_to_sg() for ITER_UBUF/IOVEC
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 12, 2023 at 5:19=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Could you apply this, please?  It doesn't affect anything yet, but I have
> patches in the works that will use it.

Applied,

             Linus
