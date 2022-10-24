Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F349C609FEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 13:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJXLNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 07:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJXLNH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C253955C7D
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 04:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7647611D8
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 11:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9E0C433C1;
        Mon, 24 Oct 2022 11:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666609978;
        bh=45nJxBP1aBW0o8WVgviV8ZRPnCPvBeyH95BDtFHYYoQ=;
        h=From:To:Cc:Subject:Date:From;
        b=jqiFNAD//LqPK4HQ6ljRYJFh4Pq6BvVlVoHRQ/UOJNd4gx3v/zg6gGlTMFwsyd7kh
         azGKs5bRWFC2t9dZf9+lI+3dKjsttFmluHPlx5n8KBdOU5CbWLCZALhbqxt8ZGkf6r
         x1UAulY2WFcEbKhIOqAM4NYIxuIiQjePnux8foHDsqTSeArJZyNmdLdABUcEzvJyvl
         EQEaqLMae/JztO6dXIABxk0Ng/rYFjOiNnZ/Vh6WWBOhyAvNbtp8d5X/4oo7eBibvm
         UzXFP7ZXC0TE3xYTPmZC0BV2bM3qVfWpvbEekWEI9kLvczu/76/uNeX9HvSragKkrE
         Xb67bAaZxd+HA==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 0/8] finish port to new vfs*id helpers
Date:   Mon, 24 Oct 2022 13:12:41 +0200
Message-Id: <20221024111249.477648-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=brauner@kernel.org; h=from:subject; bh=6uWtZRyN7o19V1EnsDHk1k6yrHWcS5MqXgWL1GS3mVo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSHFevw/VJUTWjUZZ/ge83cfNU8T/WpHFGf7jDMYp5gep09 3vl4RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEROhDD8j/7X/9j4A/fB/H/Xlxe2rG KIK6hak7f2zkS+uasvdESVnGRkOO6i7N25wfnRtP8NngZ+jCFSgaWZXL9D/Tdlb1dL3/iZGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Christian Brauner (Microsoft)" <brauner@kernel.org>

Hey,

A while ago we converted all filesystems and a good chunk of the vfs to
rely on the new vfs{g,u}id_t type and the associated type safe helpers.
After this change all places where idmapped mounts matter deal with the
dedicated new type and can't be easily confused with filesystem wide
k{g,u}id_t types. This small series converts the remaining places and
removes the old helpers. The series does not contain functional changes.
xfstests, LTP, and the libcap testsuite pass without any regressions.

(The series is based on the setgid changes sitting in my tree. It
 removes a bunch of open-coding and thus makes the change here simpler
 as well.)

Thanks!
Christian

Christian Brauner (8):
  mnt_idmapping: add missing helpers
  fs: use type safe idmapping helpers
  caps: use type safe idmapping helpers
  apparmor: use type safe idmapping helpers
  ima: use type safe idmapping helpers
  fuse: port to vfs{g,u}id_t and associated helpers
  ovl: port to vfs{g,u}id_t and associated helpers
  fs: remove unused idmapping helpers

 fs/coredump.c                       |   4 +-
 fs/exec.c                           |  16 ++---
 fs/fuse/acl.c                       |   2 +-
 fs/inode.c                          |   8 +--
 fs/namei.c                          |  40 +++++------
 fs/overlayfs/util.c                 |   9 ++-
 fs/remap_range.c                    |   2 +-
 fs/stat.c                           |   7 +-
 include/linux/fs.h                  |  34 ----------
 include/linux/mnt_idmapping.h       | 100 +++++++++-------------------
 kernel/capability.c                 |   4 +-
 security/apparmor/domain.c          |   8 +--
 security/apparmor/file.c            |   4 +-
 security/apparmor/lsm.c             |  24 ++++---
 security/commoncap.c                |  51 +++++++-------
 security/integrity/ima/ima_policy.c |  34 +++++-----
 16 files changed, 149 insertions(+), 198 deletions(-)


base-commit: 23a8ce16419a3066829ad4a8b7032a75817af65b
-- 
2.34.1

