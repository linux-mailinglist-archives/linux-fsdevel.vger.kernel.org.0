Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F256A590
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 11:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbfGPJoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 05:44:09 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:44915 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387410AbfGPJn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:43:57 -0400
Received: by mail-pf1-f201.google.com with SMTP id j22so12025175pfe.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gVc6psse1CsqJ4oK5G3/PjIcN5lI3IcM3aarpBLoyJM=;
        b=faQsKZMzmkGI5xWZVj5erlphZpAKQUmLZUV6R18+oZ8GOA5Ovw4Llm4CvG23QFL2+B
         4WmKhzOk6mwCdjmn6jGzXdD5z7/VeimVMzsgH7PUyxqw1F56lMAjuCRcDQjgf97/i1Sy
         gEGmaWgDjcEj6RHxMres2qJffikXeCDToTz9P9ixw4hOzommv1piOeASO1AFXzpGVuvT
         1+/R1c+RpTOq1sx9qZYPHh7+q3u/fY1kOCCqA24hLKLVHkXF4gTq8ODJ6FuIgyJ+riln
         52tnqhImMZwjyygb7pHt1SLWJ392kdrgnQv5F9RX8fEsctMi8w8x0/BzDuHb3ZlP2dmk
         7nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gVc6psse1CsqJ4oK5G3/PjIcN5lI3IcM3aarpBLoyJM=;
        b=BYGW6duYSC6+I8H5aM7ufhRZeoC/7pGDTa+OameXeuLQMHROaRRjn2BQxxcygKn5S+
         V+g56AhxSLDrD+9X6g2Qo2cZPpnEK6K8y7GqeOh2YUNDflDCAwVH8IEwD7DCxCr46snz
         BAyvhpoAQViUwkayx5j8VHn7bLkC+sH2i67tvaMuNKCzQXLjbH9UEzaQkZ3YPpYIk1Eq
         elyn7/ATsPpQJiD1TR/70iSyw5sjDli/ubnKcERUgAsrWlQt7sWwDJLmmJ3NIEK9uXU7
         MkCWkWxYfMgh0KkY9Df3+K8DIwNT8GIih2A+Qsk2uqWgVyFroYmTtKoWykaXo+T1HBj1
         HM7g==
X-Gm-Message-State: APjAAAXo1hdkaNicULRKEB1oBdLvWMOsQ0rSHcC6Z4t7kVc0r5tQNk4a
        +DbLQ5My2/ckermC9ux+D+4qmpUzjyJ+a2XYSY0Otg==
X-Google-Smtp-Source: APXvYqxCKPwACdZPC1L2GforS8c5GUkRStozCK7TJa5UdJPrY8e0E3hh5giTkUbSQ57Jm6Xj3+dJ5gEJuApY01MdsyvOPQ==
X-Received: by 2002:a63:5b1d:: with SMTP id p29mr31101524pgb.297.1563270235710;
 Tue, 16 Jul 2019 02:43:55 -0700 (PDT)
Date:   Tue, 16 Jul 2019 02:43:01 -0700
In-Reply-To: <20190716094302.180360-1-brendanhiggins@google.com>
Message-Id: <20190716094302.180360-18-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190716094302.180360-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v10 17/18] kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Iurii Zaikin <yzaikin@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Iurii Zaikin <yzaikin@google.com>

KUnit tests for initialized data behavior of proc_dointvec that is
explicitly checked in the code. Includes basic parsing tests including
int min/max overflow.

Signed-off-by: Iurii Zaikin <yzaikin@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/Makefile      |   2 +
 kernel/sysctl-test.c | 392 +++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug    |  11 ++
 3 files changed, 405 insertions(+)
 create mode 100644 kernel/sysctl-test.c

diff --git a/kernel/Makefile b/kernel/Makefile
index a8d923b5481ba..50fd511cd0ee0 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -114,6 +114,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomem.o
 obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_RSEQ) += rseq.o
 
+obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
+
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
new file mode 100644
index 0000000000000..2a63241a8453b
--- /dev/null
+++ b/kernel/sysctl-test.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test of proc sysctl.
+ */
+
+#include <kunit/test.h>
+#include <linux/sysctl.h>
+
+#define KUNIT_PROC_READ 0
+#define KUNIT_PROC_WRITE 1
+
+static int i_zero;
+static int i_one_hundred = 100;
+
+/*
+ * Test that proc_dointvec will not try to use a NULL .data field even when the
+ * length is non-zero.
+ */
+static void sysctl_test_api_dointvec_null_tbl_data(struct kunit *test)
+{
+	struct ctl_table null_data_table = {
+		.procname = "foo",
+		/*
+		 * Here we are testing that proc_dointvec behaves correctly when
+		 * we give it a NULL .data field. Normally this would point to a
+		 * piece of memory where the value would be stored.
+		 */
+		.data		= NULL,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	/*
+	 * proc_dointvec expects a buffer in user space, so we allocate one. We
+	 * also need to cast it to __user so sparse doesn't get mad.
+	 */
+	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
+							   GFP_USER);
+	size_t len;
+	loff_t pos;
+
+	/*
+	 * We don't care what the starting length is since proc_dointvec should
+	 * not try to read because .data is NULL.
+	 */
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&null_data_table,
+					       KUNIT_PROC_READ, buffer, &len,
+					       &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+
+	/*
+	 * See above.
+	 */
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&null_data_table,
+					       KUNIT_PROC_WRITE, buffer, &len,
+					       &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+}
+
+/*
+ * Similar to the previous test, we create a struct ctrl_table that has a .data
+ * field that proc_dointvec cannot do anything with; however, this time it is
+ * because we tell proc_dointvec that the size is 0.
+ */
+static void sysctl_test_api_dointvec_table_maxlen_unset(struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table data_maxlen_unset_table = {
+		.procname = "foo",
+		.data		= &data,
+		/*
+		 * So .data is no longer NULL, but we tell proc_dointvec its
+		 * length is 0, so it still shouldn't try to use it.
+		 */
+		.maxlen		= 0,
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
+							   GFP_USER);
+	size_t len;
+	loff_t pos;
+
+	/*
+	 * As before, we don't care what buffer length is because proc_dointvec
+	 * cannot do anything because its internal .data buffer has zero length.
+	 */
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&data_maxlen_unset_table,
+					       KUNIT_PROC_READ, buffer, &len,
+					       &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+
+	/*
+	 * See previous comment.
+	 */
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&data_maxlen_unset_table,
+					       KUNIT_PROC_WRITE, buffer, &len,
+					       &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+}
+
+/*
+ * Here we provide a valid struct ctl_table, but we try to read and write from
+ * it using a buffer of zero length, so it should still fail in a similar way as
+ * before.
+ */
+static void sysctl_test_api_dointvec_table_len_is_zero(struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
+							   GFP_USER);
+	/*
+	 * However, now our read/write buffer has zero length.
+	 */
+	size_t len = 0;
+	loff_t pos;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ, buffer,
+					       &len, &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE, buffer,
+					       &len, &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+}
+
+/*
+ * Test that proc_dointvec refuses to read when the file position is non-zero.
+ */
+static void sysctl_test_api_dointvec_table_read_but_position_set(
+		struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
+							   GFP_USER);
+	/*
+	 * We don't care about our buffer length because we start off with a
+	 * non-zero file position.
+	 */
+	size_t len = 1234;
+	/*
+	 * proc_dointvec should refuse to read into the buffer since the file
+	 * pos is non-zero.
+	 */
+	loff_t pos = 1;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ, buffer,
+					       &len, &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+}
+
+/*
+ * Test that we can read a two digit number in a sufficiently size buffer.
+ * Nothing fancy.
+ */
+static void sysctl_test_dointvec_read_happy_single_positive(struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	size_t len = 4;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	/* Store 13 in the data field. */
+	*((int *)table.data) = 13;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ,
+					       user_buffer, &len, &pos));
+	KUNIT_ASSERT_EQ(test, (size_t)3, len);
+	buffer[len] = '\0';
+	/* And we read 13 back out. */
+	KUNIT_EXPECT_STREQ(test, "13\n", buffer);
+}
+
+/*
+ * Same as previous test, just now with negative numbers.
+ */
+static void sysctl_test_dointvec_read_happy_single_negative(struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	size_t len = 5;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	*((int *)table.data) = -16;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ,
+					       user_buffer, &len, &pos));
+	KUNIT_ASSERT_EQ(test, (size_t)4, len);
+	buffer[len] = '\0';
+	KUNIT_EXPECT_STREQ(test, "-16\n", (char *)buffer);
+}
+
+/*
+ * Test that a simple positive write works.
+ */
+static void sysctl_test_dointvec_write_happy_single_positive(struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	char input[] = "9";
+	size_t len = sizeof(input) - 1;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+
+	memcpy(buffer, input, len);
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE,
+					       user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, (size_t)pos);
+	KUNIT_EXPECT_EQ(test, 9, *((int *)table.data));
+}
+
+/*
+ * Same as previous test, but now with negative numbers.
+ */
+static void sysctl_test_dointvec_write_happy_single_negative(struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	char input[] = "-9";
+	size_t len = sizeof(input) - 1;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+
+	memcpy(buffer, input, len);
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE,
+					       user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, (size_t)pos);
+	KUNIT_EXPECT_EQ(test, -9, *((int *)table.data));
+}
+
+/*
+ * Test that writing a value smaller than the minimum possible value is not
+ * allowed.
+ */
+static void sysctl_test_api_dointvec_write_single_less_int_min(
+		struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	size_t max_len = 32, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	unsigned long abs_of_less_than_min = (unsigned long)INT_MAX
+					     - (INT_MAX + INT_MIN) + 1;
+
+	/*
+	 * We use this rigmarole to create a string that contains a value one
+	 * less than the minimum accepted value.
+	 */
+	KUNIT_ASSERT_LT(test,
+			(size_t)snprintf(buffer, max_len, "-%lu",
+					 abs_of_less_than_min),
+			max_len);
+
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dointvec(&table, KUNIT_PROC_WRITE,
+						     user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, max_len, len);
+	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
+}
+
+/*
+ * Test that writing the maximum possible value works.
+ */
+static void sysctl_test_api_dointvec_write_single_greater_int_max(
+		struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	size_t max_len = 32, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	unsigned long greater_than_max = (unsigned long)INT_MAX + 1;
+
+	KUNIT_ASSERT_GT(test, greater_than_max, (unsigned long)INT_MAX);
+	KUNIT_ASSERT_LT(test, (size_t)snprintf(buffer, max_len, "%lu",
+					       greater_than_max),
+			max_len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dointvec(&table, KUNIT_PROC_WRITE,
+						     user_buffer, &len, &pos));
+	KUNIT_ASSERT_EQ(test, max_len, len);
+	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
+}
+
+static struct kunit_case sysctl_test_cases[] = {
+	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
+	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
+	KUNIT_CASE(sysctl_test_api_dointvec_table_len_is_zero),
+	KUNIT_CASE(sysctl_test_api_dointvec_table_read_but_position_set),
+	KUNIT_CASE(sysctl_test_dointvec_read_happy_single_positive),
+	KUNIT_CASE(sysctl_test_dointvec_read_happy_single_negative),
+	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_positive),
+	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
+	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
+	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
+	{}
+};
+
+static struct kunit_suite sysctl_test_suite = {
+	.name = "sysctl_test",
+	.test_cases = sysctl_test_cases,
+};
+
+kunit_test_suite(sysctl_test_suite);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cbdfae3798965..6f8007800a76f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1939,6 +1939,17 @@ config TEST_SYSCTL
 
 	  If unsure, say N.
 
+config SYSCTL_KUNIT_TEST
+	bool "KUnit test for sysctl"
+	depends on KUNIT
+	help
+	  This builds the proc sysctl unit test, which runs on boot.
+	  Tests the API contract and implementation correctness of sysctl.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
-- 
2.22.0.510.g264f2c817a-goog

