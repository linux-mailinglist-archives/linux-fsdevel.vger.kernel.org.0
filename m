Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D5E5E6708
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 17:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiIVP0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 11:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiIVP0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35977EFA62
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 08:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4E7A6360E
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 15:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869A3C433C1;
        Thu, 22 Sep 2022 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663860400;
        bh=1z4C3cDhuxGjXB0UME6NYaxyTnTBqPKAuFOfp1Tv8Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UIKPtp7sb9E7s83LyAsYXaJoWQ86lWEODey4lp7akRkjR1tmHSnVLKn195i06BDAi
         Xpnb+L7lmX18qTozO7iHRtX1Gb8DCIsh/SZXYhqkJm/fDZ9qUP20qELyZVMgs5Togg
         TICsZBOVs9SBole6a52QyeZAEqCJPes6Bsk7DVYrc4jfQu3+Xj1JSoxG+RTDW5Hpch
         fvKjbl86wjcgxzXTo4kNq8ElEVqzBeJUwACJnZ+iha0WhqCvHtM4OuzhcT0Zs/09Jy
         r94Fc8SVKcXJNjve9u+59FOUXswq+6Ajgw3EleFzNWvlpy/EKITrAEGjct3jUZYSRb
         LZL3slrfraTkQ==
Date:   Thu, 22 Sep 2022 17:26:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v4 05/10] cachefiles: use vfs_tmpfile_open() helper
Message-ID: <20220922152635.2we3o4gso7t4pmmu@wittgenstein>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
 <20220922084442.2401223-6-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220922084442.2401223-6-mszeredi@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:44:37AM +0200, Miklos Szeredi wrote:
> Use the vfs_tmpfile_open() helper instead of doing tmpfile creation and
> opening separately.
> 
> The only minor difference is that previously no permission checking was
> done, while vfs_tmpfile_open() will call may_open() with zero access mask
> (i.e. no access is checked).  Even if this would make a difference with
> callers caps (don't see how it could, even in the LSM codepaths) cachfiles
> raises caps before performing the tmpfile creation, so this extra
> permission check will not result in any regression.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

With the may_open() in vfs_tmpfile_open() we hopefully won't cause any
issues for this but it seems unlikely,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
