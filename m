Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D003052E3D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 06:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbiETEfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 00:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbiETEe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 00:34:58 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84F65D12;
        Thu, 19 May 2022 21:34:57 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id a38so3902638pgl.9;
        Thu, 19 May 2022 21:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:organization;
        bh=iwUkCEEjZUQP1swWe89Mjw7ZeFhvImaoHBlHX8r23QA=;
        b=NIL5u3ALYSKv4zCUFAC7T4/V7zPXn9Bm+/YII2HdBzTM5KpTyq/TB9ZVkS5v96ZuqE
         kPEcFn4SQL6hVR2GqpEs4YGj25leuH2mTamDczceG6aD91Z+X7aR4Dp96FXAhQT1tZ4c
         /nOUcL9UEN/i0Qr7Gn8+/n+M5wnJwuhZBz4tKX2b8lVqGKSErb8DwAARSRVd5yZX9a7Q
         C5q6k1rqH4jPEm3MQswlOhQS0BbAPjjz97QZfKE/8OKTObebzDxkCTOkCSmuPROWTtkw
         WeguErFVnSChMpoloVI00dTjczpQ7JbTTEEtlRuyw3AugEhFoCrb6/BdaHkLg8fQdsSD
         HMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization;
        bh=iwUkCEEjZUQP1swWe89Mjw7ZeFhvImaoHBlHX8r23QA=;
        b=sCIiGiGAHr+lGbtE2akcGwVLqN0GlTfzXoXPJQxz4VLb9riQFpl4gG0eXVC5371FoS
         SwR2qK/vOS+GzcDRh+xwP9QKtXE3KtLr08zx62DuZAhVhSq2f+Nm6x0UfjzDX3VnGM1o
         LkjbvVmryhpigX9pvl0GffaNAqskPt+x278y8fwlmvXUVOfDRC8k3tj6kcSUWdn9TEze
         S2sLZEDMH7budv22HGzPaJJwWekGdSk6ivx9w5lkOFh40Hn0eAH6wN5zEsSQVOt0685J
         gCoTGyQRSxrVhgdz9jTKPuuzONcjL039/ojIJ/dpvAqXKsWhuloihFEDnOCVHBrmbuE7
         +RFg==
X-Gm-Message-State: AOAM532fdFICXRL3fa0fR4xG/ic0+NKgMgiLWVlzzQ4g+Mo0J4LVcDMi
        KpE9YgrrRTCxBtxyAN85VJk=
X-Google-Smtp-Source: ABdhPJxewb7FFjEEtyeAV3CmSKl4ml0QEBkZHs5+wNxYUe9uXYydjCTBKDupQEk5rI2uuV6h2YLSQA==
X-Received: by 2002:a63:ec11:0:b0:3f6:5842:df8f with SMTP id j17-20020a63ec11000000b003f65842df8fmr3577505pgh.288.1653021296847;
        Thu, 19 May 2022 21:34:56 -0700 (PDT)
Received: from localhost.localdomain ([123.201.215.11])
        by smtp.googlemail.com with ESMTPSA id t1-20020a17090a024100b001d952b8f728sm724748pje.2.2022.05.19.21.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 21:34:56 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com
Subject: [PATCH v3 0/1] FUSE: Allow non-extending parallel direct writes
Date:   Fri, 20 May 2022 10:04:42 +0530
Message-Id: <20220520043443.17439-1-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
Organization: DDN STORAGE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is observed that currently in Fuse, for direct writes, we hold 
inode lock for the full duration of the request. As a result, 
only one direct write request can proceed on the same file. This, 
I think is due to various reasons such as serialization needed by 
USER space fuse implementations/file size issues/write failures.

This patch allows parallel writes to proceed on the same file by
by holding shared lock on the non-extending writes and exlusive
lock on extending writes.

For measuring performance, I carried out test on these 
changes over example/passthrough.c (part of libfuse) by setting 
direct-io and parallel_direct_writes flags on the file.
 
Note that we disabled write to underlying file system from passthrough 
as we wanted to check gain for Fuse only. Fio was used to test
the impact of these changes on File-per-job and Single shared File. 
CPU binding was performed on passthrough process only.

Job file for SSF:
[global]
directory=/tmp/dest
filename=ssf
size=100g
blocksize=1m
ioengine=sync
group_reporting=1
fallocate=none
runtime=60
stonewall

[write]
rw=randwrite:256
rw_sequencer=sequential
fsync_on_close=1


Job file for file-per-job:
[sequential-write]
rw=write
size=100G
directory=/tmp/dest/
group_reporting
name=sequential-write-direct
bs=1M
runtime=60


Results:

unpatched=================

File  per job


Fri May  6 09:36:52 EDT 2022
numjobs: 1  WRITE: bw=3441MiB/s (3608MB/s), 3441MiB/s-3441MiB/s (3608MB/s-3608MB/s), io=100GiB (107GB), run=29762-29762msec
numjobs: 2  WRITE: bw=8174MiB/s (8571MB/s), 8174MiB/s-8174MiB/s (8571MB/s-8571MB/s), io=200GiB (215GB), run=25054-25054msec
numjobs: 4  WRITE: bw=14.9GiB/s (15.0GB/s), 14.9GiB/s-14.9GiB/s (15.0GB/s-15.0GB/s), io=400GiB (429GB), run=26900-26900msec
numjobs: 8  WRITE: bw=23.4GiB/s (25.2GB/s), 23.4GiB/s-23.4GiB/s (25.2GB/s-25.2GB/s), io=800GiB (859GB), run=34115-34115msec
numjobs: 16  WRITE: bw=24.5GiB/s (26.3GB/s), 24.5GiB/s-24.5GiB/s (26.3GB/s-26.3GB/s), io=1469GiB (1577GB), run=60001-60001msec
numjobs: 32  WRITE: bw=20.5GiB/s (21.0GB/s), 20.5GiB/s-20.5GiB/s (21.0GB/s-21.0GB/s), io=1229GiB (1320GB), run=60003-60003msec


