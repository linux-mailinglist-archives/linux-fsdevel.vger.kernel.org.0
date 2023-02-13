Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAF5695506
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 00:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjBMXup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 18:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjBMXuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:50:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACCC17176;
        Mon, 13 Feb 2023 15:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30736B81A2C;
        Mon, 13 Feb 2023 23:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90339C433D2;
        Mon, 13 Feb 2023 23:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676332215;
        bh=nZoqCIzntooHyG/7O/cvPGIWw/MK4HLeMmg+I6toqr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NblVv/QUcjtqg2tOds2OzXshr7zDMAYVBBYrAQxu4adZj8UawL4mMLfGSM3G5jY1G
         b2mjr6+q9bB0DA2XMaoJqNFfpguLJRdSfQeaTBlGczj6tLSOGrdhPTtZDFht+G8r64
         JGOup4IWFJ5BhjQvd6OoWZP2Z3wzI5cIJK89CD20rMV9ZpGE9V7BFrE+M+C0m3bn1n
         iwdtwAkWsETBTZKRpv/pEu5qWvTYeCB+1bVNRf9g2np5R27ZrM1vIVSZWPk9U6TjDx
         aOtxcef29tACnHbigA24xFmqh63cdfzcehNeWe1PA+JwAqY3SuSzxIjeut1UIyldxH
         d3fGix6veS3+g==
Date:   Mon, 13 Feb 2023 17:50:14 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mount_setattr: fix redefine struct mount_attr
 build error
