Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EEA4B8470
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 10:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiBPJ2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 04:28:45 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiBPJ2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:28:45 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E3D220BDD
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Feb 2022 01:28:32 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id e13so1818655vsh.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Feb 2022 01:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HIWRlgaDSkeBDbWx7Q12aTkk4hl9N3e3axYauo6Q7y8=;
        b=Oi5KUcrCgG1zk1IjbWUdDP4mUwWswxl2Iqqar8TFi1N0tmPHfriBpDgBqL+FFJUdr9
         m8GK7sG+3NrUeONujCZCvnXBM3Y/KjoLQqNzqMqA6v/wPZX0EpnVLxMMFv1maRDBf+lm
         UYI7yL1yNxTTsCV494hxMcR70Yz96KVJmKPpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIWRlgaDSkeBDbWx7Q12aTkk4hl9N3e3axYauo6Q7y8=;
        b=mpzpJrASM8HeZMlUIBu2rUQuGAM2ygmkPO5IPR5pkl3MK2isQ/8eN3tNk0jFGYStYn
         mlQJQFzuyueClF0aswGit09v2+z46yqif15TL8R131eQ4OnYYKpL38agoARITlpfVilt
         5bsLZlkTagUUGIjRkDbgb+1vust8N7UTQYMnnijllZ8l7+0WRo65xiEFXNkoCruqMmuY
         U7ciwDkn/o4Tym27Ko6guE82dVaB/PL4OO4D37C/Dz8rCq4PVxFd5KirzAhrosra19jy
         wp9PzvvupGy3wwoMtvzT3PeYNXuhrnwoNiKKh8pL/SFDP7w8JjoQD1eewjEOTMz8nsj3
         4+Tg==
X-Gm-Message-State: AOAM532lHEYbRx4Pmy3qZAz9pRxH/Eev7//UbOBjWWrvnS5CmSgoe2gO
        ig4Uoy/yrJ9+Fhtf58l6thXIVZ4zhUqAfyJceh8kSQ==
X-Google-Smtp-Source: ABdhPJwvMjqz+O1DY3JFkx/CJjnkI+qqEiqp90FEVTEPmSAIB3VnN6I0CCgv9DuTEessjaZssawJVqvlsxC7mJreEW4=
X-Received: by 2002:a67:e0cc:0:b0:31b:d7bf:8403 with SMTP id
 m12-20020a67e0cc000000b0031bd7bf8403mr24961vsl.61.1645003711356; Wed, 16 Feb
 2022 01:28:31 -0800 (PST)
MIME-Version: 1.0
References: <20220214210708.GA2167841@xavier-xps> <CAJfpegvVKWHhhXwOi9jDUOJi2BnYSDxZQrp1_RRrpVjjZ3Rs2w@mail.gmail.com>
 <YguspMvu6M6NJ1hL@zeniv-ca.linux.org.uk> <YgvPbljmJXsR7ESt@zeniv-ca.linux.org.uk>
 <YgvSB6CKAhF5IXFj@casper.infradead.org> <YgvS1XOJMn5CjQyw@zeniv-ca.linux.org.uk>
In-Reply-To: <YgvS1XOJMn5CjQyw@zeniv-ca.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 16 Feb 2022 10:28:20 +0100
Message-ID: <CAJfpegv03YpTPiDnLwbaewQX_KZws5nutays+vso2BVJ1v1+TA@mail.gmail.com>
Subject: Re: race between vfs_rename and do_linkat (mv and link)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Xavier Roche <xavier.roche@algolia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 15 Feb 2022 at 17:20, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Feb 15, 2022 at 04:17:11PM +0000, Matthew Wilcox wrote:
> > On Tue, Feb 15, 2022 at 04:06:06PM +0000, Al Viro wrote:
> > > On Tue, Feb 15, 2022 at 01:37:40PM +0000, Al Viro wrote:
> > > > On Tue, Feb 15, 2022 at 10:56:29AM +0100, Miklos Szeredi wrote:
> > > >
> > > > > Doing "lock_rename() + lookup last components" would fix this race.
> > >
> > > "Fucking ugly" is inadequate for the likely results of that approach.
> > > It's guaranteed to be a source of headache for pretty much ever after.

So this is a fairly special situation.  How about adding a new rwsem
(could possibly be global or per-fs)?

 - acquired for read in lock_rename() before inode locks
 - acquired for write in do_linkat before inode locks, but only on retry

Thanks,
Miklos
