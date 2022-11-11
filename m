Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D03625E1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 16:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiKKPSQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 10:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiKKPRT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:17:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0797E994;
        Fri, 11 Nov 2022 07:16:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2361C62014;
        Fri, 11 Nov 2022 15:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84732C433D6;
        Fri, 11 Nov 2022 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668179817;
        bh=x9Ke/KRLYG8sRfB+wVrrL1OIQqqHlJ9aK+e+Rc9DtZA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eKuXnj1lSlrUKHenS8cyni9zEr1UdGjvqkDZrmIxh3wGOKK7yckVhB+mHdLgCDtzJ
         GaGmzCGAxvQAlhneA85ponVvHb1tOj6o91qchNZDbBxdPdOPoLqB1dNdMT9Z2U9nEM
         KUA4dTbqgP3LevS0mRIoqygCgEk1G7QZE48gwDsVwVkgFr4NY6a0W1HiMQJn/IK59h
         d2yqdY5taVIqxqzH7JzzQB6vPA/EmadoKQ3WuQ0MxQqtBr8VdOYO1AQeIlu3jtf4Ht
         R2k3vT6u9lH/+EXowTQoSa8XPUBx89zrYoP71I2xC3EjxgsJjfDjIstLA/XXWOodQX
         vQqAUSFngPveQ==
Received: by mail-oi1-f178.google.com with SMTP id n186so5163167oih.7;
        Fri, 11 Nov 2022 07:16:57 -0800 (PST)
X-Gm-Message-State: ANoB5plIITi++Gw5nvJCWzObH+0BMQeKVi0vZCjAAPr+IlMvwiqdWuFU
        pPYrSKg/br4Kk4n54zkr+RnbEgDA8K5jtlo7z/o=
X-Google-Smtp-Source: AA0mqf7ku+APaXjOsYRyL/D24pTq7efEYiUFAekNrIAOiYJTB8Gze8J8ysrBNf6kXpTadr0DIeLK9CA86xWIoOzaEWk=
X-Received: by 2002:aca:628a:0:b0:34f:63a5:a654 with SMTP id
 w132-20020aca628a000000b0034f63a5a654mr993220oib.257.1668179816706; Fri, 11
 Nov 2022 07:16:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Fri, 11 Nov 2022 07:16:56
 -0800 (PST)
In-Reply-To: <20221111131153.27075-1-jlayton@kernel.org>
References: <20221111131153.27075-1-jlayton@kernel.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 12 Nov 2022 00:16:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8roEwL_-+bdSgBgZ8QnEqES=_kJpbN2fmsTe69deXZNg@mail.gmail.com>
Message-ID: <CAKYAXd8roEwL_-+bdSgBgZ8QnEqES=_kJpbN2fmsTe69deXZNg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: use F_SETLK when unlocking a file
To:     Jeff Layton <jlayton@kernel.org>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-11-11 22:11 GMT+09:00, Jeff Layton <jlayton@kernel.org>:
> ksmbd seems to be trying to use a cmd value of 0 when unlocking a file.
> That activity requires a type of F_UNLCK with a cmd of F_SETLK. For
> local POSIX locking, it doesn't matter much since vfs_lock_file ignores
> @cmd, but filesystems that define their own ->lock operation expect to
> see it set sanely.
>
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks for your patch.
