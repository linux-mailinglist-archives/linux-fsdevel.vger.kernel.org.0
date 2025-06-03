Return-Path: <linux-fsdevel+bounces-50417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16CEACC013
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 08:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E6E16F38D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 06:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412261F63D9;
	Tue,  3 Jun 2025 06:15:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F71F03D7
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748931306; cv=none; b=TwJTJR4uqLfq03SnIzYYiaAErlpeWjU4iHZSFLIN2GW/C5OSoTWv1IscE3vM25j678cJI5mKk8NzBrhu4iWtnYIRrWr2ubHz5v6buHZiGo6kwBjLUM8pUV10HbhOHCKTZgjGoddfl+lPTp71Y/Zw7K8vliuqp3XUicl+UwNBDXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748931306; c=relaxed/simple;
	bh=8P1TCudIhUbWXUCNl5rslRMnZ86YaeuubRacDn/MwMg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GZIN+tWzFmbHL1tfD4bX9NZGUW8aOt2qYHLz1huAd0SsMgwhK9MfxmWZRFRt8M0+qUHoOseNZ4rdUtOzKMicUY5ZKxz6FjCALMw27XLI/F/fvWnk9VT1CxC70Po337uzlmAw789d43PjNM6MbKoTinXblNuQ1TggMkRI+AfOAH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; arc=none smtp.client-ip=202.120.2.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 95770102157DC;
	Tue,  3 Jun 2025 14:05:12 +0800 (CST)
Received: from nixos. (unknown [10.181.220.127])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 6C96637C935;
	Tue,  3 Jun 2025 14:05:12 +0800 (CST)
Date: Tue, 3 Jun 2025 14:05:11 +0800
From: Haoran Zhu <zhr1502@sjtu.edu.cn>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>
Subject: [Question] mmap_miss not increasing in mmap random reads
Message-ID: <aD6Ql3KA6u9B58lg@nixos.>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi all,

While examining mm/filemap.c, I noticed that file->f_ra.mmap_miss does not increase as expected under mmap-based random read workloads, which prevents readahead from being disabled—even when it's clearly ineffective.

Test case: 4GB file mmap'd and randomly accessed in a KVM guest with 2GB RAM. See benchmark code attached at the end. I used the following bpftrace to monitor readahead activity:

    kfunc:vmlinux:do_page_cache_ra {
        printf("size: %d start: %d mmap_miss: %d from %s\n",
               args->ractl->file->f_ra.size,
               args->ractl->file->f_ra.start,
               args->ractl->file->f_ra.mmap_miss,
               comm);
    }

The result is that mmap_miss remains low, and readahead remains enabled. From filemap_map_pages(), this appears to be due to the logic in mm/filemap.c:filemap_map_pages that treats the surrounding folios of a faulted-in page as asynchronous hits and subtracts them from mmap_miss:

    mmap_miss_saved = READ_ONCE(file->f_ra.mmap_miss);
    if (mmap_miss >= mmap_miss_saved)
        WRITE_ONCE(file->f_ra.mmap_miss, 0);
    else
        WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss_saved - mmap_miss);

This suppresses mmap_miss growth even when faults are clearly synchronous. I commented out the above block, re-run the test and saw the benchmark time drop from ~6200 ms to ~1500 ms, indicating that readahead was being wrongly retained.

Jan Kara previously mentioned a similar issue in [1]:

> I see, OK. But that's a (longstanding) bug in how mmap_miss is handled. Can
> you please test whether attached patches fix the trashing for you? At least
> now I can see mmap_miss properly increments when we are hitting uncached
> pages...

[1] https://lore.kernel.org/all/20240201173130.frpaqpy7iyzias5j@quack3/

So my questions are:
1. Is this mmap_miss suppression intentional?
2. Was the design intended to avoid false positives for disabling readahead?
3. Would it make sense to reclassify the "asynchronous hits" in filemap_map_pages() to exclude those resulting directly from the current fault?

Benchmark below.

    #define _GNU_SOURCE
    #include <stdio.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <sys/mman.h>
    #include <stdint.h>
    #include <sys/types.h>
    #include <sys/stat.h>
    #include <fcntl.h>
    #include <errno.h>
    #include <time.h>
    #include <string.h>

    #define PAGE_SIZE 4096

    void clear_page_cache() {
        sync();
        int fd = open("/proc/sys/vm/drop_caches", O_WRONLY);
        if (fd == -1) {
            perror("open");
            return;
        }
        if (write(fd, "3\n", 2) == -1) {
            perror("write");
        }
        close(fd);
    }

    void rand_read(const char *memblock, uint64_t size, uint64_t nr) {
        for (uint64_t i = 0; i < nr; i++) {
            uint64_t pos = ((uint64_t)rand()) * rand() % size;
            if (memblock[pos] == '7') printf("Magic number!\n");
        }
    }

    long long get_time_ms() {
        struct timespec ts;
        clock_gettime(CLOCK_MONOTONIC, &ts);
        return (long long)ts.tv_sec * 1000 + ts.tv_nsec / 1000000;
    }

    int main(int argc, char *argv[]) {
        if (argc < 2) {
            fprintf(stderr, "Usage: %s <filename> [num_accesses]\n", argv[0]);
            return 1;
        }

        int fd = open(argv[1], O_RDONLY);
        if (fd == -1) {
            perror("open file");
            return 1;
        }

        struct stat sb;
        fstat(fd, &sb);

        const char *memblock = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
        if (memblock == MAP_FAILED) {
            perror("mmap");
            return 1;
        }

        uint64_t nr_access = (argc > 2) ? strtoull(argv[2], NULL, 10) : (512 * 1024);

        clear_page_cache();

        long long start = get_time_ms();
        rand_read(memblock, sb.st_size, nr_access);
        long long end = get_time_ms();

        printf("Rand Read Time: %lldms\n", end - start);
        return 0;
    }

Reproduction steps:
1. save the above code as randread.c
2. # gcc -O2 -o randread randread.c
3. # fallocate -l 4G testfile
4. # ./randread testfile 524288
5. Example output:

    Rand Read Time: 1400ms

Thanks,
Haoran Zhu

