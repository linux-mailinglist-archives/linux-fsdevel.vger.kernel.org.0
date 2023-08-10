Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63113777555
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 12:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbjHJKEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 06:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbjHJKDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:03:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63A93ABF;
        Thu, 10 Aug 2023 03:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5608B6570C;
        Thu, 10 Aug 2023 10:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14833C433C7;
        Thu, 10 Aug 2023 10:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691661703;
        bh=7ugjWJhVsy+T1T5nRjQNqcfhGEJuIF4KKFMz/3r4FkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MT5PkUJBlaKBchM5vURYE9/YCNX/fU6qtulF8QygyYrLJfspVjsVkV6e5lvibTMgx
         9J7pG5gQZcab+isZSkfbQhuK1e15vqx/IpeZpSQYYYkb/0jx6EtYCxOA619AOd6P1a
         aUij20wCV4kmq08+eFMQxVGp1eGIAmw6u6y/gchASNm/Gwt6ZyvSXY3tSAxK36Pn3O
         nkY0HdFfTTXrTdwBMrK1iPe6V0i3ohJ1seNTVbDEBvCnppa/R9PjA2JozL8MO7OAzO
         0TnF9LNiemrXuxTMb4qVY4SaTd60u+HnBpdQOFPMXH9uO1mca6pZgq4TkU/HKstKkS
         aj7ZtcUTSUU1Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Subject: Re: [PATCH v9] vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing
Date:   Thu, 10 Aug 2023 12:01:34 +0200
Message-Id: <20230810-wagten-otter-2cbcbcf048cd@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808-master-v9-1-e0ecde888221@kernel.org>
References: <20230808-master-v9-1-e0ecde888221@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=brauner@kernel.org; h=from:subject:message-id; bh=7ugjWJhVsy+T1T5nRjQNqcfhGEJuIF4KKFMz/3r4FkI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRc2Vo578LFWEe+wOnaTz9yLfnaLrX1iNqH8++/344+eyvm b4j35o5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ3LNkZPgQuujHFakSh5mPkjfG9j 1WFoqblxt66sgFGT4BMRcjJXGG/xG+CcoiCWpWxfsfLq1vVI1+M7vohPcGly2flkzTXOd1kgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 08 Aug 2023 07:34:20 -0400, Jeff Layton wrote:
> When NFS superblocks are created by automounting, their LSM parameters
> aren't set in the fs_context struct prior to sget_fc() being called,
> leading to failure to match existing superblocks.
> 
> This bug leads to messages like the following appearing in dmesg when
> fscache is enabled:
> 
> [...]

I'm stuffing this on vfs.misc because this should be in -next for some
time. If there's objections let me know.

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

[1/1] vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing
      https://git.kernel.org/vfs/vfs/c/4b4fb74b1aa1
