Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803936756EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 15:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjATOUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 09:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjATOTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:19:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF18CE8A3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 06:19:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB7BB61F4A
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 14:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7CDC4339B;
        Fri, 20 Jan 2023 14:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674224280;
        bh=Kf8IP5LnsTj+StK7rLmLP9Hl6UB4tKGqQ6XeI158gFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbbThHsUUdkJxMZF4TErSiuZPouze2MumIvnsFzU8Wh+4cpEcR5HNPoLzvznDL0vO
         yi7FJp5Pc8JDpQZddsKyje4zKicf/fSY9mduvstOPm1yh23zA7YhizXFSa2Gj23tUy
         Hd7rjGPU2lpakfWdm6Fx6gR3cvgBpyFFCi/hqM9UCTyqUaFTGCFG8cNxwiY7zDFNaM
         MZIH7WpkyOX1cqmPemXYeRX0cuITEoKtue3y96dYiuu0UoCw30PUxWL4w49WdwAJFE
         pJsJPfRb+zQqWo+J+pdQLyqGLgAhRzaSHHzC5gYI9XEcmj+thU7EX2FLR3fpf/jqpV
         I2IdYCaO5HHpw==
Date:   Fri, 20 Jan 2023 15:17:55 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hughd@google.com,
        sforshee@kernel.org, hch@lst.de, rodrigoca@microsoft.com
Subject: Re: [PATCH] shmem: support idmapped mounts for tmpfs
Message-ID: <20230120141755.zhvr5wbfnkjsc75n@wittgenstein>
References: <20230120094346.3182328-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230120094346.3182328-1-gscrivan@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 10:43:46AM +0100, Giuseppe Scrivano wrote:
> This patch enables idmapped mounts for tmpfs when CONFIG_SHMEM is defined.
> Since all dedicated helpers for this functionality exist, in this
> patch we just pass down the idmap argument from the VFS methods to the
> relevant helpers.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Tested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---

Tested this and it works nicely for me. I did test:

* xfstests without and with idmapped mounts.
  They pass without introducing any new failures.
* Mounting tmpfs inside of an unprivileged container, then creating an
  idmapped mount of tmpfs and sharing that mount with a nested
  container.

I tested POSIX ACLs, fscaps, ownership changes, set{g,u}id inheritance.

I'll also let Seth take a look but otherwise this look good.
Thanks for picking that up!

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Hugh, if you're fine with this patch then I would ask you whether you
would allow me to take this patch since it's on top of other patches.
They are non-functional changes but not basing this patch on top of them
would cause yet more merge conflicts.
