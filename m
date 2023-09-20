Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385057A881E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 17:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbjITPVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbjITPVZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:21:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DBD12D
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 08:21:16 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c00df105f8so55717521fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695223275; x=1695828075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqaeJfgMbCAOmlKxZ5X85vosg0bZp8aFnul/jdxA4HQ=;
        b=Q0e/JVKZCO95z9Ezb+mLkoAfL971FSMFiSAjhipkr8iTS8OHC4QdOTthEyXDitsvdI
         NxVY6P53WqLMTA6HDMEOhZ6jYmAtff9PJSz8ox8OugjGB9BQrQg2LlJovheVUhG46StV
         Kyk9XL8D/llBjdEPHxWr0oguxQGjxVCdAISnifiHcaDIdqIw8EVJVcdV5peXyy0jLQKt
         9q6Lh57q8dEKdxwoaYenvQUKfcJSNjmCZnxTX3+GFN6l37/ZCj/vbxD9RYTzJ9E8fqiV
         bwJ3gsPfjYHR9sdpU12j5YVZLl0veWWAocKP6LTF7qzPV167EopWtIM4OefUOYM/Eg+a
         reMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695223275; x=1695828075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqaeJfgMbCAOmlKxZ5X85vosg0bZp8aFnul/jdxA4HQ=;
        b=ItWTONcTl3JqKkB7LTGKjFwZUsSVpNjWkgVxH9ygLWqvzXS9mPRfddiF389OTlRYnR
         Wg1xIplohJuDnC5lbjXXCOIkAFFcOQRm1OewCDDxRxNffI4vDA00frTT1+sCjE964E+r
         gNK1yDUkfHnZUywsS52BKSB22/pD5abOeATHo40RAclaLf3bxS7T/3jwt3NooBC4ZTRj
         KQAJjYf4xpxCCJRRNTPQF35WuZwmh7k1OL3vBsmncEatM+CB3ZgnJpdpTXKcr7f4jjJL
         mE3HLwQa4qpOjGEZy/U8/atU507JKFsuLOchf20dqCl8NcTlnkFpeNi1AGKJ2uf7/N1Q
         yVdQ==
X-Gm-Message-State: AOJu0Yxn5oFMn3XO0RLrIlfw55+9iU6HRWWl9S6sDZ1mVx3RBq29uhsh
        hXCCgh2cFjRxgYCAnqvl9RYHSTYYbAWCKIkVAZro4w==
X-Google-Smtp-Source: AGHT+IFyBrJBm7QqjR5fEPfH55kxOr72RYLdWvR2rKBg436S7rR5olMaID+4wnSnl/9EGttSa5CkpFcggWaVVUmoA1M=
X-Received: by 2002:a2e:350e:0:b0:2bc:b75e:b8b with SMTP id
 z14-20020a2e350e000000b002bcb75e0b8bmr2321855ljz.38.1695223275020; Wed, 20
 Sep 2023 08:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAKPOu+-49kBuSExvrV7kfcZWbUsy_OdpuPW1hAv6ZtT98UiQFA@mail.gmail.com>
 <20230920-macht-rupfen-96240ce98330@brauner>
In-Reply-To: <20230920-macht-rupfen-96240ce98330@brauner>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Wed, 20 Sep 2023 17:21:03 +0200
Message-ID: <CAKPOu+9uO=wbTnesZ-jCw5E+AY1fwvcXykBtEQYOzHTyEeP_8g@mail.gmail.com>
Subject: Re: When to lock pipe->rd_wait.lock?
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 3:30=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Afaict, the mutex is sufficient protection unless you're using
> watchqueues which use post_one_notification() that cannot acquire the
> pipe mutex. Since splice operations aren't supported on such kernel
> notification pipes - see get_pipe_info() - it should be unproblematic.

Which means that the spinlocks can safely be removed from
pipe_write(), because they are unnecessary overhead?
