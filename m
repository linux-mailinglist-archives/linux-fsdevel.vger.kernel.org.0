Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519D87269F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 21:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjFGTjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 15:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjFGTjI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284AD1FFA;
        Wed,  7 Jun 2023 12:39:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB12F61638;
        Wed,  7 Jun 2023 19:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FA4C433D2;
        Wed,  7 Jun 2023 19:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686166746;
        bh=lJeVIY8wRq/hgKma1+bBxZkFcZZ5cDlDkWbOyNaXnvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xz4QBOE+GgOXGoIFplwIU3a6LHqreR0Xv5BE+kO/1uA1Rf+jVP/UA6h33xPRokanN
         mbZnvfTuqd94S5u8WhzI7Er5R69VI+hhEry+yLmvtlpyvOiVvjYciPdXekoJfBsXsO
         xoUOxxam6HMvk3vLSJTxOjk7qZ8ce+35EcCcHnD5Yx8UMxNjFQTAImfqBbbWPA0Hfa
         uD8PM9rE6HhE1jyzsMi6ucAUZZ5oaJihxDVUk+/U0OmJMsJQzpXtl5NibPAbVF7mW5
         UHNyEIJ69TiOrCWJTBPrLaMODZT8jzF5HVMPdRoyhr2dB5enllvlPMzkhlF8YP2yva
         WpDe4GTMX6jZA==
Date:   Wed, 7 Jun 2023 21:39:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzag@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] fs: avoid empty option when generating legacy mount
 string
Message-ID: <20230607-rennpferd-stechen-2f645ac78fcc@brauner>
References: <20230607-fs-empty-option-v1-1-20c8dbf4671b@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607-fs-empty-option-v1-1-20c8dbf4671b@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 07:28:48PM +0200, Thomas Weißschuh wrote:
> As each option string fragment is always prepended with a comma it would
> happen that the whole string always starts with a comma.
> This could be interpreted by filesystem drivers as an empty option and
> may produce errors.
> 
> For example the NTFS driver from ntfs.ko behaves like this and fails when
> mounted via the new API.
> 
> Link: https://github.com/util-linux/util-linux/issues/2298

Yeah, the old ntfs driver implements its own option parser. It
overwrites/splits at ',' returning '\0' and then trips over this.

Contrast with e.g., ovl_next_op() which does the same thing but skips
over '\0' in ovl_parse_opt().

So arguably also a bug in ntfs parsing. But there's no reason we should
prepend ',' for legacy mount option strings.

And yeah, I can easily verify this...

Using my custom move-mount tool I originally wrote for another patchset
but which is handy to pass mount options via the new mount api _system_
calls and not via mount():
https://github.com/brauner/move-mount-beneath

I can do:

        sudo ./move-mount -f overlay -olowerdir=/mnt/a:/mnt/b,upperdir=/mnt/upper,workdir=/mnt/work /mnt/merged

and clearly see:

        > sudo bpftrace -e 'kfunc:legacy_get_tree { @m = args->fc; printf("%s\n", str(((struct legacy_fs_context *)@m->fs_private)->legacy_data)); }'
        Attaching 1 probe...
        ,lowerdir=/mnt/a:/mnt/b,upperdir=/mnt/upper,workdir=/mnt/work

> Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock creation/configuration context")

Should be:

Fixes: commit 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock creation/configuration context")

and misses a:

Cc: stable@vger.kernel.org

I'll fix this up for you though.
