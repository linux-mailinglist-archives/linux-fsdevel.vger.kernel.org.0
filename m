Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804C76C99DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 05:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjC0DF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 23:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjC0DF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 23:05:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E697519AB;
        Sun, 26 Mar 2023 20:05:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 782CF60FA5;
        Mon, 27 Mar 2023 03:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21912C433D2;
        Mon, 27 Mar 2023 03:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679886355;
        bh=Y5YgkurSEHTnuFb5rUWdtaOxzlRzLEHlxLRf+rlWEpE=;
        h=Date:From:To:Cc:Subject:From;
        b=P738GWtxdGHCmLrHqLACcemQjQ3hhSp4c1v4FQPM3ACwC6sz8aqZCj8SF8TXQD/Ph
         4D/r1b2R98NeyTJQx87cj25tZd2PRRyxsfhlexm1CCwhRvl7nu2/VznA2NNFSDukQX
         QP54idMONKsboYt5WLMsFcA7WXfedufNKQ7gbUfhvx2Dhu8BdE1h9ki/+JefbahIaq
         uWAttAbemwcz6sD9QXsuOeSHuJgnjbSQZnfz86T8vUthvWsBbKg4wl5f7mms8Innmo
         4qK3jdmkcCcePBQYJ5i7l4SeYKxGq0use9z4GrN5lY6kFi5aou9hjg6o0PkN+aW9BK
         5tQl/AjmFx+rA==
Date:   Mon, 27 Mar 2023 03:05:52 +0000
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     asmadeus@codewreck.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux_oss@crudebyte.com
Subject: [PATCH] fs/9p: Add new options to Documentation
Message-ID: <ZCEIEKC0s/MFReT0@7e9e31583646>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Need to update the documentation for new mount flags
and cache modes.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 Documentation/filesystems/9p.rst | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 0e800b8f73cc..6d257854a02a 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -78,19 +78,18 @@ Options
   		offering several exported file systems.
 
   cache=mode	specifies a caching policy.  By default, no caches are used.
-
-                        none
-				default no cache policy, metadata and data
-                                alike are synchronous.
-			loose
-				no attempts are made at consistency,
-                                intended for exclusive, read-only mounts
-                        fscache
-				use FS-Cache for a persistent, read-only
-				cache backend.
-                        mmap
-				minimal cache that is only used for read-write
-                                mmap.  Northing else is cached, like cache=none
+		Modes are progressive and inclusive.  For example, specifying fscache
+		will use loose caches, writeback, and readahead.  Due to their
+		inclusive nature, only one cache mode can be specified per mount.
+
+			=========	=============================================
+			none		no cache of file or metadata
+			readahead	readahead caching of files
+			writeback	delayed writeback of files
+			mmap		support mmap operations read/write with cache
+			loose		meta-data and file cache with no coherency
+			fscache		use FS-Cache for a persistent cache backend
+			=========	=============================================
 
   debug=n	specifies debug level.  The debug level is a bitmask.
 
@@ -137,6 +136,10 @@ Options
   		This can be used to share devices/named pipes/sockets between
 		hosts.  This functionality will be expanded in later versions.
 
+  directio	bypass page cache on all read/write operations
+
+  ignoreqv	ignore qid.version==0 as a marker to ignore cache
+
   noxattr	do not offer xattr functions on this mount.
 
   access	there are four access modes.
-- 
2.39.2

