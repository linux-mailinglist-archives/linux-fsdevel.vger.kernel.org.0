Return-Path: <linux-fsdevel+bounces-28670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA18B96D036
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F0B2834FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0C01925BE;
	Thu,  5 Sep 2024 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpJ89PZK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB74C80;
	Thu,  5 Sep 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520657; cv=none; b=lYAkJLyrhqTvori26ZeF8/e2cvR9HTdSA2leII+/rF39QUvZEzVphIQ7oLD7+SuE5x2MSR0UAH2AHL64Axn0+Xju1HLLsFOsj3hBhpSPan4se+wsVNfYZ4Xb9m0XbyeHjlyHaIhyf3FWtmGoUvh11pcnJC/cLOwDtDlO4I+Uivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520657; c=relaxed/simple;
	bh=T82ZHVv8scUbYaJTrPnoKsKDwKHzcAM8l5KrJsbK9WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCMIqyZOVlPp4H5i9uxMPj3acNEVBoJF4qPrkbnUaPtNWoPc629KqxJl7JicbNbGf3BRKVUtsZLS8aTjf0KtV7cdllJs396rpJkgt1UKgbw8k7nTXWLgwBYr22GyKjLSbNwqfr9se7X/QXAhI2sdfZeO+zpasPBHQaBcd9hRlm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpJ89PZK; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6c3551ce5c9so14133266d6.0;
        Thu, 05 Sep 2024 00:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725520654; x=1726125454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRpbL6SA78F+ra9UaJEmk9dLlLL6CvxJv1ih5NnoGCM=;
        b=HpJ89PZKTNhKTion95Ka4wjPm9tEvFpBoOczZwA/cEv61O9WDTTZPCLcXGX6lGLH2T
         xhkVueR1nd7ckleEE/85BdMlbXdrUuitdsZ8t+1mEYtkRnBOoE7DKm2ULjyiKTKNTXwL
         akX7yNFYuz7iHDWo9fNejT2CxYQu7qdQWNv/lIi0Rw4Vl/GxiSAkpHUdXM5Znh/u/cde
         L5nkcPTvbC8Uxb1o/VcKCHOhyWTk3WxB/sHqDt+FSmU75UTyNh95tWy78ousv0Axb4sV
         Ky4BXKJTMWrEd0nYSEu59fjM9E/Ob1CY55gz6bdC5lGCMxzPmZsPmRwxwu2KrejuYjZf
         yxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725520654; x=1726125454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRpbL6SA78F+ra9UaJEmk9dLlLL6CvxJv1ih5NnoGCM=;
        b=qZdOtgpuKMMPyhMvBhRQmiIk/A25d0o6EeJatwJHRij6eTF4JZWRjNP4SZ/M5DJ1Yy
         ZZdmH3TsbCynTYWLHKCslLUNAq6O3Cq7akgCNC+5vHE/EPx8jDmnBOLFv3jdGE5epHso
         4CklEVdPfVNKdza1pSxjvsHYhyBmd9eJrDFbH3RjdVO5EC8udNAdAGNMgUD9ROG+elBk
         bO8ihpyiNGf28FWTYNVqFd2aGyShO1IEtkHtYOGEOm8D7uBRiqx4SR5PMl42LzxR8xOH
         UlXY7eG1rW2rWNPgCqwamxIWdciYwwhcbWG5sHtwLYazgB+TDDlFk1Htk6BDz+tVfwcO
         b30g==
X-Forwarded-Encrypted: i=1; AJvYcCUnCCJt+9tnXRDiw9fftotgx6+/mBfI5ykGWHxuCvi5xjw6+jT29BcDr2h2/uf3Xg1NCONzAV/fxO2K5YRS@vger.kernel.org
X-Gm-Message-State: AOJu0YwDSJSEBv4Ka31lgm4fQYp3hSfP96QcBbSvVSdZGpEx/mwcCD1Y
	C83nImVhO1nRU04zSVuJq/cRQllKNJhr3MwjfM50Dtnpryb75LxCjMnpieSJ49G89dMe9f1Tro7
	eNle14Sj2HI2guD2d9KXykzdqN+ECv9N5nAQ=
X-Google-Smtp-Source: AGHT+IEaCZyL2UPTq/PB4BQpo4qcDZcu2q42Lvnu4rlVMzLtayMN/Wv9sWbD1ivwvqNtGeM4sySAgPowE2yLpnz8Ikw=
X-Received: by 2002:a05:6214:f0e:b0:6c3:57e6:9734 with SMTP id
 6a1803df08f44-6c51928c986mr74859806d6.25.1725520653287; Thu, 05 Sep 2024
 00:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725481837.git.josef@toxicpanda.com> <e331c5f1485b7d9fa1278fb205a223af3a18366e.1725481837.git.josef@toxicpanda.com>
