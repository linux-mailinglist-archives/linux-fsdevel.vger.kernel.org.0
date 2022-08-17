Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC9D597832
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241614AbiHQUps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241797AbiHQUpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:45:44 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F60DAA4E0;
        Wed, 17 Aug 2022 13:45:43 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j20so7492838ila.6;
        Wed, 17 Aug 2022 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=d1Vgpq9X5YO+PwL5y7QUHDAwAkqiaQQAgkfJbYzVVq0=;
        b=LaPYTV2/D8VkQyeRMlMejudbf5K/nTvqXy0MUDHuYszw4tWxAx21CDJ6f27ZEuLcpU
         KctBy0EHSB6NTBFzDJh0uoQ27QWNKdXoVKlW7BVQA3kvPSR81Oft6NDBecQxNLtOCnaF
         af9Kg49qpyroatKZXd5KQjuporz6n+m2gLgJN3WTt7pU8Spumrbr/YyvrGRqqREcssJ0
         UQDLJ3CDdbKj5RrFzl57SKBcnbhHjquSPFbeD95ebsNLbcfWWc62N0y/htc+YCFjAcqt
         2ze4PiBVbkPUmLzduZcFcC9LCsFac8cHEKs8Za5PI5Q1ZIWnEq/TqsAegcyu8/PUfs4Y
         fqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=d1Vgpq9X5YO+PwL5y7QUHDAwAkqiaQQAgkfJbYzVVq0=;
        b=7xHMBWkffWebaFklpzJ5rGEapRwaG6oT2nzNJVbGLriND+HlUrT7VoV/WsyV4cZOPZ
         oe6yXqIp5Zygzv/plUZHLVWubjpY4i1Y9IQoKsn4s/PTEdVzxKo5b0RZ3FKvQ+FXv5kX
         LyIGJUKYeeYD2t5oKSfCSbq5CnViDrU+okfNrz3hs6eXkvsmdZ9jAe/3s2/jxv9EX+ly
         +iInzHKCIT0QGrvtB7n1HM7RuCjfTgDLB31CCLrXKXKvZwDZayxnS6ymDGMHKcW0PIBz
         VTd2JzvzzTFbV1Uvmtsj+l4DAkaOu/U+oSEnf3i5HPWDIZz2pTv6GlZFfls5EIKhNYv7
         v6CA==
X-Gm-Message-State: ACgBeo3t+XDMU5Dd1YUZYiI4fiU6QvyC5jscTbNA24+pRcPCO+dYQ0ZZ
        rA4UcNyK5P2M9MOzhu3U7EcabJvIIUMYu06Pi1Y=
X-Google-Smtp-Source: AA6agR6Nm7MWXy0TYAOYscqNUAIzeSuDdU7CjMymOwFGtEGx7D3WFG7qttZC1lk/1OE+k4Q06t3mvA6TpFhhxMku80o=
X-Received: by 2002:a05:6e02:1c26:b0:2e0:d8eb:22d6 with SMTP id
 m6-20020a056e021c2600b002e0d8eb22d6mr12711912ilh.151.1660769142550; Wed, 17
 Aug 2022 13:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-4-ojeda@kernel.org>
 <202208171238.80053F8C@keescook> <Yv1GmvZlpMopwZTi@boqun-archlinux> <202208171330.BB5B081D1@keescook>
In-Reply-To: <202208171330.BB5B081D1@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 17 Aug 2022 22:45:31 +0200
Message-ID: <CANiq72=S4ACw1mJk4MynmUu46Hdh3bm3w-S7eGPGacw+CJda+g@mail.gmail.com>
Subject: Re: [PATCH v9 03/27] kallsyms: add static relationship between `KSYM_NAME_LEN{,_BUFFER}`
To:     Kees Cook <keescook@chromium.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 10:31 PM Kees Cook <keescook@chromium.org> wrote:
>
> Yeah, please add a source comment for that. :)

I agree, I think this sort of explanation should be in the source vs.
the commit message, since it explains something about the code, not
the change itself.

Cheers,
Miguel
