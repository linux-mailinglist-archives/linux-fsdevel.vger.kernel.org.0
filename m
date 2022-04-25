Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A0350E00F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 14:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbiDYMZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240797AbiDYMZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:25:17 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A5360ABE;
        Mon, 25 Apr 2022 05:22:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VBDrnV1_1650889317;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VBDrnV1_1650889317)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Apr 2022 20:21:58 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: [PATCH v10 08/21] cachefiles: document on-demand read mode
Date:   Mon, 25 Apr 2022 20:21:30 +0800
Message-Id: <20220425122143.56815-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
References: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document new user interface introduced by on-demand read mode.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 .../filesystems/caching/cachefiles.rst        | 174 ++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/Documentation/filesystems/caching/cachefiles.rst b/Documentation/filesystems/caching/cachefiles.rst
index 8bf396b76359..0b05391c8217 100644
--- a/Documentation/filesystems/caching/cachefiles.rst
+++ b/Documentation/filesystems/caching/cachefiles.rst
@@ -28,6 +28,7 @@ Cache on Already Mounted Filesystem
 
  (*) Debugging.
 
+ (*) On-demand Read.
 
 
 Overview
@@ -482,3 +483,176 @@ the control file.  For example::
 	echo $((1|4|8)) >/sys/module/cachefiles/parameters/debug
 
 will turn on all function entry debugging.
+
+
+On-demand Read
+==============
+
+When working in its original mode, CacheFiles serves as a local cache for a
+remote networking fs - while in on-demand read mode, CacheFiles can boost the
+scenario where on-demand read semantics are needed, e.g. container image
+distribution.
+
+The essential difference between these two modes is seen when a cache miss
+occurs: In the original mode, the netfs will fetch the data from the remote
+server and then write it to the cache file; in on-demand read mode, fetching
+the data and writing it into the cache is delegated to a user daemon.
+
+``CONFIG_CACHEFILES_ONDEMAND`` should be enabled to support on-demand read mode.
+
+
+Protocol Communication
+----------------------
+
+The on-demand read mode uses a simple protocol for communication between kernel
+and user daemon. The protocol can be modeled as::
+
+	kernel --[request]--> user daemon --[reply]--> kernel
+
+CacheFiles will send requests to the user daemon when needed.  The user daemon
+should poll the devnode ('/dev/cachefiles') to check if there's a pending
+request to be processed.  A POLLIN event will be returned when there's a pending
+request.
+
+The user daemon then reads the devnode to fetch a request to process.  It should
+be noted that each read only gets one request. When it has finished processing
+the request, the user daemon should write the reply to the devnode.
+
+Each request starts with a message header of the form::
+
+	struct cachefiles_msg {
+		__u32 msg_id;
+		__u32 opcode;
+		__u32 len;
+		__u32 object_id;
+		__u8  data[];
+	};
+
+	where:
+
+	* ``msg_id`` is a unique ID identifying this request among all pending
+	  requests.
+
+	* ``opcode`` indicates the type of this request.
+
+	* ``object_id`` is a unique ID identifying the cache file operated on.
+
+	* ``data`` indicates the payload of this request.
+
+	* ``len`` indicates the whole length of this request, including the
+	  header and following type-specific payload.
+
+
+Turning on On-demand Mode
+-------------------------
+
+An optional parameter becomes available to the "bind" command::
+
+	bind [ondemand]
+
+When the "bind" command is given no argument, it defaults to the original mode.
+When it is given the "ondemand" argument, i.e. "bind ondemand", on-demand read
+mode will be enabled.
+
+
+The OPEN Request
+----------------
+
+When the netfs opens a cache file for the first time, a request with the
+CACHEFILES_OP_OPEN opcode, a.k.a an OPEN request will be sent to the user
+daemon.  The payload format is of the form::
+
+	struct cachefiles_open {
+		__u32 volume_key_size;
+		__u32 cookie_key_size;
+		__u32 fd;
+		__u32 flags;
+		__u8  data[];
+	};
+
+	where:
+
+	* ``data`` contains the volume_key followed directly by the cookie_key.
+	  The volume key is a NUL-terminated string; the cookie key is binary
+	  data.
+
+	* ``volume_key_size`` indicates the size of the volume key in bytes.
+
+	* ``cookie_key_size`` indicates the size of the cookie key in bytes.
+
+	* ``fd`` indicates an anonymous fd referring to the cache file, through
+	  which the user daemon can perform write/llseek file operations on the
+	  cache file.
+
+
+The user daemon can use the given (volume_key, cookie_key) pair to distinguish
+the requested cache file.  With the given anonymous fd, the user daemon can
+fetch the data and write it to the cache file in the background, even when
+kernel has not triggered a cache miss yet.
+
+Be noted that each cache file has a unique object_id, while it may have multiple
+anonymous fds.  The user daemon may duplicate anonymous fds from the initial
+anonymous fd indicated by the @fd field through dup().  Thus each object_id can
+be mapped to multiple anonymous fds, while the usr daemon itself needs to
+maintain the mapping.
+
+When implementing a user daemon, please be careful of RLIMIT_NOFILE,
+``/proc/sys/fs/nr_open`` and ``/proc/sys/fs/file-max``.  Typically these needn't
+be huge since they're related to the number of open device blobs rather than
+open files of each individual filesystem.
+
+The user daemon should reply the OPEN request by issuing a "copen" (complete
+open) command on the devnode::
+
+	copen <msg_id>,<cache_size>
+
+	* ``msg_id`` must match the msg_id field of the OPEN request.
+
+	* When >= 0, ``cache_size`` indicates the size of the cache file;
+	  when < 0, ``cache_size`` indicates any error code encountered by the
+	  user daemon.
+
+
+The CLOSE Request
+-----------------
+
+When a cookie withdrawn, a CLOSE request (opcode CACHEFILES_OP_CLOSE) will be
+sent to the user daemon.  This tells the user daemon to close all anonymous fds
+associated with the given object_id.  The CLOSE request has no extra payload,
+and shouldn't be replied.
+
+
+The READ Request
+----------------
+
+When a cache miss is encountered in on-demand read mode, CacheFiles will send a
+READ request (opcode CACHEFILES_OP_READ) to the user daemon. This tells the user
+daemon to fetch the contents of the requested file range.  The payload is of the
+form::
+
+	struct cachefiles_read {
+		__u64 off;
+		__u64 len;
+	};
+
+	where:
+
+	* ``off`` indicates the starting offset of the requested file range.
+
+	* ``len`` indicates the length of the requested file range.
+
+
+When it receives a READ request, the user daemon should fetch the requested data
+and write it to the cache file identified by object_id.
+
+When it has finished processing the READ request, the user daemon should reply
+by using the CACHEFILES_IOC_READ_COMPLETE ioctl on one of the anonymous fds
+associated with the object_id given in the READ request.  The ioctl is of the
+form::
+
+	ioctl(fd, CACHEFILES_IOC_READ_COMPLETE, msg_id);
+
+	* ``fd`` is one of the anonymous fds associated with the object_id
+	  given.
+
+	* ``msg_id`` must match the msg_id field of the READ request.
-- 
2.27.0

