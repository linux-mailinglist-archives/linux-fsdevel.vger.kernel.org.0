Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8888E6A2AF0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 18:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBYRFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Feb 2023 12:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBYRFS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Feb 2023 12:05:18 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1B7CC0D
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Feb 2023 09:05:17 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id da10so9450380edb.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Feb 2023 09:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kxoscNZqMv4xoYF3RLqiGyx1me2ebOAvYSK+OK3ZhoY=;
        b=c6d6DuQDEwEyWOeU9gj9Xo815A7QOUCOMTCo9jq9Cq5yz6hYmwiLx0c4Fp5B4LKb75
         o9RKpwNFd3uXOtyXLhbn6NtL3WgoxgV5zyvcMWc3kUhGHYY+jL0lSNw/pHxQbGQj0MuR
         87uJf9mWtRan435KYLEgINT37dYgLVED/pPO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxoscNZqMv4xoYF3RLqiGyx1me2ebOAvYSK+OK3ZhoY=;
        b=Ents9nAi/IrYxYDCfkikXpUmGlGsE7o6BneFbphxkGGdFWkXZXRSZ787fwZAdfbERe
         PFvw21mKBzKuIMezBZCVIVIquvU9yzF1s3+Ntpb/9YvaHM2boPC4WMASwIhWOOjtdLEz
         Sf9OG3dlKe67q318O9nTsgCqlqgw/o/SjjhKSYem17h+x6cNb//xFN9lAD+DTS+aa83U
         VOwnYvOOL1Xj6ZxMOGKfQVMF1dFHv1kxY9TPBn8pAkMHabQTqCt+KMaYd5BpNvQaqi+O
         ZXh2J0UPYS4OWo6Qz8MD3BlU7ABjpAwPmJ7qc7Bj3Vbln0catXguyKoutw03W7FhbXCY
         pLIg==
X-Gm-Message-State: AO0yUKUQCMsxNwsUUngrpBjjYxd7L9kk9k2UazDhyOUTgsvQXeCFjwg9
        hV89ipeGQbFwidu7LCPwpalZgWNud2VL9fEBFvvFsw==
X-Google-Smtp-Source: AK7set+t9wbCirAZ4IA0C7lX4D28qx0YbndHibr34SUyaxoQjAGBxJ0AfQ9uF+28a/td/5sDmVWUHw==
X-Received: by 2002:aa7:c996:0:b0:4af:593d:9ce5 with SMTP id c22-20020aa7c996000000b004af593d9ce5mr18045754edt.16.1677344715350;
        Sat, 25 Feb 2023 09:05:15 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id m19-20020a509993000000b004af5152751esm1035604edb.83.2023.02.25.09.05.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 09:05:14 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id ec43so9343381edb.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Feb 2023 09:05:14 -0800 (PST)
X-Received: by 2002:a05:6402:500b:b0:4ad:739c:b38e with SMTP id
 p11-20020a056402500b00b004ad739cb38emr2500448eda.1.1677344714502; Sat, 25 Feb
 2023 09:05:14 -0800 (PST)
MIME-Version: 1.0
References: <Y/gxyQA+yKJECwyp@ZenIV> <CAHk-=wiPHkYmiFY_O=7MK-vbWtLEiRP90ufugj1H1QFeiLPoVw@mail.gmail.com>
 <Y/mEQUfLqf8m2s/G@ZenIV> <Y/mVP5EsmoCt9NwK@ZenIV>
In-Reply-To: <Y/mVP5EsmoCt9NwK@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Feb 2023 09:04:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQz8VDDxdaj3rk861Ucjzk72hJoCjZvfaeo8jCyVc_2w@mail.gmail.com>
Message-ID: <CAHk-=wgQz8VDDxdaj3rk861Ucjzk72hJoCjZvfaeo8jCyVc_2w@mail.gmail.com>
Subject: Re: [git pull] vfs.git misc bits
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Fri, Feb 24, 2023 at 8:57 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Let's have it sit around for at least a few days, OK?  I mean, I'm pretty
> certain that these are fixes, but they hadn't been in any public tree -
> only posted to linux-arch.  At least #fixes gets picked by linux-next...

Ack, sounds good.

               Linus
