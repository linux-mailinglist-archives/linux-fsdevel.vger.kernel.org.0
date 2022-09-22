Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D075E66F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 17:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiIVPX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 11:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiIVPX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:23:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A606F858A
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 08:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5D17B8384C
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 15:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6650C433D6;
        Thu, 22 Sep 2022 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663860204;
        bh=hkdW3InphBGzX0x+ezd00Kwhp28YJTtjRTY4gAbmOf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBGxCHolA+4UzIKjucA0X2AP0i3pFKHe5Aw6pZAp0/BjBodclHaJByREBc3oQ+Fxy
         WezXAxQKsMXoxzRM4rW+EFnoBRQuTa1mptA/aOh4oTftjOjA/ysG61ozdJvkGdy5dU
         4ON9RkklYRJDMvItKICD1i3ZxWnYG+KOvVvhDu/6M/JGA/8UUy3JdcZ9qqfu6JGKxI
         4b/ZMYS7Kdoxieg219rGbUTtp1xFESiiqAPM5vGrgFMhTxLtPgaQkrLH2Nq75ii2Ik
         HzfMiNiTdsyhXr4IuUu1TkBf3WvXXNmEjfBp/5rin5tvrafck9V2m2UHAwxO9Ui35S
         kIDk6zHr8AcTA==
Date:   Thu, 22 Sep 2022 17:23:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v4 01/10] vfs: add vfs_tmpfile_open() helper
Message-ID: <20220922152314.rp7lc45iu34egutr@wittgenstein>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
 <20220922084442.2401223-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220922084442.2401223-2-mszeredi@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:44:33AM +0200, Miklos Szeredi wrote:
> This helper unifies tmpfile creation with opening.
> 
> Existing vfs_tmpfile() callers outside of fs/namei.c will be converted to
> using this helper.  There are two such callers: cachefile and overlayfs.
> 
> The cachefiles code currently uses the open_with_fake_path() helper to open
> the tmpfile, presumably to disable accounting of the open file.  Overlayfs
> uses tmpfile for copy_up, which means these struct file instances will be
> short lived, hence it doesn't really matter if they are accounted or not.
> Disable accounting in this helper too, which should be okay for both
> callers.
> 
> Add MAY_OPEN permission checking for consistency.  Like for create(2)
> read/write permissions are not checked.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Seems good to me. Again, I'd change at least the flow of this function
but as it's reworked in later patches it probably doesn't matter much:
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
