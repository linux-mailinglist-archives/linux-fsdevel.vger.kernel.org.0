Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FCB7BEACF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 21:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjJITp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 15:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjJITp0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:45:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204FF94
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 12:45:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9adca291f99so836923066b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696880720; x=1697485520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i9IoVUFnZqWRaCM70mDq121GEnQ6kFXLINjENnMWdgE=;
        b=ee5uvAT80fSxSRtYDeyvxEuQ7zXOl8wdW0kO70gd08D47hzkRd+3mbkEUekmJUq06D
         8q777oRQSHZ6op/ZWJCsNQZHdOoWUoWw7duI1oSVMIVq6M0NdKQzZqs6MGy5XSqr2EmX
         BbA+2lv6IrYcf5dVP2Pc+icl6wM6wxHnu4EFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696880720; x=1697485520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9IoVUFnZqWRaCM70mDq121GEnQ6kFXLINjENnMWdgE=;
        b=nUZeBp/QagtQex9Y/UCS1+EPrmfxqsg9AT//IPHSX9TjfTW0F92qcCDxRZ+5wOWMhS
         171cmmS1xzbeY8YFugWl1FUJYr7gWcd7evAUyL001drvPLFegw+UAqRiNMmBrySgg9UF
         VK/TCnaMJVekQv2wMmtt+V6txiQ0tbpqpf+A34EnsL7NjbiuEoZEIy5p8yc1bQsnMYyd
         RdVsL0p5340zWYd8Qfz7T4kuIOE+Qk8he8EnJNYvPXWOLCisELzqTmJUnGS3KEE8+K1T
         wGMVgJpHEndjgKt21AR2uQVdo5Yg3HL1658bojG+R/AFivq30T8deYoIiiKkdvGCpjNX
         jM+w==
X-Gm-Message-State: AOJu0Yy/chf9ofdQ64OTr3GzXWVFrq2wTnaHj6gruq0a835odn83nz6J
        1zW8pS0QcnB8eIKfDX6KPCyTI5nPETNCmzKaQsl6UA==
X-Google-Smtp-Source: AGHT+IE9/+jcV6HV7HriuNXF+o7ki9IxeNc8WkeAHgY0RIJH0VhVY2+4Rx5D1jMrroc6t+20is5KxtXPiyekxAgUTkw=
X-Received: by 2002:a17:906:1db2:b0:9ba:2b14:44fb with SMTP id
 u18-20020a1709061db200b009ba2b1444fbmr2323048ejh.47.1696880720133; Mon, 09
 Oct 2023 12:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696043833.git.kjlx@templeofstupid.com> <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
In-Reply-To: <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 9 Oct 2023 21:45:08 +0200
Message-ID: <CAJfpegtOdqeK34CYvBTuVwOzcyZG8hnusiYO05JdbATOxfVMOg@mail.gmail.com>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their parent
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2 Oct 2023 at 17:24, Krister Johansen <kjlx@templeofstupid.com> wrote:
>
> The submount code uses the parent nodeid passed into the function in
> order to create the root dentry for the new submount.  This nodeid does
> not get its remote reference count incremented by a lookup option.
>
> If the parent inode is evicted from its superblock, due to memory
> pressure for example, it can result in a forget opertation being sent to
> the server.  Should this nodeid be forgotten while it is still in use in
> a submount, users of the submount get an error from the server on any
> subsequent access.  In the author's case, this was an EBADF on all
> subsequent operations that needed to reference the root.
>
> Debugging the problem revealed that the dentry shrinker triggered a forget
> after killing the dentry with the last reference, despite the root
> dentry in another superblock still using the nodeid.

There's some context missing here.  There are two dentries: a mount
point in the parent mount and the root of the submount.

The server indicates that the looked up inode is a submount using
FUSE_ATTR_SUBMOUNT.  Then AFAICS the following happens:

 1) the mountpoint dentry is created with nlookup = 1.  The
S_AUTOMOUNT flag is set on the mountpoint inode.

 2) the lookup code sees S_AUTOMOUNT and triggers the submount
operation, which sets up the new super_block and the root dentry with
the user supplied nodeid and with nlookup = 0 (because it wasn't
actually looked up).

How the automount gets torn down is another story.  You say that the
mount point gets evicted due to memory pressure.  But it can't get
evicted while the submount is attached.  So the submount must first
get detached, and then the mount point can be reclaimed.   The
question is:  how does the submount gets detached.  Do you have an
idea?

Thanks,
Miklos
