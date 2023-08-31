Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C8778EA19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 12:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjHaKUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 06:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjHaKUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:20:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E92FCEE;
        Thu, 31 Aug 2023 03:20:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B877F624DA;
        Thu, 31 Aug 2023 10:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1943C433C7;
        Thu, 31 Aug 2023 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693477232;
        bh=SiDmbWzbEV78bSnqLoerIwfDyM53DisVmFwX+qnWIZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9TMIBlrFuxs69JgcZqbBEIqn3C3tj1i3yiCkQ25KbRRQmut6sD9xHPNvNFHD+FDp
         ztetXAzCXPYlAfajc26xgUsJ2Cy6v3NdFqOQyLvzgNrt5SdSRZD3SefRrM9QhcsmrG
         iV2+7PLqHacG9iKdhGr6av5xTPXvMhLEFUBe3/SOtv8XAxJKw+M2111h4PqkxR0n5N
         V/rFCA8wA64laVb/wB61w9JKFqX83sRyhvhxczhr32tOzvaVk+hB8ilztFeAEmEl52
         uroNkviluTX7Id7ZyWENqQsTJwzflHFW+vkAT/WlQ3g+qDuLuFX+Ahy9XJIiTeS08K
         5HubNX8VOF7Yw==
Date:   Thu, 31 Aug 2023 12:20:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: sb->s_fs_info freeing fixes
Message-ID: <20230831-dazulernen-gepflanzt-8a64056bf362@brauner>
References: <20230831053157.256319-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831053157.256319-1-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 07:31:53AM +0200, Christoph Hellwig wrote:
> sb->s_fs_info should only be freed after the superblock has been marked
> inactive in generic_shutdown_super, which means either in ->put_super or
> in ->kill_sb after generic_shutdown_super has returned.  Fix the
> instances where that is not the case.

Funny, I had looked at all those filesystems a while back to
double-check that things are sane and that's why I didn't change them.

>  arch/s390/hypfs/inode.c      |    3 +--

get_tree_single() -> single instance
=> doesn't match on sb->s_fs_info

>  fs/devpts/inode.c            |    2 +-

get_tree_nodev() -> each mount is a new instance
=> We don't match on sb->s_fs_info

>  fs/ramfs/inode.c             |    2 +-

get_tree_nodev() -> each mount is a new instance
=> We don't match on sb->s_fs_info

>  security/selinux/selinuxfs.c |    5 +----

get_tree_single() -> single instance
=> doesn't match on sb->s_fs_info

Al roughly said the same thing afaict.

I still think that there's no need to deviate from the basic logic:

(1) call generic kill_*() helper
(2) wipe sb->s_fs_info

So I think that's a cleanup we should do. Just change the rationale to
say that this deviation is pointless and just means the reader of the
code has to sanity check against the superblock helper that's used.

This btw, has confused me before too and I basically had a version of
the exchange we're now having:

https://lore.kernel.org/all/YvzUS%2F7bd1mm6c%2FV@kroah.com/T/#mee634e46448d6c88244c0c5d33f935ffdb60cb12
