Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278D85254CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 20:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356273AbiELS2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 14:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245317AbiELS2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 14:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D334A246D88;
        Thu, 12 May 2022 11:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D4C861685;
        Thu, 12 May 2022 18:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A841C34100;
        Thu, 12 May 2022 18:27:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KR4Mx/Gh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652380074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3kOEdFLyvwaZwQ/Wsa24hFT1mtvdhKYBw5Fd/atvQkE=;
        b=KR4Mx/GhEviiQw5WQov7TonQszDnWrHkjMPNa7E9khrAvXucdJ9gcrkd8ljEPZoLaHRbsh
        B+bzMRCpRatvbeYBJDsCtvfPxenOwW+n7Hq6FkwJMtdC46BIzWV54/a2MufcYDwXrq0Bco
        slENIYspg7jHbltnonOXocMlFo3uVbY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 20c77356 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 12 May 2022 18:27:54 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id j84so513300ybc.3;
        Thu, 12 May 2022 11:27:53 -0700 (PDT)
X-Gm-Message-State: AOAM531AZV3KmqJhcmgK9pY14xX44ZTsa6IXFmnlTRgGiKme/a8vEy9B
        T6Xqnmnenp7nQIYhBdboAZr7YiiHMIJrrY+gWWY=
X-Google-Smtp-Source: ABdhPJw1ZrtavAsGkHuehsdDeB2v/XGX2Wi/410UmwT5vM110Hnw6u4bzDcb9gLsit1Kus/nr28QnW9CCFF+r9FQWrw=
X-Received: by 2002:a25:7901:0:b0:64a:a1d9:43dd with SMTP id
 u1-20020a257901000000b0064aa1d943ddmr1119815ybc.271.1652380073024; Thu, 12
 May 2022 11:27:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:6406:b0:179:6742:1e2c with HTTP; Thu, 12 May 2022
 11:27:52 -0700 (PDT)
In-Reply-To: <20220512182209.7uiy3pt4chctqhg4@ldmartin-desk2>
References: <20220502140602.130373-1-Jason@zx2c4.com> <20220512182209.7uiy3pt4chctqhg4@ldmartin-desk2>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 12 May 2022 20:27:52 +0200
X-Gmail-Original-Message-ID: <CAHmME9pZ0TeLR5NExbp88oXfOzcxULbce_GP31wEHcS9oWq+7A@mail.gmail.com>
Message-ID: <CAHmME9pZ0TeLR5NExbp88oXfOzcxULbce_GP31wEHcS9oWq+7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] sysctl: read() must consume poll events, not poll()
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Lucas,

On 5/12/22, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> On Mon, May 02, 2022 at 04:06:01PM +0200, Jason A. Donenfeld wrote:
>>Events that poll() responds to are supposed to be consumed when the file
>>is read(), not by the poll() itself. By putting it on the poll() itself,
>>it makes it impossible to poll() on a epoll file descriptor, since the
>>event gets consumed too early. Jann wrote a PoC, available in the link
>>below.
>>
>>Reported-by: Jann Horn <jannh@google.com>
>>Cc: Kees Cook <keescook@chromium.org>
>>Cc: Luis Chamberlain <mcgrof@kernel.org>
>>Cc: linux-fsdevel@vger.kernel.org
>>Link:
>> https://lore.kernel.org/lkml/CAG48ez1F0P7Wnp=PGhiUej=u=8CSF6gpD9J=Oxxg0buFRqV1tA@mail.gmail.com/
>>Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> It seems to be my bug. This is indeed better. Also, I don't think it's
> unsafe
> to fix it like this neither. If my memory serves (it's what, 10+ years?),
> this
> was only tested and used with poll(), which will continue to work.

You are not correct. Please read the entire thread. This breaks systemd.

Jason
