Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FC979D0E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 14:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjILMSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 08:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjILMSw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:18:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D886710D5;
        Tue, 12 Sep 2023 05:18:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AA0C433C7;
        Tue, 12 Sep 2023 12:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694521128;
        bh=7t1ARw1hegx1IfSBe7ZkfXYSFLWxUp1FwIP8Gl7Edkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tC9tbTMj/pok+xbC6048Ft+CVJH7y7MvD7SYbCh6dopu/8Ow0U2ihcjwyMdHXSaYT
         LpMHCo2KO2OuM0YWwHSndS4fxjc6TezmykV69+naYx07ZfjmSZ0cuNCGgyNmJoV+3i
         zmTRGqc+54YRBGkXTn/bQSOYaTCtKixF9gv44xr/xNaXZP9ib9v2DRCqytVBfMNb3y
         qQYDxKXM5ILSiuVJSn0bOn+VBsXVvnWGl0dSUH8rwhjwpo1fBTBfxSmkMznxWOohOM
         Nd8ma513s5/x/yt4u3q1i8RwFLF9EhTNyHKmsvP9ITQ6tSuLTAyY5XC8tXjmKs7smt
         fdEIlv/37mg6w==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Subject: Re: [PATCH v3] fs: add a new SB_I_NOUMASK flag
Date:   Tue, 12 Sep 2023 14:18:36 +0200
Message-Id: <20230912-zahlreich-relikt-d31be8e489b8@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911-acl-fix-v3-1-b25315333f6c@kernel.org>
References: <20230911-acl-fix-v3-1-b25315333f6c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=brauner@kernel.org; h=from:subject:message-id; bh=7t1ARw1hegx1IfSBe7ZkfXYSFLWxUp1FwIP8Gl7Edkw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQyhIsXX5kl+yHsTZS5XN+CvzI1taZT5tyROPneSlP5atef 3GscHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOR/8Dwz/qcrPUDozvXzjctOuT8bY eB/otVsVnnLI4xe0VLxpvfns7IMEfvDZM5c9tSlcsxr2zzZetnvoyaKnHuwz2PZNEz9u37uAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 11 Sep 2023 20:25:50 -0400, Jeff Layton wrote:
> SB_POSIXACL must be set when a filesystem supports POSIX ACLs, but NFSv4
> also sets this flag to prevent the VFS from applying the umask on
> newly-created files. NFSv4 doesn't support POSIX ACLs however, which
> causes confusion when other subsystems try to test for them.
> 
> Add a new SB_I_NOUMASK flag that allows filesystems to opt-in to umask
> stripping without advertising support for POSIX ACLs. Set the new flag
> on NFSv4 instead of SB_POSIXACL.
> 
> [...]

Fine by me and removes hacking around this by abusing the POSIX ACL api.

---

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

[1/1] fs: add a new SB_I_NOUMASK flag
      https://git.kernel.org/vfs/vfs/c/34618fcb9fae
