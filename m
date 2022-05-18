Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD4C52BE04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 17:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiERPLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 11:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbiERPLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 11:11:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6882826C9;
        Wed, 18 May 2022 08:11:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C36C61988;
        Wed, 18 May 2022 15:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBC7C385A5;
        Wed, 18 May 2022 15:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652886673;
        bh=eogH2XGX/H8oF8Dyk4upgXHDcX0uOOeC3pStIK6kNxI=;
        h=From:To:Cc:Subject:Date:From;
        b=qMWue3vGcxy3FaUma7uyp1/8fBfbQiwSvgj1/5HSVhALTCsrE3Y8+K3/ptSTbE7NV
         alIxwonnPj+0in4piMS0GirHQ6FDI0q/yb5QnFnJuQSBWKn7q77SIuZEU8tBsm/tI5
         T86elK+Zk1KrDhXSPfCFMAhQUeBYDYxmTEwA+dkqomqjmuPZBUqnukEKpW00KFNgD7
         oJIlGVqWXVvwxHOjiiG1PzV+PpnpVx8Pa+eJMPH6siK7UwXfiBbHeeCzEouGnF9JC1
         kPRN2ENs5mWu7vtW8ay8JBdhzi/w3ffYBtELvIte7gLBWVnCAkEfXYlqsGWe6O+hY/
         aPpJuXuZfFB4Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        xiubli@redhat.com, idryomov@gmail.com
Subject: [PATCH 0/4] ceph: convert to netfs_direct_read_iter for DIO reads
Date:   Wed, 18 May 2022 11:11:07 -0400
Message-Id: <20220518151111.79735-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series is based on top of David Howells' netfs-lib branch.

I previously sent an RFC set for this back in early April, but David has
revised his netfs-lib branch since then. This converts ceph to use the
new DIO read helper netfs_direct_read_iter instead of using our own
routine.

With this change we ought to be able to rip out a large swath of
ceph_direct_read_write, but I've decided to wait on that until the write
helpers are in place and we can just remove that function wholesale.

David, do you mind carrying these patches in your tree? Given that they
depend on your netfs-lib branch, it's probably simpler to do it that way
rather than have us base the ceph-client master branch on yours. If
conflicts crop up, we can revisit that approach though.

David Howells (1):
  ceph: Use the provided iterator in ceph_netfs_issue_op()

Jeff Layton (3):
  netfs: fix sense of DIO test on short read
  ceph: enhance dout messages in issue_read codepaths
  ceph: switch to netfs_direct_read_iter

 fs/ceph/addr.c | 55 +++++++++++++++++++++++++++++++++-----------------
 fs/ceph/file.c |  3 +--
 fs/netfs/io.c  |  2 +-
 3 files changed, 38 insertions(+), 22 deletions(-)

-- 
2.36.1

