Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409236614D3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 12:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjAHLmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 06:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjAHLmh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 06:42:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA8DF70;
        Sun,  8 Jan 2023 03:42:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDE7A60C60;
        Sun,  8 Jan 2023 11:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D00BC433EF;
        Sun,  8 Jan 2023 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673178155;
        bh=6LYKIjMigwIeb+1vOC3fx9ezdDdKbYkCT2HN2IRrSYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UAQ4JT3wYZsFHJAbQqaq73VqX2EzHgOOxX8SpqFTXDlEK+g+CMSuhZOVsEuSnfskv
         X15YbO64OTiX7IFV2GAjAouU3imB0xOQWWgQQW5s9Qu0hp/lFlv02qw3z9chTWOg0m
         zeiH8GBVAwkOD2yBueNEguw9Be2ZpxhW7AdN5JNA71LKYRzvUP29agK/0S5lvLtcPP
         NPKzRoQuCEb02wN7KQu8cao4X5sdzI0BejAV83PVd0iVQwhFX0vdINCnj52R8An3xn
         I1fhGRJTPMFIPR/D8MnbX+i28XjRILrKsKuScoDz52tchNUfrPiT+pYINsSsHm8pJK
         iAQBfNtNXhV0g==
Date:   Sun, 8 Jan 2023 12:42:28 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] posix_acl: Use try_cmpxchg in get_acl
Message-ID: <20230108114228.3szmdq32lt25zbtp@wittgenstein>
References: <20221221193540.10078-1-ubizjak@gmail.com>
 <20221223104724.uurfko6bqzpjv5n5@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221223104724.uurfko6bqzpjv5n5@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 23, 2022 at 11:47:24AM +0100, Christian Brauner wrote:
> On Wed, Dec 21, 2022 at 08:35:40PM +0100, Uros Bizjak wrote:
> > Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old
> > in get_acl. x86 CMPXCHG instruction returns success in ZF flag,
> > so this change saves a compare after cmpxchg (and related move
> > instruction in front of cmpxchg).
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > ---
> 
> Looks ok to me. But it's not urgent so I'll circle back to this post
> -rc1.

Seems good to me. So if there are no objectsions, then applied, thanks!

[1/1] posix_acl: Use try_cmpxchg in get_acl
      commit: 4e1da8fe031303599e78f88e0dad9f44272e4f99
