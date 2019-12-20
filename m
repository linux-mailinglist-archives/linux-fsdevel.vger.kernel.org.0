Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63474127D6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 15:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfLTOdu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 09:33:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37455 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfLTOdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:33:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so9458213wmf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 06:33:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=V6peUYVw+8q1XalOpqZ1ayFyqbTEFtfcEYX2FP9pROo=;
        b=O2NUj8PkP1Y8E8uafuKkjKJU1mg3rYaqup/1w7D0ngdFssyHOWdqTV4iETzuLWdtr/
         FAKTBxyYl1BmyD1INSagMCVxG4EE6ROWdpFbOWrhSIPDCxNj3yv7tEIPus58AaVrLlmR
         h5AClIy8S5BdvtQ3SquFJzBPujwvqqyPILKDqzZkoGKIFaadsVyxPn/oh6S6qZnlBaki
         ANG7ktkKkxGx04wIaC47eWJLky3GMwXpr7oUmn142HkfGeJo4wPAAMBCpBFC062Klf9T
         KMVtThp/Yi3dgmwOv1meVhYkghGzK8V4/OHCRz6cCRdu5ijq5rXmK2ZbCxn34hmuvtp/
         8uwA==
X-Gm-Message-State: APjAAAWUStDNL4NkrddMlRx2UmfDb1inDeGA7VtQmyiHGuwQQC/4ExIo
        C8kga4CYwUwiy7rdGA1YD459Og==
X-Google-Smtp-Source: APXvYqxVS8YAU3RLQWiNFWWhq3mf++gLHMleVdt7qSTwX9NrqFbPr8TqBrxxQzLMRWsCwz0CaURhTQ==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr17423248wml.71.1576852426193;
        Fri, 20 Dec 2019 06:33:46 -0800 (PST)
Received: from [10.140.78.238] ([46.114.38.238])
        by smtp.gmail.com with ESMTPSA id l15sm9907506wrv.39.2019.12.20.06.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 06:33:43 -0800 (PST)
Date:   Fri, 20 Dec 2019 15:33:39 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20191220140328.20907-2-cyphar@cyphar.com>
References: <20191220140328.20907-1-cyphar@cyphar.com> <20191220140328.20907-2-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 1/2] openat2: drop open_how->__padding field
To:     containers@lists.linux-foundation.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@opencontainers.org,
        David Laight <david.laight@aculab.com>,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <88F5533A-9C91-41D1-A2E6-3622FCEEEDB1@ubuntu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc Arnd for struct layout sanity checking]

