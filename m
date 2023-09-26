Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D17AEEBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjIZOOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjIZOOG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:14:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EF3CE;
        Tue, 26 Sep 2023 07:13:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B459C433C8;
        Tue, 26 Sep 2023 14:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695737639;
        bh=K//I43pYNKd0hnss16g14ct+ZnACMgfq5k78PInDtpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jM72ZyHDERi5MoaOIk8F1nPCYuqmGr926Zxyt1R9Ams/B2Dmh61pjKGcF0hvpsq0J
         JbhWAXvSVBrkGHjwDCwZClOpMIOeYIZuMhmE2rXJ87sIFv0ldHHeOojd9OTihiutVx
         eB94jEPvPRnErhVdfvgzBhSTD3NR2eCA6ubNEKxuEno4bMTORarrO8M50qZanj2que
         8MzAk2BTDAJw4PpZNMq9z0YwrPY2mbtWEgDfDpoI/8OIlAHGYG2pJ3pui6Ibdau4qb
         OnNzbOELCPoRLdC9N+/kBokqQsrp7Spdz6MfHH0+dVHTfwhu3NSjfqZ6qpn4mknJzY
         4RT8Nifedfbzg==
Date:   Tue, 26 Sep 2023 16:13:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
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
Message-ID: <20230926-flatterhaft-nachverfolgen-4bf7f78cc0ee@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
 <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner>
 <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <871qeloxj0.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871qeloxj0.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I also don't quite understand the dislike of variable-sized records.
> Don't getdents, inotify, Netlink all use them?  And I think at least for
> Netlink, more stuff is added all the time?

Netlink is absolutely atrocious to work with because everything is
variable sized and figuring out the correct allocation size is a
complete nightmare even with the "helpful" macros that are provided.

The bigger problem however is the complete untypedness even of the most
basic things. For example, retrieving the mtu of a network interface
through netlink is a complete nightmare. getdents, inotify, fanotify,
open_by_handle_at()'s struct fiel_handle are all fine. But let's
absolutely not take netlink as a model for anything related to mounts.

And no one is against again variable sized records per se. I think we're
coming to a good compromise here.
