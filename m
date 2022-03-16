Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154024DB0EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 14:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356225AbiCPNTA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 09:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356216AbiCPNSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:18:55 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C725C66AE8;
        Wed, 16 Mar 2022 06:17:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V7NDHAL_1647436654;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V7NDHAL_1647436654)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 21:17:35 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com
Subject: [PATCH v5 07/22] cachefiles: document on-demand read mode
Date:   Wed, 16 Mar 2022 21:17:08 +0800
Message-Id: <20220316131723.111553-8-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document new user interface introduced by on-demand read mode.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 .../filesystems/caching/cachefiles.rst        | 176 ++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/Documentation/filesystems/caching/cachefiles.rst b/Documentation/filesystems/caching/cachefiles.rst
index 8bf396b76359..c8286c901eae 100644
--- a/Documentation/filesystems/caching/cachefiles.rst
+++ b/Documentation/filesystems/caching/cachefiles.rst
@@ -28,6 +28,8 @@ Cache on Already Mounted Filesystem
 
  (*) Debugging.
 
+ (*) On-demand Read.
+
 
 
 Overview
@@ -482,3 +484,177 @@ the control file.  For example::
 	echo $((1|4|8)) >/sys/module/cachefiles/parameters/debug
 
 will turn on all function entry debugging.
+
+
+On-demand Read
+==============
+
+When working in original mode, cachefiles mainly serves as a local cache for
+remote networking fs, while in on-demand read mode, cachefiles can boost the
+scenario where on-demand read semantics is needed, e.g. container image
+distribution.
+
+The essential difference between these two modes is that, in original mode,
+when cache miss, netfs itself will fetch data from remote, and then write the
+fetched data into cache file. While in on-demand read mode, a user daemon is
+responsible for fetching data and then writing to the cache file.
+
+``CONFIG_CACHEFILES_ONDEMAND`` shall be enabled to support on-demand read mode.
+
+
+Protocol Communication
+----------------------
+
+The on-demand read mode relies on a simple protocol used for communication
+between kernel and user daemon. The model is like::
+
+	kernel --[request]--> user daemon --[reply]--> kernel
+
+The cachefiles kernel module will send requests to user daemon when needed.
+User daemon needs to poll on the devnode ('/dev/cachefiles') to check if
+there's pending request to be processed. A POLLIN event will be returned
+when there's pending request.
+
+Then user daemon needs to read the devnode to fetch one request and process it
+accordingly. It is worth nothing that each read only gets one request. When
+finished processing the request, user dameon needs to write the reply to the
+devnode.
+
+Each request is started with a message header like::
+
+	struct cachefiles_msg {
+		__u32 id;
+		__u32 opcode;
+		__u32 len;
+		__u8  data[];
+	};
+
+	* ``id`` identifies the position of this request in an internal xarray
+	  managing all pending requests.
+
+	* ``opcode`` identifies the type of this request.
+
+	* ``data`` identifies the payload of this request.
+
+	* ``len`` identifies the whole length of this request, including the
+	  header and following type specific payload.
+
+
+Turn on On-demand Mode
+----------------------
+
+An optional parameter is added to "bind" command::
+
+	bind [ondemand]
+
+When "bind" command takes without argument, it defaults to the original mode.
+When "bind" command takes with "ondemand" argument, i.e. "bind ondemand",
+on-demand read mode will be enabled.
+
+
+OPEN Request
+------------
+
+When netfs opens a cache file for the first time, a request with
+CACHEFILES_OP_OPEN opcode, a.k.a OPEN request will be sent to user daemon. The
+payload format is like::
+
+	struct cachefiles_open {
+		__u32 volume_key_len;
+		__u32 cookie_key_len;
+		__u32 fd;
+		__u32 flags;
+		__u8  data[];
+	};
+
+	* ``data`` contains volume_key and cookie_key in sequence.
+
+	* ``volume_key_len`` identifies the length of the volume key of the
+	  cache file, in bytes. volume_key is of string format, with a suffix
+	  '\0'.
+
+	* ``cookie_key_len`` identifies the length of the cookie key of the
+	  cache file, in bytes. The format of cookie_key is netfs specific. It
+	  can be of binary format.
+
+	* ``fd`` identifies the anonymous fd of the cache file, with which user
+	  daemon can perform write/llseek file operations on the cache file.
+
+
+OPEN request contains (volume_key, cookie_key, anon_fd) triple for corresponding
+cache file. With this triple, user daemon could fetch and write data into the
+cache file in the background, even when kernel has not triggered the cache miss
+yet. User daemon is able to distinguish the requested cache file with the given
+(volume_key, cookie_key), and write the fetched data into cache file with the
+given anon_fd.
+
+After recording the (volume_key, cookie_key, anon_fd) triple, user daemon shall
+reply with "cinit" (complete init) command::
+
+	cinit <id>
+
+	* ``id`` is exactly the id field of the previous OPEN request.
+
+
+Besides, CACHEFILES_OPEN_WANT_CACHE_SIZE flag may be set in flags field of
+OPEN request. This flag is used in the scenario where one cache file can contain
+multiple netfs files for the purpose of deduplication, e.g. In this case, netfs
+itself has no idea the cache file size, whilst user daemon needs to offer the
+hint on the cache file size.
+
+Thus when receiving an OPEN request with CACHEFILES_OPEN_WANT_CACHE_SIZE flag
+set, user daemon must reply with the cache file size::
+
+	cinit <id>,<cache_size>
+
+	* ``id`` is exactly the id field of the previous OPEN request.
+
+	* ``cache_size`` identifies the size of the cache file.
+
+
+CLOSE Request
+-------------
+When cookie withdrawed, a request with CACHEFILES_OP_CLOSE opcode, a.k.a CLOSE
+request, will be sent to user daemon. It will notify user daemon to close the
+attached anon_fd. The payload format is like::
+
+	struct cachefiles_close {
+		__u32 fd;
+	};
+
+	* ``fd`` identifies the anon_fd to be closed, which is exactly the same
+	  with that in OPEN request.
+
+
+READ Request
+------------
+
+When on-demand read mode is turned on, and cache miss encountered, kernel will
+send a request with CACHEFILES_OP_READ opcode, a.k.a READ request, to user
+daemon. It will notify user daemon to fetch data in the requested file range.
+The payload format is like::
+
+	struct cachefiles_read {
+		__u64 off;
+		__u64 len;
+		__u32 fd;
+	};
+
+	* ``off`` identifies the starting offset of the requested file range.
+
+	* ``len`` identifies the length of the requested file range.
+
+	* ``fd`` identifies the anonymous fd of the requested cache file. It is
+	  guaranteed that it shall be the same with the fd field in the previous
+	  OPEN request.
+
+When receiving one READ request, user daemon needs to fetch data of the
+requested file range, and then write the fetched data into cache file with the
+given anonymous fd.
+
+When finished processing the READ request, user daemon needs to reply with
+"cread" (complete read) command::
+
+	cread <id>
+
+	* ``id`` is exactly the id field of the previous READ request.
-- 
2.27.0

