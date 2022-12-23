Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC01654F48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 11:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiLWKre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 05:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiLWKrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:47:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBA92EFA0;
        Fri, 23 Dec 2022 02:47:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4A3EB82047;
        Fri, 23 Dec 2022 10:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24284C433EF;
        Fri, 23 Dec 2022 10:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671792449;
        bh=ex9tUFVzc3QpNndS9PcMpEixDO6l3s3FIt9ke6UH+ZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ka70E5tliEuEJuR8BXOIfpsdrB8M3Ypxmi8HmSwwAgr+652FYThaXtjy9LMDQ89n+
         2n5/b2Ca34ShyUWa8l8C6bbRPwSt6koWzxNoTd860eZcPF6tdSZ87LxEnBwGXevYhD
         lGioDkksupu6H8Tdi+tNbaXYi2XTogjCsFLJT3rDihEQ+W7v+PwKD+9bGbUANus4iV
         a8ALJKh39Q7v00Hg5RhZVzrxj4L1ouW1ktcyYown5kKjg6Qo9zPm34rON2gYICJVqO
         cO162Ao1DpYeAK4iUGx3W0N+rToXUhIr1d6g9NEAeS/8LbF2EC1AVaquHZ79Ad3dVY
         IIABKhvvgyR2A==
Date:   Fri, 23 Dec 2022 11:47:24 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] posix_acl: Use try_cmpxchg in get_acl
Message-ID: <20221223104724.uurfko6bqzpjv5n5@wittgenstein>
References: <20221221193540.10078-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221221193540.10078-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 21, 2022 at 08:35:40PM +0100, Uros Bizjak wrote:
> Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old
> in get_acl. x86 CMPXCHG instruction returns success in ZF flag,
> so this change saves a compare after cmpxchg (and related move
> instruction in front of cmpxchg).
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> ---

Looks ok to me. But it's not urgent so I'll circle back to this post
-rc1.

Thanks!
Christian