Message-ID: <Y+rMtlvx31w7eWCA@do-x1extreme>
References: <20230213183149.231779-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230213183149.231779-1-skhan@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 13, 2023 at 11:31:49AM -0700, Shuah Khan wrote:
> Fix the following build error due to redefining struct mount_attr by
> removing duplicate define from mount_setattr_test.c
> 
> gcc -g -isystem .../tools/testing/selftests/../../../usr/include -Wall -O2 -pthread     mount_setattr_test.c  -o .../tools/testing/selftests/mount_setattr/mount_setattr_test
> mount_setattr_test.c:107:8: error: redefinition of ‘struct mount_attr’
>   107 | struct mount_attr {
>       |        ^~~~~~~~~~
> In file included from /usr/include/x86_64-linux-gnu/sys/mount.h:32,
>                  from mount_setattr_test.c:10:
> .../usr/include/linux/mount.h:129:8: note: originally defined here
>   129 | struct mount_attr {
>       |        ^~~~~~~~~~
> make: *** [../lib.mk:145: .../tools/testing/selftests/mount_setattr/mount_setattr_test] Error 1
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  tools/testing/selftests/mount_setattr/mount_setattr_test.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> index 8c5fea68ae67..582669ca38e9 100644
> --- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> +++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> @@ -103,13 +103,6 @@
>  	#else
>  		#define __NR_mount_setattr 442
>  	#endif
> -
> -struct mount_attr {
> -	__u64 attr_set;
> -	__u64 attr_clr;
> -	__u64 propagation;
> -	__u64 userns_fd;
> -};
>  #endif

The difficulty with this is that whether or not you need this definition
depends on your system headers. My laptop doesn't have definitions for
either __NR_mount_setattr or struct mount_attr, so for me the build
works without this patch but fails with it.

I suppose we could fix this universally by using a different name for
the struct in the test, e.g.:

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 8c5fea68ae67..0658129d526e 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -103,13 +103,6 @@
 	#else
 		#define __NR_mount_setattr 442
 	#endif
-
-struct mount_attr {
-	__u64 attr_set;
-	__u64 attr_clr;
-	__u64 propagation;
-	__u64 userns_fd;
-};
 #endif
 
 #ifndef __NR_open_tree
@@ -132,6 +125,13 @@ struct mount_attr {
 	#endif
 #endif
 
+struct __mount_attr {
+	__u64 attr_set;
+	__u64 attr_clr;
+	__u64 propagation;
+	__u64 userns_fd;
+};
+
 #ifndef MOUNT_ATTR_IDMAP
 #define MOUNT_ATTR_IDMAP 0x00100000
 #endif
@@ -141,7 +141,7 @@ struct mount_attr {
 #endif
 
 static inline int sys_mount_setattr(int dfd, const char *path, unsigned int flags,
-				    struct mount_attr *attr, size_t size)
+				    struct __mount_attr *attr, size_t size)
 {
 	return syscall(__NR_mount_setattr, dfd, path, flags, attr, size);
 }
@@ -347,7 +347,7 @@ static bool is_shared_mount(const char *path)
 
 static void *mount_setattr_thread(void *data)
 {
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set	= MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
 		.attr_clr	= 0,
 		.propagation	= MS_SHARED,
@@ -445,7 +445,7 @@ FIXTURE_TEARDOWN(mount_setattr)
 
 TEST_F(mount_setattr, invalid_attributes)
 {
-	struct mount_attr invalid_attr = {
+	struct __mount_attr invalid_attr = {
 		.attr_set = (1U << 31),
 	};
 
@@ -479,11 +479,11 @@ TEST_F(mount_setattr, extensibility)
 {
 	unsigned int old_flags = 0, new_flags = 0, expected_flags = 0;
 	char *s = "dummy";
-	struct mount_attr invalid_attr = {};
+	struct __mount_attr invalid_attr = {};
 	struct mount_attr_large {
-		struct mount_attr attr1;
-		struct mount_attr attr2;
-		struct mount_attr attr3;
+		struct __mount_attr attr1;
+		struct __mount_attr attr2;
+		struct __mount_attr attr3;
 	} large_attr = {};
 
 	if (!mount_setattr_supported())
@@ -542,7 +542,7 @@ TEST_F(mount_setattr, extensibility)
 TEST_F(mount_setattr, basic)
 {
 	unsigned int old_flags = 0, new_flags = 0, expected_flags = 0;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set	= MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
 		.attr_clr	= MOUNT_ATTR__ATIME,
 	};
@@ -578,7 +578,7 @@ TEST_F(mount_setattr, basic_recursive)
 {
 	int fd;
 	unsigned int old_flags = 0, new_flags = 0, expected_flags = 0;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set	= MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
 		.attr_clr	= MOUNT_ATTR__ATIME,
 	};
@@ -672,7 +672,7 @@ TEST_F(mount_setattr, mount_has_writers)
 {
 	int fd, dfd;
 	unsigned int old_flags = 0, new_flags = 0;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set	= MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
 		.attr_clr	= MOUNT_ATTR__ATIME,
 		.propagation	= MS_SHARED,
@@ -729,7 +729,7 @@ TEST_F(mount_setattr, mount_has_writers)
 TEST_F(mount_setattr, mixed_mount_options)
 {
 	unsigned int old_flags1 = 0, old_flags2 = 0, new_flags = 0, expected_flags = 0;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_clr = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NOEXEC | MOUNT_ATTR__ATIME,
 		.attr_set = MOUNT_ATTR_RELATIME,
 	};
@@ -763,7 +763,7 @@ TEST_F(mount_setattr, mixed_mount_options)
 TEST_F(mount_setattr, time_changes)
 {
 	unsigned int old_flags = 0, new_flags = 0, expected_flags = 0;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set	= MOUNT_ATTR_NODIRATIME | MOUNT_ATTR_NOATIME,
 	};
 
@@ -967,7 +967,7 @@ TEST_F(mount_setattr, multi_threaded)
 TEST_F(mount_setattr, wrong_user_namespace)
 {
 	int ret;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set = MOUNT_ATTR_RDONLY,
 	};
 
@@ -983,7 +983,7 @@ TEST_F(mount_setattr, wrong_user_namespace)
 TEST_F(mount_setattr, wrong_mount_namespace)
 {
 	int fd, ret;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set = MOUNT_ATTR_RDONLY,
 	};
 
@@ -1074,7 +1074,7 @@ FIXTURE_TEARDOWN(mount_setattr_idmapped)
  */
 TEST_F(mount_setattr_idmapped, invalid_fd_negative)
 {
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set	= MOUNT_ATTR_IDMAP,
 		.userns_fd	= -EBADF,
 	};
@@ -1092,7 +1092,7 @@ TEST_F(mount_setattr_idmapped, invalid_fd_negative)
  */
 TEST_F(mount_setattr_idmapped, invalid_fd_large)
 {
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set	= MOUNT_ATTR_IDMAP,
 		.userns_fd	= INT64_MAX,
 	};
@@ -1111,7 +1111,7 @@ TEST_F(mount_setattr_idmapped, invalid_fd_large)
 TEST_F(mount_setattr_idmapped, invalid_fd_closed)
 {
 	int fd;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 
@@ -1134,7 +1134,7 @@ TEST_F(mount_setattr_idmapped, invalid_fd_closed)
 TEST_F(mount_setattr_idmapped, invalid_fd_initial_userns)
 {
 	int open_tree_fd = -EBADF;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 
@@ -1243,7 +1243,7 @@ static int get_userns_fd(unsigned long nsid, unsigned long hostid, unsigned long
 TEST_F(mount_setattr_idmapped, attached_mount_inside_current_mount_namespace)
 {
 	int open_tree_fd = -EBADF;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 
@@ -1273,7 +1273,7 @@ TEST_F(mount_setattr_idmapped, attached_mount_inside_current_mount_namespace)
 TEST_F(mount_setattr_idmapped, attached_mount_outside_current_mount_namespace)
 {
 	int open_tree_fd = -EBADF;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 
@@ -1303,7 +1303,7 @@ TEST_F(mount_setattr_idmapped, attached_mount_outside_current_mount_namespace)
 TEST_F(mount_setattr_idmapped, detached_mount_inside_current_mount_namespace)
 {
 	int open_tree_fd = -EBADF;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 
@@ -1333,7 +1333,7 @@ TEST_F(mount_setattr_idmapped, detached_mount_inside_current_mount_namespace)
 TEST_F(mount_setattr_idmapped, detached_mount_outside_current_mount_namespace)
 {
 	int open_tree_fd = -EBADF;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 
@@ -1365,7 +1365,7 @@ TEST_F(mount_setattr_idmapped, detached_mount_outside_current_mount_namespace)
 TEST_F(mount_setattr_idmapped, change_idmapping)
 {
 	int open_tree_fd = -EBADF;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 
@@ -1410,7 +1410,7 @@ static bool expected_uid_gid(int dfd, const char *path, int flags,
 TEST_F(mount_setattr_idmapped, idmap_mount_tree_invalid)
 {
 	int open_tree_fd = -EBADF;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 
@@ -1445,7 +1445,7 @@ TEST_F(mount_setattr, mount_attr_nosymfollow)
 {
 	int fd;
 	unsigned int old_flags = 0, new_flags = 0, expected_flags = 0;
-	struct mount_attr attr = {
+	struct __mount_attr attr = {
 		.attr_set	= MOUNT_ATTR_NOSYMFOLLOW,
 	};
