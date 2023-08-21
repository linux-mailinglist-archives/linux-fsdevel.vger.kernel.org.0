Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456CF782D32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjHUPZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 11:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjHUPZy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25993FE
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 08:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF59461474
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 15:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDB3C433C8;
        Mon, 21 Aug 2023 15:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692631549;
        bh=XSaI4cc1jdaKotenuIZRcuK1/rETWxt7RTH2MYprPMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oBNObrFg3p+CLIyywVmEXDSq19Dnzw2ncWf3baiagHSbCBTCg2bNjgIBhyyQHl+kA
         8iEaVparkRcL5eMN8o/IFKAxp38ReRsF23DUnlkq9qBNSXbPcQuD0h3TpMFQ/udTx5
         HUxzDMEYKeMcUHnQxM1jo2NzsMRo0P/Q1Zb1HDRc0IdK5SZJBXmEqvjNEK7CGAMZIW
         CqPTyu0HM2+qSxohf6eSiMVWfC7icTvjXDztrEPXwQHbv3+bH01r7w3oqQFJRVdfoJ
         hspVfVBgfoNqVTUeAxxiDQYRDhGySIPYKXM9tWAAh6g1Lw1ux16wNVPlqZn1tBLI4X
         dk6B7lO6lyJVQ==
From:   Christian Brauner <brauner@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] libfs: Convert simple_write_begin and simple_write_end to use a folio
Date:   Mon, 21 Aug 2023 17:25:43 +0200
Message-Id: <20230821-heirat-sargnagel-612e6ec4dccf@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821141322.2535459-1-willy@infradead.org>
References: <20230821141322.2535459-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074; i=brauner@kernel.org; h=from:subject:message-id; bh=XSaI4cc1jdaKotenuIZRcuK1/rETWxt7RTH2MYprPMw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8bvxyaUf9L0Y916bLWTM1jE67XTjLp9BldO76+/Nvv4vN apuu0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRqbMY/mfviMwLroy2dK9+EDRXRc HUTsallDG61bTmVFeE7K5cL0aGQ643d06paKk5ekXW7cysIxF/LT4cUnjvVS9gt9E+R66ZAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 21 Aug 2023 15:13:22 +0100, Matthew Wilcox (Oracle) wrote:
> Remove a number of implicit calls to compound_head() and various calls
> to compatibility functions.  This is not sufficient to enable support
> for large folios; generic_perform_write() must be converted first.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] libfs: Convert simple_write_begin and simple_write_end to use a folio
      https://git.kernel.org/vfs/vfs/c/22697cef47b7
