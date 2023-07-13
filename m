Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D2F7528FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 18:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjGMQp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 12:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbjGMQp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:45:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD6A273F;
        Thu, 13 Jul 2023 09:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AB4061ABC;
        Thu, 13 Jul 2023 16:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265BFC433C8;
        Thu, 13 Jul 2023 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689266720;
        bh=EYt4iVezJKnvAkatfVTh6UE+U2wAlMrUTkseeDOaRrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xrm5ygEAON2Aar9YGb6Gvc8HVb6TzERYyxYHhjZ+O5/LzljdIPe53MQEyu+6HAoHz
         zxHnrtjvYdz6sknkDV31O2Ep+SjisADMjYR5kpRyq05Lis7rPixq/mX+KpGN+c01tT
         OS4jvVUJWsIY9IBSyNEVahOwK3ilHU91+8EzHoAZiKvaW5GUlqfduG8OmHNJTgELwN
         pjdJlyY4YDdEx91YwgE3gE3e42t0l8K4iJB6f4Xko6AaqCWVCYgcd0GMj53+tO57H3
         8tR6g0dbZFTFtQBo9jWhDhUiiNT5zhjtErgel6fseJ0wmYrvB1LgxhjU20eHQk3E7u
         +Pe+5tlJY2A3g==
From:   Christian Brauner <brauner@kernel.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Christian Brauner <brauner@kernel.org>, opensource.kernel@vivo.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] fs: Fix error checking for d_hash_and_lookup()
Date:   Thu, 13 Jul 2023 18:41:23 +0200
Message-Id: <20230713-verkraften-fortkommen-cbb49d8d2ea5@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713120555.7025-1-machel@vivo.com>
References: <20230713120555.7025-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=brauner@kernel.org; h=from:subject:message-id; bh=gJUuPKM4EW0q4dZ1DFgnHG6lOhKj3nmCzj4C3HBEr2s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRs0GRpPh08PV52bvahCc35T9n0Vzty/unb/vuO7trGyULO 1YvtOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSvJrhr3z/ZcZDDtfCOQvuNiwpms jN+k57p8fH6TphbE/jNzetmcvI8Gh1znL9J9+mrIyvl38fcH3/9CsxDcJpOh1qPu/cVn1ZxgAA
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

On Thu, 13 Jul 2023 20:05:42 +0800, Wang Ming wrote:
> The d_hash_and_lookup() function returns error pointers or NULL.
> Most incorrect error checks were fixed, but the one in int path_pts()
> was forgotten.
> 
> 

That one is valid but the chance of running into this issue is almost
zero. For this to be a problem a ptmx device node must have been created
on a filesystem with a custom hash function that cannot hash a three
ascii char string. The only filesystem that would reject this is
efivarfs because it has very specific expectations about naming. But it
neither allows the creation of symlinks nor device nodes and bind-mounts
of ptmx don't have that issue.

The only other candidate would be ntfs and only if an oom condition
hits. But the ntfs driver can't create any files so that device node
would have to preexist.

So all in all mostly an academic issue but still.

---

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs: Fix error checking for d_hash_and_lookup()
      https://git.kernel.org/vfs/vfs/c/5ad699137e4a
