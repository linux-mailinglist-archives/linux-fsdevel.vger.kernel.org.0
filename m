Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A96E2EBC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 05:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjDODHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 23:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDODHF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 23:07:05 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FE149EA
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 20:07:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33F36rCO005359
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 23:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1681528015; bh=eObovwA9jSzaeP3XHUX6/KxQAiJBxQg41IZIxE7s0Q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jErlg5NM7LmZsmcX84SUhdibWLszLqJPpxvHyKPiWxUtzOB9aN3xZPGmAr9r/VKco
         Eb+h48b/SjuGZ/1Lea06rbUQ/gfw7AeYOWWsstBxjQ+lnCZC0Dy2t5R17vXO9D6jH1
         wBGxtVasyLdqfQCJy+MWJ1kjjugJqb7O47mZZqPGyDuo6rjIs4QLQAN3gG20qPIFX6
         +QxGSPAgRBmzwT/gVno923rmyWAwhTN1GcGPCE5Vx9TYeIa2RpgxfZyrErGMq6ZGCY
         uOJRzLvdNZ1zfM7nBLP/15c6bM8L7bZmNRsZoudOAm4cEWX9GaoZdm/oj2AD5XLoeN
         O8gJoMmv69oZQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B107015C4935; Fri, 14 Apr 2023 23:06:53 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>
Subject: Re: [PATCH v6 0/9] ext4: Convert inode preallocation list to an rbtree
Date:   Fri, 14 Apr 2023 23:06:52 -0400
Message-Id: <168152581960.510457.9877863491937008511.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1679731817.git.ojaswin@linux.ibm.com>
References: <cover.1679731817.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Sat, 25 Mar 2023 13:43:33 +0530, Ojaswin Mujoo wrote:
> This patch series aim to improve the performance and scalability of
> inode preallocation by changing inode preallocation linked list to an
> rbtree. I've ran xfstests quick on this series and plan to run auto group
> as well to confirm we have no regressions.
> 
> ** Shortcomings of existing implementation **
> 
> [...]

Applied, thanks!

[1/9] ext4: Stop searching if PA doesn't satisfy non-extent file
      commit: e86a718228b61eef747b8deb446f807b2be73148
[2/9] ext4: Refactor code related to freeing PAs
      commit: 820897258ad342e78388ee9f5814fc485e79102a
[3/9] ext4: Refactor code in ext4_mb_normalize_request() and ext4_mb_use_preallocated()
      commit: bcf434992145dd08bb5c8d0bd4bf34811e0a5d78
[4/9] ext4: Move overlap assert logic into a separate function
      commit: 7692094ac513e48ee37d0f1fb057f3f7f8d53385
[5/9] ext4: Abstract out overlap fix/check logic in ext4_mb_normalize_request()
      commit: 0830344c953aeabee91ac88281585756d047df39
[6/9] ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()
      commit: 93cdf49f6eca5e23f6546b8f28457b2e6a6961d9
[7/9] ext4: Convert pa->pa_inode_list and pa->pa_obj_lock into a union
      commit: a8e38fd37cff911638ac288adb138265f71e50c0
[8/9] ext4: Use rbtrees to manage PAs instead of inode i_prealloc_list
      commit: 3872778664e36528caf8b27f355e75482f6d562d
[9/9] ext4: Remove the logic to trim inode PAs
      commit: 361eb69fc99f1a8f1d653d69ecd742f3cbb896be

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
