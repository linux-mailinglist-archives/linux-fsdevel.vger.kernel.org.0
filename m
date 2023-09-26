Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7406D7AE9E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 12:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjIZKGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 06:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjIZKGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:06:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C39397;
        Tue, 26 Sep 2023 03:06:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E6EC433C7;
        Tue, 26 Sep 2023 10:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695722768;
        bh=5onSzf5BNFbFhVXiA+U4L0mSIUR02CQroDNZdJ/Wi8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrlvP8M/WGIMxDQUlrAlDtJCIhJZnHOgxzaN4l3cUscNnqxCn8ER5BobU0+J74MCE
         QkGCBpL/mpoZzwdWQAWchoUjjSzZbJGiXMPs5wnwY1O5Ke+c7JAnCKkCIY4J3krVq1
         3I5Ucfi2Q/lddDf4MoiCUadOrNh7FTCHxhTDNefq0c9Uro5lQ9CUy99DiEm0HJLVH+
         L8Yj0OX0qmlABgA5Ja/dlIcLitbUSFNVKnGgd0g0QBM3b6m0U2Tsb38gBBySZ+yMmD
         INRhtBhTfEDY9BFOyxPTMzqwOeitd6z0BsY1qnQezsMf2S7P1yUX6fZeLXTC93B5Dc
         gflwbcNWun4OQ==
Date:   Tue, 26 Sep 2023 12:05:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Message-ID: <20230926-kajak-klarzukommen-e6c6e3662798@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <44631c05-6b8a-42dc-b37e-df6776baa5d4@app.fastmail.com>
 <20230925-total-debatten-2a1f839fde5a@brauner>
 <CAJfpegvUCoKebYS=_3eZtCH49nObotuWc=_khFcHshKjRG8h6Q@mail.gmail.com>
 <20230925-wahlrecht-zuber-3cdc5a83d345@brauner>
 <CAJfpegvAVJUhgKZH2Dqo1s1xyT3nSopUg6J+8pEFYOnFDssH8g@mail.gmail.com>
 <15fb406a-0f12-4708-abe7-91a464fecbc2@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15fb406a-0f12-4708-abe7-91a464fecbc2@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 05:46:59PM +0200, Arnd Bergmann wrote:
> On Mon, Sep 25, 2023, at 15:20, Miklos Szeredi wrote:
> > On Mon, 25 Sept 2023 at 15:19, Christian Brauner <brauner@kernel.org> wrote:
> >>
> >> > How about passing u64 *?
> >>
> >> struct statmnt_req {
> >>         __u64 mnt_id;
> >>         __u64 mask;
> >> };
> >>
> >> ?
> >
> > I'm fine with that as well.
> 
> Yes, this looks fine for the compat syscall purpose.
> 
> Not sure if losing visibility of the mnt_id and mask in ptrace
> or seccomp/bpf is a problem though.

It's an information retrieval syscall so there shouldn't be any need to
block it and I think that this ship has sailed in general. Container
workloads should migrate from seccomp to landlock if they need to filter
system calls like this.
