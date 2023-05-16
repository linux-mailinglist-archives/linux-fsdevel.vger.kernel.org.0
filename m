Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CC470505D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjEPORu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjEPORq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 10:17:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA217A92;
        Tue, 16 May 2023 07:17:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AD1063AA0;
        Tue, 16 May 2023 14:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D71CC4339B;
        Tue, 16 May 2023 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684246664;
        bh=zbu+/n1x0xP+L4aQcQ1ZrPVzWz9/XfixfwAvoEb/yWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ayLeUhjLyoFQG5An2cJGxC2tnorgg7lrk9krHEdlFdl/qiqXZhr0HVyT6kCNoPbND
         FgxKAP2cVUM7uMESbbhxr+dEMZ0e3EyqXgWnriWaZOerADL5RiXdYG4xJemn3/o9to
         sWxQ9YeEV8G1lflOd5FyfzDFlLTXjwpnHQka4WleO/+cexT9jBSEicUTaAA4GycJbq
         IEdPJLPoa7AyBQFoRzVjceVebRzui5162Pm7VJXfAtQLGX+qmAV4Q0jgfJqTAGGcM6
         1AT8pHu+iI41O43TCZDNg+HPlyLAi5mx5a7I5n+1Sixpse4IsB8Cqro/Y7/G8Exsex
         DnKQ0Lkeyly8w==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, trondmy@hammerspace.com,
        eggert@cs.ucla.edu, bruno@clisp.org,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: don't call posix_acl_listxattr in generic_listxattr
Date:   Tue, 16 May 2023 16:17:37 +0200
Message-Id: <20230516-notorisch-geblickt-6b591fbd77c1@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516124655.82283-1-jlayton@kernel.org>
References: <20230516124655.82283-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=brauner@kernel.org; h=from:subject:message-id; bh=zbu+/n1x0xP+L4aQcQ1ZrPVzWz9/XfixfwAvoEb/yWY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQkT8hVmlNc1X3s8NrkkKmPAixtFY0WBhpPs9zLdsks2/FX 5WLtjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIks+MTwT0P97YqIcwFbxIxLZl9g08 gzqGZWWegtvYXpzs8L9TyKixkZ7oo6lfROP779TF/Kk8KZm/tubtNiU/Wcsebx3UuH/S5+4gAA
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

On Tue, 16 May 2023 08:46:54 -0400, Jeff Layton wrote:
> Commit f2620f166e2a caused the kernel to start emitting POSIX ACL xattrs
> for NFSv4 inodes, which it doesn't support. The only other user of
> generic_listxattr is HFS (classic) and it doesn't support POSIX ACLs
> either.
> 
> 

Applied to the vfs.misc.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.misc.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc.fixes

[1/1] fs: don't call posix_acl_listxattr in generic_listxattr
      https://git.kernel.org/vfs/vfs/c/f3689fa785f0
