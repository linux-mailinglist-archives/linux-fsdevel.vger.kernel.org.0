Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30B97526A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 17:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjGMPVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 11:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjGMPVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49348B4;
        Thu, 13 Jul 2023 08:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3BF060C26;
        Thu, 13 Jul 2023 15:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29396C433C8;
        Thu, 13 Jul 2023 15:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689261698;
        bh=sCUx5r2DZPKfzTRMP1CiZcMdAlioIinNWLALD/baR1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gtlXRFf35r3ABG6O7A1f7oa74AK/iu9aoZ9HWGXimGfmO/feJhhSZ5ywjN/e0h1qZ
         urcBI3CLd/JzHCXjRrjlL/q8VS/9yxed/4A+tUGjW4eemTxS0D34AHLpTvOGT2l46E
         9or5s4or5qlc9YkF3/yxS2w9yAs/xbYNeer4NRACjB6TTQC3+EnO0F3XLE5wvxuMYv
         wBfYMbQ7M4KAXvsqXwgDSF49mLS30o6m0zoRwBTARqGAshMUOEfA1T6JZJeQgd/yAv
         ssZB5s1Stfz9GrFaJE7rwMkSI499MBuxxmgRk4TXKPxtENUQ7WfTOYKladSPSPfxot
         HtBmCC+Dk8iOw==
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Thomas Weissschuh <thomas@t-8ch.de>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Stefan Roesch <shr@devkernel.io>,
        Janis Danisevskis <jdanis@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] procfs: block chmod on /proc/thread-self/comm
Date:   Thu, 13 Jul 2023 17:21:29 +0200
Message-Id: <20230713-shrimps-urlaub-80a9818b50d9@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713141001.27046-1-cyphar@cyphar.com>
References: <20230713141001.27046-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=brauner@kernel.org; h=from:subject:message-id; bh=sCUx5r2DZPKfzTRMP1CiZcMdAlioIinNWLALD/baR1A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRsECvbwnyq/KSC1PLGZEExz9i2R907S/4VfRLvenJGgrvP jyGto5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKHrzIynBNocnhh1K/F7rK8OXWheK ZxW03aRcH0S2q3nnt5vDxlxvBP2ZfP30fkaUeZRtb596VaD/rs1upezD4f9iJgXqFu2AQWAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 14 Jul 2023 00:09:58 +1000, Aleksa Sarai wrote:
> Due to an oversight in commit 1b3044e39a89 ("procfs: fix pthread
> cross-thread naming if !PR_DUMPABLE") in switching from REG to NOD,
> chmod operations on /proc/thread-self/comm were no longer blocked as
> they are on almost all other procfs files.
> 
> A very similar situation with /proc/self/environ was used to as a root
> exploit a long time ago, but procfs has SB_I_NOEXEC so this is simply a
> correctness issue.
> 
> [...]

Just to reiterate: The long term fix to avoid these odd behavioral bugs
in the future is to remove the fallback to simple_setattr() we still
have in notify_change() that happens when no setattr inode operation has
been explicitly defined. To do this we need to change all filesystem
that rely on this fallback to explicitly set simple_setattr() as their
inode operation. Then notify_change() would simply return EOPNOTSUPP
when no setattr iop is defined making such omissions pretty obvious.

But that's a bigger patch. This is a backportable fix for this issue.
Needs long soaking in -next ofc.

---

Applied to the fs.proc.uapi branch of the vfs/vfs.git tree.
Patches in the fs.proc.uapi branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: fs.proc.uapi

[1/1] procfs: block chmod on /proc/thread-self/comm
      https://git.kernel.org/vfs/vfs/c/ccf61486fe1e