In-Reply-To: <e331c5f1485b7d9fa1278fb205a223af3a18366e.1725481837.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Sep 2024 09:17:21 +0200
Message-ID: <CAOQ4uxgwx9h1K4D5dK=eApkA2r93owhL9=nqmP4UdX7xFvUzcQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fstests: add a test for the precontent fanotify hooks
To: Josef Bacik <josef@toxicpanda.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:33=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> This is a test to validate the precontent hooks work properly for reads
> and page faults.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Very cool!

Some minor comments below.

I will publicly commit to duplicating your test to LTP
in the hope of shaming myself to actually do it...

> ---
>  doc/group-names.txt            |   1 +
>  src/Makefile                   |   2 +-
>  src/precontent/Makefile        |  26 ++
>  src/precontent/mmap-validate.c | 227 +++++++++++++++++
>  src/precontent/populate.c      | 188 ++++++++++++++
>  src/precontent/remote-fetch.c  | 441 +++++++++++++++++++++++++++++++++
>  tests/generic/800              |  68 +++++
>  tests/generic/800.out          |   2 +
>  8 files changed, 954 insertions(+), 1 deletion(-)
>  create mode 100644 src/precontent/Makefile
>  create mode 100644 src/precontent/mmap-validate.c
>  create mode 100644 src/precontent/populate.c
>  create mode 100644 src/precontent/remote-fetch.c
>  create mode 100644 tests/generic/800
>  create mode 100644 tests/generic/800.out
>
> diff --git a/doc/group-names.txt b/doc/group-names.txt
> index 6cf71796..93ba6a23 100644
> --- a/doc/group-names.txt
> +++ b/doc/group-names.txt
> @@ -56,6 +56,7 @@ fiexchange            XFS_IOC_EXCHANGE_RANGE ioctl
>  freeze                 filesystem freeze tests
>  fsck                   general fsck tests
>  fsmap                  FS_IOC_GETFSMAP ioctl
> +fsnotify               fsnotify tests
>  fsr                    XFS free space reorganizer
>  fuzzers                        filesystem fuzz tests
>  growfs                 increasing the size of a filesystem
> diff --git a/src/Makefile b/src/Makefile
> index 559209be..6dae892e 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -40,7 +40,7 @@ EXTRA_EXECS =3D dmerror fill2attr fill2fs fill2fs_check=
 scaleread.sh \
