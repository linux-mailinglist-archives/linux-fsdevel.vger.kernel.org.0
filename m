Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D557A5D67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 11:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjISJHx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 05:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjISJHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:07:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA848EC;
        Tue, 19 Sep 2023 02:07:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CF5C433C8;
        Tue, 19 Sep 2023 09:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695114465;
        bh=B/Kioz3f57QDGw85DtiGtnUTyVRNwLeq2/Ex7+Ek1iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpjM+7H48CgdX5cq5vTfg1JsM1JSl8Hss8/ZKcySHZIHl2GAIoKjqO0BvawtpgLn2
         Vj4qIXupZpioMYlg80kzFkhZQiFsmuKzuM+yIetGbJ+P97b4qFWt6ou7ddUBwuVKCb
         5XiwKS1JkF0RTOgGzfAoSyOLhWkTtbguwzivGItlnlgBB0blE2s4Bh0X0roGzSabGJ
         IvALVx1LdHT1Fo+HeyidZbBDgIZSJ6+2lIRLq3m96q1z6H9xP4ahhy8Jl4Q0YO3gWT
         EqS6KOsOUPKbovR10LFE58pqjprrLEu1vRx+E6TXobKtMWgGUe8jbUH/6dQhZqzSBS
         noE/I2NXjNWdQ==
Date:   Tue, 19 Sep 2023 11:07:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Matthew House <mattlloydhouse@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Message-ID: <20230919-abfedern-halfen-c12583ff93ac@brauner>
References: <20230918-grafik-zutreffen-995b321017ae@brauner>
 <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
 <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
 <20230918-stuhl-spannend-9904d4addc93@brauner>
 <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
 <20230918-bestialisch-brutkasten-1fb34abdc33c@brauner>
 <CAJfpegvTiK=RM+0y07h-2vT6Zk2GCu6F98c=_CNx8B1ytFtO-g@mail.gmail.com>
 <20230919003800.93141-1-mattlloydhouse@gmail.com>
 <CAJfpegs6g8JQDtaHsECA_12ss_8KXOHVRH9gwwPf5WamzxXOWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegs6g8JQDtaHsECA_12ss_8KXOHVRH9gwwPf5WamzxXOWQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:02:17AM +0200, Miklos Szeredi wrote:
> On Tue, 19 Sept 2023 at 02:38, Matthew House <mattlloydhouse@gmail.com> wrote:
> 
> > One natural solution is to set either of the two lengths to the expected
> > size if the provided buffer are too small. That way, the caller learns both
> > which of the buffers is too small, and how large they need to be. Replacing
> > a provided size with an expected size in this way already has precedent in
> > existing syscalls:
> 
> This is where the thread started.  Knowing the size of the buffer is
> no good, since the needed buffer could change between calls.

The same problem would exist for the single buffer. Realistically, users
will most often simply use a fixed size PATH_MAX buffer that will cover
most cases and fallback to allocating a larger buffer in case things go
awry.

I don't think we need to make this atomic either. Providing a hint for
the required buffer size in case this fails is good enough and should be
a rather rare occurence and is exactly how other variable-sized buffers
are handled.

> Also having the helper allocate buffers inside the struct could easily
> result in leaks since it's not obvious what the caller needs to free,

I don't think we need to be overly concerned with how userspace
implements the wrapper here. Leaks can occur in both scenarios and
low-level userspace can use automatic cleanup macros (we even support it
in the kernel since v6.5) to harden against this.

Really, the main things I care about are 64 bit alignment of the whole
struct, typed __u64 pointers with __u32 size for mnt_root and mnt_point
and that we please spell out "mount" and not use "mnt": so statmount
because the new mount api uses "mount" (move_mount(), mount_setattr(),
fsmount(), MOUNT_ATTR_*) almost everywhere.
