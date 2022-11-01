Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0C6614535
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 08:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKAHrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 03:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAHrB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 03:47:01 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC82517E2A;
        Tue,  1 Nov 2022 00:47:00 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id v129so13228161vsb.3;
        Tue, 01 Nov 2022 00:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n38GxNNMIxzvhVEdb99MrZWD4bfYUoPuf3+bxVa1LJ8=;
        b=Or7pBgyk13JDypqslv8KBdimdKih0Ekw5TVaCkYKu0g96J7yOnnUwXOvyw4H0MSaC5
         cysIl/nktGvmFnt8RYNzs2zM+bqFzGNaZ5paob6DF/d1laX3R6iYcMM4SlMN4onX7EJq
         KDeZ6noMIiidaqx5b9ZRDpbEbJFrY3+THjK9dLGcu1jxwGwlczM+HNjG0JSsDuKxStkG
         h+IwtbU2RVejaGZLUtwtIoCgBPFQqWGNMMC2UKwTcO4AssJoZn/4SDYY/QyjUQh+bS7P
         w0ijuIOuJW3hDODITE06lkekXVxpJyDovA6Zrnghy3KEBC3W85UP6EvKNIOg3bgvBhgx
         Nbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n38GxNNMIxzvhVEdb99MrZWD4bfYUoPuf3+bxVa1LJ8=;
        b=gw6mvBDFaoFWEETHMPiwcQfEbN1eaksHXdX8XCdUxGIXkrr4q61ngdEwRxejHcJRH+
         pGWhiub7lUud7QCNvltfGfNojOlfnz7TV7sk+eK2ko1qZ4V8PS56mLELyIVJJtseZFhV
         gdfRbXsdeL2mUW2YFX4naA92zJRde61i1K0h3TtYdy5PtpPyCV5w83ka/NKFnLYLgunr
         /qTa7Ot8gAkcObx07P54DnkKA0BmE+1e0HIVnU39ZWFg6aX88P8lGwSm+DZCvbyt1dxl
         F242JnBE8SqWQcYSZJgkxFmIcPpF7FkH8ydHnCRP/DrNvx+jhRhnt6lgn2ghkEqH/2O/
         pHcw==
X-Gm-Message-State: ACrzQf35kvRY0L1RjpoRexzVWKRW9EAJQmqfXzQrws6lVG3BExwibvvz
        7K8LvsW8JAFALJDTXGPKmziglFuvH4UmIYamIjsOe71Y
X-Google-Smtp-Source: AMsMyM5RxE2ldSWMOdIh3VJErsRcdBjORX2L6WDF+mHHJW45H/FsEkS5CPNxvrYxNNj36AWnJTQ0gmVMa7/f4nj55fE=
X-Received: by 2002:a67:c08d:0:b0:3ac:d0e5:719a with SMTP id
 x13-20020a67c08d000000b003acd0e5719amr3716454vsi.3.1667288819932; Tue, 01 Nov
 2022 00:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net> <166606036967.13363.9336408133975631967.stgit@donald.themaw.net>
In-Reply-To: <166606036967.13363.9336408133975631967.stgit@donald.themaw.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 1 Nov 2022 09:46:48 +0200
Message-ID: <CAOQ4uxjiEbHwT7M1GhPb_GFn-oiuvqwS1aOw7N9N8cu5jam5Yw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernfs: dont take i_lock on revalidate
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 5:58 AM Ian Kent <raven@themaw.net> wrote:
>
> In kernfs_dop_revalidate() when the passed in dentry is negative the
> dentry directory is checked to see if it has changed and if so the
> negative dentry is discarded so it can refreshed. During this check
> the dentry inode i_lock is taken to mitigate against a possible
> concurrent rename.
>
> But if it's racing with a rename, becuase the dentry is negative, it
> can't be the source it must be the target and it must be going to do
> a d_move() otherwise the rename will return an error.
>
> In this case the parent dentry of the target will not change, it will
> be the same over the d_move(), only the source dentry parent may change
> so the inode i_lock isn't needed.

You meant d_lock.
Same for the commit title.

Thanks,
Amir.
