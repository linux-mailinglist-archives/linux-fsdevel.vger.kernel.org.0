Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3969F11207
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 06:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfEBEEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 00:04:07 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:50718 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfEBEEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 00:04:07 -0400
Received: by mail-yw1-f73.google.com with SMTP id j66so1966299ywa.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 21:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MSgT6H7NVvxbaiBARPgQvrKPRDe5d9QWUx3dqoIjICQ=;
        b=lBwj9EAVWUjsiL/hHHU9U5d+QC1JlFlQqW0elFNvktAcfdtqADCR2j2gBbnmduB3mu
         zit30vbbmdPYk6+sVEhsmksvW6aopoaztfrq/hgEAaGjaKxk5YnnGSeWnXAFaG8ivs2V
         YAY4BGTGL7qEjOhQ/2ae7tXN3fpSVes7O+1W3MKhmItdcXJRcZ2tFkax8d1SA2QJ6K4s
         PvnFpUhDptNDqUrgfYvsX7aqkgI7js7VLTDa8x501cU+54gMhSmemVQG5q5nL9Jko4ly
         a5/+b3v3RqYv8nZYJwNiFLh3xUF/wBn4ivQopdNYTXO6gBtjkow3pKrALcfnZS+dM/Bz
         wasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MSgT6H7NVvxbaiBARPgQvrKPRDe5d9QWUx3dqoIjICQ=;
        b=UNoYhYfGdoR1+t6qNsjrF3BpgNfbs6XmBzfqtwK6505t0CpTaQ+d9/4m4bP8Vsrlsz
         vXRrHGeNW13qL7mKfB8j9oVMW9prv2RsxdVR+U+aasEIv6N8D8eyTLhyzuoJOAjqv+d1
         UIjRobyJo7PYct2PpY/kD5o0cv4aaqWvyftb1ViK5kC/tnStur8U0ToX5ky9kalyNgRH
         c4OUjFx4D6LYlWJRCRN3hKRmM15IdQLiXg00H3mueiEyD8kdOcKvK1NhiaFJyq+z/EvB
         4OSKon2+DmkgdGqPu3eAUWg7BwNtEocKMU4oDKaMyTvP0pmDxYoH+NrYQ15sPkZgkGYA
         ECVw==
X-Gm-Message-State: APjAAAXQUHfISenwR6jILaS12EuAo3rKlGTiMxyH9VI8FmfLZbAp6jLL
        Bvqf+4K9YUTS8EVragOx9tdDdxTxvSVAW2OLC6bI0kdpocfGs5hxo4kannGQAUO5u6kKegXQ0tB
        fpawRhMx1UPOQ8FYwhrGgv7yekRqQCOLFRzTQGnsEvndZx5vJPvWwS3vyra5kkJQSb5XD2WjxXm
        8=
X-Google-Smtp-Source: APXvYqx3IeOguSNBTZmSP8bK1XDNfVtAKGrGnUaxCdQ+TeerQ0mH0HYklNpyHgfj6EPHxpyBTlZpjOsJgewmAg==
X-Received: by 2002:a25:2d46:: with SMTP id s6mr1228280ybe.436.1556769845431;
 Wed, 01 May 2019 21:04:05 -0700 (PDT)
Date:   Wed,  1 May 2019 21:03:31 -0700
In-Reply-To: <20190502040331.81196-1-ezemtsov@google.com>
Message-Id: <20190502040331.81196-7-ezemtsov@google.com>
Mime-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH 6/6] incfs: Integration tests for incremental-fs
From:   ezemtsov@google.com
To:     linux-fsdevel@vger.kernel.org
Cc:     tytso@mit.edu, Eugene Zemtsov <ezemtsov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eugene Zemtsov <ezemtsov@google.com>

Testing main use cases for Incremental FS.
Things like:
	- interaction between consuments and producers
	- basic dir operations
	- mounting a backing file with existing data

Signed-off-by: Eugene Zemtsov <ezemtsov@google.com>
---
 tools/testing/selftests/Makefile              |    1 +
 .../selftests/filesystems/incfs/.gitignore    |    1 +
 .../selftests/filesystems/incfs/Makefile      |   12 +
 .../selftests/filesystems/incfs/config        |    1 +
 .../selftests/filesystems/incfs/incfs_test.c  | 1603 +++++++++++++++++
 .../selftests/filesystems/incfs/utils.c       |  159 ++
 .../selftests/filesystems/incfs/utils.h       |   39 +
 7 files changed, 1816 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/incfs/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/incfs/Makefile
 create mode 100644 tools/testing/selftests/filesystems/incfs/config
 create mode 100644 tools/testing/selftests/filesystems/incfs/incfs_test.c
 create mode 100644 tools/testing/selftests/filesystems/incfs/utils.c
 create mode 100644 tools/testing/selftests/filesystems/incfs/utils.h

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 971fc8428117..78fd8590cede 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -11,6 +11,7 @@ TARGETS += efivarfs
 TARGETS += exec
 TARGETS += filesystems
 TARGETS += filesystems/binderfs
+TARGETS += filesystems/incfs
 TARGETS += firmware
 TARGETS += ftrace
 TARGETS += futex
