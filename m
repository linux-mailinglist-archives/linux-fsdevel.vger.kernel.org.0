Return-Path: <linux-fsdevel+bounces-50830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BD7ACFFE6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 11:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB4A3A8AAD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7272868B2;
	Fri,  6 Jun 2025 09:59:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5942857EF;
	Fri,  6 Jun 2025 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203975; cv=none; b=okE9DE3jRTjLQ48XzuaH/Fz1jYoVMIYsDEtemKhi+AyV3LCh+C8yoFiPSDg66htI8oqSotUEay0L4FckCZ6KqjTVHA4qV/CYCqm5W0H1xARW2J/lWVwaTJ2jR5DSXfZB6jDwg5Vx2paSixGmeufDrXMXc66OQffdwj/nI66nzSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203975; c=relaxed/simple;
	bh=sTYLlWK7D9rHYnaH7Ko2SXSb+sPWa/ys/gbyd7C5Zz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OC1ND8gPzFiF0EJ5oyMhH4ib4fgdi5ds3FvDMxehKmnOSz0O9brt8yV5zceQbsxNZ5EZdJkK5DCDt79FF+9ESvZsMasCYMbCSYFi4H5c3MK4aij9lmo4DRaJOgwqVMXax0QqYjnh9mzEO6RhUuGkfgXFapmx6N7xoASA2n1xC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4bDGtg6WhnzYm3Kr;
	Fri,  6 Jun 2025 17:56:43 +0800 (CST)
Received: from a014.hihonor.com (10.68.16.227) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Jun
 2025 17:59:02 +0800
