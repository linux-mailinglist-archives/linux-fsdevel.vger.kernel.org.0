Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E113478EDF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 15:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245349AbjHaNCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 09:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjHaNCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:02:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F741A4;
        Thu, 31 Aug 2023 06:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48F08B8228F;
        Thu, 31 Aug 2023 13:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8901CC433C9;
        Thu, 31 Aug 2023 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693486920;
        bh=m6Nl6Id8RoMewEtH5d20+zLMfYasZ5KSlv3RtZKHV3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NE83sSaLByG8i26eCcjMTDtoO6coDvgiqce0pkCSzpQQBhmgnCzqEWvbHN8a9kRdC
         yn7vSFbUIgitryijAyyyV0BvqpP7W0/Cy+gAcBX7XptP2fCXKPB4wv997NmU+P0+YX
         W26C4QMO1+RU25GNiA0jGUi30dcoeZkRmPh28DWiChzwRJAgVbO/TPkem5Tl8E2BjA
         YQo5OfD7N6PZQ44R6WdOXz9o1/FH4bD3Mlm6xjIWORIvOcWizKJeALcOzB3eFRAWu9
         NxKxTglZepw8T8e2j2LLgAFkhMVwcdRAUuPuWUIf836TCDsp9dGw2n4u5qReZQrBsM
         2Bgqr8y5gkMIg==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: have setattr_copy handle multigrain timestamps appropriately
Date:   Thu, 31 Aug 2023 15:01:52 +0200
Message-Id: <20230831-fernbedienung-ovale-4232fdd5bff6@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830-kdevops-v1-1-ef2be57755dd@kernel.org>
References: <20230830-kdevops-v1-1-ef2be57755dd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422; i=brauner@kernel.org; h=from:subject:message-id; bh=m6Nl6Id8RoMewEtH5d20+zLMfYasZ5KSlv3RtZKHV3Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR86Le88eGrcdMPxkOZ88RXFDFezVZeb/F+vceTVsFlkkvW snPXdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEQZaR4abV677d3at5j4REGvtHKj xfn2fiN+vaGieG/xrXFlRfvsbI8HP/0ylV7YvubTcKOr3G/jZ3hf7ri9EXbJ57PtXSvvszlBsA
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

On Wed, 30 Aug 2023 14:28:43 -0400, Jeff Layton wrote:
> The setattr codepath is still using coarse-grained timestamps, even on
> multigrain filesystems. To fix this, we need to fetch the timestamp for
> ctime updates later, at the point where the assignment occurs in
> setattr_copy.
> 
> On a multigrain inode, ignore the ia_ctime in the attrs, and always
> update the ctime to the current clock value. Update the atime and mtime
> with the same value (if needed) unless they are being set to other
> specific values, a'la utimes().
> 
> [...]

Picking this into vfs.ctime. Let me know if this has to go somewhere else.

---

Applied to the vfs.ctime branch of the vfs/vfs.git tree.
Patches in the vfs.ctime branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.ctime

[1/1] fs: have setattr_copy handle multigrain timestamps appropriately
      https://git.kernel.org/vfs/vfs/c/2846ab555339
