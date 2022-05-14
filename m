Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB48D5272F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiENQh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 May 2022 12:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiENQhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 May 2022 12:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88734245BC;
        Sat, 14 May 2022 09:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D0BA61013;
        Sat, 14 May 2022 16:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C690C340EE;
        Sat, 14 May 2022 16:37:23 +0000 (UTC)
Subject: [PATCH v2 0/8] Make NFSv4 OPEN(CREATE) less brittle
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Date:   Sat, 14 May 2022 12:37:21 -0400
Message-ID: <165254610700.2361.2480451215356922637.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Attempt to address occasional reports of failures caused by NFSv4
OPEN(CREATE) failing internally only after the target file object
has already been created.

The basic approach is to re-organize the NFSv4 OPEN code path so
that common failure modes occur /before/ the call to vfs_create()
rather than afterwards. In addition, the local file is opened and
created atomically so that another client can't race and de-permit
that file just after it is created but before the server has opened
it.

This series was posted a few weeks ago as an RFC. Since then, Red
Hat QE has used a Lustre racer-based reproducer to confirm that
the issue is not reproducible. Therefore I'd like to include this
series in the NFSD 5.19 pull request.

Changes since v1:
- Address review comments in dentry_create()


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
 fs/open.c           |  42 ++++++++
 include/linux/fs.h  |   2 +
 10 files changed, 469 insertions(+), 242 deletions(-)

--
Chuck Lever

