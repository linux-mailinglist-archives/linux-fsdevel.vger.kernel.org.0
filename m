Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF8738494
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 15:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjFUNNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 09:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjFUNNB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:13:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4981739;
        Wed, 21 Jun 2023 06:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEB3D614BF;
        Wed, 21 Jun 2023 13:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F80C433C0;
        Wed, 21 Jun 2023 13:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687353178;
        bh=xkP28nQB96Oh4QiVptT3fJHnDXTgi6IiTCAHtTa0K4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEtlNSTxLmGwdRcOyd106AaQJqPM1T2rjODQDd6SoE40Sz+PEaxElGYTWwxYjMWe0
         zxlhi3+C7Slk4LUL8A4Ha2btgW3FDivOBi4RbyOEAzPbXh8M37rF6McPczNCSSriYt
         kuIRjz5B/0tNdCiYeyC/aLPpe14hqJep1g/QOXrmfSvn7EHjDFPWgHOd1bR1Ogjla+
         beVmUX/7Dz9f66BKtkapFKG0yJlN+ZMsxvuCaalQvwuuCFpePvfciRhuP0T66nQhAz
         Vm+/kmSZv/vDRo8UUw6TXkQsSP1AE9jMg13L8f34giADc98PNgeH02YiWd2WbhtcQ+
         dhYz0NmYppBVg==
From:   Christian Brauner <brauner@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] readdir: Replace one-element arrays with flexible-array members
Date:   Wed, 21 Jun 2023 15:12:41 +0200
Message-Id: <20230621-frohe-kegeln-3549bb239263@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZJHiPJkNKwxkKz1c@work>
References: <ZJHiPJkNKwxkKz1c@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=brauner@kernel.org; h=from:subject:message-id; bh=xkP28nQB96Oh4QiVptT3fJHnDXTgi6IiTCAHtTa0K4M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRM+i4R8fv3hjlrX4bcDFoR/r3tk+oFo0M5QbPe3l8pt+zP XvdrKh2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATEZJhZOg0Ykgq+rly2b+n9eFz2I 7Nk3i6v2rv9wU3uXf5yPvMfhTH8E/9Xl24fHmR+8c1J1SrtmxaXxV1aMHWrCTlqRZme76dlGEAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 20 Jun 2023 11:30:36 -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in multiple structures.
> 
> Address the following -Wstringop-overflow warnings seen when built
> m68k architecture with m5307c3_defconfig configuration:
> In function '__put_user_fn',
>     inlined from 'fillonedir' at fs/readdir.c:170:2:
> include/asm-generic/uaccess.h:49:35: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>    49 |                 *(u8 __force *)to = *(u8 *)from;
>       |                 ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
> fs/readdir.c: In function 'fillonedir':
> fs/readdir.c:134:25: note: at offset 1 into destination object 'd_name' of size 1
>   134 |         char            d_name[1];
>       |                         ^~~~~~
> In function '__put_user_fn',
>     inlined from 'filldir' at fs/readdir.c:257:2:
> include/asm-generic/uaccess.h:49:35: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>    49 |                 *(u8 __force *)to = *(u8 *)from;
>       |                 ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
> fs/readdir.c: In function 'filldir':
> fs/readdir.c:211:25: note: at offset 1 into destination object 'd_name' of size 1
>   211 |         char            d_name[1];
>       |                         ^~~~~~
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] readdir: Replace one-element arrays with flexible-array members
      https://git.kernel.org/vfs/vfs/c/2507135e4ff2
