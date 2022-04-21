Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3243D5098F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 09:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385736AbiDUH1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 03:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385732AbiDUH13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:27:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D276183AC;
        Thu, 21 Apr 2022 00:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8077B8229B;
        Thu, 21 Apr 2022 07:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53182C385A1;
        Thu, 21 Apr 2022 07:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650525878;
        bh=95qv/mzlhfG1VVXD4CfUUhHWp9mU3YVW3h2A2kkM9aQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3d5XrguhhyWnnHyDh7SBzufBbKpx1wNgC7Q32fe7LL1ftcjJUflE5ljsUp8kn6+m
         xsZ7RLlzBLJHfYRU05KOIFh5091UFRh68N9ZyePzlPCnLwVV5rTNi69VHJUGldhEbh
         P0wsc9KVaclIdmxcL5S4fVDhxNo2LcPla8xkUYn37b/k6fHxAy3xokL9cQoPVsx8Wj
         Fq8zTZPdF+VXPXhuZ3WlyNvP9Y7/SDCRUooSA96Udj8KqR7Gopv3dJ5hntAfvIpBcW
         CxX0HES3hxaUPSI04XOcHY/WyHDQohcHbUl7w6nSp/m+8SIJSvZPGilITqYSY9Dl3k
         4EKaTVld3ZMKQ==
Date:   Thu, 21 Apr 2022 09:24:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        willy@infradead.org, jlayton@kernel.org
Subject: Re: [PATCH v5 2/4] fs: Add missing umask strip in vfs_tmpfile
Message-ID: <20220421072433.xtgamsjy3nbe44hl@wittgenstein>
References: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650527658-2218-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650527658-2218-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 03:54:16PM +0800, Yang Xu wrote:
> All creation paths except for O_TMPFILE handle umask in the vfs directly
> if the filesystem doesn't support or enable POSIX ACLs. If the filesystem
> does then umask handling is deferred until posix_acl_create().
> Because, O_TMPFILE misses umask handling in the vfs it will not honor
> umask settings. Fix this by adding the missing umask handling.
> 
> Reported-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

So given that we seem to all agree that the missing umask stripping is a
bug and not intentional because of special O_TMPFILE semantics (which
wouldn't have suprised me tbh...) this should get a:

Fixes: 60545d0d4610 ("[O_TMPFILE] it's still short a few helpers, but infrastructure should be OK now...")
Cc: <stable@vger.kernel.org> # 4.19+

If people feel comfortable it'd be great to get some more acks on this
or an explanation why umask doesn't need to be stripped in this case...
