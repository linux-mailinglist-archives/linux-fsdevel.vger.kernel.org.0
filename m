Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E241E752513
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 16:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGMOZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 10:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGMOZ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:25:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D3E26AF;
        Thu, 13 Jul 2023 07:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C6F96153D;
        Thu, 13 Jul 2023 14:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6E6C433C7;
        Thu, 13 Jul 2023 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689258356;
        bh=ceLGsUdUEdvARZ34SamfY0iHE6Sz+y/w35l/b94Ztx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fKbF+Ln0o06eJaKuOtHmDtmY8sKeziOCE1UI5chCXUVsovuRJ2r1oA2cwcL+akIX2
         fRBasAvqYabjCDTLO7oBPyY4PIrYy2i0io0rMkOxdbUseIZUNNq05h5PG3UdRK+GcK
         O3m7PxonbM91zIRkYhFzgQYKm4KpM0+PxxQ8PGuRU1R7vA/AZ40TYfV9STdOD05QjL
         RaxQWNqd8gLNJE2azgmYSCsdTKdPSOx+FnwCLlJzHK5GEhHbyLXuNgi21ssS0qY+D7
         FriPqVjZd++IlYd5cVGGua6KWf6XB6+jkmk6WAwUzGuziXTQhck4dvRP4Sni5PE3dH
         F1NmYD3aJxX5A==
From:   Christian Brauner <brauner@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH] gfs2: fix timestamp handling on quota inodes
Date:   Thu, 13 Jul 2023 16:25:50 +0200
Message-Id: <20230713-beispiel-bezeichnen-cf537927cefd@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713135249.153796-1-jlayton@kernel.org>
References: <20230713135249.153796-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115; i=brauner@kernel.org; h=from:subject:message-id; bh=ceLGsUdUEdvARZ34SamfY0iHE6Sz+y/w35l/b94Ztx8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRs4Mw+Ei5erdYSLhCbuvKoiYZWkESapb7alPumIS/0KzT1 pzztKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEjMN0aGu7Oe+r6/avoobZ9m47WcLU V7ws/NSDoYIPf3e925aSd1/Bn+2SbPk/3VXFGX3PD8q+URbfGKRWdCNj1eer197vyfZwQmsAMA
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

On Thu, 13 Jul 2023 09:52:48 -0400, Jeff Layton wrote:
> While these aren't generally visible from userland, it's best to be
> consistent with timestamp handling. When adjusting the quota, update the
> mtime and ctime like we would with a write operation on any other inode,
> and avoid updating the atime which should only be done for reads.
> 
> 

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

[1/1] gfs2: fix timestamp handling on quota inodes
      https://git.kernel.org/vfs/vfs/c/ea462c3f7f48
