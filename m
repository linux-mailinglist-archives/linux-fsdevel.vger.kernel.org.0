Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AEC6A99CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjCCOtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 09:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjCCOtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:49:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9675A6FA;
        Fri,  3 Mar 2023 06:49:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F05CB61841;
        Fri,  3 Mar 2023 14:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE79C433EF;
        Fri,  3 Mar 2023 14:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677854948;
        bh=VsE4cZHeMMEG2onkqVTGj+mUSvPiqfXKJVwDf1VrF4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBsICalC9Jrhl7g9pTYAt0UgSiKGuKoaO7iexbNBGcCOg+OGThLR1i7rGTN42tSXD
         Xd9N48cCpyb5MtGkplu3sqiWqV7/rPpYpf2UBFHdAjokEhKnA9UnTxhLKwIZ4KT91M
         PS2B6x6ggBIsvjPiO+wOV8bFupZIK71skBf7B+94sEoKvtRV7y1AkrKBmvgkpNbP02
         KVaLUUcDJPFVFFvdB537sRzzJ4HMuXyffKHFmwvGgQL14+9hNegzL4MJJxcxcSRhhP
         19csLcv8woY4l96P3JseFswtYL+ZKM9J4Ro8is28EMad33M767iPEWMECrOiz1oGbO
         VoBdPshPGPsmg==
Date:   Fri, 3 Mar 2023 15:49:03 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        serge@hallyn.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <20230303144903.amxafbhpbedwab33@wittgenstein>
References: <20230125155557.37816-1-mjguzik@gmail.com>
 <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
 <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 09:51:48AM -0800, Linus Torvalds wrote:
> On Thu, Mar 2, 2023 at 12:30 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Fwiw, as long as you, Al, and others are fine with it and I'm aware of
> > it I'm happy to pick up more stuff like this. I've done it before and
> > have worked in this area so I'm happy to help with some of the load.
> 
> Yeah, that would work. We've actually had discussions of vfs
> maintenance in general.

As I've said to Al in the other thread I'm happy to help more.

> 
> In this case it really wasn't an issue, with this being just two
> fairly straightforward patches for code that I was familiar with.

Yup, I understand.
