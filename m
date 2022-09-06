Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D285ADF06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 07:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiIFFtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 01:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiIFFtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:49:40 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB721A066;
        Mon,  5 Sep 2022 22:49:37 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id AED00132;
        Tue, 06 Sep 2022 13:49:32 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 13:49:33 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <vgoyal@redhat.com>, <stefanha@redhat.com>, <miklos@szeredi.hu>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] virtiofs: Drop unnecessary initialization in send_forget_request and virtio_fs_get_tree
Date:   Tue, 6 Sep 2022 01:38:48 -0400
Message-ID: <20220906053848.2503-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201619.home.langchao.com (10.100.2.19)
tUid:   2022906134932b38d0b2abf1131d443f55694c3b78f63
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The variable is initialized but it is only used after its assignment.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 fs/fuse/virtio_fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4d8d4f16c..bffe74d44 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -414,7 +414,7 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
 {
 	struct scatterlist sg;
 	struct virtqueue *vq;
-	int ret = 0;
+	int ret;
 	bool notify;
 	struct virtio_fs_forget_req *req = &forget->req;
 
@@ -1414,10 +1414,10 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 {
 	struct virtio_fs *fs;
 	struct super_block *sb;
-	struct fuse_conn *fc = NULL;
+	struct fuse_conn *fc;
 	struct fuse_mount *fm;
 	unsigned int virtqueue_size;
-	int err = -EIO;
+	int err;
 
 	/* This gets a reference on virtio_fs object. This ptr gets installed
 	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
-- 
2.27.0