On December 20, 2019 3:03:27 PM GMT+01:00, Aleksa Sarai <cyphar@cyphar.com> wrote:
>The purpose of explicit padding was to allow us to use the space in the
>future (C provides no guarantee about the value of padding bytes and
>thus userspace could've provided garbage).
>
>However, the downside of explicit padding is that any extension we wish
>to add should fit the space exactly (otherwise we may end up with a u16
>which will never be used). In addition, the correct error to return for
>non-zero padding is not clear (-EINVAL doesn't imply "you're using an
>extension field unsupported by this kernel", but -E2BIG seems a bit odd
>if the structure size isn't different).
>
>The simplest solution is to just match the design of clone3(2) -- use
>u64s for all fields. The extra few-bytes cost of extra fields is not
>significant (it's unlikely configuration structs will ever be extremely
>large) and it allows for more flag space if necessary. There is also no
>need to align the u64s because we will not permit any padding in the
>structure.
>
>As openat2(2) is not yet in Linus's tree, we can iron out these minor
>warts before we commit to this as a stable ABI.
>
>Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
>Suggested-by: David Laight <david.laight@aculab.com>
>Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>---
> fs/open.c                                     |  2 --
> include/uapi/linux/fcntl.h                    | 17 +++++++------
> tools/testing/selftests/openat2/helpers.h     |  7 +++---
> .../testing/selftests/openat2/openat2_test.c  | 24 +++++++------------
> 4 files changed, 19 insertions(+), 31 deletions(-)
>
>diff --git a/fs/open.c b/fs/open.c
>index 50a46501bcc9..8cdb2b675867 100644
>--- a/fs/open.c
>+++ b/fs/open.c
>@@ -993,8 +993,6 @@ static inline int build_open_flags(const struct
>open_how *how,
> 		return -EINVAL;
> 	if (how->resolve & ~VALID_RESOLVE_FLAGS)
> 		return -EINVAL;
>-	if (memchr_inv(how->__padding, 0, sizeof(how->__padding)))
>-		return -EINVAL;
> 
> 	/* Deal with the mode. */
> 	if (WILL_CREATE(flags)) {
>diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
>index d886bdb585e4..5aaadfd79dd5 100644
>--- a/include/uapi/linux/fcntl.h
>+++ b/include/uapi/linux/fcntl.h
>@@ -101,22 +101,21 @@
> #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
> 
> /*
>- * Arguments for how openat2(2) should open the target path. If
>@resolve is
>- * zero, then openat2(2) operates very similarly to openat(2).
>+ * Arguments for how openat2(2) should open the target path. If only
>@flags and
>+ * @mode are non-zero, then openat2(2) operates very similarly to
>openat(2).
>  *
>- * However, unlike openat(2), unknown bits in @flags result in -EINVAL
>rather
>- * than being silently ignored. @mode must be zero unless one of
>{O_CREAT,
>- * O_TMPFILE} are set.
>+ * However, unlike openat(2), unknown or invalid bits in @flags result
>in
>+ * -EINVAL rather than being silently ignored. @mode must be zero
>unless one of
>+ *  {O_CREAT, O_TMPFILE} are set.
>  *
>  * @flags: O_* flags.
>  * @mode: O_CREAT/O_TMPFILE file mode.
>  * @resolve: RESOLVE_* flags.
>  */
> struct open_how {
>-	__aligned_u64 flags;
>-	__u16 mode;
>-	__u16 __padding[3]; /* must be zeroed */
>-	__aligned_u64 resolve;
>+	__u64 flags;
>+	__u64 mode;
>+	__u64 resolve;
> };
> 
> #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
>diff --git a/tools/testing/selftests/openat2/helpers.h
>b/tools/testing/selftests/openat2/helpers.h
>index 43ca5ceab6e3..a6ea27344db2 100644
>--- a/tools/testing/selftests/openat2/helpers.h
>+++ b/tools/testing/selftests/openat2/helpers.h
>@@ -36,10 +36,9 @@
>  * @resolve: RESOLVE_* flags.
>  */
> struct open_how {
>-	__aligned_u64 flags;
>-	__u16 mode;
>-	__u16 __padding[3]; /* must be zeroed */
>-	__aligned_u64 resolve;
>+	__u64 flags;
>+	__u64 mode;
>+	__u64 resolve;
> };
> 
> #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
>diff --git a/tools/testing/selftests/openat2/openat2_test.c
>b/tools/testing/selftests/openat2/openat2_test.c
>index 0b64fedc008b..b386367c606b 100644
>--- a/tools/testing/selftests/openat2/openat2_test.c
>+++ b/tools/testing/selftests/openat2/openat2_test.c
>@@ -40,7 +40,7 @@ struct struct_test {
> 	int err;
> };
> 
>-#define NUM_OPENAT2_STRUCT_TESTS 10
>+#define NUM_OPENAT2_STRUCT_TESTS 7
> #define NUM_OPENAT2_STRUCT_VARIATIONS 13
> 
> void test_openat2_struct(void)
>@@ -57,20 +57,6 @@ void test_openat2_struct(void)
> 		  .arg.inner.flags = O_RDONLY,
> 		  .size = sizeof(struct open_how_ext) },
> 
>-		/* Normal struct with broken padding. */
>-		{ .name = "normal struct (non-zero padding[0])",
>-		  .arg.inner.flags = O_RDONLY,
>-		  .arg.inner.__padding = {0xa0, 0x00, 0x00},
>-		  .size = sizeof(struct open_how_ext), .err = -EINVAL },
>-		{ .name = "normal struct (non-zero padding[1])",
>-		  .arg.inner.flags = O_RDONLY,
>-		  .arg.inner.__padding = {0x00, 0x1a, 0x00},
>-		  .size = sizeof(struct open_how_ext), .err = -EINVAL },
>-		{ .name = "normal struct (non-zero padding[2])",
>-		  .arg.inner.flags = O_RDONLY,
>-		  .arg.inner.__padding = {0x00, 0x00, 0xef},
>-		  .size = sizeof(struct open_how_ext), .err = -EINVAL },
>-
> 		/* TODO: Once expanded, check zero-padding. */
> 
> 		/* Smaller than version-0 struct. */
>@@ -169,7 +155,7 @@ struct flag_test {
> 	int err;
> };
> 
>-#define NUM_OPENAT2_FLAG_TESTS 21
>+#define NUM_OPENAT2_FLAG_TESTS 23
> 
> void test_openat2_flags(void)
> {
>@@ -214,9 +200,15 @@ void test_openat2_flags(void)
> 		{ .name = "invalid how.mode and O_CREAT",
> 		  .how.flags = O_CREAT,
> 		  .how.mode = 0xFFFF, .err = -EINVAL },
>+		{ .name = "invalid (very large) how.mode and O_CREAT",
>+		  .how.flags = O_CREAT,
>+		  .how.mode = 0xC000000000000000ULL, .err = -EINVAL },
> 		{ .name = "invalid how.mode and O_TMPFILE",
> 		  .how.flags = O_TMPFILE | O_RDWR,
> 		  .how.mode = 0x1337, .err = -EINVAL },
>+		{ .name = "invalid (very large) how.mode and O_TMPFILE",
>+		  .how.flags = O_TMPFILE | O_RDWR,
>+		  .how.mode = 0x0000A00000000000ULL, .err = -EINVAL },
> 
> 		/* ->resolve must only contain RESOLVE_* flags. */
> 		{ .name = "invalid how.resolve and O_RDONLY",

