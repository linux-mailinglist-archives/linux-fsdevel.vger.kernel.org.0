Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC04970D8F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 11:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbjEWJ11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 05:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbjEWJ1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 05:27:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAA6102;
        Tue, 23 May 2023 02:27:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD0DB62EB0;
        Tue, 23 May 2023 09:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DFCC433EF;
        Tue, 23 May 2023 09:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684834044;
        bh=IUrdaNLqIx/2k/BkZ+Swg4n2KP9d9NG4z8/sFcd3UFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K9p8/R/2GOLJ+gglD8sAEXiHT3l92ycui7awQIL+0u634XoNaf+VS3sPMuzloNS+D
         w3KYTh+U+MARjO8FnTnp93zK1rUlP1JC2Wf3GV6iEmQ7tFLxsVA6WNeh4B2gO6A5A9
         QDqgYxw44mJwg2reUkVgDWAaXGXgpboVLlQ4fgXgW10ZM5kZS9/EbhHiVWjphhUkmK
         Tcu/d2668TFe8b9fnCqtPBGmBnjVE+TD3bFapyad+d2yU+8PN7L4G9LQi5dqOmIRfP
         76/08+oJtkGSjpwqyj3OYuw+pKUA3SeFpocQqnaxo1S1Uj0VvaBMef70MLvrP+LiRW
         4GUJNlQMyKQug==
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 20/32] vfs: factor out inode hash head calculation
Date:   Tue, 23 May 2023 11:27:06 +0200
Message-Id: <20230523-plakat-kleeblatt-007077ebabb6@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230509165657.1735798-21-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev> <20230509165657.1735798-21-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=brauner@kernel.org; h=from:subject:message-id; bh=IUrdaNLqIx/2k/BkZ+Swg4n2KP9d9NG4z8/sFcd3UFw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTktD1MkmSOvBvDGd7YnhPg3nj0/9WP9pd/Pr2ibmqWWGxy zSW3o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIyuxgZFjxfFJHp7Nf0WHRDtMdCwZ +cWX/tjARO/rs99Re3S47Od4a/Ym8mrPAQ5jybq3/9z+qFXH4W9yoMGPy+Xa1p28i6x+wUOwA=
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

On Tue, 09 May 2023 12:56:45 -0400, Kent Overstreet wrote:
> In preparation for changing the inode hash table implementation.
>
>

This is interesting completely independent of bcachefs so we should give
it some testing.

---

Applied to the vfs.unstable.inode-hash branch of the vfs/vfs.git tree.
Patches in the vfs.unstable.inode-hash branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.unstable.inode-hash

[20/32] vfs: factor out inode hash head calculation
        https://git.kernel.org/vfs/vfs/c/b54a4516146d
