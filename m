Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC3B7520AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 14:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjGMMAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 08:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjGMMAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:00:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB8F2D45;
        Thu, 13 Jul 2023 04:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89C2A61077;
        Thu, 13 Jul 2023 11:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91B6C433C7;
        Thu, 13 Jul 2023 11:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689249587;
        bh=ouScaK8v7+X9Png+HkEOnDttdXAuG7e8+D2RZ23vdxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlxwbmsSqPSxSwUe++eeDGP9hFq5f2E8zTJ+qFSvisVKxkiXmlj4KW3RgEpk5iN9i
         rdoToqFf/V5NCxxB5O4LfAfFvS8tpt5M3R02/QCJoMZAaB4vw7A6RAzWOw5aiPMzQI
         sCAlMB39uJmvgN5ipitFPGRgL8eSkNm0KtWkA/yaKoJTGlXKS71Go4dyZkvL0Gm8/h
         4z+BuN5aueoLX3MMyuL3Kdb9bvHMe0KTfcDLeXbf/EefL/SIVehkwTZgjNHISDYVZU
         o4tlYMvEV1TZoxPCQ+lheJdNwKPdUTSgStleI+JlWLayrrDqrregTPJ2E5sCB6ZAM7
         8UkrmV3vlosDw==
From:   Christian Brauner <brauner@kernel.org>
To:     =?utf-8?q?Willy_Tarreau_=3Cw=401wt=2Eeu=3E=2C_Thomas_Wei=C3=9Fschuh_=3Cl?=@vger.kernel.org,
        =?utf-8?q?inux=40weissschuh=2Enet=3E?=@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 0/2] proc: proc_setattr for /proc/$PID/net
Date:   Thu, 13 Jul 2023 13:58:48 +0200
Message-Id: <20230713-schwalben-anproben-6af2eac149fd@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
References: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510; i=brauner@kernel.org; h=from:subject:message-id; bh=ouScaK8v7+X9Png+HkEOnDttdXAuG7e8+D2RZ23vdxk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSsf/bxdUWs/+pZqS9ef/4U9WBnyL1td247iAvzdSTI2vLG HJye2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCREj9GhuWu3buCRfKVtQ7fXcNkX/ n2T9WySfqt/0uzVXV8DqQ8P8Xwz3hHX8v637wyETwHcvg3xhsbizAt63AsmBl8t3nNtFXCHAA=
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

On Sat, 24 Jun 2023 12:30:45 +0200, Thomas Weißschuh wrote:
> /proc/$PID/net currently allows the setting of file attributes,
> in contrast to other /proc/$PID/ files and directories.
> 
> This would break the nolibc testsuite so the first patch in the series
> removes the offending testcase.
> The "fix" for nolibc-test is intentionally kept trivial as the series
> will most likely go through the filesystem tree and if conflicts arise,
> it is obvious on how to resolve them.
> 
> [...]

I've picked both for now. Let me know if I should do something else.
In any case, this needs long soaking in -next.

---

Applied to the fs.proc.net.uapi branch of the vfs/vfs.git tree.
Patches in the fs.proc.net.uapi branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: fs.proc.net.uapi

[1/2] selftests/nolibc: drop test chmod_net
      https://git.kernel.org/vfs/vfs/c/49319832de90
[2/2] proc: use generic setattr() for /proc/$PID/net
      https://git.kernel.org/vfs/vfs/c/18e66ae67673
