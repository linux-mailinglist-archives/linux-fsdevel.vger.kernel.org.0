Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE835726A1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 21:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjFGTrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 15:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjFGTrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:47:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F34F2102;
        Wed,  7 Jun 2023 12:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA86364337;
        Wed,  7 Jun 2023 19:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F2CC4339B;
        Wed,  7 Jun 2023 19:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686167225;
        bh=75h7WJz25lMPAMfQcgH7F+k6bNvFGYHYbc1gBOEj+p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mz/NBg0wNHHi2pQoYMUS9RwNafR0DA+zLFXI4QZiZA3SenqacejK7wGVJ9lsYN9rq
         Q59sz/eSg9JOYqDLkOQOWfZPfLKLta8ySq4iljG/Au8wJZ8f6ZEp9QmzZlkwML0Cf3
         kMXsV0TCPTRYqpQ/Uxvu2YzB5wQrwakRd0f3gLUiMbZBwgUrWFx23iGxSlpW6fhUmB
         GWK2tgv9RkkCSOSZbjMcrNW0tSRL0Y2OIQjhkGIFALsG7jTnWYH9pZepH8PWi3xxrw
         iiP54gvwt8iAm09ZpkxKlhZzsPxpPOnTA6bhDunThfeW1GL2adjQbgByu4+3nZXElx
         MbAiCRMytsOgQ==
From:   Christian Brauner <brauner@kernel.org>
To:     =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzag@redhat.com>, stable@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: avoid empty option when generating legacy mount string
Date:   Wed,  7 Jun 2023 21:46:48 +0200
Message-Id: <20230607-nussbaum-erleben-33b0998d9aa0@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607-fs-empty-option-v1-1-20c8dbf4671b@weissschuh.net>
References: <20230607-fs-empty-option-v1-1-20c8dbf4671b@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=brauner@kernel.org; h=from:subject:message-id; bh=75h7WJz25lMPAMfQcgH7F+k6bNvFGYHYbc1gBOEj+p8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ03Fty98uBz277JlX2TOCLfy3JMT979vrvzeYL1FzsxNuD zj7731HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARnxuMDJMDmfqWTuD4subfR7b4S/ OY+K5eY7R6V3O6gvUtI1fuU2dGhn1Ks0/Z2av/PK32Yu3m8sVXbrd8lzsi0pHbdTzjr/yUw+wA
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

On Wed, 07 Jun 2023 19:28:48 +0200, Thomas Weißschuh wrote:
> As each option string fragment is always prepended with a comma it would
> happen that the whole string always starts with a comma.
> This could be interpreted by filesystem drivers as an empty option and
> may produce errors.
> 
> For example the NTFS driver from ntfs.ko behaves like this and fails when
> mounted via the new API.
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

[1/1] fs: avoid empty option when generating legacy mount string
      https://git.kernel.org/vfs/vfs/c/de3824801c82
