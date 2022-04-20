Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D927C508F67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 20:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345997AbiDTSbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 14:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245374AbiDTSbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:31:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FFA23BDE;
        Wed, 20 Apr 2022 11:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD5D161B60;
        Wed, 20 Apr 2022 18:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3B6C385A0;
        Wed, 20 Apr 2022 18:28:35 +0000 (UTC)
Subject: [PATCH RFC 0/8] Make NFSv4 OPEN(CREATE) less brittle
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 20 Apr 2022 14:28:34 -0400
Message-ID: <165047903719.1829.18357114060053600197.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Attempt to address occasional reports of test failures caused by
NFSv4 OPEN(CREATE) having failing internally after the target
file object has been created.

The basic approach is to re-organize the NFSv4 OPEN code path so
that common failure modes occur /before/ the call to vfs_create()
rather than afterwards. In addition, the file is opened and created
atomically so that another client can't race and de-permit the
file just after it was created but before the server has opened it.

So far I haven't found any regressions. However I have not been
able to reproduce the original failures.


---

Chuck Lever (8):
      NFSD: Clean up nfsd3_proc_create()
      NFSD: Avoid calling fh_drop_write() twice in do_nfsd_create()
      NFSD: Refactor nfsd_create_setattr()
      NFSD: Refactor NFSv3 CREATE
      NFSD: Refactor NFSv4 OPEN(CREATE)
      NFSD: Remove do_nfsd_create()
      NFSD: Clean up nfsd_open_verified()
      NFSD: Instantiate a struct file when creating a regular NFSv4 file


 fs/nfsd/filecache.c |  51 +++++++--
 fs/nfsd/filecache.h |   2 +
 fs/nfsd/nfs3proc.c  | 141 +++++++++++++++++++++----
 fs/nfsd/nfs4proc.c  | 197 +++++++++++++++++++++++++++++++++--
 fs/nfsd/nfs4state.c |  16 ++-
 fs/nfsd/vfs.c       | 245 ++++++++++----------------------------------
 fs/nfsd/vfs.h       |  14 +--
 fs/nfsd/xdr4.h      |   1 +
 fs/open.c           |  44 ++++++++
 include/linux/fs.h  |   2 +
 10 files changed, 471 insertions(+), 242 deletions(-)

--
Chuck Lever

