Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA414FBC97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243259AbiDKM75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 08:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiDKM74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:59:56 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E598EB0E
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 05:57:42 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id hu11so13116472qvb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLaCLo2jXluwgznaIyKM5pJvq/d/TlkDDgPNpL8ZKVQ=;
        b=iQ1B1Zr1n7hrPfWIDizmoaVh387jK/sLrrMefnr6s0/sIOVwLGAgKyT/Xb3DaxQXR7
         cL9+K3FE3K/2BYwqbk1jUEDUphp72nRBsqAXbBbtYCGPGLIAVmycMHlbJEPT6yPHqAjm
         zHsXB4+KzDATl28yfY8TTLwN+VQDsTxAs4iO4gsZrWXso34QZPkGwGhP/NvgFzUFcZu0
         KIIZn19tAdyLhzaPypCsXLuYpB3UQHCLNnbEEwWe0gShhcTnDyUZzH5OW0bEcC8dDTwK
         80Yrp63i/22N58Xh0z7bl3pUPGBgmme911cQFS+31FWKBoXfMy+Hf5JqSYMqGEHU1Te8
         k0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLaCLo2jXluwgznaIyKM5pJvq/d/TlkDDgPNpL8ZKVQ=;
        b=WGPXMrRMJSSbzoe9AVnisVC6f7ynMialH/KhG2m4Jf5I/1imnS6exRlRek3+FLJt3I
         iLkzFg32oKCI6uHO55wqV7uZggEoLBSgsIDgYpsNiltNqktTm37v05a/PKyurigvqf4a
         HGW+FgGqGbbfmuA6fBFW1Kwzifis+MVAkrbFnaqifsElDJi/f66RdJTCOzWH82QpcJOd
         nRus2f8SUYCrT0ZLLkGeXQZ6ElURguXOqnx+3Q8OyStoBArRZTPq0WbzaIjztllSkWvm
         wrqhuBjb3EpyDRnS4EghzJI8t7VVwvBVtKwPOLkrlna3cv9IFDjmH12WPyT9pOBLGL78
         E2KQ==
X-Gm-Message-State: AOAM532dO5tPZ7R5nEd5+so7yi2huwu4uVMBnIpm2TY+ioxL5R2MQzjS
        LYZX+KVMyS1Yz9xcmOWSvCbwpzFJYTn4Rr6Rzkp1s3bM
X-Google-Smtp-Source: ABdhPJyEUij1TnubK5NqCtf+oFZlmgV+qEnzx0P5yzG9HGX7Tjm9T3BBsFug9GiaFKBgKpd/AKv9BXZMA86CU1xdShI=
X-Received: by 2002:a05:6214:2aa4:b0:443:c595:ca82 with SMTP id
 js4-20020a0562142aa400b00443c595ca82mr26682749qvb.77.1649681861983; Mon, 11
 Apr 2022 05:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220329074904.2980320-1-amir73il@gmail.com> <20220329074904.2980320-14-amir73il@gmail.com>
 <20220411114752.jpn7kkxnqobriep3@quack3.lan>
In-Reply-To: <20220411114752.jpn7kkxnqobriep3@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 11 Apr 2022 15:57:30 +0300
Message-ID: <CAOQ4uxjuYChExjsqPmczM9SzXapUR0bT8RTEbxaQsSacNOMV4A@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] fanotify: implement "evictable" inode marks
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

On Mon, Apr 11, 2022 at 2:47 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 29-03-22 10:49:01, Amir Goldstein wrote:
> > When an inode mark is created with flag FAN_MARK_EVICTABLE, it will not
> > pin the marked inode to inode cache, so when inode is evicted from cache
> > due to memory pressure, the mark will be lost.
> >
> > When an inode mark with flag FAN_MARK_EVICATBLE is updated without using
> > this flag, the marked inode is pinned to inode cache.
> >
> > When an inode mark is updated with flag FAN_MARK_EVICTABLE but an
> > existing mark already has the inode pinned, the mark update fails with
> > error EEXIST.
>
> I was thinking about this. FAN_MARK_EVICTABLE is effectively a hint to the
> kernel - you can drop this if you wish. So does it make sense to return
> error when we cannot follow the hint? Doesn't this just add unnecessary
> work (determining whether the mark should be evictable or not) to the
> userspace application using FAN_MARK_EVICTABLE?

I do not fully agree about your definition of  "hint to the kernel".
Yes, for a single inode it may be a hint, but for a million inodes it is pretty
much a directive that setting a very large number of evictable marks
CANNOT be used to choke the system.

It's true that the application should be able to avoid shooting its own
foot and we do not need to be the ones providing this protection, but
I rather prefer to keep the API more strict and safe than being sorry later.
After all, I don't think this complicates the implementation nor documentation
too much. Is it? see:

https://github.com/amir73il/man-pages/commit/b52eb7d1a8478cbd1456f4d9463902bbc4e80f0d

>
> I'd also note that FSNOTIFY_MARK_FLAG_NO_IREF needs to be stored only
> because of this error checking behavior. Otherwise it would be enough to
> have a flag on the connector (whether it holds iref or not) and
> fsnotify_add_mark() would update the connector as needed given the added

I am not sure I agree to that.
Maybe I am missing something, but the way fsnotify_recalc_mask() works now
is by checking if there is any mark without FSNOTIFY_MARK_FLAG_NO_IREF
attached to the object, so fsnotify_put_mark() knows to drop the inode when the
last non-evictable mark is removed.

Thanks,
Amir.
