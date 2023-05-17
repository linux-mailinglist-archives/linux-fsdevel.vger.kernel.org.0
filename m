Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3301B7060F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 09:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjEQHTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 03:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjEQHTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 03:19:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E0819BD;
        Wed, 17 May 2023 00:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D77C642B8;
        Wed, 17 May 2023 07:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A00BC433D2;
        Wed, 17 May 2023 07:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684307946;
        bh=lpgoFWtGsmHy3izaeLeWv2MM633TtfJzPMe+uccB3rE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YVlUvmO1QtjInnJHnwjVmg+IUU8xOiUhVwlKCbTNbgcvrEhgP5o5+yQDjOCF22zSl
         f6HJ0SeneDbaYstBeN6H8XkHzNglFWBgZ+f3bDiZuJm/C0gUiBtZcamOU+Usr75S2B
         /tln1lU1KnHKUTWzDmqMCwP5wFkvizTXbJrb8J0SPS6GQgsKWuoZQ1Ds4ssbzM/SuS
         mkRcj5uhpOUhR2PHsmOudD6BiHJuQMs8rH/vfkbovU3LySrFHUiTMvQ1ufzC/dRDFN
         cHNVImEIllkgPJ5pk0lU7HKdfw9PHq1VnzRa340t7I83BvSl52FYYycE+lL+V42Dyw
         ZWTImTjU2cG5A==
From:   Christian Brauner <brauner@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/2] fs: d_path: include internal.h
Date:   Wed, 17 May 2023 09:18:59 +0200
Message-Id: <20230517-ratten-bezeichnen-ad20e1d5f60f@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516195444.551461-1-arnd@kernel.org>
References: <20230516195444.551461-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=brauner@kernel.org; h=from:subject:message-id; bh=lpgoFWtGsmHy3izaeLeWv2MM633TtfJzPMe+uccB3rE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSk1F85eODxtfotsnIS9he7nr3QFDD6Ebn8baf09QnhFvPF 1aewdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkUTPD/6Kcp7+Er9mvs94nvOGa8J vfLZLRlyK6du/+t0Lm3sb60HqG/8UaG8POsU7xlNYy65tTx/b/iMVDM5YLi17wLbty7MkLVUYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 16 May 2023 21:54:38 +0200, Arnd Bergmann wrote:
> make W=1 warns about a missing prototype that is defined but
> not visible at point where simple_dname() is defined:
> 
> fs/d_path.c:317:7: error: no previous prototype for 'simple_dname' [-Werror=missing-prototypes]
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/2] fs: d_path: include internal.h
      https://git.kernel.org/vfs/vfs/c/fb385a13fc9a
[2/2] fs: pipe: reveal missing function protoypes
      https://git.kernel.org/vfs/vfs/c/bf0603ebb9ee
