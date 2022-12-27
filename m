Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B998656DFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Dec 2022 19:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiL0SbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Dec 2022 13:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiL0SbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Dec 2022 13:31:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9B7BFF
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Dec 2022 10:31:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 582D26121B
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Dec 2022 18:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C93C433D2;
        Tue, 27 Dec 2022 18:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672165879;
        bh=nB4ru9tkR0qa7+bU+9/jwEqWzAyoAdbJCSBMapAoNcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kdn2dmixZS7YhVKU6/UQu3t4XTJYB2IgUhh7QTY5w0cqTYrTwTNvOVO7RYINNc2h/
         FuZ7zsI+6XayGVfKsKRQZdd4joEAX5E9CLHe16nWhMmIUfXgaCtbLo5ajcc9FLpnJZ
         16P8n+V5bhNYtu3BlFzl/uKfE/lSdi3ir6mt2a6ReYBj5T/23qs6uzz6IHSaSj+4YW
         do0NwGaIPHbZ6gbsjXPjgMiXRdqSNDQVz1jNYj2P57odEmRAdyoEzkAcYKwBMF0oDE
         X7fte34O49CtevTfyOQUBZjUCLL+Rb9JPrY/gUALM4ZEdhxHKWI3rMq3m8rxVehY06
         VSoC28NKUBIiQ==
Date:   Tue, 27 Dec 2022 19:31:15 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "J. R. Okajima" <hooanon05g@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] acl updates for v6.2
Message-ID: <20221227183115.ho5irvmwednenxxq@wittgenstein>
References: <20221212111919.98855-1-brauner@kernel.org>
 <29161.1672154875@jrobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29161.1672154875@jrobl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 28, 2022 at 12:27:55AM +0900, J. R. Okajima wrote:
> Hello,
> 
> Christian Brauner:
> > This series passes the LTP and xfstests suites without any regressions. For
> > xfstests the following combinations were tested:
> 
> I've found a behaviour got changed from v6.1 to v6.2-rc1 on ext3 (ext4).

Hey, I'll try to take a look before new years.

But what xfstests exactly is reporting a failure?
What xfstests config did you use?
How can I reproduce this?
Did you bisect it to this series specifically?

Thanks!
Christian

> 
> ----------------------------------------
> on v6.1
> + ls -ld /dev/shm/rw/hd-test/newdir
> drwxrwsr-x 2 nobody nogroup 1024 Dec 27 14:46 /dev/shm/rw/hd-test/newdir
> 
> + getfacl -d /dev/shm/rw/hd-test/newdir
> # file: dev/shm/rw/hd-test/newdir
> # owner: nobody
> # group: nogroup
> # flags: -s-
> 
> ----------------------------------------
> on v6.2-rc1
> + ls -ld /dev/shm/rw/hd-test/newdir
> drwxrwsr-x+ 2 nobody nogroup 1024 Dec 27 23:51 /dev/shm/rw/hd-test/newdir
> 
> + getfacl -d /dev/shm/rw/hd-test/newdir
> # file: dev/shm/rw/hd-test/newdir
> # owner: nobody
> # group: nogroup
> # flags: -s-
> user::rwx
> user:root:rwx
> group::r-x
> mask::rwx
> other::r-x
> 
> ----------------------------------------
> 
> - in the output from 'ls -l', the extra '+' appears
> - in the output from 'getfacl -d', some lines are appended
> - in those lines, I am not sure whether 'user:root:rwx' is correct or
>   not. Even it is correct, getfacl on v6.1 didn't produce such lines.
> 
> Is this change intentional?
> In other words, is this patch series for a bugfix?
> 
> 
> J. R. Okajima
