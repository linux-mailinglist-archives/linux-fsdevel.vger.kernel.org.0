Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB355ACE94
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiIEJIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 05:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiIEJIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA88A4F690;
        Mon,  5 Sep 2022 02:08:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 620016118A;
        Mon,  5 Sep 2022 09:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A450C433D6;
        Mon,  5 Sep 2022 09:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662368896;
        bh=S2p2RLiAi4qCOG2G2v8yboDeC5W0c2K+DwY7rJTXPE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAodLkEOM0uh9XXgMZ1gMB2ypQ+Jr4jGT+WX2Sm6hs4rY6kJ9FlHK42AISP3LPvO7
         SuxEXRjHelJGM0mGwfPh9vvheHyViVXD7rAXRukwnMA+suY0Au1gHhS0PnNg4QDK5t
         4/X5aQPCF/D3rZGiNQO7ij28tAFsmMc4lmm9Om1VX8ZDHdVPUzW2WmnfIEcOwUUgwy
         szAWlZAncDiemkJdYCu44iFFsYlnajlKlZcYbF+c+UjKz/F/W8dZ8044zugYQbowbz
         +74P5CeiCLJlb1w4bIAs3Ek+Kh+stJQYQmAzXhyPO6ox2YJ+FDxBVkuONtA1Xy1sFv
         RHXh8nEE0cnSw==
Date:   Mon, 5 Sep 2022 11:08:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>, Vasily Averin <vvs@openvz.org>
Subject: Re: [PATCH 0/2] fs: fix capable() call in simple_xattr_list()
Message-ID: <20220905090811.ocnnc53y2bow7m3i@wittgenstein>
References: <20220901152632.970018-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220901152632.970018-1-omosnace@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 05:26:30PM +0200, Ondrej Mosnacek wrote:
> The goal of these patches is to avoid calling capable() unconditionally
> in simple_xattr_list(), which causes issues under SELinux (see
> explanation in the second patch).
> 
> The first patch tries to make this change safer by converting
> simple_xattrs to use the RCU mechanism, so that capable() is not called
> while the xattrs->lock is held. I didn't find evidence that this is an
> issue in the current code, but it can't hurt to make that change
> either way (and it was quite straightforward).

Hey Ondrey,

There's another patchset I'd like to see first which switches from a
linked list to an rbtree to get rid of performance issues in this code
that can be used to dos tmpfs in containers:

https://lore.kernel.org/lkml/d73bd478-e373-f759-2acb-2777f6bba06f@openvz.org

I don't think Vasily has time to continue with this so I'll just pick it
up hopefully this or the week after LPC.

Christian
