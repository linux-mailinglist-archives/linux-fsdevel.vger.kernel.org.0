Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF418702668
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 09:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbjEOHvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 03:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbjEOHuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 03:50:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FAD1985;
        Mon, 15 May 2023 00:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F6536140B;
        Mon, 15 May 2023 07:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733DBC433D2;
        Mon, 15 May 2023 07:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684137038;
        bh=ae5VwYIxEjqbexaMut9c4sfZ65ZBScjHyi86EtHkf1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YyLJALqoGRYFOhVY63TWZPiZ/wJ6Vy22syFcUSlf3Obvd6Nx1XWnNf1aFvmfQFLZC
         isIaunbOZlxXEe40NOuqWS+GIUCywbEY58hzKSARleY0IIzIRp0LbsYLY6JBVXkDK6
         8hosyvTt+87Vn0saH0ptzi7wL+ve5VRTgzm086CDNYZiuNDKgGWkMk+CYVgP07seu4
         y69gb3o1Y1mCysjTrF6uppFLB2P+v5XMXF09UpB/e4iYF7dsLwN/YzyGRw0kuojnys
         d8qpC+MtFOep3hsyPBUYVrTEV67YXJvYJ8bLLxJou5CSrAMbfeZgIyD902IpnPp1Ub
         xqhu/RDTIgoiA==
From:   Christian Brauner <brauner@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] vfs: Replace all non-returning strlcpy with strscpy
Date:   Mon, 15 May 2023 09:50:25 +0200
Message-Id: <20230515-seenotrettung-variieren-10995fad7802@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510221119.3508930-1-azeemshaikh38@gmail.com>
References: <20230510221119.3508930-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=brauner@kernel.org; h=from:subject:message-id; bh=ae5VwYIxEjqbexaMut9c4sfZ65ZBScjHyi86EtHkf1Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQkPtGXWPIs3LLc58/8MO1DdyaxJLGECLtPaLBYdtByRkbh RH3tjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInkJTD8T73ee6DAXvri/ZOML6q+nS 7g3lic43iLYWFufW2nwxb3cob/hQW2G+/y/hU6P/XNwu11Zd9mmwq2sTHFJ8vkxR2LcbLlAgA=
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

On Wed, 10 May 2023 22:11:19 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

I sincerely hope we'll be done with swapping out various string
functions for one another at some point. Such patches always seems
benign and straightforward but the potential for subtle bugs is
feels rather high...

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] vfs: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/vfs/vfs/c/3c5d4d803c60
