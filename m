Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D06B4D0B80
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 23:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbiCGWxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 17:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiCGWx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EA0DBBA
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 14:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646693550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/Qcd2KUNkxujEc+525HTLxK0w0ZHSGaJPWrpj+hfIKQ=;
        b=G6uz8JIKlWHoMiWpzWX9jfiBTOUqnnaWrB2lecFfFWIsk7hvo1TZCLxz+y0JbalIaqTCVq
        yEhhXj7HbeMEYJ7dXV9WZrn+iBUkHwk+/5fPwjs9SpNvfzogGnthc0vM2VIAD4OBHelJyU
        bLRejxxhzFaeq7vgdxI7/fA3iiWt5NQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-KP9qxLSQN-uE--b7rhMqhQ-1; Mon, 07 Mar 2022 17:52:29 -0500
X-MC-Unique: KP9qxLSQN-uE--b7rhMqhQ-1
Received: by mail-wm1-f70.google.com with SMTP id 14-20020a05600c028e00b003897a4056e8so218235wmk.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Mar 2022 14:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/Qcd2KUNkxujEc+525HTLxK0w0ZHSGaJPWrpj+hfIKQ=;
        b=n7PFCF+inw0BXmekcTjsSyLfRd/0nwBzlPsx/j9Fhs3QcNMZxYif60Mu7oi/JDCyqP
         riIcnip6GGYNUMZVC7cuoCPXtx8/gIfMhihX/A68ssCRnNdeJaThDjdo/QQo7ZjbU4Ie
         hhQffiGkeKDCuqLV0nWG5bNt2zif7rZ3nCBLJFbQ82Srxd8z2nYK1XIhB1K2J19sdhkE
         hNbsFlPxtdvlbyPWCYnOfnVCQ4E0KnCOJcUNgRrXpZZI5QPUV0IkqKH+nV4NqYKDlyv6
         8dsJvgEX4rkRFXX7iHw9va4caD1J0vUpBAD7q3m33H6gNYBQzhw0k5/xAmmsQHJgl12Z
         4ZkA==
X-Gm-Message-State: AOAM531Zmsj4cxean9nfHIq5yu7kNxoxLRHmRpX4HJLYct44lBxzWpV+
        pE0BO2LO1kToeEzp9zc2fTLz0sRXPCCv9eEHpJ4+k71rThKjTY2lUmNi3mYuYFaJCxiYY7pQg2R
        VxWqjuwb8qU8itlMzA1t0q+KZfD//MqPdXnLIyBJD7A==
X-Received: by 2002:a05:6000:188f:b0:1f1:e5da:b116 with SMTP id a15-20020a056000188f00b001f1e5dab116mr8524973wri.467.1646693547790;
        Mon, 07 Mar 2022 14:52:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyq4ey+92ZSgSnJfgzPO459bGTsVM/CWO6mW9ykfCSQrbiHYMKTSuyjTOq9qpSQV1/PI9ieOplJOPuXavrzq0=
X-Received: by 2002:a05:6000:188f:b0:1f1:e5da:b116 with SMTP id
 a15-20020a056000188f00b001f1e5dab116mr8524954wri.467.1646693547537; Mon, 07
 Mar 2022 14:52:27 -0800 (PST)
MIME-Version: 1.0
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 7 Mar 2022 23:52:16 +0100
Message-ID: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
Subject: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-s390@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

since the page fault disabling changes from v5.15, gfs2 is in trouble
and I'm out of ideas; maybe one of you can help.

The test case in question writes large chunks of data into mmapped
memory (between 400 MiB and 797 MiB) and then reads that data back in
in a single read system call. With those large reads, we end up in a
tight loop in gfs2_file_read_iter() on s390x:

After generic_file_read_iter() returns a short or empty read, we fault
in some pages with fault_in_iov_iter_writeable(). This succeeds, but
the next call to generic_file_read_iter() returns -EFAULT and we're
not making any progress.