SSF

Fri May  6 09:46:38 EDT 2022
numjobs: 1  WRITE: bw=3624MiB/s (3800MB/s), 3624MiB/s-3624MiB/s (3800MB/s-3800MB/s), io=100GiB (107GB), run=28258-28258msec
numjobs: 2  WRITE: bw=5801MiB/s (6083MB/s), 5801MiB/s-5801MiB/s (6083MB/s-6083MB/s), io=200GiB (215GB), run=35302-35302msec
numjobs: 4  WRITE: bw=4794MiB/s (5027MB/s), 4794MiB/s-4794MiB/s (5027MB/s-5027MB/s), io=281GiB (302GB), run=60001-60001msec
numjobs: 8  WRITE: bw=3946MiB/s (4137MB/s), 3946MiB/s-3946MiB/s (4137MB/s-4137MB/s), io=231GiB (248GB), run=60003-60003msec
numjobs: 16  WRITE: bw=4040MiB/s (4236MB/s), 4040MiB/s-4040MiB/s (4236MB/s-4236MB/s), io=237GiB (254GB), run=60006-60006msec
numjobs: 32  WRITE: bw=2822MiB/s (2959MB/s), 2822MiB/s-2822MiB/s (2959MB/s-2959MB/s), io=165GiB (178GB), run=60013-60013msec


Patched=====

File per job

Fri May  6 10:05:46 EDT 2022
numjobs: 1  WRITE: bw=3193MiB/s (3348MB/s), 3193MiB/s-3193MiB/s (3348MB/s-3348MB/s), io=100GiB (107GB), run=32068-32068msec
numjobs: 2  WRITE: bw=9084MiB/s (9525MB/s), 9084MiB/s-9084MiB/s (9525MB/s-9525MB/s), io=200GiB (215GB), run=22545-22545msec
numjobs: 4  WRITE: bw=14.8GiB/s (15.9GB/s), 14.8GiB/s-14.8GiB/s (15.9GB/s-15.9GB/s), io=400GiB (429GB), run=26986-26986msec
numjobs: 8  WRITE: bw=24.5GiB/s (26.3GB/s), 24.5GiB/s-24.5GiB/s (26.3GB/s-26.3GB/s), io=800GiB (859GB), run=32624-32624msec
numjobs: 16  WRITE: bw=24.2GiB/s (25.0GB/s), 24.2GiB/s-24.2GiB/s (25.0GB/s-25.0GB/s), io=1451GiB (1558GB), run=60001-60001msec
numjobs: 32  WRITE: bw=19.3GiB/s (20.8GB/s), 19.3GiB/s-19.3GiB/s (20.8GB/s-20.8GB/s), io=1160GiB (1245GB), run=60002-60002msec


SSF

Fri May  6 09:58:33 EDT 2022
numjobs: 1  WRITE: bw=3137MiB/s (3289MB/s), 3137MiB/s-3137MiB/s (3289MB/s-3289MB/s), io=100GiB (107GB), run=32646-32646msec
numjobs: 2  WRITE: bw=7736MiB/s (8111MB/s), 7736MiB/s-7736MiB/s (8111MB/s-8111MB/s), io=200GiB (215GB), run=26475-26475msec
numjobs: 4  WRITE: bw=14.4GiB/s (15.4GB/s), 14.4GiB/s-14.4GiB/s (15.4GB/s-15.4GB/s), io=400GiB (429GB), run=27869-27869msec
numjobs: 8  WRITE: bw=22.6GiB/s (24.3GB/s), 22.6GiB/s-22.6GiB/s (24.3GB/s-24.3GB/s), io=800GiB (859GB), run=35340-35340msec
numjobs: 16  WRITE: bw=25.6GiB/s (27.5GB/s), 25.6GiB/s-25.6GiB/s (27.5GB/s-27.5GB/s), io=1535GiB (1648GB), run=60001-60001msec
numjobs: 32  WRITE: bw=20.2GiB/s (21.7GB/s), 20.2GiB/s-20.2GiB/s (21.7GB/s-21.7GB/s), io=1211GiB (1300GB), run=60003-60003msec



SSF gain in percentage:-
For 1 fio thread: +0%
For 2 fio threads: +0% 
For 4 fio threads: +42%
For 8 fio threads: +246.8%
For 16 fio threads: +549%
For 32 fio threads: +630.33%


Dharmendra Singh (1):
  Allow non-extending parallel direct writes on the same file.

 fs/fuse/file.c            | 33 ++++++++++++++++++++++++++++++---
 include/uapi/linux/fuse.h |  2 ++
 2 files changed, 32 insertions(+), 3 deletions(-)

---

v3: Addressed all comments.

---