Received: from a010.hihonor.com (10.68.16.52) by a014.hihonor.com
 (10.68.16.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Jun
 2025 17:59:02 +0800
Received: from a010.hihonor.com ([fe80::7127:3946:32c7:6e]) by
 a010.hihonor.com ([fe80::7127:3946:32c7:6e%14]) with mapi id 15.02.1544.011;
 Fri, 6 Jun 2025 17:59:02 +0800
From: wangtao <tao.wangtao@honor.com>
To: Christoph Hellwig <hch@infradead.org>, =?iso-8859-1?Q?Christian_K=F6nig?=
	<christian.koenig@amd.com>
CC: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, "kraxel@redhat.com"
	<kraxel@redhat.com>, "vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "amir73il@gmail.com"
	<amir73il@gmail.com>, "benjamin.gaignard@collabora.com"
	<benjamin.gaignard@collabora.com>, "Brian.Starkey@arm.com"
	<Brian.Starkey@arm.com>, "jstultz@google.com" <jstultz@google.com>,
	"tjmercier@google.com" <tjmercier@google.com>, "jack@suse.cz" <jack@suse.cz>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "wangbintian(BintianWang)"
	<bintian.wang@honor.com>, yipengxiang <yipengxiang@honor.com>, liulu 00013167
	<liulu.liu@honor.com>, hanfeng 00012985 <feng.han@honor.com>
Subject: RE: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
Thread-Topic: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
Thread-Index: AQHb1G1ol+FT389RFkuW+lwB3adoKrPw4BKAgAADywCAAAF8AIAAEGgAgAAC0oCAABhEAIAAAd6AgATEk2A=
Date: Fri, 6 Jun 2025 09:59:02 +0000
Message-ID: <d5d3567d956440c39cb8d2851950f412@honor.com>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
 <aD72alIxu718uri4@infradead.org>
 <924ac01f-b86b-4a03-b563-878fa7736712@amd.com>
 <aD8Gi9ShWDEYqWjB@infradead.org>
 <d1937343-5fc3-4450-b31a-d45b6f5cfc16@amd.com>
 <aD8cd137bWPALs4u@infradead.org>
In-Reply-To: <aD8cd137bWPALs4u@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Wednesday, June 4, 2025 12:02 AM
> To: Christian K=F6nig <christian.koenig@amd.com>
> Cc: Christoph Hellwig <hch@infradead.org>; wangtao
> <tao.wangtao@honor.com>; sumit.semwal@linaro.org; kraxel@redhat.com;
> vivek.kasireddy@intel.com; viro@zeniv.linux.org.uk; brauner@kernel.org;
> hughd@google.com; akpm@linux-foundation.org; amir73il@gmail.com;
> benjamin.gaignard@collabora.com; Brian.Starkey@arm.com;
> jstultz@google.com; tjmercier@google.com; jack@suse.cz;
> baolin.wang@linux.alibaba.com; linux-media@vger.kernel.org; dri-
> devel@lists.freedesktop.org; linaro-mm-sig@lists.linaro.org; linux-
> kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-
> mm@kvack.org; wangbintian(BintianWang) <bintian.wang@honor.com>;
> yipengxiang <yipengxiang@honor.com>; liulu 00013167
> <liulu.liu@honor.com>; hanfeng 00012985 <feng.han@honor.com>
> Subject: Re: [PATCH v4 0/4] Implement dmabuf direct I/O via
> copy_file_range
>=20
> On Tue, Jun 03, 2025 at 05:55:18PM +0200, Christian K=F6nig wrote:
> > On 6/3/25 16:28, Christoph Hellwig wrote:
> > > On Tue, Jun 03, 2025 at 04:18:22PM +0200, Christian K=F6nig wrote:
> > >>> Does it matter compared to the I/O in this case?
> > >>
> > >> It unfortunately does, see the numbers on patch 3 and 4.
> > >
> > > That's kinda weird.  Why does the page table lookup tage so much
> > > time compared to normal I/O?
> >
> > I have absolutely no idea. It's rather surprising for me as well.
> >
> > The user seems to have a rather slow CPU paired with fast I/O, but it s=
till
> looks rather fishy to me.
> >
> > Additional to that allocating memory through memfd_create() is *much*
> slower on that box than through dma-buf-heaps (which basically just uses
> GFP and an array).
>=20
> Can someone try to reproduce these results on a normal system before
> we're building infrastructure based on these numbers?

Here's my test program. If anyone's interested,
please help test it?

Regards,
Wangtao.

[PATCH] Add dmabuf direct I/O zero-copy test program

Compare latency and throughput of file read/write for
memfd, udmabuf+memfd, udmabuf, and dmabuf buffers.
memfd supports buffer I/O and direct I/O via read/write,
sendfile, and splice user APIs.
udmabuf/dmabuf only support buffer I/O via read/write,
lacking direct I/O, sendfile, and splice support.
Previous patch added dmabuf's copy_file_range callback,
enabling buffer/direct I/O file copies for udmabuf/dmabuf.
u+memfd represents using memfd-created udmabuf with memfd's
user APIs for file copying.

usage: dmabuf-dio [file_path] [size_MB]

Signed-off-by: wangtao <tao.wangtao@honor.com>
---
 tools/testing/selftests/dmabuf-heaps/Makefile |   1 +
 .../selftests/dmabuf-heaps/dmabuf-dio.c       | 617 ++++++++++++++++++
 2 files changed, 618 insertions(+)
 create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-dio.c

diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testing/=
selftests/dmabuf-heaps/Makefile
index 9e7e158d5fa3..beb6b3e55e17 100644
--- a/tools/testing/selftests/dmabuf-heaps/Makefile
+++ b/tools/testing/selftests/dmabuf-heaps/Makefile
@@ -2,5 +2,6 @@
 CFLAGS +=3D -static -O3 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
=20
 TEST_GEN_PROGS =3D dmabuf-heap
+TEST_GEN_PROGS +=3D dmabuf-dio
=20
 include ../lib.mk
diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-dio.c b/tools/test=
ing/selftests/dmabuf-heaps/dmabuf-dio.c
new file mode 100644
index 000000000000..eae902a27f29
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-dio.c
@@ -0,0 +1,617 @@
+#include <linux/dma-heap.h>
+#include <linux/dma-buf.h>
+#include <linux/udmabuf.h>
+#include <sys/mman.h>
+#include <sys/sendfile.h>
+#include <sys/ioctl.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <asm/unistd.h>
+#include <time.h>
+#include <errno.h>
+
+#ifndef TEMP_FAILURE_RETRY
+#define TEMP_FAILURE_RETRY(exp) ({         \
+    __typeof__(exp) _rc;                   \
+    do {                                   \
+        _rc =3D (exp);                       \
+    } while (_rc =3D=3D -1 && errno =3D=3D EINTR); \
+    _rc; })
+#endif
+
+#if 1
+int memfd_create(const char *name, unsigned flags)
+{
+    return syscall(__NR_memfd_create, name, flags);
+}
+
+ssize_t copy_file_range(int fd_in, off_t *off_in, int fd_out, off_t *off_o=
ut,
+                size_t len, unsigned flags)
+{
+    return syscall(__NR_copy_file_range, fd_in, off_in, fd_out, off_out, l=
en, flags);
+}
+#endif
+
+int alloc_memfd(size_t size)
+{
+    int memfd =3D memfd_create("ubuf", MFD_ALLOW_SEALING);
+    if (memfd < 0)
+        return -1;
+
+    int ret =3D fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK);
+    if (ret < 0)
+        return -1;
+    ret =3D TEMP_FAILURE_RETRY(ftruncate(memfd, size));
+    if (ret < 0)
+        return -1;
+    return memfd;
+}
+
+int alloc_udmabuf(size_t size, int memfd)
+{
+    static int udev_fd =3D -1;
+    if (udev_fd < 0) {
+        udev_fd =3D open("/dev/udmabuf", O_RDONLY);
+        if (udev_fd < 0)
+            return -1;
+    }
+
+    struct udmabuf_create uc =3D {0};
+    uc.memfd =3D memfd;
+    uc.offset =3D 0;
+    uc.size =3D size;
+    int buf_fd =3D TEMP_FAILURE_RETRY(ioctl(udev_fd, UDMABUF_CREATE, &uc))=
;
+    if (buf_fd < 0)
+        return -1;
+
+    return buf_fd;
+}
+
+int alloc_dmabuf(size_t size)
+{
+    static int heap_fd =3D -1;
+
+    struct dma_heap_allocation_data heap_data =3D { 0 };
+    heap_data.len =3D size;  // length of data to be allocated in bytes
+    heap_data.fd_flags =3D O_RDWR | O_CLOEXEC;  // permissions for the mem=
ory to be allocated
+
+    if (heap_fd < 0) {
+        heap_fd =3D open("/dev/dma_heap/system", O_RDONLY);
+        if (heap_fd < 0)
+            return -1;
+    }
+
+    int ret =3D TEMP_FAILURE_RETRY(ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &h=
eap_data));
+    if (ret < 0) {
+        return -1;
+    }
+    if (heap_data.fd < 0)
+        return -1;
+
+    return heap_data.fd;
+}
+
+static inline long times_us_duration(struct timespec *ts_start, struct tim=
espec *ts_end)
+{
+    long long start =3D ts_start->tv_sec * 1000000 + ts_start->tv_nsec / 1=
000;
+    long long end =3D ts_end->tv_sec * 1000000 + ts_end->tv_nsec / 1000;
+    return end - start;
+}
+
+static inline long time_us2ms(long us)
+{
+        return (us + 1000 - 1) / 1000;
+}
+
+void drop_pagecaches(int file_fd, loff_t offset, size_t len)
+{
+    if (file_fd >=3D 0 && len > 0) {
+        posix_fadvise(file_fd, offset, len, POSIX_FADV_DONTNEED);
+        return;
+    }
+
+    int fd =3D open("/proc/sys/vm/drop_caches", O_WRONLY | O_CLOEXEC);
+    if (fd < 0) {
+        printf("open drop_caches failed %d\n", errno);
+        return;
+    }
+    write(fd, "3", 1);
+    close(fd);
+}
+
+const size_t SIZ_MB =3D 1024 * 1024;
+const size_t DMABUF_SIZE_MAX =3D SIZ_MB * 32;
+
+static inline unsigned char test_data_value(unsigned int val)
+{
+    return val % 253;
+}
+
+void test_fill_data(unsigned char* ptr, unsigned int val, size_t sz, bool =
fast)
+{
+    if (sz > 0 && fast) {
+        ptr[0] =3D test_data_value(val);
+        ptr[sz / 2] =3D test_data_value(val + sz / 2);
+        ptr[sz - 1] =3D test_data_value(val + sz - 1);
+        return;
+    }
+    for (size_t i =3D 0; i < sz; i++) {
+        ptr[i] =3D test_data_value(val + i);
+    }
+}
+
+bool test_check_data(unsigned char* ptr, unsigned int val, size_t sz, bool=
 fast)
