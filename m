Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E89C6DF0A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 11:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDLJk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 05:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjDLJk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:40:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A76A6F
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 02:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1CC1629E1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 09:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D5BC433D2;
        Wed, 12 Apr 2023 09:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681292438;
        bh=Hpzhy+XSjFsqYBo1Q4mT54Hc6kABe1J5WFH/p2FsROU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ov7AHC5GpZQVWzc+g9Xqlv0F0DjrJD+ibF3KF7U84ZVOAeC7as5HOud5PkcaPpSDd
         HcQyheGgCCmpCR/LmVOU7gT9cfzaRYt/1CL1bgqiVdPKjvkQI6M7UsLVnd4/oHiTiy
         jPwbzwhKFPmBxyGRFnf7njwzq+wFSRQEDQZjElFpJSvwafC/hfaBYY+AR2d/Z9SNKb
         K44sKPIDIghnW4aJGBZ4zPeutXW7ReK3dx5+eV/4ahkGMFTYyIY+RwzMQU2gSCcSZD
         7CyD8iuSKGH/ovoyaG9gKd+uHFFMcB+7oOip2lhzv/p2C10+c1vlxdXio0mRlIgRXP
         wDUPeIeRWqxjQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+e2787430e752a92b8750@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+4913dca2ea6e4d43f3f1@syzkaller.appspotmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        damien.lemoal@opensource.wdc.com, jlayton@kernel.org,
        willy@infradead.org
Subject: Re: [PATCH] fs: hfsplus: remove WARN_ON() from hfsplus_cat_{read,write}_inode()
Date:   Wed, 12 Apr 2023 11:38:55 +0200
Message-Id: <20230412-driften-aufsagen-cb1c5b9d2ca9@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <15308173-5252-d6a3-ae3b-e96d46cb6f41@I-love.SAKURA.ne.jp>
References: <0000000000008a836b05eec3a7e9@google.com> <15308173-5252-d6a3-ae3b-e96d46cb6f41@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=592; i=brauner@kernel.org; h=from:subject:message-id; bh=ExwhowRPo57a/lVbsNlXkKlfb22mI0UKV0EPmtZO+8U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSY1Qg1NjySu/WdT73xqkLHu0U7j3/07r7q9JnvAOM/IV62 2ZJrO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZiOoeR4XX5osaDc2eo/rlQJxX9xW jNM91fxy8nTA9a5L62l+nJ+mBGhqOzfrmx6qxjObKPIVD44mO2Lr5CpgW8PWtunCu5uit+OQsA
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


On Tue, 11 Apr 2023 19:57:33 +0900, Tetsuo Handa wrote:
> syzbot is hitting WARN_ON() in hfsplus_cat_{read,write}_inode(), for
> crafted filesystem image can contain bogus length. There conditions are
> not kernel bugs that can justify kernel to panic.
> 
> 

Seems fine as a follow-up fix to Arnd's in
55d1cbbbb29e ("hfs/hfsplus: use WARN_ON for sanity check").
Filesystems is orphaned so taking this through one of our vfs trees,

branch: fs.misc
[1/1] fs: hfsplus: remove WARN_ON() from hfsplus_cat_{read,write}_inode()
      commit: 81b21c0f0138ff5a499eafc3eb0578ad2a99622c