>               btrfs_crc32c_forged_name.py popdir.pl popattr.py \
>               soak_duration.awk
>
> -SUBDIRS =3D log-writes perf
> +SUBDIRS =3D log-writes perf precontent
>
>  LLDLIBS =3D $(LIBHANDLE) $(LIBACL) -lpthread -lrt -luuid
>
> diff --git a/src/precontent/Makefile b/src/precontent/Makefile
> new file mode 100644
> index 00000000..367a34bb
> --- /dev/null
> +++ b/src/precontent/Makefile
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TOPDIR =3D ../..
> +include $(TOPDIR)/include/builddefs
> +
> +TARGETS =3D $(basename $(wildcard *.c))
> +
> +CFILES =3D $(TARGETS:=3D.c)
> +LDIRT =3D $(TARGETS)
> +
> +default: depend $(TARGETS)
> +
> +depend: .dep
> +
> +include $(BUILDRULES)
> +
> +$(TARGETS): $(CFILES)
> +       @echo "    [CC]    $@"
> +       $(Q)$(LTLINK) $@.c -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
> +
> +install:
> +       $(INSTALL) -m 755 -d $(PKG_LIB_DIR)/src/precontent
> +       $(INSTALL) -m 755 $(TARGETS) $(PKG_LIB_DIR)/src/precontent
> +
> +-include .dep
> +
> diff --git a/src/precontent/mmap-validate.c b/src/precontent/mmap-validat=
e.c
> new file mode 100644
> index 00000000..af606d5b
> --- /dev/null
> +++ b/src/precontent/mmap-validate.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _FILE_OFFSET_BITS 64
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +/* 1 MiB. */
> +#define FILE_SIZE (1 * 1024 * 1024)
> +#define PAGE_SIZE 4096
> +
> +#define __free(func) __attribute__((cleanup(func)))
> +
> +static void freep(void *ptr)
> +{
> +       void *real_ptr =3D *(void **)ptr;
> +       if (real_ptr =3D=3D NULL)
> +               return;
> +       free(real_ptr);
> +}
> +
> +static void close_fd(int *fd)
> +{
> +       if (*fd < 0)
> +               return;
> +       close(*fd);
> +}
> +
> +static void unmap(void *ptr)
> +{
> +       void *real_ptr =3D *(void **)ptr;
> +       if (real_ptr =3D=3D NULL)
> +               return;
> +       munmap(real_ptr, PAGE_SIZE);
> +}
> +
> +static void print_buffer(const char *buf, off_t buf_off, off_t off, size=
_t len)
> +{
> +       for (int i =3D 0; i <=3D (len / 32); i++) {
> +               printf("%lu:", off + (i * 32));
> +
> +               for (int c =3D 0; c < 32; c++) {
> +                       if (!(c % 8))
> +                               printf(" ");
> +                       printf("%c", buf[buf_off++]);
> +               }
> +               printf("\n");
> +       }
> +}
> +
> +static int validate_buffer(const char *type, const char *buf,
> +                          const char *pattern, off_t bufoff, off_t off,
> +                          size_t len)
> +{
> +
> +       if (memcmp(buf + bufoff, pattern + off, len)) {
> +               printf("Buffers do not match at off %lu size %lu after %s=
\n",
> +                      off, len, type);
> +               printf("read buffer\n");
> +               print_buffer(buf, bufoff, off, len);
> +               printf("valid buffer\n");
> +               print_buffer(pattern, off, off, len);
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int validate_range_fd(int fd, char *pattern, off_t off, size_t le=
n)
> +{
> +       char *buf __free(freep) =3D NULL;
> +       ssize_t ret;
> +       size_t readin =3D 0;
> +
> +       buf =3D malloc(len);
> +       if (!buf) {
> +               perror("malloc buf");
> +               return 1;
> +       }
> +
> +       while ((ret =3D pread(fd, buf + readin, len - readin, off + readi=
n)) > 0) {
> +               readin +=3D ret;
> +               if (readin =3D=3D len)
> +                       break;
> +       }
> +
> +       if (ret < 0) {
> +               perror("read");
> +               return 1;
> +       }
> +
> +       return validate_buffer("read", buf, pattern, 0, off, len);
> +}
> +
> +static int validate_file(const char *file, char *pattern)
> +{
> +       int fd __free(close_fd) =3D -EBADF;
> +       char *buf __free(unmap) =3D NULL;
> +       int ret;
> +
> +       fd =3D open(file, O_RDONLY);
> +       if (fd < 0) {
> +               perror("open file");
> +               return 1;
> +       }
> +
> +       /* Cycle through the file and do some random reads and validate t=
hem. */
> +       for (int i =3D 0; i < 5; i++) {
> +               off_t off =3D random() % FILE_SIZE;
> +               size_t len =3D random() % PAGE_SIZE;
> +
> +               while ((off + len) > FILE_SIZE) {
> +                       len =3D FILE_SIZE - off;
> +                       if (len)
> +                               break;
> +                       len =3D random() % PAGE_SIZE;
> +               }
> +
> +               ret =3D validate_range_fd(fd, pattern, off, len);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       buf =3D mmap(NULL, FILE_SIZE, PROT_READ|PROT_EXEC, MAP_PRIVATE, f=
d, 0);
> +       if (!buf) {
> +               perror("mmap");
> +               return 1;
> +       }
> +
> +       /* Validate random ranges of the mmap buffer. */
> +       for (int i =3D 0; i < 5; i++) {
> +               off_t off =3D random() % FILE_SIZE;
> +               size_t len =3D random() % PAGE_SIZE;
> +
> +               while ((off + len) > FILE_SIZE) {
> +                       len =3D FILE_SIZE - off;
> +                       if (len)
> +                               break;
> +                       len =3D random() % PAGE_SIZE;
> +               }
> +
> +               ret =3D validate_buffer("mmap", buf, pattern, off, off, l=
en);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       /* Now check the whole thing, one page at a time. */
> +       for (int i =3D 0; i < (FILE_SIZE / PAGE_SIZE); i++) {
> +               ret =3D validate_buffer("mmap", buf, pattern, i * PAGE_SI=
ZE,
> +                                     i * PAGE_SIZE, PAGE_SIZE);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int create_file(const char *file, char *pattern)
> +{
> +       ssize_t ret;
> +       size_t written =3D 0;
> +       int fd __free(close_fd) =3D -EBADF;
> +
> +       fd =3D open(file, O_RDWR | O_CREAT, 0644);
> +       if (fd < 0) {
> +               perror("opening file");
> +               return 1;
> +       }
> +
> +       while ((ret =3D write(fd, pattern + written, FILE_SIZE - written)=
) > 0) {
> +               written +=3D ret;
> +               if (written =3D=3D FILE_SIZE)
> +                       break;
> +       }
> +
> +       if (ret < 0) {
> +               perror("writing to the file");
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +static void generate_pattern(char *pattern)
> +{
> +       for (int i =3D 0; i < (FILE_SIZE / PAGE_SIZE); i++) {
> +               char fill =3D 'a' + (i % 26);
> +
> +               memset(pattern + (i * PAGE_SIZE), fill, PAGE_SIZE);
> +       }
> +}
> +
> +static void usage(void)
> +{
> +       fprintf(stderr, "Usage: mmap-validate <create|validate> <file>\n"=
);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       char *pattern __free(freep) =3D NULL;
> +
> +       if (argc !=3D 3) {
> +               usage();
> +               return 1;
> +       }
> +
> +       pattern =3D malloc(FILE_SIZE * sizeof(char));
> +       if (!pattern) {
> +               perror("malloc pattern");
> +               return 1;
> +       }
> +
> +       generate_pattern(pattern);
> +
> +       if (!strcmp(argv[1], "create"))
> +               return create_file(argv[2], pattern);
> +
> +       if (strcmp(argv[1], "validate")) {
> +               usage();
> +               return 1;
> +       }
> +
> +       return validate_file(argv[2], pattern);
> +}
> diff --git a/src/precontent/populate.c b/src/precontent/populate.c
> new file mode 100644
> index 00000000..9c935427
> --- /dev/null
> +++ b/src/precontent/populate.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _FILE_OFFSET_BITS 64
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <poll.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
> +#define __free(func) __attribute__((cleanup(func)))
> +
> +static void close_fd(int *fd)
> +{
> +       if (*fd < 0)
> +               return;
> +       close(*fd);
> +}
> +
> +static void close_dir(DIR **dir)
> +{
> +       if (*dir =3D=3D NULL)
> +               return;
> +       closedir(*dir);
> +}
> +
> +static void freep(void *ptr)
> +{
> +       void *real_ptr =3D *(void **)ptr;
> +       if (real_ptr =3D=3D NULL)
> +               return;
> +       free(real_ptr);
> +}
> +
> +/*
> + * Dup a path, make sure there's a trailing '/' to make path concat easi=
er.
> + */
> +static char *pathdup(const char *orig)
> +{
> +       char *ret;
> +       size_t len =3D strlen(orig);
> +
> +       /* Easy path, we have a trailing '/'. */
> +       if (orig[len - 1] =3D=3D '/')
> +               return strdup(orig);
> +
> +       ret =3D malloc((len + 2) * sizeof(char));
> +       if (!ret)
> +               return ret;
> +
> +       memcpy(ret, orig, len);
> +       ret[len] =3D '/';
> +       len++;
> +       ret[len] =3D '\0';
> +       return ret;
> +}
> +
> +static int process_directory(DIR *srcdir, char *srcpath, char *dstpath)
> +{
> +       char *src __free(freep) =3D NULL;
> +       char *dst __free(freep) =3D NULL;
> +       size_t srclen =3D strlen(srcpath) + 256;
> +       size_t dstlen =3D strlen(dstpath) + 256;
> +       struct dirent *dirent;
> +
> +       src =3D malloc(srclen * sizeof(char));
> +       dst =3D malloc(dstlen * sizeof(char));
> +       if (!src || !dst) {
> +               perror("allocating path buf");
> +               return -1;
> +       }
> +
> +       errno =3D 0;
> +       while ((dirent =3D readdir(srcdir)) !=3D NULL) {
> +               if (!strcmp(dirent->d_name, ".") ||
> +                   !strcmp(dirent->d_name, ".."))
> +                       continue;
> +
> +               if (dirent->d_type =3D=3D DT_DIR) {
> +                       DIR *nextdir __free(close_dir) =3D NULL;
> +                       struct stat st;
> +                       int ret;
> +
> +                       snprintf(src, srclen, "%s%s/", srcpath, dirent->d=
_name);
> +                       snprintf(dst, dstlen, "%s%s/", dstpath, dirent->d=
_name);
> +
> +                       nextdir =3D opendir(src);
> +                       if (!nextdir) {
> +                               fprintf(stderr, "Couldn't open directory =
%s: %s (%d)\n",
> +                                       src, strerror(errno), errno);
> +                               return -1;
> +                       }
> +
> +                       if (stat(src, &st)) {
> +                               fprintf(stderr, "Couldn't stat directory =
%s: %s (%d)\n",
> +                                       src, strerror(errno), errno);
> +                               return -1;
> +                       }
> +
> +                       if (mkdir(dst, st.st_mode)) {
> +                               fprintf(stderr, "Couldn't mkdir %s: %s (%=
d)\n",
> +                                       dst, strerror(errno), errno);
> +                               return -1;
> +                       }
> +
> +                       ret =3D process_directory(nextdir, src, dst);
> +                       if (ret)
> +                               return ret;
> +               } else if (dirent->d_type =3D=3D DT_REG) {
> +                       int fd __free(close_fd) =3D -EBADF;
> +                       struct stat st;
> +
> +                       snprintf(src, srclen, "%s%s", srcpath, dirent->d_=
name);
> +                       snprintf(dst, dstlen, "%s%s", dstpath, dirent->d_=
name);
> +
> +                       if (stat(src, &st)) {
> +                               fprintf(stderr, "Couldn't stat file %s: %=
s (%d)\n",
> +                                       src, strerror(errno), errno);
> +                               return -1;
> +                       }
> +
> +                       fd =3D open(dst, O_WRONLY|O_CREAT, st.st_mode);
> +                       if (fd < 0) {
> +                               fprintf(stderr, "Couldn't create file %s:=
 %s (%d)\n",
> +                                       dst, strerror(errno), errno);
> +                               return -1;
> +                       }
> +
> +                       if (truncate(dst, st.st_size)) {
> +                               fprintf(stderr, "Couldn't truncate file %=
s: %s (%d)\n",
> +                                       dst, strerror(errno), errno);
> +                               return -1;
> +                       }
> +
> +
> +                       if (fsync(fd)) {
> +                               fprintf(stderr, "Couldn't fsync file %s: =
%s (%d)\n",
> +                                       dst, strerror(errno), errno);
> +                               return -1;
> +                       }
> +
> +                       if (posix_fadvise(fd, 0, 0, POSIX_FADV_DONTNEED))=
 {
> +                               fprintf(stderr, "Couldn't clear cache on =
file %s: %s (%d)\n",
> +                                       dst, strerror(errno), errno);
> +                               return -1;
> +                       }
> +               }
> +               errno =3D 0;
> +       }
> +
> +       if (errno) {
> +               perror("readdir");
> +               return -1;
> +       }
> +       return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       DIR *srcdir __free(close_dir) =3D NULL;
> +       char *dstpath __free(freep) =3D NULL;
> +       char *srcpath __free(freep) =3D NULL;
> +       int ret;
> +
> +       if (argc !=3D 3) {
> +               fprintf(stderr, "Usage: populate <src directory> <dest di=
rectory>\n");
> +               return 1;
> +       }
> +
> +       srcpath =3D pathdup(argv[1]);
> +       dstpath =3D pathdup(argv[2]);
> +       if (!dstpath || !srcpath) {
> +               perror("allocating paths");
> +               return 1;
> +       }
> +
> +       srcdir =3D opendir(srcpath);
> +       if (!srcdir) {
> +               perror("open src directory");
> +               return 1;
> +       }
> +
> +       ret =3D process_directory(srcdir, srcpath, dstpath);
> +       return ret ? 1 : 0;
> +}
> diff --git a/src/precontent/remote-fetch.c b/src/precontent/remote-fetch.=
c
> new file mode 100644
> index 00000000..2e35b9f8
> --- /dev/null
> +++ b/src/precontent/remote-fetch.c
> @@ -0,0 +1,441 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _FILE_OFFSET_BITS 64
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <poll.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/fanotify.h>
> +#include <sys/sendfile.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
> +#ifndef FAN_ERRNO_BITS
> +#define FAN_ERRNO_BITS 8
> +#define FAN_ERRNO_SHIFT (32 - FAN_ERRNO_BITS)
> +#define FAN_ERRNO_MASK ((1 << FAN_ERRNO_BITS) - 1)
> +#define FAN_DENY_ERRNO(err) \
> +       (FAN_DENY | ((((__u32)(err)) & FAN_ERRNO_MASK) << FAN_ERRNO_SHIFT=
))
> +#endif
> +
> +#ifndef FAN_PRE_ACCESS
> +#define FAN_PRE_ACCESS 0x00080000
> +#endif
> +
> +#ifndef FAN_PRE_MODIFY
> +#define FAN_PRE_MODIFY 0x00100000
> +#endif
> +
> +#ifndef FAN_EVENT_INFO_TYPE_RANGE
> +#define FAN_EVENT_INFO_TYPE_RANGE      6
> +struct fanotify_event_info_range {
> +       struct fanotify_event_info_header hdr;
> +       __u32 pad;
> +       __u64 offset;
> +       __u64 count;
> +};
> +#endif
> +
> +#define FAN_EVENTS (FAN_PRE_ACCESS | FAN_PRE_MODIFY)
> +
> +#define __round_mask(x, y) ((__typeof__(x))((y)-1))
> +#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
> +#define round_down(x, y) ((x) & ~__round_mask(x, y))
> +
> +static const char *srcpath;
> +static const char *dstpath;
> +static int pagesize;
> +static bool use_sendfile =3D false;
> +
> +#define __free(func) __attribute__((cleanup(func)))
> +
> +static void close_dir(DIR **dir)
> +{
> +       if (*dir =3D=3D NULL)
> +               return;
> +       closedir(*dir);
> +}
> +
> +static void close_fd(int *fd)
> +{
> +       if (*fd < 0)
> +               return;
> +       close(*fd);
> +}
> +
> +static void freep(void *ptr)
> +{
> +       void *real_ptr =3D *(void **)ptr;
> +       if (real_ptr =3D=3D NULL)
> +               return;
> +       free(real_ptr);
> +}
> +
> +static int strip_dstpath(char *path)
> +{
> +       size_t remaining;
> +
> +       if (strlen(path) <=3D strlen(dstpath)) {
> +               fprintf(stderr, "'%s' not in the path '%s'", path, dstpat=
h);
> +               return -1;
> +       }
> +
> +       if (strncmp(path, dstpath, strlen(dstpath))) {
> +               fprintf(stderr, "path '%s' doesn't start with the source =
path '%s'\n",
> +                       path, dstpath);
> +               return -1;
> +       }
> +
> +       remaining =3D strlen(path) - strlen(dstpath);
> +       memmove(path, path + strlen(dstpath), remaining);
> +
> +       /* strip any leading / in order to make it easier to concat. */
> +       while (*path =3D=3D '/') {
> +               if (remaining =3D=3D 0) {
> +                       fprintf(stderr, "you gave us a weird ass string\n=
");
> +                       return -1;
> +               }
> +               remaining--;
> +               memmove(path, path + 1, remaining);
> +       }
> +       path[remaining] =3D '\0';
> +       return 0;
> +}
> +
> +/*
> + * Dup a path, make sure there's a trailing '/' to make path concat easi=
er.
> + */
> +static char *pathdup(const char *orig)
> +{
> +       char *ret;
> +       size_t len =3D strlen(orig);
> +
> +       /* Easy path, we have a trailing '/'. */
> +       if (orig[len - 1] =3D=3D '/')
> +               return strdup(orig);
> +
> +       ret =3D malloc((len + 2) * sizeof(char));
> +       if (!ret)
> +               return ret;
> +
> +       memcpy(ret, orig, len);
> +       ret[len] =3D '/';
> +       len++;
> +       ret[len] =3D '\0';
> +       return ret;
> +}
> +
> +static char *get_relpath(int fd)
> +{
> +       char procfd_path[PATH_MAX];
> +       char abspath[PATH_MAX];
> +       ssize_t path_len;
> +       int ret;
> +
> +       /* readlink doesn't NULL terminate. */
> +       memset(abspath, 0, sizeof(abspath));
> +
> +       snprintf(procfd_path, sizeof(procfd_path), "/proc/self/fd/%d", fd=
);
> +       path_len =3D readlink(procfd_path, abspath, sizeof(abspath) - 1);
> +       if (path_len < 0) {
> +               perror("readlink");
> +               return NULL;
> +       }
> +
> +       ret =3D strip_dstpath(abspath);
> +       if (ret < 0)
> +               return NULL;
> +
> +       return strdup(abspath);
> +}
> +
> +static int copy_range(int src_fd, int fd, off_t offset, size_t count)
> +{
> +       off_t src_offset =3D offset;
> +       ssize_t copied;
> +
> +       if (use_sendfile)
> +               goto slow;
> +
> +       while ((copied =3D copy_file_range(src_fd, &src_offset, fd, &offs=
et,
> +                                        count, 0)) >=3D 0) {
> +               if (copied =3D=3D 0)
> +                       return 0;
> +
> +               count -=3D copied;
> +               if (count =3D=3D 0)
> +                       return 0;
> +       }
> +
> +       if (errno !=3D EXDEV) {
> +               perror("copy_file_range");
> +               return -1;
> +       }
> +       use_sendfile =3D true;
> +
> +slow:
> +       /* I love linux interfaces. */
> +       if (lseek(fd, offset, SEEK_SET) =3D=3D (off_t)-1) {
> +               perror("seeking");
> +               return -1;
> +       }
> +
> +       while ((copied =3D sendfile(fd, src_fd, &src_offset, count)) >=3D=
 0) {
> +               if (copied =3D=3D 0)
> +                       return 0;
> +
> +               count -=3D copied;
> +               if (count =3D=3D 0)
> +                       return 0;
> +       }
> +
> +       perror("sendfile");
> +       return -1;
> +}
> +
> +static int handle_event(int fanotify_fd, int fd, off_t offset, size_t co=
unt)
> +{
> +       char path[PATH_MAX];
> +       char *relpath __free(freep) =3D NULL;
> +       int src_fd __free(close_fd) =3D -1;
> +       off_t end =3D offset + count;
> +       blkcnt_t src_blocks;
> +       struct stat st;
> +
> +       relpath =3D get_relpath(fd);
> +       if (!relpath)
> +               return -1;
> +
> +       offset =3D round_down(offset, pagesize);
> +       end =3D round_up(end, pagesize);
> +       count =3D end - offset;
> +
> +       snprintf(path, sizeof(path), "%s%s", srcpath, relpath);
> +       src_fd =3D open(path, O_RDONLY);
> +       if (src_fd < 0) {
> +               fprintf(stderr, "srcpath %s relpath %s\n", srcpath, relpa=
th);
> +               fprintf(stderr, "error opening file %s: %s (%d)\n", path,=
 strerror(errno), errno);
> +               return -1;
> +       }
> +
> +       if (fstat(src_fd, &st)) {
> +               perror("src fd is fucked");
> +               return -1;
> +       }
> +
> +       src_blocks =3D st.st_blocks;
> +
> +       if (fstat(fd, &st)) {
> +               perror("fd is fucked");
> +               return -1;
> +       }
> +
> +       /*
> +        * If we are the same size or larger (which can happen if we copy=
 zero's
> +        * instead of inserting a hole) then just assume we're full.  Thi=
s is
> +        * approximation can fall over, but its good enough for a PoC.
> +        */
> +       if (st.st_blocks >=3D src_blocks) {
> +               int ret;
> +
> +               snprintf(path, sizeof(path), "%s%s", dstpath, relpath);
> +               ret =3D fanotify_mark(fanotify_fd, FAN_MARK_REMOVE,
> +                                   FAN_EVENTS, -1, path);
> +               if (ret < 0) {
> +                       /* We already removed the mark, carry on. */
> +                       if (errno =3D=3D ENOENT) {
> +                               errno =3D 0;
> +                               return 0;
> +                       }
> +                       perror("removing fanotify mark");
> +                       return -1;
> +               }
> +               return 0;
> +       }
> +
> +
> +       return copy_range(src_fd, fd, offset, count);
> +}
> +
> +static int handle_events(int fd)
> +{
> +       const struct fanotify_event_metadata *metadata;
> +       struct fanotify_event_metadata buf[200];
> +       ssize_t len;
> +       struct fanotify_response response;
> +       int ret =3D 0;
> +
> +       len =3D read(fd, (void *)buf, sizeof(buf));
> +       if (len <=3D 0 && errno !=3D EINTR) {
> +               perror("reading fanotify events");
> +               return -1;
> +       }
> +
> +       metadata =3D buf;
> +       while(FAN_EVENT_OK(metadata, len)) {
> +               off_t offset =3D 0;
> +               size_t count =3D 0;
> +
> +               if (metadata->vers !=3D FANOTIFY_METADATA_VERSION) {
> +                       fprintf(stderr, "invalid metadata version, have %=
d, expect %d\n",
> +                               metadata->vers, FANOTIFY_METADATA_VERSION=
);
> +                       return -1;
> +               }
> +               if (metadata->fd < 0) {
> +                       fprintf(stderr, "metadata fd is an error\n");
> +                       return -1;
> +               }
> +               if (!(metadata->mask & FAN_EVENTS)) {
> +                       fprintf(stderr, "metadata mask incorrect %llu\n",
> +                               metadata->mask);
> +                       return -1;
> +               }
> +
> +               /*
> +                * We have a specific range, load that instead of filling=
 the
> +                * entire file in.
> +                */
> +               if (metadata->event_len > FAN_EVENT_METADATA_LEN) {
> +                       const struct fanotify_event_info_range *range;
> +                       range =3D (const struct fanotify_event_info_range=
 *)(metadata + 1);
> +                       if (range->hdr.info_type =3D=3D FAN_EVENT_INFO_TY=
PE_RANGE) {
> +                               count =3D range->count;
> +                               offset =3D range->offset;
> +                               if (count =3D=3D 0) {
> +                                       ret =3D 0;
> +                                       goto next;
> +                               }
> +                       }
> +               }
> +
> +               /* We don't have a range, pre-fill the whole file. */
> +               if (count =3D=3D 0) {
> +                       struct stat st;
> +
> +                       if (fstat(metadata->fd, &st)) {
> +                               perror("stat() on opened file");
> +                               return -1;
> +                       }
> +
> +                       count =3D st.st_size;
> +               }
> +
> +               ret =3D handle_event(fd, metadata->fd, offset, count);
> +next:
> +               response.fd =3D metadata->fd;
> +               if (ret)
> +                       response.response =3D FAN_DENY_ERRNO(errno);
> +               else
> +                       response.response =3D FAN_ALLOW;
> +               write(fd, &response, sizeof(response));

This write() can fail if errno is not on the white list.
If you ignore this failure, the pre-content event will block.

> +               close(metadata->fd);
> +               metadata =3D FAN_EVENT_NEXT(metadata, len);
> +       }
> +
> +       return ret;
> +}
> +
> +static int add_marks(const char *src, int fanotify_fd)
> +{
> +       char *path __free(freep) =3D NULL;
> +       DIR *dir __free(close_dir) =3D NULL;
> +       size_t pathlen =3D strlen(src) + 256;
> +       struct dirent *dirent;
> +
> +       path =3D malloc(pathlen * sizeof(char));
> +       if (!path) {
> +               perror("allocating path buf");
> +               return -1;
> +       }
> +
> +       dir =3D opendir(src);
> +       if (!dir) {
> +               fprintf(stderr, "Couldn't open directory %s: %s (%d)\n",
> +                       src, strerror(errno), errno);
> +               return -1;
> +       }
> +
> +       errno =3D 0;
> +       while ((dirent =3D readdir(dir)) !=3D NULL) {
> +               int ret;
> +
> +               if (!strcmp(dirent->d_name, ".") ||
> +                   !strcmp(dirent->d_name, ".."))
> +                       continue;
> +
> +               if (dirent->d_type =3D=3D DT_DIR) {
> +                       snprintf(path, pathlen, "%s%s/", src, dirent->d_n=
ame);
> +                       ret =3D add_marks(path, fanotify_fd);
> +                       if (ret)
> +                               return ret;
> +               } else if (dirent->d_type =3D=3D DT_REG) {
> +                       ret =3D fanotify_mark(fanotify_fd, FAN_MARK_ADD,
> +                                           FAN_EVENTS, dirfd(dir),
> +                                           dirent->d_name);
> +                       if (ret < 0) {
> +                               perror("fanotify_mark");
> +                               return -1;
> +                       }
> +               }
> +               errno =3D 0;
> +       }
> +       return 0;
> +}
> +
> +static void usage(void)
> +{
> +       fprintf(stderr, "Usage: remote-fetch <src directory> <dest direct=
ory>\n");
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       int fd __free(close_fd) =3D -1;
> +       int dirfd __free(close_fd) =3D -1;
> +       int ret;
> +
> +       if (argc !=3D 3) {
> +               usage();
> +               return 1;
> +       }
> +
> +       pagesize =3D sysconf(_SC_PAGESIZE);
> +       if (pagesize < 0) {
> +               perror("sysconf");
> +               return 1;
> +       }
> +
> +       srcpath =3D pathdup(argv[1]);
> +       dstpath =3D pathdup(argv[2]);
> +       if (!srcpath || !dstpath) {
> +               perror("allocate paths");
> +               return 1;
> +       }
> +
> +       dirfd =3D open(dstpath, O_DIRECTORY | O_RDONLY);
> +       if (dirfd < 0) {
> +               perror("open dstpath");
> +               return 1;
> +       }
> +
> +       fd =3D fanotify_init(FAN_CLASS_PRE_CONTENT | FAN_UNLIMITED_MARKS,=
 O_WRONLY | O_LARGEFILE);
> +       if (fd < 0) {
> +               perror("fanotify_init");
> +               return 1;
> +       }
> +
> +       ret =3D add_marks(dstpath, fd);
> +       if (ret < 0)
> +               return 1;
> +
> +       for (;;) {
> +               ret =3D handle_events(fd);
> +               if (ret)
> +                       break;
> +       }
> +
> +       return (ret < 0) ? 1 : 0;
> +}
> diff --git a/tests/generic/800 b/tests/generic/800
> new file mode 100644
> index 00000000..08ac5b26
> --- /dev/null
> +++ b/tests/generic/800
> @@ -0,0 +1,68 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 800
> +#
> +# Validate the pre-content related fanotify features
> +#
> +# The mmap-verify pre-content tool generates a file and then validates t=
hat the
> +# pre-content watched directory properly fills it in with a mixture of p=
age
> +# faults and normal reads.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto fsnotify
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -rf $TEST_DIR/dst-$seq
> +       rm -rf $TEST_DIR/src-$seq
> +}
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_test_program "precontent/mmap-validate"
> +_require_test_program "precontent/populate"
> +_require_test_program "precontent/remote-fetch"
> +
> +dstdir=3D$TEST_DIR/dst-$seq
> +srcdir=3D$TEST_DIR/src-$seq
> +
> +POPULATE=3D$here/src/precontent/populate
> +REMOTE_FETCH=3D$here/src/precontent/remote-fetch
> +MMAP_VALIDATE=3D$here/src/precontent/mmap-validate
> +
> +mkdir $dstdir $srcdir

For tests on the test partition, should also cleanup
prior leftovers at the beginning of the test.

> +
> +# Generate the test file
> +$MMAP_VALIDATE create $srcdir/validate
> +
> +# Generate the stub file in the watch directory
> +$POPULATE $srcdir $dstdir
> +
> +# Start the remote watcher
> +$REMOTE_FETCH $srcdir $dstdir &
> +
> +FETCH_PID=3D$!
> +
> +# We may not support fanotify, give it a second to start and then make s=
ure the
> +# fetcher is running before we try to validate the buffer
> +sleep 1
> +
> +if ! ps -p $FETCH_PID > /dev/null
> +then
> +       _notrun "precontent watches not supported"

That's not so nice and prone to races.
Let's do a deterministic test for precontent support,
i.e. $here/src/precontent/test-support
or $REMOTE_FETCH - $dstdir
and abstract this test inside _require_fsnotify_precontent

Thanks,
Amir.