+{
+    if (sz > 0 && fast) {
+        if (ptr[0] !=3D test_data_value(val))
+            return false;
+        if (ptr[sz / 2] !=3D test_data_value(val + sz / 2))
+            return false;
+        if (ptr[sz - 1] !=3D test_data_value(val + sz - 1))
+            return false;
+        return true;
+    }
+    for (size_t i =3D 0; i < sz; i++) {
+        if (ptr[i] !=3D test_data_value(val + i))
+            return false;
+    }
+    return true;
+}
+
+enum mem_buf_type {
+    BUF_MEMFD,
+    BUF_UDMA_MEMFD,
+    BUF_UDMABUF,
+    BUF_DMABUF,
+    BUF_TYPE_MAX,
+};
+
+enum copy_io_type {
+    IO_MAP_READ_WRITE,
+    IO_SENDFILE,
+    IO_SPLICE,
+    IO_COPY_FILE_RANGE,
+    IO_TYPE_MAX,
+};
+
+static const char *mem_buf_type_descs[BUF_TYPE_MAX] =3D {
+    "memfd", "u+memfd", "udmabuf", "dmabuf",
+};
+
+static const char *io_type_descs[IO_TYPE_MAX] =3D {
+    "R/W", "sendfile", "splice", "c_f_r",
+};
+
+struct mem_buf_st {
+    enum mem_buf_type buf_type_;
+    int io_fd_;
+    int mem_fd_;
+    int buf_fd_;
+    size_t buf_len_;
+    unsigned char *buf_ptr_;
+};
+
+struct mem_buf_tc {
+    enum mem_buf_type buf_type_;
+    enum copy_io_type io_type_;
+    int file_fd_;
+    bool direct_io_;
+    size_t io_len_;
+    long times_create_;
+    long times_data_;
+    long times_io_;
+    long times_close_;
+};
+
+void membuf_deinit(struct mem_buf_st *membuf)
+{
+    if (membuf->buf_ptr_ !=3D NULL && membuf->buf_ptr_ !=3D MAP_FAILED)
+        munmap(membuf->buf_ptr_, membuf->buf_len_);
+    membuf->buf_ptr_ =3D NULL;
+    if (membuf->mem_fd_ > 0)
+       close(membuf->mem_fd_);
+    if (membuf->buf_fd_ > 0)
+       close(membuf->buf_fd_);
+    membuf->mem_fd_ =3D -1;
+    membuf->buf_fd_ =3D -1;
+}
+
+bool membuf_init(struct mem_buf_st *membuf, size_t len, enum mem_buf_type =
buf_type)
+{
+    int map_fd =3D -1;
+
+    membuf->mem_fd_ =3D -1;
+    membuf->buf_fd_ =3D -1;
+    membuf->buf_len_ =3D len;
+    membuf->buf_ptr_ =3D NULL;
+    if (buf_type <=3D BUF_UDMABUF) {
+        membuf->mem_fd_ =3D alloc_memfd(len);
+        if (membuf->mem_fd_ < 0) {
+            printf("alloc memfd %zd failed %d\n", len, errno);
+            return false;
+        }
+        map_fd =3D membuf->mem_fd_;
+        if (buf_type > BUF_MEMFD) {
+            membuf->buf_fd_ =3D alloc_udmabuf(len, membuf->mem_fd_);
+            if (membuf->buf_fd_ < 0) {
+                printf("alloc udmabuf %zd failed %d\n", len, errno);
+                return false;
+            }
+            if (buf_type =3D=3D BUF_UDMABUF)
+                map_fd =3D membuf->buf_fd_;
+        }
+    } else {
+        membuf->buf_fd_ =3D alloc_dmabuf(len);
+        if (membuf->buf_fd_ < 0) {
+            printf("alloc dmabuf %zd failed %d\n", len, errno);
+            return false;
+        }
+        map_fd =3D membuf->buf_fd_;
+    }
+    membuf->io_fd_ =3D map_fd;
+    membuf->buf_ptr_ =3D (unsigned char *)mmap(NULL, len,
+            PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
+    if (membuf->buf_ptr_ =3D=3D MAP_FAILED) {
+        printf("fd %d map %zd failed %d\n", map_fd, len, errno);
+        membuf->buf_ptr_ =3D NULL;
+        return false;
+    }
+    return true;
+}
+
+ssize_t membuf_read_write(const struct mem_buf_st *membuf, int file_fd,
+                loff_t off, bool is_read)
+{
+    if (!membuf->buf_ptr_)
+        return -1;
+    lseek(file_fd, off, SEEK_SET);
+    if (is_read)
+        return read(file_fd, membuf->buf_ptr_, membuf->buf_len_);
+    else
+        return write(file_fd, membuf->buf_ptr_, membuf->buf_len_);
+}
+
+ssize_t membuf_sendfile(const struct mem_buf_st *membuf, int file_fd,
+                        loff_t off, bool is_read)
+{
+    int mem_fd =3D membuf->io_fd_;
+    size_t buf_len =3D membuf->buf_len_;
+
+    if (mem_fd < 0)
+        return -__LINE__;
+
+    lseek(mem_fd, 0, SEEK_SET);
+    lseek(file_fd, off, SEEK_SET);
+    if (is_read)
+        return sendfile(mem_fd, file_fd, NULL, buf_len);
+    else
+        return sendfile(file_fd, mem_fd, NULL, buf_len);
+}
+
+ssize_t membuf_splice(const struct mem_buf_st *membuf, int file_fd,
+                        loff_t off, bool is_read)
+{
+    size_t len =3D 0, out_len =3D 0, buf_len =3D membuf->buf_len_;
+    int mem_fd =3D membuf->io_fd_;
+    int fd_in =3D file_fd, fd_out =3D mem_fd;
+    ssize_t ret =3D 0;
+    static int s_pipe_fds[2] =3D { -1, -1};
+
+    if (mem_fd < 0)
+        return -__LINE__;
+
+    lseek(mem_fd, 0, SEEK_SET);
+    lseek(file_fd, off, SEEK_SET);
+    if (s_pipe_fds[0] < 0) {
+        const int pipe_size =3D SIZ_MB * 32;
+        int pipe_fds[2];
+        ret =3D pipe(pipe_fds);
+        if (ret < 0)
+            return -__LINE__;
+        ret =3D fcntl(pipe_fds[1], F_SETPIPE_SZ, pipe_size);
+        if (ret < 0)
+            return -__LINE__;
+        ret =3D fcntl(pipe_fds[0], F_GETPIPE_SZ, pipe_size);
+        if (ret !=3D pipe_size)
+            return -__LINE__;
+        s_pipe_fds[0] =3D pipe_fds[0];
+        s_pipe_fds[1] =3D pipe_fds[1];
+    }
+
+    if (!is_read) {
+        fd_in =3D mem_fd;
+        fd_out =3D file_fd;
+    }
+
+    while (buf_len > len) {
+        ret =3D splice(fd_in, NULL, s_pipe_fds[1], NULL, buf_len - len, SP=
LICE_F_NONBLOCK);
+        if (ret <=3D 0)
+            break;
+        len +=3D ret;
+        do {
+            ret =3D splice(s_pipe_fds[0], NULL, fd_out, NULL, len - out_le=
n, 0);
+            if (ret <=3D 0)
+                break;
+            out_len +=3D ret;
+        } while (out_len < len);
+    }
+    return out_len > 0 ? out_len : ret;
+}
+
+ssize_t membuf_cfr(const struct mem_buf_st *membuf, int file_fd, loff_t of=
f,
+                        bool is_read)
+{
+    loff_t mem_pos =3D 0;
+    loff_t file_pos =3D off;
+    size_t out_len =3D 0, buf_len =3D membuf->buf_len_;
+    int mem_fd =3D membuf->io_fd_;
+    int fd_in =3D file_fd, fd_out =3D mem_fd;
+    loff_t pos_in =3D file_pos, pos_out =3D mem_pos;
+    ssize_t ret =3D 0;
+
+    if (mem_fd < 0)
+        return -__LINE__;
+
+    lseek(mem_fd, mem_pos, SEEK_SET);
+    lseek(file_fd, file_pos, SEEK_SET);
+
+    if (!is_read) {
+        fd_in =3D mem_fd;
+        fd_out =3D file_fd;
+        pos_in =3D mem_pos;
+        pos_out =3D file_pos;
+    }
+
+    while (buf_len > out_len) {
+        ret =3D copy_file_range(fd_in, &pos_in, fd_out, &pos_out, buf_len =
- out_len, 0);
+        if (ret <=3D 0)
+            break;
+        out_len +=3D ret;
+    }
+    return out_len > 0 ? out_len : ret;
+}
+
+ssize_t membuf_io(const struct mem_buf_st *membuf, int file_fd, loff_t off=
,
+                        bool is_read, enum copy_io_type io_type)
+{
+    ssize_t ret =3D 0;
+    if (io_type =3D=3D IO_MAP_READ_WRITE) {
+        ret =3D membuf_read_write(membuf, file_fd, off, is_read);
+    } else if (io_type =3D=3D IO_SENDFILE) {
+        ret =3D membuf_sendfile(membuf, file_fd, off, is_read);
+    } else if (io_type =3D=3D IO_SPLICE) {
+        ret =3D membuf_splice(membuf, file_fd, off, is_read);
+    } else if (io_type =3D=3D IO_COPY_FILE_RANGE) {
+        ret =3D membuf_cfr(membuf, file_fd, off, is_read);
+    } else
+        return -1;
+    if (ret < 0)
+        printf("membuf_io io failed %d\n", errno);
+    return ret;
+}
+
+const char *membuf_tc_desc(const struct mem_buf_tc *tc)
+{
+    static char buf[32];
+    snprintf(buf, sizeof(buf), "%s %s %s", mem_buf_type_descs[tc->buf_type=
_],
+        tc->direct_io_ ? "direct" : "buffer", io_type_descs[tc->io_type_])=
;
+    return buf;
+}
+
+bool test_membuf(struct mem_buf_tc *tc, loff_t pos, size_t file_len,
+                        size_t buf_siz, bool is_read, bool clean_pagecache=
s)
+{
+    loff_t off =3D pos, file_end =3D pos + file_len;
+    int file_fd =3D tc->file_fd_;
+    int i =3D 0, buf_num;
+    struct mem_buf_st *membufs;
+    struct timespec ts_start, ts_end;
+    ssize_t ret;
+
+    if (buf_siz > file_len)
+        buf_siz =3D file_len;
+    buf_num =3D (file_len + buf_siz - 1) / buf_siz;
+    membufs =3D (struct mem_buf_st *)malloc(sizeof(*membufs) * buf_num);
+    if (!membufs)
+        return false;
+
+    memset(membufs, 0, sizeof(*membufs) * buf_num);
+    drop_pagecaches(-1, 0, 0);
+    for (i =3D 0; i < buf_num && off < file_end; i++, off +=3D buf_siz) {
+        if (buf_siz > file_end - off)
+            buf_siz =3D file_end - off;
+
+        if (clean_pagecaches)
+            drop_pagecaches(file_fd, off, buf_siz);
+
+        clock_gettime(CLOCK_MONOTONIC, &ts_start);
+        if (!membuf_init(&membufs[i], buf_siz, tc->buf_type_)) {
+             printf("alloc %s %d failed\n", membuf_tc_desc(tc), i);
+             break;
+        }
+        clock_gettime(CLOCK_MONOTONIC, &ts_end);
+        tc->times_create_ +=3D times_us_duration(&ts_start, &ts_end);
+
+        clock_gettime(CLOCK_MONOTONIC, &ts_start);
+        if (!membufs[i].buf_ptr_) {
+            printf("map %s %d failed\n", membuf_tc_desc(tc), i);
+            break;
+        }
+        if (!is_read)
+            test_fill_data(membufs[i].buf_ptr_, off + 1, buf_siz, true);
+        clock_gettime(CLOCK_MONOTONIC, &ts_end);
+        tc->times_data_ +=3D times_us_duration(&ts_start, &ts_end);
+
+        clock_gettime(CLOCK_MONOTONIC, &ts_start);
+        ret =3D membuf_io(&membufs[i], file_fd, off, is_read, tc->io_type_=
);
+        if (ret < 0 || ret !=3D buf_siz) {
+            printf("membuf_io %s %d rw %zd ret %zd failed %d\n",
+                membuf_tc_desc(tc), i, buf_siz, ret, errno);
+            break;
+        }
+        clock_gettime(CLOCK_MONOTONIC, &ts_end);
+        tc->times_io_ +=3D times_us_duration(&ts_start, &ts_end);
+
+        clock_gettime(CLOCK_MONOTONIC, &ts_start);
+        if (!test_check_data(membufs[i].buf_ptr_, off + 1, buf_siz, true))=
 {
+            printf("check data %s %d failed\n", membuf_tc_desc(tc), i);
+            break;
+        }
+        clock_gettime(CLOCK_MONOTONIC, &ts_end);
+        tc->times_data_ +=3D times_us_duration(&ts_start, &ts_end);
+
+        if (clean_pagecaches)
+            drop_pagecaches(file_fd, off, buf_siz);
+    }
+
+    clock_gettime(CLOCK_MONOTONIC, &ts_start);
+    for (i =3D 0; i < buf_num; i++) {
+        membuf_deinit(&membufs[i]);
+    }
+    clock_gettime(CLOCK_MONOTONIC, &ts_end);
+    tc->times_close_ +=3D times_us_duration(&ts_start, &ts_end);
+    drop_pagecaches(-1, 0, 0);
+    tc->io_len_ =3D off - pos;
+    return off - pos >=3D file_end;
+}
+
+bool prepare_init_file(int file_fd, loff_t off, size_t file_len)
+{
+    struct mem_buf_st membuf =3D {};
+    ssize_t ret;
+
+    ftruncate(file_fd, off + file_len);
+
+    if (!membuf_init(&membuf, file_len, BUF_MEMFD))
+        return false;
+
+    test_fill_data(membuf.buf_ptr_, off + 1, file_len, false);
+    ret =3D membuf_io(&membuf, file_fd, off, false, IO_MAP_READ_WRITE);
+    membuf_deinit(&membuf);
+
+    return ret >=3D file_len;
+}
+
+bool prepare_file(const char *filepath, loff_t off, size_t file_len)
+{
+    ssize_t file_end;
+    bool suc =3D true;
+    int flags =3D O_RDWR | O_CLOEXEC | O_LARGEFILE | O_CREAT;
+    int file_fd =3D open(filepath, flags, 0660);
+    if (file_fd < 0) {
+        printf("open %s failed %d\n", filepath, errno);
+        return false;
+    }
+
+    file_end =3D (size_t)lseek(file_fd, 0, SEEK_END);
+    if (file_end < off + file_len)
+        suc =3D prepare_init_file(file_fd, off, file_len);
+
+    close(file_fd);
+    return suc;
+}
+
+void test_membuf_cases(struct mem_buf_tc *test_cases, int test_count,
+                loff_t off, size_t file_len, size_t buf_siz,
+                bool is_read, bool clean_pagecaches)
+{
+    char title[64];
+    long file_MB =3D (file_len + SIZ_MB - 1) / SIZ_MB;
+    long buf_MB =3D (buf_siz + SIZ_MB - 1) / SIZ_MB;
+    long base_io_time, io_times;
+    long base_io_speed, io_speed;
+    struct mem_buf_tc *tc;
+    int n;
+
+    for (n =3D 0; n < test_count; n++) {
+        test_membuf(&test_cases[n], off, file_len, buf_siz, is_read, clean=
_pagecaches);
+    }
+
+    snprintf(title, sizeof(title), "%ldx%ldMB %s %4ldMB",
+             (file_MB + buf_MB - 1) / buf_MB, buf_MB,
+             is_read ? "Read" : "Write", file_MB);
+
+    base_io_time =3D test_cases[0].times_io_ ?: 1;
+    base_io_speed =3D test_cases[0].io_len_ / base_io_time ? : 1000;
+
+    printf("|    %-23s|%8s|%8s|%8s|%8s| I/O%%\n", title,
+           "Creat-ms", "Close-ms", "I/O-ms", "I/O-MB/s");
+    printf("|---------------------------|--------|--------|--------|------=
--|-----\n");
+    for (n =3D 0; n < test_count; n++) {
+        tc =3D &test_cases[n];
+        io_times =3D tc->times_io_;
+        io_speed =3D io_times > 0 ? tc->io_len_ / io_times : 0;
+
+        printf("|%2d) %23s| %6ld | %6ld | %6ld | %6ld |%4ld%%\n", n + 1,
+               membuf_tc_desc(tc), time_us2ms(tc->times_create_),
+               time_us2ms(tc->times_close_), time_us2ms(io_times),
+               io_speed, io_speed * 100 / base_io_speed);
+    }
+    return;
+}
+
+void test_all_membufs(const char *filepath, loff_t off, size_t file_len, s=
ize_t buf_siz,
+                        bool is_read, bool clean_pagecaches)
+{
+    int buffer_fd;
+    int direct_fd;
+
+    buffer_fd =3D open(filepath, O_RDWR | O_CLOEXEC | O_LARGEFILE);
+    direct_fd =3D open(filepath, O_RDWR | O_CLOEXEC | O_LARGEFILE | O_DIRE=
CT);
+    if (buffer_fd < 0 || direct_fd < 0) {
+        printf("buffer_fd %d direct_fd %d\n", buffer_fd, direct_fd);
+        return;
+    }
+
+    struct mem_buf_tc test_cases[] =3D {
+        {BUF_MEMFD, IO_MAP_READ_WRITE, buffer_fd, false},
+        {BUF_MEMFD, IO_MAP_READ_WRITE, direct_fd, true},
+        {BUF_UDMA_MEMFD, IO_MAP_READ_WRITE, buffer_fd, false},
+        {BUF_UDMA_MEMFD, IO_MAP_READ_WRITE, direct_fd, true},
+        {BUF_UDMA_MEMFD, IO_SENDFILE, buffer_fd, false},
+        {BUF_UDMA_MEMFD, IO_SENDFILE, direct_fd, true},
+        {BUF_UDMA_MEMFD, IO_SPLICE, buffer_fd, false},
+        {BUF_UDMA_MEMFD, IO_SPLICE, direct_fd, true},
+        {BUF_UDMABUF, IO_MAP_READ_WRITE, buffer_fd, false},
+        {BUF_DMABUF, IO_MAP_READ_WRITE, buffer_fd, false},
+        {BUF_UDMABUF, IO_COPY_FILE_RANGE, buffer_fd, false},
+        {BUF_UDMABUF, IO_COPY_FILE_RANGE, direct_fd, true},
+        {BUF_DMABUF, IO_COPY_FILE_RANGE, buffer_fd, false},
+        {BUF_DMABUF, IO_COPY_FILE_RANGE, direct_fd, true},
+    };
+
+    test_membuf_cases(test_cases, sizeof(test_cases) / sizeof(test_cases[0=
]),
+            off, file_len, buf_siz, is_read, clean_pagecaches);
+    close(buffer_fd);
+    close(direct_fd);
+}
+
+void usage(void)
+{
+    printf("usage: dmabuf-dio [file_path] [size_MB]\n");
+    return;
+}
+
+int main(int argc, char *argv[])
+{
+    const char *file_path =3D "/data/membuf.tmp";
+    size_t file_len =3D SIZ_MB * 1024;
+
+    if (argc > 1)
+        file_path =3D argv[1];
+    if (argc > 2)
+        file_len =3D atoi(argv[2]) * SIZ_MB;
+    if (file_len < 0)
+        file_len =3D SIZ_MB * 1024;
+    if (!prepare_file(file_path, 0, file_len)) {
+        usage();
+        return -1;
+    }
+
+    test_all_membufs(file_path, 0, file_len, SIZ_MB * 32, true, true);    =
   =20
+    return 0;
+}
--


