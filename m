Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10B97A64A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjISNSS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjISNSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:18:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B31FB;
        Tue, 19 Sep 2023 06:18:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C133C433C7;
        Tue, 19 Sep 2023 13:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695129489;
        bh=B+8I3aKM/91Zhsrq6ewP8IyGv0QxNwN6RyGlRjopINc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNgu3Pfy4jLszNXbMEb4vwJG05SdOoDIM+ApOEgtH4lxLcQMQ+GdKK2Biq042/jKB
         Qw9uDXlIZEA+Bf+alZe3RVxZULe1X1it9mZ7dZDcg9sbyNio+WunzJl7LfdX6zvgLi
         QRXJ5fF+clWvRNzenzBQtQ1F0S1kaFQO1TbWa2w46YTjuwf0N9zk0X+cgfAhtJsjbF
         HGGLMxZyVMLyjgkIPpo3jx1Ws+j4QQ1U2ILFNpzt+x8j/5G6DXT4QcmlqrBUmySRGE
         FD8aBeyt95ABKEv/StLzVvwO6FGJPMb5dSJaOjDRYVrMC9R+uGotPcztSM/VIDlpUu
         tRVmP1CkY9CDw==
Date:   Tue, 19 Sep 2023 15:18:03 +0200
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
Message-ID: <20230919-gecheckt-loyal-a3355735afef@brauner>
References: <20230918-stuhl-spannend-9904d4addc93@brauner>
 <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
 <20230918-bestialisch-brutkasten-1fb34abdc33c@brauner>
 <CAJfpegvTiK=RM+0y07h-2vT6Zk2GCu6F98c=_CNx8B1ytFtO-g@mail.gmail.com>
 <20230919003800.93141-1-mattlloydhouse@gmail.com>
 <CAJfpegs6g8JQDtaHsECA_12ss_8KXOHVRH9gwwPf5WamzxXOWQ@mail.gmail.com>
 <20230919-abfedern-halfen-c12583ff93ac@brauner>
 <CAJfpegsjE_G4d-W2hCZc0y+PioRgvK5TxT7kFAVgBqX6zN2dKg@mail.gmail.com>
 <20230919-hackordnung-asketisch-331907800aa0@brauner>
 <CAJfpeguv+Z6uys18_QYnHcbs_JpMNicRKGt50Scmp82kAOOFOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpeguv+Z6uys18_QYnHcbs_JpMNicRKGt50Scmp82kAOOFOQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 02:59:53PM +0200, Miklos Szeredi wrote:
> On Tue, 19 Sept 2023 at 14:41, Christian Brauner <brauner@kernel.org> wrote:
> >
> > > >  with __u32 size for mnt_root and mnt_point
> > >
> > > Unnecessary if the strings are nul terminated.
> >
> > All ok by me so far but how does the kernel know the size of the buffer
> > to copy into? Wouldn't it be better to allow userspace to specify that?
> > I'm probably just missing something but I better ask.
> 
> Because size of the buffer is given as the syscall argument.
> 
>   long statmount(u64 mnt_id, u64 mask, struct statmnt __user *buf,
> size_t bufsize, unsigned int flags);
> 
> If you are still hung up about this not being properly typed, how about this:

I really just wasn't clear how exactly you envisioned this. Your
proposal as is sounds good to me! I'm on board. I prefer the two offsets
as that lets us avoid searching for null bytes. So please leave it as is!
Thanks!
