Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD0A6263ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 22:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiKKVzn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 16:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKKVzl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:55:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFB64877F;
        Fri, 11 Nov 2022 13:55:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4C62620E4;
        Fri, 11 Nov 2022 21:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48F3C433C1;
        Fri, 11 Nov 2022 21:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203740;
        bh=ppNuqHgfgh6VS8z+UdUsS9MYS2XQh0sPVUBYG7uz4TE=;
        h=From:To:Cc:Subject:Date:From;
        b=fiOzLjpyLkR8q4H4aAPW+JUpi1X5Q8ugD8zZsPZdwmqDOqg6IE9KXFmud7ZgU8+nj
         wi8h8HiWNLeEhKFQfbcq8U3txfkwcxen0LdO6XqKd57vj1+9cTujXIXDDmjOjGFD7r
         zn1RrHFkMhH+iylcsvYkMSj3hkx0Ni/OOg0+95PlyX4n54XJTLz7b+7/E+TcCvrayn
         98HpwN1sst238js2jtM+kytvQjn2AGkztVWGqxDe0aPWsKWqDIWOQ5MT4PXf/P+l6G
         x9VGbcTpaVKL5BNBmCb18Bx4ORZzGVJUPfOYju4l1SP3OMm5pDtwSK4hhSnnto1pPy
         CiTk6BSixoKJA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] filelock: WARN when @filp and fl_file don't match
Date:   Fri, 11 Nov 2022 16:55:34 -0500
Message-Id: <20221111215538.356543-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eventually, I'd like to reduce the redundant arguments to the locking
APIs, but to get there we need to ensure the callers all set their file
locks sanely.

Adding the WARN_ON_ONCEs helped to find a couple of warts in lockd's
file handling. The first 3 patches fix those.

I'd like to see these included in v6.2, with an eye toward a locking API
cleanup in v6.3.

Thanks,

Jeff Layton (4):
  lockd: set missing fl_flags field when retrieving args
  lockd: ensure we use the correct file description when unlocking
  lockd: fix file selection in nlmsvc_cancel_blocked
  filelock: WARN_ON_ONCE when ->fl_file and filp don't match

 fs/lockd/svc4proc.c |  1 +
 fs/lockd/svclock.c  | 17 ++++++++++-------
 fs/lockd/svcproc.c  |  1 +
 fs/locks.c          |  3 +++
 4 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.38.1

