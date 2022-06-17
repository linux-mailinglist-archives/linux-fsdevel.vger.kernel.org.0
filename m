Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D2254F192
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380453AbiFQHKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 03:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380451AbiFQHKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:10:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B8664BDF;
        Fri, 17 Jun 2022 00:10:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso3428826pja.2;
        Fri, 17 Jun 2022 00:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:organization;
        bh=sbdL7NYIgnZykcubj6eIQhN+9HQk/gmt9kOuPLu+onM=;
        b=nj/oDV5XCpmplWioG3yHC72l+Bn13A1Qawk/oNQcQ/C1pwBio+CqvE8mjnd+CcHYO7
         v5cc4XjTI3ZaA8uuSDxN9J00qKyOHuUONLDtBQnSjs5NGj+duMKlpxGg0rlwqKDF9Crv
         8+K6rS2G68Iem5xyuvqZI1yNO8wncZNyuWttfaAsIwXANDGnQL6g/q361Hn2ibmhYV+S
         j81Bjo+Iwmp5Qnsp1RSh+5or64D3yn+WB/45foZwefpgVjTmEzN1MTmuE+oRWlC9guu0
         5wi1NeCthnXel824DRxlu8pHl+SCSFvGRI4LRsg9jodj62MEHS25zx9W9GzppslQ3Uxy
         LLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization;
        bh=sbdL7NYIgnZykcubj6eIQhN+9HQk/gmt9kOuPLu+onM=;
        b=XMVIsujewrxdT5qgkZ2OFljPhPYfy6BmQ9wjW+JsxzoQHamBS6h8TS35T6wAnY2loG
         NarDgC3o3mQkEtufu0GrcIeqC56+L0U8JA9q+isckAKD1Ejvzkz+PMZfZpu43kZ0LEh9
         RjkFjp07JYr7fm7DCzUoF5qRjBxN691l6y0p7MeQdN4qC8MZxPc57OzZQEa196dstJLB
         vagtjJB+Dep9FophXemkFH6OgsAJ/cNvcE/TJ0IsznlAI09qj1bOThRMTwzItMwM6nZ2
         Ph8/aYEavL6AWBwY7Y5ISK4PUspBbwh1Oqq0KUjHUa6AYS5/oiM5oYyv6zIimQgkk+L9
         fuvA==
X-Gm-Message-State: AJIora8AT/24SWtjB7lyOQWviSDitM7mZ2zhw1xWmzsguqb3N3F59lSY
        swE4BYQ3Cv41adyEO28EsqU=
X-Google-Smtp-Source: AGRyM1s/bzAGE/2G0ILO2y231zBgHE99E7Nyl6UGhrpaL8CkJxi5htH1K+ccFlUEtMvwQQK1NDUc7w==
X-Received: by 2002:a17:903:32d1:b0:169:6ed:afa5 with SMTP id i17-20020a17090332d100b0016906edafa5mr6239908plr.31.1655449845852;
        Fri, 17 Jun 2022 00:10:45 -0700 (PDT)
Received: from localhost.localdomain ([219.91.170.210])
        by smtp.googlemail.com with ESMTPSA id d6-20020a170902654600b00163c0a1f718sm2770025pln.303.2022.06.17.00.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 00:10:45 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com
Subject: [PATCH v5 0/1] FUSE: Allow non-extending parallel direct writes
Date:   Fri, 17 Jun 2022 12:40:26 +0530
Message-Id: <20220617071027.6569-1-dharamhans87@gmail.com>
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
USER space fuse implementations/file size issues/partial write
failures.

This patch allows parallel writes to proceed on the same file by
holding shared lock on the non-extending writes and exlusive lock
on extending writes.

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

 fs/fuse/file.c            | 43 ++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/fuse.h |  2 ++
 2 files changed, 42 insertions(+), 3 deletions(-)

---

v5:
   - Removed retry label.
   - Renamed feaure flag as suggested
   - Updated commit message to reflect more precisely why exclusive lock needed.

v4: Handled the case when file size can get reduced after the check but
     before we acquire the shared lock.

v3: Addressed all comments.

---