diff --git a/tools/testing/selftests/filesystems/incfs/.gitignore b/tools/testing/selftests/filesystems/incfs/.gitignore
new file mode 100644
index 000000000000..4cba9c219a92
--- /dev/null
+++ b/tools/testing/selftests/filesystems/incfs/.gitignore
@@ -0,0 +1 @@
+incfs_test
\ No newline at end of file
diff --git a/tools/testing/selftests/filesystems/incfs/Makefile b/tools/testing/selftests/filesystems/incfs/Makefile
new file mode 100644
index 000000000000..493efc23fa33
--- /dev/null
+++ b/tools/testing/selftests/filesystems/incfs/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -Wall
+CFLAGS += -I../../../../../usr/include/
+CFLAGS += -I../../../../include/uapi/
+CFLAGS += -I../../../../lib
+
+EXTRA_SOURCES := utils.c ../../../../lib/lz4.c
+TEST_GEN_PROGS := incfs_test
+
+include ../../lib.mk
+
+$(OUTPUT)/incfs_test: incfs_test.c $(EXTRA_SOURCES)
diff --git a/tools/testing/selftests/filesystems/incfs/config b/tools/testing/selftests/filesystems/incfs/config
new file mode 100644
index 000000000000..b6749837a318
--- /dev/null
+++ b/tools/testing/selftests/filesystems/incfs/config
@@ -0,0 +1 @@
+CONFIG_INCREMENTAL_FS=y
\ No newline at end of file
diff --git a/tools/testing/selftests/filesystems/incfs/incfs_test.c b/tools/testing/selftests/filesystems/incfs/incfs_test.c
new file mode 100644
index 000000000000..6c2797970f77
--- /dev/null
+++ b/tools/testing/selftests/filesystems/incfs/incfs_test.c
@@ -0,0 +1,1603 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 Google LLC
+ */
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <dirent.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/mount.h>
+#include <errno.h>
+#include <sys/wait.h>
+#include <alloca.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include "../../kselftest.h"
+
+#include "lz4.h"
+#include "utils.h"
+#define TEST_FAILURE 1
+#define TEST_SUCCESS 0
+
+struct test_file {
+	int ino;
+	char *name;
+	off_t size;
+};
+
+struct test_files_set {
+	struct test_file *files;
+	int files_count;
+};
+
+struct test_files_set get_test_files_set(void)
+{
+	static struct test_file files[] = {
+			{ .name = "file_one_byte", .size = 1 },
+			{ .name = "file_one_block",
+			.size = INCFS_DATA_FILE_BLOCK_SIZE },
+			{ .name = "file_one_and_a_half_blocks",
+			.size = INCFS_DATA_FILE_BLOCK_SIZE +
+				INCFS_DATA_FILE_BLOCK_SIZE / 2 },
+			{ .name = "file_three",
+			.size = 300 * INCFS_DATA_FILE_BLOCK_SIZE + 3 },
+			{ .name = "file_four",
+			.size = 400 * INCFS_DATA_FILE_BLOCK_SIZE + 7 },
+			{ .name = "file_five",
+			.size = 500 * INCFS_DATA_FILE_BLOCK_SIZE + 7 },
+			{ .name = "file_six",
+			.size = 600 * INCFS_DATA_FILE_BLOCK_SIZE + 7 },
+			{ .name = "file_seven",
+			.size = 700 * INCFS_DATA_FILE_BLOCK_SIZE + 7 },
+			{ .name = "file_eight",
+			.size = 800 * INCFS_DATA_FILE_BLOCK_SIZE + 7 },
+			{ .name = "file_nine",
+			.size = 900 * INCFS_DATA_FILE_BLOCK_SIZE + 7 },
+			{ .name = "file_big",
+			.size = 500 * 1024 * 1024 }
+		};
+	return (struct test_files_set){
+		.files = files,
+		.files_count = ARRAY_SIZE(files)
+	};
+}
+
+struct test_files_set get_small_test_files_set(void)
+{
+	static struct test_file files[] = {
+			{ .name = "file_one_byte", .size = 1 },
+			{ .name = "file_one_block",
+			.size = INCFS_DATA_FILE_BLOCK_SIZE },
+			{ .name = "file_one_and_a_half_blocks",
+			.size = INCFS_DATA_FILE_BLOCK_SIZE +
+				INCFS_DATA_FILE_BLOCK_SIZE / 2 },
+			{ .name = "file_three",
+			.size = 300 * INCFS_DATA_FILE_BLOCK_SIZE + 3 },
+			{ .name = "file_four",
+			.size = 400 * INCFS_DATA_FILE_BLOCK_SIZE + 7 }
+		};
+	return (struct test_files_set){
+		.files = files,
+		.files_count = ARRAY_SIZE(files)
+	};
+}
+
+static int get_file_block_seed(int file, int block)
+{
+	return 7919 * file + block;
+}
+
+static loff_t min(loff_t a, loff_t b)
+{
+	return a < b ? a : b;
+}
+
+static pid_t flush_and_fork(void)
+{
+	fflush(stdout);
+	return fork();
+}
+
+static void print_error(char *msg)
+{
+	ksft_print_msg("%s: %s\n", msg, strerror(errno));
+}
+
+static int wait_for_process(pid_t pid)
+{
+	int status;
+	int wait_res;
+
+	wait_res = waitpid(pid, &status, 0);
+	if (wait_res <= 0) {
+		print_error("Can't wait for the child");
+		return -EINVAL;
+	}
+	if (!WIFEXITED(status)) {
+		ksft_print_msg("Unexpected child status pid=%d\n", pid);
+		return -EINVAL;
+	}
+	status = WEXITSTATUS(status);
+	if (status != 0)
+		return status;
+	return 0;
+}
+
+static void rnd_buf(uint8_t *data, size_t len, unsigned int seed)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		seed = 1103515245 * seed + 12345;
+		data[i] = (uint8_t)(seed >> (i % 13));
+	}
+}
+
+struct file_and_block {
+	struct test_file *file;
+	int block_index;
+};
+
+static int emit_test_blocks(int fd, struct file_and_block *blocks, int count)
+{
+	uint8_t data[INCFS_DATA_FILE_BLOCK_SIZE];
+	uint8_t comp_data[2 * INCFS_DATA_FILE_BLOCK_SIZE];
+	int block_count = (count > 32) ? 32 : count;
+	int data_buf_size = 2 * INCFS_DATA_FILE_BLOCK_SIZE
+					* block_count;
+	uint8_t *data_buf = malloc(data_buf_size);
+	uint8_t *current_data = data_buf;
+	uint8_t *data_end = data_buf + data_buf_size;
+	struct incfs_new_data_block *block_buf =
+			calloc(block_count, sizeof(*block_buf));
+	ssize_t write_res = 0;
+	int error = 0;
+	int i = 0;
+	int blocks_written = 0;
+
+	for (i = 0; i < block_count; i++) {
+		int block_index = blocks[i].block_index;
+		struct test_file *file = blocks[i].file;
+		bool compress = (file->ino + block_index) % 2 == 0;
+		int seed = get_file_block_seed(file->ino, block_index);
+		off_t block_offset =
+			((off_t)block_index) * INCFS_DATA_FILE_BLOCK_SIZE;
+		size_t block_size = 0;
+
+		if (block_offset > file->size) {
+			error = -EINVAL;
+			break;
+		} else {
+			if (file->size - block_offset
+					> INCFS_DATA_FILE_BLOCK_SIZE)
+				block_size = INCFS_DATA_FILE_BLOCK_SIZE;
+			else
+				block_size = file->size - block_offset;
+		}
+
+		rnd_buf(data, block_size, seed);
+		if (compress) {
+			size_t comp_size = LZ4_compress_default((char *)data,
+				(char *)comp_data, block_size,
+				ARRAY_SIZE(comp_data));
+
+			if (comp_size <= 0) {
+				error = -EBADMSG;
+				break;
+			}
+			if (current_data + comp_size > data_end) {
+				error = -ENOMEM;
+				break;
+			}
+			memcpy(current_data, comp_data, comp_size);
+			block_size = comp_size;
+			block_buf[i].compression = COMPRESSION_LZ4;
+		} else {
+			if (current_data + block_size > data_end) {
+				error = -ENOMEM;
+				break;
+			}
+			memcpy(current_data, data, block_size);
+			block_buf[i].compression = COMPRESSION_NONE;
+		}
+
+		block_buf[i].file_ino = file->ino;
+		block_buf[i].block_index = block_index;
+		block_buf[i].data_len = block_size;
+		block_buf[i].data = ptr_to_u64(current_data);
+		block_buf[i].compression =
+			compress ? COMPRESSION_LZ4 : COMPRESSION_NONE;
+		current_data += block_size;
+	}
+
+	if (!error) {
+		write_res = write(fd, block_buf, sizeof(*block_buf) * i);
+		if (write_res < 0)
+			error = -errno;
+		else
+			blocks_written = write_res / sizeof(*block_buf);
+	}
+	if (error) {
+		ksft_print_msg("Writing data block error. Write returned: %d. Error:%s\n",
+				write_res, strerror(-error));
+	}
+	free(block_buf);
+	free(data_buf);
+	return (error < 0) ? error : blocks_written;
+}
+
+static int emit_test_block(int fd, struct test_file *file, int block_index)
+{
+	struct file_and_block blk = {
+		.file = file,
+		.block_index = block_index
+	};
+	int res = 0;
+
+	res = emit_test_blocks(fd, &blk, 1);
+	if (res == 0)
+		return -EINVAL;
+	if (res == 1)
+		return 0;
+	return res;
+}
+
+static void shuffle(int array[], int count, unsigned int seed)
+{
+	int i;
+
+	for (i = 0; i < count - 1; i++) {
+		int items_left = count - i;
+		int shuffle_index;
+		int v;
+
+		seed = 1103515245 * seed + 12345;
+		shuffle_index = i + seed % items_left;
+
+		v = array[shuffle_index];
+		array[shuffle_index] = array[i];
+		array[i] = v;
+	}
+}
+
+static int emit_test_file_data(int fd, struct test_file *file)
+{
+	int i;
+	int block_cnt = 1 + (file->size - 1) / INCFS_DATA_FILE_BLOCK_SIZE;
+	int *block_indexes = NULL;
+	struct file_and_block *blocks = NULL;
+	int result = 0;
+	int blocks_written = 0;
+
+	if (file->size == 0)
+		return 0;
+
+	blocks = calloc(block_cnt, sizeof(*blocks));
+	block_indexes = calloc(block_cnt, sizeof(*block_indexes));
+	for (i = 0; i < block_cnt; i++)
+		block_indexes[i] = i;
+
+	shuffle(block_indexes, block_cnt, file->ino);
+	for (i = 0; i < block_cnt; i++) {
+		blocks[i].block_index = block_indexes[i];
+		blocks[i].file = file;
+	}
+
+	for (i = 0; i < block_cnt; i += blocks_written) {
+		blocks_written = emit_test_blocks(fd,
+				blocks + i,
+				block_cnt - i);
+		if (blocks_written < 0) {
+			result = blocks_written;
+			goto out;
+		}
+		if (blocks_written == 0) {
+			result = -EIO;
+			goto out;
+		}
+	}
+out:
+	free(blocks);
+	free(block_indexes);
+	return result;
+}
+
+static loff_t read_whole_file(char *filename)
+{
+	int fd = -1;
+	loff_t result;
+	loff_t bytes_read = 0;
+	uint8_t buff[16 * 1024];
+
+	fd = open(filename, O_RDONLY);
+	if (fd <= 0)
+		return fd;
+
+	while (1) {
+		int read_result = read(fd, buff, ARRAY_SIZE(buff));
+
+		if (read_result < 0) {
+			print_error("Error during reading from a file.");
+			result = -errno;
+			goto cleanup;
+		} else if (read_result == 0)
+			break;
+
+		bytes_read += read_result;
+	}
+	result = bytes_read;
+
+cleanup:
+	close(fd);
+	return result;
+}
+
+
+static int read_test_file(uint8_t *buf, size_t len,
+			char *filename, int block_idx)
+{
+	int fd = -1;
+	int result;
+	int bytes_read = 0;
+	size_t bytes_to_read = len;
+	off_t offset = ((off_t)block_idx) * INCFS_DATA_FILE_BLOCK_SIZE;
+
+	fd = open(filename, O_RDONLY);
+	if (fd <= 0)
+		return fd;
+
+	if (lseek(fd, offset, SEEK_SET) != offset) {
+		print_error("Seek error");
+		return -errno;
+	}
+
+	while (bytes_read < bytes_to_read) {
+		int read_result =
+			read(fd, buf + bytes_read, bytes_to_read - bytes_read);
+		if (read_result < 0) {
+			result = -errno;
+			goto cleanup;
+		} else if (read_result == 0)
+			break;
+
+		bytes_read += read_result;
+	}
+	result = bytes_read;
+
+cleanup:
+	close(fd);
+	return result;
+}
+
+static int open_test_backing_file(char *mount_dir, bool delete)
+{
+	char backing_file_name[255];
+	int backing_fd;
+
+	snprintf(backing_file_name, ARRAY_SIZE(backing_file_name), "%s.img",
+		 mount_dir);
+	backing_fd = open(backing_file_name, O_CREAT | O_RDWR | O_TRUNC, 0666);
+	if (backing_fd < 0)
+		print_error("Can't open backing file");
+	else if (delete) {
+		/* Once backing file was opened, it's safe to delete it ;) */
+		remove(backing_file_name);
+	}
+	return backing_fd;
+}
+
+static int open_existing_test_backing_file(char *mount_dir, bool delete)
+{
+	char backing_file_name[255];
+	int backing_fd;
+
+	snprintf(backing_file_name, ARRAY_SIZE(backing_file_name), "%s.img",
+		 mount_dir);
+	backing_fd = open(backing_file_name, O_RDWR);
+	if (backing_fd < 0)
+		print_error("Can't open backing file");
+	else if (delete) {
+		/* Once backing file was opened, it's safe to delete it ;) */
+		remove(backing_file_name);
+	}
+	return backing_fd;
+}
+
+static int validate_test_file_content_with_seed(char *mount_dir,
+					 struct test_file *file,
+					 unsigned int shuffle_seed)
+{
+	int error = -1;
+	char *filename = concat_file_name(mount_dir, file->name);
+	off_t size = file->size;
+	loff_t actual_size = get_file_size(filename);
+	int block_cnt = 1 + (size - 1) / INCFS_DATA_FILE_BLOCK_SIZE;
+	int *block_indexes = NULL;
+	int i;
+
+	block_indexes = alloca(sizeof(int) * block_cnt);
+	for (i = 0; i < block_cnt; i++)
+		block_indexes[i] = i;
+
+	if (shuffle_seed != 0)
+		shuffle(block_indexes, block_cnt, shuffle_seed);
+
+	if (actual_size != size) {
+		ksft_print_msg("File size doesn't match. name: %s expected size:%ld actual size:%ld\n",
+		       filename, size, actual_size);
+		error = -1;
+		goto failure;
+	}
+
+	for (i = 0; i < block_cnt; i++) {
+		int block_idx = block_indexes[i];
+		uint8_t expected_block[INCFS_DATA_FILE_BLOCK_SIZE];
+		uint8_t actual_block[INCFS_DATA_FILE_BLOCK_SIZE];
+		int seed = get_file_block_seed(file->ino, block_idx);
+		size_t bytes_to_compare =
+			min((off_t)INCFS_DATA_FILE_BLOCK_SIZE,
+			size - ((off_t)block_idx) * INCFS_DATA_FILE_BLOCK_SIZE);
+		int read_result =
+			read_test_file(actual_block, INCFS_DATA_FILE_BLOCK_SIZE,
+				       filename, block_idx);
+		if (read_result < 0) {
+			ksft_print_msg("Error reading block %d from file %s. Error: %s\n",
+			       block_idx, filename, strerror(-read_result));
+			error = read_result;
+			goto failure;
+		}
+		rnd_buf(expected_block, INCFS_DATA_FILE_BLOCK_SIZE, seed);
+		if (memcmp(expected_block, actual_block, bytes_to_compare)) {
+			ksft_print_msg("File contents don't match. name: %s block:%d\n",
+			       file->name, block_idx);
+			error = -2;
+			goto failure;
+		}
+	}
+	free(filename);
+	return 0;
+
+failure:
+	free(filename);
+	return error;
+}
+
+static int validate_test_file_content(char *mount_dir, struct test_file *file)
+{
+	return validate_test_file_content_with_seed(mount_dir, file, 0);
+}
+
+static int dynamic_files_and_data_test(char *mount_dir)
+{
+	struct test_files_set test = get_test_files_set();
+	const int file_num = test.files_count;
+	const int missing_file_idx = 5;
+	int backing_fd = -1, cmd_fd = -1;
+	int i;
+
+	backing_fd = open_test_backing_file(mount_dir, true);
+	if (backing_fd < 0)
+		goto failure;
+
+	/* Mount FS and release the backing file. */
+	if (mount_fs(mount_dir, backing_fd, 50) != 0)
+		goto failure;
+	close(backing_fd);
+
+	cmd_fd = open_commands_file(mount_dir);
+	if (cmd_fd < 0)
+		goto failure;
+
+	/* Check that test files don't exist in the filesystem. */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+		char *filename = concat_file_name(mount_dir, file->name);
+
+		if (access(filename, F_OK) != -1) {
+			ksft_print_msg("File %s somehow already exists in a clean FS.\n",
+			       filename);
+			goto failure;
+		}
+		free(filename);
+	}
+
+	/* Write test data into the command file. */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+		int res;
+
+		res = emit_file(cmd_fd, file->name,
+			&file->ino, INCFS_ROOT_INODE, file->size);
+		if (res < 0) {
+			ksft_print_msg("Error %s emiting file %s.\n",
+					strerror(-res), file->name);
+			goto failure;
+		}
+
+		/* Skip writing data to one file so we can check */
+		/* that it's missing later. */
+		if (i == missing_file_idx)
+			continue;
+
+		res = emit_test_file_data(cmd_fd, file);
+		if (res) {
+			ksft_print_msg("Error %s emiting data for %s.\n",
+					strerror(-res), file->name);
+			goto failure;
+		}
+	}
+
+	/* Validate contents of the FS */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+
+		if (i == missing_file_idx) {
+			/* No data has been written to this file. */
+			/* Check for read error; */
+			uint8_t buf;
+			char *filename =
+				concat_file_name(mount_dir, file->name);
+			int res = read_test_file(&buf, 1, filename, 0);
+
+			free(filename);
+			if (res > 0) {
+				ksft_print_msg("Data present, even though never writtern.\n");
+				goto failure;
+			}
+			if (res != -ETIME) {
+				ksft_print_msg("Wrong error code: %d.\n", res);
+				goto failure;
+			}
+		} else {
+			if (validate_test_file_content(mount_dir, file) < 0)
+				goto failure;
+		}
+	}
+
+	close(cmd_fd);
+	cmd_fd = -1;
+	if (umount(mount_dir) != 0) {
+		print_error("Can't unmout FS");
+		goto failure;
+	}
+
+	return TEST_SUCCESS;
+
+failure:
+	close(cmd_fd);
+	umount(mount_dir);
+	return TEST_FAILURE;
+}
+
+static int errors_on_overwrite_test(char *mount_dir)
+{
+	struct test_files_set test = get_small_test_files_set();
+	const int file_num = test.files_count;
+	int backing_fd = -1, cmd_fd = -1;
+	int i, bidx;
+
+	backing_fd = open_test_backing_file(mount_dir, true);
+	if (backing_fd < 0)
+		goto failure;
+
+	/* Mount FS and release the backing file. */
+	if (mount_fs(mount_dir, backing_fd, 50) != 0)
+		goto failure;
+	close(backing_fd);
+
+	cmd_fd = open_commands_file(mount_dir);
+	if (cmd_fd < 0)
+		goto failure;
+
+	/* Write test data into the command file. */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+		int emit_res;
+
+		emit_res = emit_file(cmd_fd, file->name, &file->ino,
+				     INCFS_ROOT_INODE, file->size);
+		if (emit_res < 0)
+			goto failure;
+
+		emit_res = emit_test_file_data(cmd_fd, file);
+		if (emit_res)
+			goto failure;
+	}
+
+	/* Write again, this time all writes should fail. */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+		int emit_res;
+
+		emit_res = emit_file(cmd_fd, file->name, &file->ino,
+				     INCFS_ROOT_INODE, file->size);
+		if (emit_res != -EEXIST) {
+			ksft_print_msg("Repeated file %s wasn't reported.\n",
+			       file->name);
+			goto failure;
+		}
+
+		for (bidx = 0; bidx * INCFS_DATA_FILE_BLOCK_SIZE < file->size;
+		     bidx++) {
+			emit_res = emit_test_block(cmd_fd, file, bidx);
+
+			/* Repeated blocks are ignored without an error */
+			if (emit_res < 0) {
+				ksft_print_msg("Repeated block was reported. err:%s\n",
+				       strerror(-emit_res));
+				goto failure;
+			}
+		}
+	}
+
+	/* Validate contents of the FS */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+
+		if (validate_test_file_content(mount_dir, file) < 0)
+			goto failure;
+	}
+
+	close(cmd_fd);
+	cmd_fd = -1;
+	if (umount(mount_dir) != 0) {
+		print_error("Can't unmout FS");
+		goto failure;
+	}
+
+	return TEST_SUCCESS;
+
+failure:
+	close(cmd_fd);
+	umount(mount_dir);
+	return TEST_FAILURE;
+}
+
+static int work_after_remount_test(char *mount_dir)
+{
+	struct test_files_set test = get_test_files_set();
+	const int file_num = test.files_count;
+	const int file_num_stage1 = file_num / 2;
+	const int file_num_stage2 = file_num;
+	int i = 0;
+	int backing_fd = -1, cmd_fd = -1;
+
+	backing_fd = open_test_backing_file(mount_dir, false);
+	if (backing_fd < 0)
+		goto failure;
+
+	/* Mount FS and release the backing file. */
+	if (mount_fs(mount_dir, backing_fd, 50) != 0)
+		goto failure;
+	close(backing_fd);
+	backing_fd = -1;
+
+	cmd_fd = open_commands_file(mount_dir);
+	if (cmd_fd < 0)
+		goto failure;
+
+	/* Write first half of the data into the command file. (stage 1) */
+	for (i = 0; i < file_num_stage1; i++) {
+		struct test_file *file = &test.files[i];
+
+		emit_file(cmd_fd, file->name, &file->ino, INCFS_ROOT_INODE,
+			  file->size);
+		if (emit_test_file_data(cmd_fd, file))
+			goto failure;
+	}
+
+	/* Unmount and mount again, to see that data is persistent. */
+	close(cmd_fd);
+	cmd_fd = -1;
+	if (umount(mount_dir) != 0) {
+		print_error("Can't unmout FS");
+		goto failure;
+	}
+	backing_fd = open_existing_test_backing_file(mount_dir, false);
+	if (backing_fd < 0)
+		goto failure;
+	if (mount_fs(mount_dir, backing_fd, 50) != 0)
+		goto failure;
+	close(backing_fd);
+	backing_fd = -1;
+
+	cmd_fd = open_commands_file(mount_dir);
+	if (cmd_fd < 0)
+		goto failure;
+
+	/* Write the second half of the data into the command file. (stage 2) */
+	for (; i < file_num_stage2; i++) {
+		struct test_file *file = &test.files[i];
+
+		emit_file(cmd_fd, file->name, &file->ino, INCFS_ROOT_INODE,
+			  file->size);
+		if (emit_test_file_data(cmd_fd, file))
+			goto failure;
+	}
+
+	/* Validate contents of the FS */
+	for (i = 0; i < file_num_stage2; i++) {
+		struct test_file *file = &test.files[i];
+
+		if (validate_test_file_content(mount_dir, file) < 0)
+			goto failure;
+	}
+
+	/* Hide all files */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+		char *filename = concat_file_name(mount_dir, file->name);
+
+		if (access(filename, F_OK) != 0) {
+			ksft_print_msg("File %s is not visible.\n", filename);
+			goto failure;
+		}
+
+		unlink_node(cmd_fd, INCFS_ROOT_INODE, file->name);
+
+		if (access(filename, F_OK) != -1) {
+			ksft_print_msg("File %s is still visible.\n", filename);
+			goto failure;
+		}
+		free(filename);
+	}
+
+	/* Unmount and mount again, to see that unlinked files stay unlinked. */
+	close(cmd_fd);
+	cmd_fd = -1;
+	if (umount(mount_dir) != 0) {
+		print_error("Can't unmout FS");
+		goto failure;
+	}
+	backing_fd = open_existing_test_backing_file(mount_dir, true);
+	if (backing_fd < 0)
+		goto failure;
+	if (mount_fs(mount_dir, backing_fd, 50) != 0)
+		goto failure;
+	close(backing_fd);
+	backing_fd = -1;
+
+	cmd_fd = open_commands_file(mount_dir);
+	if (cmd_fd < 0)
+		goto failure;
+
+	/* Validate all hidden files are still hidden. */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+		char *filename = concat_file_name(mount_dir, file->name);
+
+		if (access(filename, F_OK) != -1) {
+			ksft_print_msg("File %s is still visible.\n", filename);
+			goto failure;
+		}
+		free(filename);
+	}
+
+	/* Final unmount */
+	close(cmd_fd);
+	cmd_fd = -1;
+	if (umount(mount_dir) != 0) {
+		print_error("Can't unmout FS");
+		goto failure;
+	}
+
+	return TEST_SUCCESS;
+
+failure:
+	close(cmd_fd);
+	close(backing_fd);
+	umount(mount_dir);
+	return TEST_FAILURE;
+}
+
+static int validate_dir(char *dir_path, struct dirent *entries, int count)
+{
+	DIR *dir;
+	struct dirent *dp;
+	int result = 0;
+	int matching_entries = 0;
+
+	dir = opendir(dir_path);
+	if (!dir) {
+		result = -errno;
+		goto out;
+	}
+
+	while ((dp = readdir(dir))) {
+		int i;
+
+		if (!strcmp(dp->d_name, ".") || !strcmp(dp->d_name, ".."))
+			continue;
+
+		for (i = 0; i < count; i++) {
+			struct dirent *entry = entries + i;
+
+			if ((dp->d_ino == entry->d_ino) &&
+			    (strcmp(dp->d_name, entry->d_name) == 0) &&
+			    (dp->d_type == entry->d_type)) {
+				matching_entries++;
+				break;
+			}
+		}
+	}
+	result = count - matching_entries;
+
+out:
+	if (dir)
+		closedir(dir);
+	return result;
+}
+
+/* Test for:
+ *  1. No more than one hardlink can be created for a dir.
+ *  2. Only an empty dir can be unlinked.
+ */
+static int dirs_corner_cases(char *mount_dir)
+{
+	int dir1_ino = 0;
+	int dir2_ino = 0;
+	int backing_fd = -1, cmd_fd = -1;
+	char dirname1[] = "dir1";
+	char *dir_path1 = concat_file_name(mount_dir, dirname1);
+	char dirname2[] = "dir2";
+	char *dir_path2 = concat_file_name(dir_path1, dirname2);
+	struct stat st = {};
+	int ret;
+	struct incfs_instruction inst = {};
+
+	backing_fd = open_test_backing_file(mount_dir, true);
+	if (backing_fd < 0)
+		goto failure;
+
+	/* Mount FS and release the backing file. */
+	if (mount_fs(mount_dir, backing_fd, 50) != 0)
+		goto failure;
+	close(backing_fd);
+	backing_fd = -1;
+
+	cmd_fd = open_commands_file(mount_dir);
+	if (cmd_fd < 0)
+		goto failure;
+
+	/* Create dir1 node. */
+	inst = (struct incfs_instruction) {
+			.type = INCFS_INSTRUCTION_NEW_FILE,
+			.file = {
+				.size = 0,
+				.mode = S_IFDIR | 0555,
+			}
+	};
+	ret = send_md_instruction(cmd_fd, &inst);
+	dir1_ino = inst.file.ino_out;
+	if (ret)
+		goto failure;
+
+	/* Create dir2 node. */
+	inst = (struct incfs_instruction) {
+			.type = INCFS_INSTRUCTION_NEW_FILE,
+			.file = {
+				.size = 0,
+				.mode = S_IFDIR | 0555,
+			}
+	};
+	ret = send_md_instruction(cmd_fd, &inst);
+	dir2_ino = inst.file.ino_out;
+	if (ret)
+		goto failure;
+
+	/* Try to put dir1 into itself. */
+	inst = (struct incfs_instruction){
+			.type = INCFS_INSTRUCTION_ADD_DIR_ENTRY,
+			.dir_entry = {
+				.dir_ino = dir1_ino,
+				.child_ino = dir1_ino,
+				.name = ptr_to_u64(dirname1),
+				.name_len = strlen(dirname1)
+			}
+	};
+	ret = send_md_instruction(cmd_fd, &inst);
+	if (ret != -EINVAL)
+		goto failure;
+
+	/* Try to put root into dir1. */
+	inst = (struct incfs_instruction){
+			.type = INCFS_INSTRUCTION_ADD_DIR_ENTRY,
+			.dir_entry = {
+				.dir_ino = dir1_ino,
+				.child_ino = INCFS_ROOT_INODE,
+				.name = ptr_to_u64(dirname1),
+				.name_len = strlen(dirname1)
+			}
+	};
+	ret = send_md_instruction(cmd_fd, &inst);
+	if (ret != -EINVAL)
+		goto failure;
+
+	/* Put dir1 into root. */
+	inst = (struct incfs_instruction){
+			.type = INCFS_INSTRUCTION_ADD_DIR_ENTRY,
+			.dir_entry = {
+				.dir_ino = INCFS_ROOT_INODE,
+				.child_ino = dir1_ino,
+				.name = ptr_to_u64(dirname1),
+				.name_len = strlen(dirname1)
+			}
+	};
+	ret = send_md_instruction(cmd_fd, &inst);
+	if (ret)
+		goto failure;
+
+	/* Check dir1 is visible. */
+	if (stat(dir_path1, &st) != 0 || st.st_ino != dir1_ino) {
+		print_error("stat failed for dir1");
+		goto failure;
+	}
+
+	/* Put dir2 into dir1. */
+	inst = (struct incfs_instruction){
+			.type = INCFS_INSTRUCTION_ADD_DIR_ENTRY,
+			.dir_entry = {
+				.dir_ino = dir1_ino,
+				.child_ino = dir2_ino,
+				.name = ptr_to_u64(dirname2),
+				.name_len = strlen(dirname2)
+			}
+	};
+	ret = send_md_instruction(cmd_fd, &inst);
+	if (ret)
+		goto failure;
+
+	/* Check dir2 is visible. */
+	if (stat(dir_path2, &st) != 0 || st.st_ino != dir2_ino) {
+		print_error("stat failed for dir2");
+		goto failure;
+	}
+
+	/* Try to create a loop. Put dir2 into dir1. */
+	inst = (struct incfs_instruction){
+			.type = INCFS_INSTRUCTION_ADD_DIR_ENTRY,
+			.dir_entry = {
+				.dir_ino = dir2_ino,
+				.child_ino = dir1_ino,
+				.name = ptr_to_u64(dirname1),
+				.name_len = strlen(dirname1)
+			}
+	};
+	ret = send_md_instruction(cmd_fd, &inst);
+	if (ret != -EMLINK) {
+		ksft_print_msg("Loop creation test filed. %s\n",
+					strerror(-ret));
+		goto failure;
+	}
+
+	/* Try to unlink dir1 without removing dir2 first. */
+	ret = unlink_node(cmd_fd, INCFS_ROOT_INODE, dirname1);
+	if (ret != -ENOTEMPTY) {
+		ksft_print_msg("Unlinked non empty dir: %s\n", strerror(-ret));
+		goto failure;
+	}
+
+	ret = unlink_node(cmd_fd, dir1_ino, dirname2);
+	if (ret)
+		goto failure;
+
+	ret = unlink_node(cmd_fd, INCFS_ROOT_INODE, dirname1);
+	if (ret)
+		goto failure;
+
+	close(cmd_fd);
+	cmd_fd = -1;
+	if (umount(mount_dir) != 0) {
+		print_error("Can't unmout FS");
+		goto failure;
+	}
+	free(dir_path1);
+	free(dir_path2);
+
+	return TEST_SUCCESS;
+
+failure:
+	close(cmd_fd);
+	close(backing_fd);
+	umount(mount_dir);
+	return TEST_FAILURE;
+}
+
+static int directory_structure_test(char *mount_dir)
+{
+	int dir_ino = 0;
+	int file_ino = 0;
+	int backing_fd = -1, cmd_fd = -1;
+	int mismatch_count = 0;
+	char dirname[] = "dir";
+	char filename[] = "file";
+	char *dir_path = concat_file_name(mount_dir, dirname);
+	char *file_path = concat_file_name(dir_path, filename);
+	struct stat st;
+	int ret;
+
+	backing_fd = open_test_backing_file(mount_dir, true);
+	if (backing_fd < 0)
+		goto failure;
+
+	/* Mount FS and release the backing file. */
+	if (mount_fs(mount_dir, backing_fd, 50) != 0)
+		goto failure;
+	close(backing_fd);
+	backing_fd = -1;
+
+	cmd_fd = open_commands_file(mount_dir);
+	if (cmd_fd < 0)
+		goto failure;
+
+	/* Write test data into the command file. */
+	ret = emit_dir(cmd_fd, dirname, &dir_ino, INCFS_ROOT_INODE);
+	if (ret < 0) {
+		ksft_print_msg("Error creating a dir: %s\n", strerror(-ret));
+		goto failure;
+	}
+	ret = emit_file(cmd_fd, filename, &file_ino, dir_ino, 0);
+	if (ret < 0) {
+		ksft_print_msg("Error creating a file: %s\n", strerror(-ret));
+		goto failure;
+	}
+
+	/* Validate directory structure */
+	{
+		struct dirent dir_dentry = { .d_ino = dir_ino,
+					     .d_type = DT_DIR,
+					     .d_name = "dir" };
+		struct dirent cmd_dentry = { .d_ino = INCFS_COMMAND_INODE,
+					     .d_type = DT_REG,
+					     .d_name = ".cmd" };
+		struct dirent file_dentry = { .d_ino = file_ino,
+					      .d_type = DT_REG,
+					      .d_name = "file" };
+		struct dirent root_entries[] = { cmd_dentry, dir_dentry };
+		struct dirent dir_entries[] = { file_dentry };
+
+		mismatch_count = validate_dir(mount_dir, root_entries,
+					      ARRAY_SIZE(root_entries));
+		if (mismatch_count) {
+			ksft_print_msg("Root validatoin failed. Mismatch %d",
+			       mismatch_count);
+			goto failure;
+		}
+
+		mismatch_count = validate_dir(dir_path, dir_entries,
+					      ARRAY_SIZE(dir_entries));
+		if (mismatch_count) {
+			ksft_print_msg("Subdir validatoin failed. Mismatch %d",
+			       mismatch_count);
+			goto failure;
+		}
+	}
+
+	/* Validate file inode */
+	if (stat(file_path, &st) != 0) {
+		print_error("stat failed");
+		goto failure;
+	}
+
+	if (st.st_ino != file_ino) {
+		ksft_print_msg("Unexpected file inode.");
+		goto failure;
+	}
+
+	if (st.st_size != 0) {
+		ksft_print_msg("Unexpected file size.");
+		goto failure;
+	}
+
+	ret = unlink_node(cmd_fd, dir_ino, filename);
+	if (ret < 0) {
+		ksft_print_msg("Error unlinking a file: %s\n", strerror(-ret));
+		goto failure;
+	}
+
+	/* Validate directory structure */
+	{
+		struct dirent dir_entries[0] = {};
+
+		mismatch_count = validate_dir(dir_path, dir_entries, 0);
+		if (mismatch_count) {
+			ksft_print_msg("Second subdir validatoin failed. Mismatch %d",
+			       mismatch_count);
+			goto failure;
+		}
+
+		if (access(file_path, F_OK) != -1) {
+			ksft_print_msg("Unlinked file is still visible");
+			goto failure;
+		}
+	}
+
+	close(cmd_fd);
+	cmd_fd = -1;
+	if (umount(mount_dir) != 0) {
+		print_error("Can't unmout FS");
+		goto failure;
+	}
+	free(file_path);
+	free(dir_path);
+
+	return TEST_SUCCESS;
+
+failure:
+	close(cmd_fd);
+	close(backing_fd);
+	umount(mount_dir);
+	return TEST_FAILURE;
+}
+
+static int data_producer(int fd, struct test_files_set *test_set)
+{
+	int ret = 0;
+	int timeout_ms = 1000;
+	struct incfs_pending_read_info prs[100] = {};
+	int prs_size = ARRAY_SIZE(prs);
+
+	while ((ret = wait_for_pending_reads(fd, timeout_ms,
+						prs, prs_size)) > 0) {
+		struct file_and_block blocks[ARRAY_SIZE(prs)] = {};
+		int read_count = ret;
+		int i;
+
+		for (i = 0; i < read_count; i++) {
+			int j = 0;
+
+			for (j = 0; j < test_set->files_count; j++) {
+				if (test_set->files[j].ino == prs[i].file_ino)
+					blocks[i].file = &test_set->files[j];
+			}
+			blocks[i].block_index = prs[i].block_index;
+		}
+
+		ret = emit_test_blocks(fd, blocks, read_count);
+		if (ret < 0) {
+			ksft_print_msg("Emitting test data error: %s\n",
+				strerror(-ret));
+			return ret;
+		}
+	}
+	return ret;
+}
+
+
+static int multiple_providers_test(char *mount_dir)
+{
+	struct test_files_set test = get_test_files_set();
+	const int file_num = test.files_count;
+	const int producer_count = 5;
+	int backing_fd = -1, cmd_fd = -1;
+	int status;
+	int i;
+	pid_t *producer_pids = alloca(producer_count * sizeof(pid_t));
+
+	backing_fd = open_test_backing_file(mount_dir, true);
+	if (backing_fd < 0)
+		goto failure;
+
+	/* Mount FS and release the backing file. */
+	if (mount_fs(mount_dir, backing_fd, 10000) != 0)
+		goto failure;
+	close(backing_fd);
+
+	cmd_fd = open_commands_file(mount_dir);
+	if (cmd_fd < 0)
+		goto failure;
+
+	/* Tell FS about the files, without actually providing the data. */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+
+		if (emit_file(cmd_fd, file->name, &file->ino, INCFS_ROOT_INODE,
+			      file->size) < 0)
+			goto failure;
+	}
+
+	/* Start producer processes */
+	for (i = 0; i < producer_count; i++) {
+		pid_t producer_pid = flush_and_fork();
+
+		if (producer_pid == 0) {
+			int ret;
+			/*
+			 * This is a child that should provide data to
+			 * pending reads.
+			 */
+
+			ret = data_producer(cmd_fd, &test);
+			exit(-ret);
+		} else if (producer_pid > 0) {
+			producer_pids[i] = producer_pid;
+		} else {
+			print_error("Fork error");
+			goto failure;
+		}
+	}
+
+	/* Validate FS content */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+		char *filename = concat_file_name(mount_dir, file->name);
+		loff_t read_result = read_whole_file(filename);
+
+		free(filename);
+		if (read_result != file->size) {
+			ksft_print_msg("Error validating file %s. Result: %ld\n",
+				file->name, read_result);
+			goto failure;
+		}
+	}
+
+	/* Check that all producers has finished with 0 exit status */
+	for (i = 0; i < producer_count; i++) {
+		status = wait_for_process(producer_pids[i]);
+		if (status != 0) {
+			ksft_print_msg("Producer %d failed with code (%s)\n",
+			       i, strerror(status));
+			goto failure;
+		}
+	}
+
+	close(cmd_fd);
+	cmd_fd = -1;
+	if (umount(mount_dir) != 0) {
+		print_error("Can't unmout FS");
+		goto failure;
+	}
+
+	return TEST_SUCCESS;
+
+failure:
+	close(cmd_fd);
+	umount(mount_dir);
+	return TEST_FAILURE;
+}
+
+static int concurrent_reads_and_writes_test(char *mount_dir)
+{
+	struct test_files_set test = get_test_files_set();
+	const int file_num = test.files_count;
+	/* Validate each file from that many child processes. */
+	const int child_multiplier = 3;
+	int backing_fd = -1, cmd_fd = -1;
+	int status;
+	int i;
+	pid_t producer_pid;
+	pid_t *child_pids = alloca(child_multiplier * file_num * sizeof(pid_t));
+
+	backing_fd = open_test_backing_file(mount_dir, true);
+	if (backing_fd < 0)
+		goto failure;
+
+	/* Mount FS and release the backing file. */
+	if (mount_fs(mount_dir, backing_fd, 10000) != 0)
+		goto failure;
+	close(backing_fd);
+
+	cmd_fd = open_commands_file(mount_dir);
+	if (cmd_fd < 0)
+		goto failure;
+
+	/* Tell FS about the files, without actually providing the data. */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+
+		if (emit_file(cmd_fd, file->name, &file->ino, INCFS_ROOT_INODE,
+			      file->size) < 0)
+			goto failure;
+	}
+
+	/* Start child processes acessing data in the files */
+	for (i = 0; i < file_num * child_multiplier; i++) {
+		struct test_file *file = &test.files[i / child_multiplier];
+		pid_t child_pid = flush_and_fork();
+
+		if (child_pid == 0) {
+			/* This is a child process, do the data validation. */
+			int ret = validate_test_file_content_with_seed(
+				mount_dir, file, i);
+			if (ret >= 0) {
+				/* Zero exit status if data is valid. */
+				exit(0);
+			}
+
+			/* Positive status if validation error found. */
+			exit(-ret);
+		} else if (child_pid > 0) {
+			child_pids[i] = child_pid;
+		} else {
+			print_error("Fork error");
+			goto failure;
+		}
+	}
+
+	producer_pid = flush_and_fork();
+	if (producer_pid == 0) {
+		int ret;
+		/*
+		 * This is a child that should provide data to
+		 * pending reads.
+		 */
+
+		ret = data_producer(cmd_fd, &test);
+		exit(-ret);
+	} else {
+		status = wait_for_process(producer_pid);
+		if (status != 0) {
+			ksft_print_msg("Data produces failed. %d(%s) ", status,
+			       strerror(status));
+			goto failure;
+		}
+	}
+
+	/* Check that all children has finished with 0 exit status */
+	for (i = 0; i < file_num * child_multiplier; i++) {
+		struct test_file *file = &test.files[i / child_multiplier];
+
+		status = wait_for_process(child_pids[i]);
+		if (status != 0) {
+			ksft_print_msg("Validation for the file %s failed with code %d (%s)\n",
+			       file->name, status, strerror(status));
+			goto failure;
+		}
+	}
+
+	/* Check that there are no pending reads left */
+	{
+		struct incfs_pending_read_info prs[1] = {};
+		int timeout = 0;
+		int read_count = wait_for_pending_reads(cmd_fd, timeout, prs,
+							ARRAY_SIZE(prs));
+
+		if (read_count) {
+			ksft_print_msg("Pending reads pending when all data written\n");
+			goto failure;
+		}
+	}
+
+	close(cmd_fd);
+	cmd_fd = -1;
+	if (umount(mount_dir) != 0) {
+		print_error("Can't unmout FS");
+		goto failure;
+	}
+
+	return TEST_SUCCESS;
+
+failure:
+	close(cmd_fd);
+	umount(mount_dir);
+	return TEST_FAILURE;
+}
+
+static int child_procs_waiting_for_data_test(char *mount_dir)
+{
+	struct test_files_set test = get_test_files_set();
+	const int file_num = test.files_count;
+	int backing_fd = -1, cmd_fd = -1;
+	int i;
+	pid_t *child_pids = alloca(file_num * sizeof(pid_t));
+
+	backing_fd = open_test_backing_file(mount_dir, true);
+	if (backing_fd < 0)
+		goto failure;
+
+	/* Mount FS and release the backing file. (10s wait time) */
+	if (mount_fs(mount_dir, backing_fd, 10000) != 0)
+		goto failure;
+	close(backing_fd);
+
+	cmd_fd = open_commands_file(mount_dir);
+	if (cmd_fd < 0)
+		goto failure;
+
+	/* Tell FS about the files, without actually providing the data. */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+
+		emit_file(cmd_fd, file->name, &file->ino, INCFS_ROOT_INODE,
+			  file->size);
+	}
+
+	/* Start child processes acessing data in the files */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+		pid_t child_pid = flush_and_fork();
+
+		if (child_pid == 0) {
+			/* This is a child process, do the data validation. */
+			int ret = validate_test_file_content(mount_dir, file);
+
+			if (ret >= 0) {
+				/* Zero exit status if data is valid. */
+				exit(0);
+			}
+
+			/* Positive status if validation error found. */
+			exit(-ret);
+		} else if (child_pid > 0) {
+			child_pids[i] = child_pid;
+		} else {
+			print_error("Fork error");
+			goto failure;
+		}
+	}
+
+	/* Write test data into the command file. */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+
+		if (emit_test_file_data(cmd_fd, file))
+			goto failure;
+	}
+
+	/* Check that all children has finished with 0 exit status */
+	for (i = 0; i < file_num; i++) {
+		struct test_file *file = &test.files[i];
+		int status = wait_for_process(child_pids[i]);
+
+		if (status != 0) {
+			ksft_print_msg("Validation for the file %s failed with code %d (%s)\n",
+			       file->name, status, strerror(status));
+			goto failure;
+		}
+	}
+
+	close(cmd_fd);
+	cmd_fd = -1;
+	if (umount(mount_dir) != 0) {
+		print_error("Can't unmout FS");
+		goto failure;
+	}
+
+	return TEST_SUCCESS;
+
+failure:
+	close(cmd_fd);
+	umount(mount_dir);
+	return TEST_FAILURE;
+}
+
+static int file_count_limit(char *mount_dir)
+{
+	int file_ino = 0;
+	int i;
+	int backing_fd = -1, cmd_fd = -1;
+	char filename[100];
+	char file_path[100];
+	int ret;
+
+	backing_fd = open_test_backing_file(mount_dir, true);
+	if (backing_fd < 0)
+		goto failure;
+
+	if (mount_fs(mount_dir, backing_fd, 50) != 0)
+		goto failure;
+	close(backing_fd);
+	backing_fd = -1;
+
+	cmd_fd = open_commands_file(mount_dir);
+	if (cmd_fd < 0)
+		goto failure;
+
+	/*
+	 * Create INCFS_MAX_FILES - 1 files as see that everything works.
+	 * One inode is already taken by the root dir.
+	 */
+	for (i = 0; i < INCFS_MAX_FILES - 1; i++) {
+		struct stat st;
+
+		sprintf(filename, "file_%d", i);
+		sprintf(file_path, "%s/%s", mount_dir, filename);
+		ret = emit_file(cmd_fd, filename, &file_ino,
+				INCFS_ROOT_INODE, 0);
+		if (ret < 0) {
+			ksft_print_msg("Error creating a file: %s (%s)\n",
+				filename, strerror(-ret));
+			goto failure;
+		}
+
+		if (stat(file_path, &st) != 0) {
+			print_error("stat failed");
+			goto failure;
+		}
+	}
+
+	ret = emit_file(cmd_fd, "over_limit_file", &file_ino,
+			INCFS_ROOT_INODE, 0);
+	if (ret != -ENFILE) {
+		ksft_print_msg("Too many files were allowed to be cerated.\n");
+		goto failure;
+	}
+
+	close(cmd_fd);
+	cmd_fd = -1;
+	if (umount(mount_dir) != 0) {
+		print_error("Can't unmout FS");
+		goto failure;
+	}
+	return TEST_SUCCESS;
+
+failure:
+	close(cmd_fd);
+	close(backing_fd);
+	umount(mount_dir);
+	return TEST_FAILURE;
+}
+
+static char *setup_mount_dir()
+{
+	struct stat st;
+	char *current_dir = get_current_dir_name();
+	char *mount_dir = concat_file_name(current_dir,
+						"incfs_test_mount_dir");
+
+	free(current_dir);
+	if (stat(mount_dir, &st) == 0) {
+		if (S_ISDIR(st.st_mode))
+			return mount_dir;
+
+		ksft_print_msg("%s is a file, not a dir.\n", mount_dir);
+		return NULL;
+	}
+
+	if (mkdir(mount_dir, 0777)) {
+		print_error("Can't create mount dir.");
+		return NULL;
+	}
+
+	return mount_dir;
+}
+
+int main(int argc, char *argv[])
+{
+	char *mount_dir = NULL;
+	int fails = 0;
+
+	ksft_print_header();
+
+	if (geteuid() != 0)
+		ksft_print_msg("Not a root, might fail to mount.\n");
+
+	mount_dir = setup_mount_dir();
+	if (mount_dir == NULL)
+		ksft_exit_fail_msg("Can't create a mount dir\n");
+
+#define RUN_TEST(test)                                                         \
+	do {                                                                   \
+		ksft_print_msg("Running " #test "\n");                         \
+		if (test(mount_dir) == TEST_SUCCESS)                           \
+			ksft_test_result_pass(#test "\n");                     \
+		else {                                                         \
+			ksft_test_result_fail(#test "\n");                     \
+			fails++;                                               \
+		}                                                              \
+	} while (0)
+
+	RUN_TEST(directory_structure_test);
+	RUN_TEST(dirs_corner_cases);
+	RUN_TEST(file_count_limit);
+	RUN_TEST(work_after_remount_test);
+	RUN_TEST(child_procs_waiting_for_data_test);
+	RUN_TEST(errors_on_overwrite_test);
+	RUN_TEST(concurrent_reads_and_writes_test);
+	RUN_TEST(multiple_providers_test);
+	RUN_TEST(dynamic_files_and_data_test);
+
+#undef RUN_TEST
+	umount2(mount_dir, MNT_FORCE);
+	rmdir(mount_dir);
+
+	if (fails > 0)
+		ksft_exit_pass();
+	else
+		ksft_exit_pass();
+	return 0;
+}
diff --git a/tools/testing/selftests/filesystems/incfs/utils.c b/tools/testing/selftests/filesystems/incfs/utils.c
new file mode 100644
index 000000000000..1f83b97225de
--- /dev/null
+++ b/tools/testing/selftests/filesystems/incfs/utils.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 Google LLC
+ */
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <errno.h>
+#include <string.h>
+#include <poll.h>
+
+#include "utils.h"
+
+int mount_fs(char *mount_dir, int backing_fd, int read_timeout_ms)
+{
+	static const char fs_name[] = INCFS_NAME;
+	char mount_options[512];
+	int result;
+
+	snprintf(mount_options, ARRAY_SIZE(mount_options),
+		 "backing_fd=%u,read_timeout_ms=%u",
+		 backing_fd, read_timeout_ms);
+
+	result = mount(fs_name, mount_dir, fs_name, 0, mount_options);
+	if (result != 0)
+		perror("Error mounting fs.");
+	return result;
+}
+
+int unlink_node(int fd, int parent_ino, char *filename)
+{
+	struct incfs_instruction inst = {
+			.type = INCFS_INSTRUCTION_REMOVE_DIR_ENTRY,
+			.dir_entry = {
+				.dir_ino = parent_ino,
+				.name = ptr_to_u64(filename),
+				.name_len = strlen(filename)
+			}
+	};
+
+	return send_md_instruction(fd, &inst);
+}
+
+int emit_node(int fd, char *filename, int *ino_out, int parent_ino,
+		size_t size, mode_t mode)
+{
+	int ret = 0;
+	__u64 ino = 0;
+	struct incfs_instruction inst = {
+			.type = INCFS_INSTRUCTION_NEW_FILE,
+			.file = {
+				.size = size,
+				.mode = mode,
+			}
+	};
+
+	ret = send_md_instruction(fd, &inst);
+	if (ret)
+		return ret;
+
+	ino = inst.file.ino_out;
+	inst = (struct incfs_instruction){
+			.type = INCFS_INSTRUCTION_ADD_DIR_ENTRY,
+			.dir_entry = {
+				.dir_ino = parent_ino,
+				.child_ino = ino,
+				.name = ptr_to_u64(filename),
+				.name_len = strlen(filename)
+			}
+		};
+	ret = send_md_instruction(fd, &inst);
+	if (ret)
+		return ret;
+	*ino_out = ino;
+	return 0;
+}
+
+
+int emit_dir(int fd, char *filename, int *ino_out, int parent_ino)
+{
+	return emit_node(fd, filename, ino_out, parent_ino, 0, S_IFDIR | 0555);
+}
+
+int emit_file(int fd, char *filename, int *ino_out, int parent_ino, size_t size)
+{
+	return emit_node(fd, filename, ino_out, parent_ino, size,
+				S_IFREG | 0555);
+}
+
+int send_md_instruction(int cmd_fd, struct incfs_instruction *inst)
+{
+	inst->version = INCFS_HEADER_VER;
+	if (ioctl(cmd_fd, INCFS_IOC_PROCESS_INSTRUCTION, inst) == 0)
+		return 0;
+	return -errno;
+}
+
+loff_t get_file_size(char *name)
+{
+	struct stat st;
+
+	if (stat(name, &st) == 0)
+		return st.st_size;
+	return -ENOENT;
+}
+
+int open_commands_file(char *mount_dir)
+{
+	char cmd_file[255];
+	int cmd_fd;
+
+	snprintf(cmd_file, ARRAY_SIZE(cmd_file), "%s/.cmd", mount_dir);
+	cmd_fd = open(cmd_file, O_RDWR);
+	if (cmd_fd < 0)
+		perror("Can't open commands file");
+	return cmd_fd;
+}
+
+int wait_for_pending_reads(int fd, int timeout_ms,
+	struct incfs_pending_read_info *prs, int prs_count)
+{
+	ssize_t read_res = 0;
+
+	if (timeout_ms > 0) {
+		int poll_res = 0;
+		struct pollfd pollfd = {
+			.fd = fd,
+			.events = POLLIN
+		};
+
+		poll_res = poll(&pollfd, 1, timeout_ms);
+		if (poll_res < 0)
+			return -errno;
+		if (poll_res == 0)
+			return 0;
+		if (!(pollfd.revents | POLLIN))
+			return 0;
+	}
+
+	read_res = read(fd, prs, prs_count * sizeof(*prs));
+	if (read_res < 0)
+		return -errno;
+
+	return read_res / sizeof(*prs);
+}
+
+char *concat_file_name(char *dir, char *file)
+{
+	char full_name[FILENAME_MAX] = "";
+
+	if (snprintf(full_name, ARRAY_SIZE(full_name), "%s/%s", dir, file) < 0)
+		return NULL;
+	return strdup(full_name);
+}
diff --git a/tools/testing/selftests/filesystems/incfs/utils.h b/tools/testing/selftests/filesystems/incfs/utils.h
new file mode 100644
index 000000000000..c3423fe01857
--- /dev/null
+++ b/tools/testing/selftests/filesystems/incfs/utils.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+#include <stdbool.h>
+#include <sys/stat.h>
+
+#include "../../include/uapi/linux/incrementalfs.h"
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
+
+#ifdef __LP64__
+#define ptr_to_u64(p) ((__u64)p)
+#else
+#define ptr_to_u64(p) ((__u64)(__u32)p)
+#endif
+
+int mount_fs(char *mount_dir, int backing_fd, int read_timeout_ms);
+
+int send_md_instruction(int cmd_fd, struct incfs_instruction *inst);
+
+int emit_node(int fd, char *filename, int *ino_out, int parent_ino,
+		size_t size, mode_t mode);
+
+int emit_dir(int fd, char *filename, int *ino_out, int parent_ino);
+
+int emit_file(int fd, char *filename, int *ino_out, int parent_ino,
+		size_t size);
+
+int unlink_node(int fd, int parent_ino, char *filename);
+
+loff_t get_file_size(char *name);
+
+int open_commands_file(char *mount_dir);
+
+int wait_for_pending_reads(int fd, int timeout_ms,
+	struct incfs_pending_read_info *prs, int prs_count);
+
+char *concat_file_name(char *dir, char *file);
--
2.21.0.593.g511ec345e18-goog

