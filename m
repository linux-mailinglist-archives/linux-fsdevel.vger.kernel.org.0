Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721656600F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 14:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjAFNH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 08:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjAFNG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:06:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D766E406;
        Fri,  6 Jan 2023 05:06:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D771461E2B;
        Fri,  6 Jan 2023 13:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826D8C433EF;
        Fri,  6 Jan 2023 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673010417;
        bh=1qhYVDm7j1muQ6+34gjzL4UJr40kZ7yhX+GsuvoA7u8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnvsAYdW6FoAbWVo3OzFrj9soKEvjCqIdhyKr6ty1l9WD1KNt34PtgyhaF9BbRq0S
         5d99vJORsQ3Dn2gdg8KW/P6hHryxLFOVN4T0gLkGM4bWlPvyaLvI0GjC6clA9hZmS3
         8Rp8vQmW5Wz4rhrUXoGq0MyAKuJ9GGvqCFK8CRMDHx3Afe1JiKt2mTH4G5iX6T9Fc8
         CD1wMSxbq4H/rZuP02RTgYkfogCKpA2RK/t/YqpwCSiiRP1c/CVEMw1Q59fMBY35/X
         FBG7jOA1wgmRBcOgrdQJLkko0qhxfdAFF/0oXGwLwp8h4K3Lq7mfXwN3AnWnakB4Q7
         9uj0HA+skT1cQ==
Date:   Fri, 6 Jan 2023 14:06:51 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Ameer Hamza <ahamza@ixsystems.com>
Cc:     viro@zeniv.linux.org.uk, jlayton@kernel.org,
        chuck.lever@oracle.com, arnd@arndb.de, guoren@kernel.org,
        palmer@rivosinc.com, f.fainelli@gmail.com, slark_xiao@163.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, awalker@ixsystems.com
Subject: Re: [PATCH] Add new open(2) flag - O_EMPTY_PATH
Message-ID: <20230106130651.vxz7pjtu5gvchdgt@wittgenstein>
References: <20221228160249.428399-1-ahamza@ixsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221228160249.428399-1-ahamza@ixsystems.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 28, 2022 at 09:02:49PM +0500, Ameer Hamza wrote:
> This patch adds a new flag O_EMPTY_PATH that allows openat and open
> system calls to open a file referenced by fd if the path is empty,
> and it is very similar to the FreeBSD O_EMPTY_PATH flag. This can be
> beneficial in some cases since it would avoid having to grant /proc
> access to things like samba containers for reopening files to change
> flags in a race-free way.
> 
> Signed-off-by: Ameer Hamza <ahamza@ixsystems.com>
> ---

In general this isn't a bad idea and Aleksa and I proposed this as part
of the openat2() patchset (see [1]).

However, the reason we didn't do this right away was that we concluded
that it shouldn't be simply adding a flag. Reopening file descriptors
through procfs is indeed very useful and is often required. But it's
also been an endless source of subtle bugs and security holes as it
allows reopening file descriptors with more permissions than the
original file descriptor had.

The same lax behavior should not be encoded into O_EMPTYPATH. Ideally we
would teach O_EMPTYPATH to adhere to magic link modes by default. This
would be tied to the idea of upgrade mask in openat2() (cf. [2]). They
allow a caller to specify the permissions that a file descriptor may be
reopened with at the time the fd is opened.

[1]: https://lore.kernel.org/lkml/20190930183316.10190-4-cyphar@cyphar.com/
[2]: https://lore.kernel.org/all/20220526130355.fo6gzbst455fxywy@senku/Kk
