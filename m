Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0533178C011
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 10:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjH2IPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 04:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjH2IPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:15:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133E4CCF
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 01:15:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9A4164120
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 08:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5EDC433C7;
        Tue, 29 Aug 2023 08:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693296917;
        bh=UShegHuhi4JkIe4eimuZYTMz0+Qos2oXdzZQibgyC18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hA07P6dcS8KwWwNgoENkKoGzVXJYVsEqC6rEImW3LWhE1SzTGqCEzC7o7XpRtymHd
         Ca9z37Q9IpnP/M3ciueOd88iOde0C1N98qS1b9v5MgeDcg0dIlX27twVWz5aM2hkuV
         fNRsR83iWohFpo8HYP3kzNn3slvmGzgzXA+CIGjX5/VhjBOvErqyFYi2rMDdVJEZWk
         xc4Ev1DPQmleqGVP2oE80jDRt8aKAFiBJwgCPZc91hcUtUZ+bXR45VEtf26p4EwsF4
         CrgkwnM+wX4xoGWJXSGTjhgXBl2Omf3OwhJikuA1SmYt3upSX2XqHQg5V132aHpIR7
         rZSc8K6Dhh4+A==
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/2] Small follow-up fixes for this cycle
Date:   Tue, 29 Aug 2023 10:15:08 +0200
Message-Id: <20230829-umgeladen-wolldecke-2b3f7e9b2088@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828-vfs-super-fixes-v1-0-b37a4a04a88f@kernel.org>
References: <20230828-vfs-super-fixes-v1-0-b37a4a04a88f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066; i=brauner@kernel.org; h=from:subject:message-id; bh=UShegHuhi4JkIe4eimuZYTMz0+Qos2oXdzZQibgyC18=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS8XclyQv5QCUNG6xkzxfqDmt/YOzrUJ8dKe19b8PMI37yu R6arOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS/o7hf9qCPzb/Z3zvNApYYnZ/1p XCTO94sU31J5grnnpXmvfrn2D4pyjxRMR7tXGKjNqVZjYumTkf1Fd8u/Uvcefj6fI64pKLeAE=
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

On Mon, 28 Aug 2023 13:26:22 +0200, Christian Brauner wrote:
> Hey Jan & Christoph,
> 
> Two small follow-up fixes for two brainos.
> I plan on getting this merged tomorrow if there aren't any objections.
> 
> Christian
> 
> [...]

Applied to the vfs.super branch of the vfs/vfs.git tree.
Patches in the vfs.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.super

[1/2] super: move lockdep assert
      https://git.kernel.org/vfs/vfs/c/345a5c4a0b63
[2/2] super: ensure valid info
      https://git.kernel.org/vfs/vfs/c/dc3216b14160
