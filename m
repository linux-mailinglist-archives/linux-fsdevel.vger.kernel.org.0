Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1943A6AB9B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 10:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjCFJXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 04:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCFJXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:23:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59E37DB7;
        Mon,  6 Mar 2023 01:23:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10E2660B1B;
        Mon,  6 Mar 2023 09:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905C7C433EF;
        Mon,  6 Mar 2023 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678094625;
        bh=YuHiNibTfvsVI3IB9f2dBIPvtAF+oVsFjShxdpWt8vI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vRHqvzLb1zE9mcjQ1jp4FZpy4X8k8BOCAlO9Bd5FU1F4TVtHEQxIzWeAF7S818xQ+
         7xK3kfsNq0N4FRkmFjgxeb0F6ohOwO36ABYH1YAeso+eRkf84EFU0ogvHt4F1UJ1RJ
         oQemTFv/ifce2YxmokP97eoLfW9/UsnnpgZxsZeJQcMQA/7ILKaFJXh9YrPt7cRamg
         RYtyJOTKXDNXB8Tey1paVCbZneSuXCyW4nM76R0EHO4qdYqbr8CIzaLd4NYRGY4Jv8
         yzWzxlwfCzfkqcpdRm8guCNMHC0sEE+P+I82LhGfpNNbQlZBEoP8fpH3vG+O9o9ih1
         nbwR4a4OxfI6A==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-mtd@lists.infradead.org, reiserfs-devel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 00/10] acl: drop posix acl handlers from xattr handlers
Date:   Mon,  6 Mar 2023 10:23:26 +0100
Message-Id: <167809442083.601764.7315016407199154883.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098; i=brauner@kernel.org; h=from:subject:message-id; bh=6frdtzvyOBNLoWw4RvF5CPVqSoJpiwQ7PJrxxeWRt78=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSwbmQwlN8kdf9RF1PvK6H2638aD35gZ2WS5V7SlrHx1a6k lP/zO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSN4nhv/tGP83DZ7cU/t0z7Qyb+v 13JVdvP12bIhN1RohDPt/PgIHhr8j29aLnKn8d6Lkdl8x5d16OtfgjxcXyB3axNO7KuBFczQ4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner (Microsoft) <brauner@kernel.org>


On Wed, 01 Feb 2023 14:14:51 +0100, Christian Brauner wrote:
> Hey everyone,
> 
> After we finished the introduction of the new posix acl api last cycle
> we still left the generic POSIX ACL xattr handlers around in the
> filesystems xattr handlers for two reasons:
> 
> (1) Because a few filesystems rely on the ->list() method of the generic
>     POSIX ACL xattr handlers in their ->listxattr() inode operation.
> (2) POSIX ACLs are only available if IOP_XATTR is raised. The IOP_XATTR
>     flag is raised in inode_init_always() based on whether the
>     sb->s_xattr pointer is non-NULL. IOW, the registered xattr handlers
>     of the filesystem are used to raise IOP_XATTR.
>     If we were to remove the generic POSIX ACL xattr handlers from all
>     filesystems we would risk regressing filesystems that only implement
>     POSIX ACL support and no other xattrs (nfs3 comes to mind).
> 
> [...]

With v6.3-rc1 out, I've applied this now. Please keep an eye out for any
regressions as this has been a delicate undertaking: 

[01/10] xattr: simplify listxattr helpers
        commit: f2620f166e2a4db08f016b7b30b904ab28c265e4
[02/10] xattr: add listxattr helper
        commit: 2db8a948046cab3a2f707561592906a3d096972f
[03/10] xattr: remove unused argument
        commit: 831be973aa21d1cf8948bf4b1d4e73e6d5d028c0
[04/10] fs: drop unused posix acl handlers
        commit: 0c95c025a02e477b2d112350e1c78bb0cc994c51
[05/10] fs: simplify ->listxattr() implementation
        commit: a5488f29835c0eb5561b46e71c23f6c39aab6c83
[06/10] reiserfs: rework ->listxattr() implementation
        commit: 387b96a5891c075986afbf13e84cba357710068e
[07/10] fs: rename generic posix acl handlers
        commit: d549b741740e63e87e661754e2d1b336fdc51d50
[08/10] reiserfs: rework priv inode handling
        commit: d9f892b9bdc22b12bc960837a09f014d5a324975
[09/10] ovl: check for ->listxattr() support
        commit: a1fbb607340d49f208e90cc0d7bdfff2141cce8d
[10/10] acl: don't depend on IOP_XATTR
        commit: e499214ce3ef50c50522719e753a1ffc928c2ec1

Christian