The problem starts when the system runs low on memory and the
read_fault and read_fault_race numbers suddenly shoot up (1 second
sampling rate):

# ./runhang /mnt/scratch/foo
swpd free buff cache read_fault(*) read_fault_race(*)
read_lock_stolen(*) min_flt maj_flt
0 2610408 6352 470064 0 0 0 654 76064
0 2412172 6352 667352 0 0 0 0 49276
0 1887404 6224 1080936 0 0 0 956 103586
0 1692324 6224 1275004 0 0 0 0 48400
0 1350184 6224 1460968 0 0 0 962 46400
0 1134788 6224 1675756 0 0 0 0 53600
0 967088 6224 1842556 0 0 0 0 41600
0 803168 6224 2006044 0 0 0 0 40000
0 714448 6096 2157080 0 0 0 862 38704
0 502388 6096 2367356 0 0 0 0 52476
0 287008 6096 2582648 0 0 0 0 53680
0 532888 6096 2748832 0 0 0 278 41471
0 32344 5424 2948440 0 0 0 440 63721
0 44812 4848 2946208 0 0 0 1 45344
0 36080 4332 2954440 0 0 0 0 37114
0 44316 1060 2779684 0 0 0 42375 35251
0 64276 1060 2759572 0 0 0 0 32952
0 57564 1060 2762912 0 0 0 0 44036
0 33424 1060 2785804 0 0 0 171 44036
0 69752 828 2747364 0 0 0 176 38201
0 69652 828 2747456 2454899 2454898 0 0 0
0 69932 828 2747456 1977938 1977938 0 0 0
0 69972 828 2747456 2010242 2010242 0 0 0
0 70004 828 2747456 1977223 1977223 0 0 0
0 69784 828 2747456 2004963 2004963 0 0 0
0 69560 828 2747456 2020472 2020472 0 0 0
0 70144 828 2747456 2019310 2019310 0 0 0
0 69440 828 2748256 1965665 1965665 0 0 0
0 69200 828 2748388 2008175 2008175 0 0 0
0 69000 828 2748388 2010383 2010383 0 0 0
0 69052 828 2748388 2011591 2011591 0 0 0
0 68588 828 2748388 2017224 2017224 0 0 0
0 68888 828 2748388 2015931 2015931 0 0 0
0 69156 828 2748388 1995175 1995175 0 0 0
0 69196 828 2748388 2009583 2009583 0 0 0
0 68484 828 2748388 2014036 2014036 0 0 0
0 69032 828 2748388 2004889 2004889 0 0 0

Here, read_fault is the number of fault_in_iov_iter_writeable calls in
gfs2_file_read_iter,
read_fault_race is the number of unsuccessful generic_file_read_iter
calls after successful fault_in_iov_iter_writeable calls, and
read_lock_stolen is the number of times the glock got stolen.

The hang goes away with a chunk size between 4 MiB and 8 MiB. This
currently reproduces on s390x, but not on x86_64 or ppc64le. In all
cases, there are about 4G of memory, no swap, and 4 CPUs. It's not
clear if btrfs is affected by this as well.

There's a bug in the window size logic in gfs2's
should_fault_in_pages(), so the window currently always ends up being
one page. We have a fix for that queued for the next merge window
(https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?h=for-next&id=cf8da18f6c4d),
but the hang reproduces independent of that fix.

Any ideas?

Thanks a lot,
Andreas


hang.c
======
#define _XOPEN_SOURCE 600  /* posix_memalign() */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <err.h>
#include <sys/mman.h>

#define MiB (1ULL << 20)

off_t filesize = 21061 * MiB;
size_t mintrans = 400 * MiB;
size_t maxtrans = 797 * MiB;

const char *filename;
unsigned int seed;

static void usage(char *progname)
{
    fprintf(stderr,
        "Usage: %s [-S seed] [-z filesize] [-t mintrans] [-T maxtrans]
{filename}\n",
        progname);
}

