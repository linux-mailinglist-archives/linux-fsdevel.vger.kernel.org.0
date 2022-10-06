Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3BB5F6112
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 08:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJFGcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 02:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJFGcD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 02:32:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C13AE51
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Oct 2022 23:32:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id z23so2263420ejw.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Oct 2022 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mHju16tHxpXl3EK4c7Bh3/hsomdw2uS+nwGbV/7jvJE=;
        b=iySenhqEf+XihjlDc4yaj8PGwDwtb8erweo1YsY4IcBWCgSq5VaSLzZDVtDF+VqQAC
         BEHszdgbn3nX20tgDQ677zAacRoyxXK4hXS9taeizO0XiacsmzZoVQDmH8s0fEn/i8DX
         wAbMjCOdqOLgddyiDGsCCI+cuaoQiFQWoAKds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mHju16tHxpXl3EK4c7Bh3/hsomdw2uS+nwGbV/7jvJE=;
        b=DU4j+/uSkYISQOGJSJHPc8tBcnAbuOj+U29ADgVBy5vrSKcngggkdBEgg0+4z+KB9V
         /Dc0NJ2isosPua6TG0sSprp9feT5n0ZA79bo9zgWPhmycpDDjzMGSIskIPa5zyTdvP3H
         lpcwtd7fOh0WSxOU1eACwEyZCGPR9LYck5S/uBnfdyD4Jd6avYUlKqnxF+D5xW2/Zdco
         IuVwevfD4Q07/aPb8TkoT4j9i+KJDFvHm/bye7NIDjJ/HegmiLgPNDoF7NJXxVpQJrUh
         1CLSVe8R/0hyq9I8HjaTYEW/3Hc0mud6I33+Y9TRb6Oy1G9yi89yj3WWOuhBpWn64+/7
         csRw==
X-Gm-Message-State: ACrzQf1jBpghW/INSXivtdNHjzpCocFpO8jKwMOWRCeeY+4FxXdw26Ga
        42g25AKUkCBW8enTSTBxilurY8pHt/K6wHbVi2Ydcg==
X-Google-Smtp-Source: AMsMyM5f9K6PIAM9zeO5vKX91jTFdHXC9+MnXMlia0zJkE65UlxJxiFVol75UCFnY+6Gy9vUC0i9YtJsYgZ3KGz0mEc=
X-Received: by 2002:a17:907:7f9e:b0:78b:c4af:bcca with SMTP id
 qk30-20020a1709077f9e00b0078bc4afbccamr2714447ejc.187.1665037918815; Wed, 05
 Oct 2022 23:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-5-brauner@kernel.org>
 <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
 <20220930090949.cl3ajz7r4ub6jrae@wittgenstein> <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
 <CAH2r5muRDdy1s4xS7bHePEF3t84qGaX3rDXUgGLY1k_XG4vuAg@mail.gmail.com> <20221005071508.lc7qg6cffqrhbc4d@wittgenstein>
In-Reply-To: <20221005071508.lc7qg6cffqrhbc4d@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 6 Oct 2022 08:31:47 +0200
Message-ID: <CAJfpegviBdPx25oLTNHCg661GfMa92NKOadSr=QnaFAhzkkN2Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
To:     Christian Brauner <brauner@kernel.org>
Cc:     Steve French <smfrench@gmail.com>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 5 Oct 2022 at 09:15, Christian Brauner <brauner@kernel.org> wrote:

> We're just talking about thet fact that
> {g,s}etxattr(system.posix_acl_{access,default}) work on cifs but
> getting acls based on inode operations isn't supported. Consequently you
> can't use the acls for permission checking in the vfs for cifs. If as
> you say below that's intentional because the client doesn't perform
> access checks then that's probably fine.

Now I just need to wrap my head around how this interacts with all the
uid/gid transformations.

Do these (userns, mnt_userns) even make sense for the case of remotely
checked permissions?

Thanks,
Miklos