static void do_mmwrite(int fd, void *addr, off_t offset, size_t xferlen)
{
    void *buf;
    size_t count = 0;
    ssize_t ret;

    printf("%lu %zu\n", offset, xferlen);

    errno = posix_memalign(&buf, 512, xferlen);
    if (errno)
        err(1, "posix_memalign");

    memset(buf, (char)offset, xferlen);
    memcpy(addr + offset, buf, xferlen);

    if (lseek(fd, offset, SEEK_SET) == -1)
        err(1, "%s", filename);

    do {
        ret = read(fd, buf + count, xferlen - count);
        if (ret <= 0) {
            if (ret == -EINTR) {
                warn("read interrupted by signal");
                continue;
            }
            break;
        }
        if (ret != xferlen - count)
            warn("short read");
        count += ret;
    } while (count != xferlen);

    if (ret < 0)
        err(1, "%s", filename);
    if (ret == 0 && offset + xferlen != filesize)
        warn("read returned 0 before EOF");

    free(buf);
}

int main(int argc, char *argv[])
{
    int c;
    int fd;
    void *addr;

    seed = getpid();

    while ((c = getopt(argc, argv, "S:z:t:T:h")) != -1) {
        switch(c) {
        case 'S':
            seed = atoi(optarg);
            break;
        case 'z':
            filesize = atoi(optarg) * MiB;
            break;
        case 't':
            mintrans = atoi(optarg) * MiB;
            break;
        case 'T':
            maxtrans = atoi(optarg) * MiB;
            break;
        case '?':
            usage(argv[0]);
            exit(2);
        case 'h':
            usage(argv[0]);
            exit(0);
        }
    }

    if (optind + 1 != argc) {
        usage(argv[0]);
        exit(2);
    }
    filename = argv[optind];

    srandom(seed);

    fd = open(filename, O_CREAT | O_RDWR | O_TRUNC, 0666);
    if (fd == -1)
        err(1, "%s", filename);

    if (lseek(fd, filesize - 1, SEEK_SET) == -1)
        err(1, "%s", filename);
    if (write(fd, "X", 1) != 1)
        err(1, "%s", filename);

    addr = mmap(NULL, filesize, PROT_WRITE, MAP_SHARED, fd, 0);
    if (addr == MAP_FAILED)
        err(1, "mmap");

    for(;;) {
        off_t offset = 0;

        for (;;) {
            size_t xferlen = mintrans;

            if (mintrans != maxtrans)
                xferlen = mintrans +
                      (random() % (maxtrans - mintrans));

            if (offset + xferlen > filesize)
                xferlen = filesize - offset;

            do_mmwrite(fd, addr, offset, xferlen);

            offset += xferlen;
            if (offset >= filesize)
                offset = 0;
        }
    }

    munmap(addr, filesize);
    close(fd);
    unlink(filename);

    return 0;
}


runhang
=======
#! /bin/bash

${0%/*}/hang "$@" > /dev/null &
STATUS=$?
HANGPID=$!
[ $STATUS  = 0 ] || exit 1

trap "kill $HANGPID" EXIT

sample() {
    local -a stats

    set -- $(grep ^read_iter /sys/kernel/debug/gfs2/*/fault_stats)
    shift
    stats=("$@")
    set -- $(cat /proc/$HANGPID/stat)
    stats=("${stats[@]}" "${10}" "${12}")
    echo "${stats[@]}"
}

meminfo() {
    awk '
    /^'"$1"'/ { print $2 }
    ' /proc/meminfo
}

echo swpd free buff cache read_fault read_fault_race read_lock_stolen
min_flt maj_flt
old=( $(sample) )
while :; do
    sleep 1
    new=( $(sample) )
    set --
    for ((n=0; n<${#old[@]}; n++)); do
    set -- "$@" $((${new[n]} - ${old[n]}))
    done
    set -- $(meminfo SwapCached) $(meminfo MemFree) $(meminfo Buffers)
$(meminfo Cached) "$@"
    echo "$@"
    old=( "${new[@]}" )
done

