Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083604F8E51
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 08:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiDHGUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 02:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiDHGUu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:20:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C054B5577F;
        Thu,  7 Apr 2022 23:18:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso6901293wme.5;
        Thu, 07 Apr 2022 23:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:organization;
        bh=MGPeQ2SfsVkzxRg2OtmpcXO1w92uEn/ZgH5z4M+Va5E=;
        b=UCp/UwJCNdP1tiYQxb/D+71MQVWywUzm/lPbommQF0Fzvu7gT9NvBTL4Y8k5wsmcrj
         7AZ2u3x4aOncieRK9h39xTDHPll8uhwaNbSnJupOVUpmS+tSptAufkwEGrvC6MJ6qcKb
         tA0zf2FPgDSxQafIu04/J7eA2U8bGuS8jCJ6+OqxYnn/g93h6HRgKr/v3eOfbnmK3MEe
         zbId4CYmHUZmdwmZn7xsHcd8NFhhXHC1nbKw4Om6/uBWyuRS8cyXIdFaGd/D1DCJXtc5
         NTbgjB15Zm1La/Ri97qDxdnetR3+oXuC63/FjPJLaf050mIyuloPjFTALKpipSHubqts
         L9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization;
        bh=MGPeQ2SfsVkzxRg2OtmpcXO1w92uEn/ZgH5z4M+Va5E=;
        b=p5T94hLPiflalB3RFAHn1cCt1AZlLpfJvaohrY7ivFFQPiuG4f8EY4ttL1aAONSSM1
         5nvRgwtRkkStR4D2wC94HsdI83TzTx96JZifDj7uzdWWJ0FMIHcaAv7THVfIUywHLQoG
         hEvOlkedonMe5LStRQyq3Fdggp71A8mpqQcPcihLpUKjHPLL2IjawFAa+xiD3W/69Pjm
         At6FYlpc+sDhjifko518xoywHGvWTnxyUFbXPSHC5gBB8QeOkFqvlkdjBygyH85o9rpp
         Qz4sfUGWH+ar8rHZDo7fpkP0z3TrytzWnpS6X3jFLKSGVNjmKEQYZ48HPhZSZG39BjPy
         0ieA==
X-Gm-Message-State: AOAM532/fWF2+tRNJWmd7chGJNn4YKXts2Zb3ZTlqJr2M0alhQ26WHXV
        PUPuZ0jVBohQubxb95vJakw=
X-Google-Smtp-Source: ABdhPJykYD64nImYEV6FaJZYNjiI07B2I2AWIYjmB2oxDk5L7vHrEhwLq6ITfqFOfyDFbuR0jTo23g==
X-Received: by 2002:a05:600c:3009:b0:381:194a:8cb5 with SMTP id j9-20020a05600c300900b00381194a8cb5mr16035788wmh.43.1649398726059;
        Thu, 07 Apr 2022 23:18:46 -0700 (PDT)
Received: from DDNINR0360.datadirect.datadirectnet.com ([123.201.116.157])
        by smtp.googlemail.com with ESMTPSA id k13-20020a7bc40d000000b0038e9edf5e73sm1051695wmi.3.2022.04.07.23.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 23:18:45 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     bschubert@ddn.com, miklos@szeredi.hu
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] FUSE: Parallel direct writes on the same file
Date:   Fri,  8 Apr 2022 11:48:08 +0530
Message-Id: <20220408061809.12324-1-dharamhans87@gmail.com>
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
I think is kept the way it is due to the reason that many FUSE 
user space implementations rely on this serialization for 
cache/data integrity which is fine. But it is hurting badly FUSE 
implementations which have their own mechanism of keeping data/cache 
integrity and can handle parallel writes on same file/region.

This patch allows parallel writes to proceed on the same file by
by not holding the inode lock all the time but only acquire it 
when needed to update certain fields. Default behaviour remains the
same i.e one direct write at a time.

I carried out performance test on these changes over example/passthrough
(part of libfuse) by setting direct-io and parallel_direct_writes flags
on the file. 
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


RESULT:

Unpatched:-

Single shared file:
numjobs: 1  WRITE: bw=2679MiB/s (2809MB/s), 2679MiB/s-2679MiB/s (2809MB/s-2809MB/s), io=100GiB (107GB), run=38220-38220msec
numjobs: 2  WRITE: bw=4902MiB/s (5140MB/s), 4902MiB/s-4902MiB/s (5140MB/s-5140MB/s), io=200GiB (215GB), run=41778-41778msec
numjobs: 4  WRITE: bw=2756MiB/s (2890MB/s), 2756MiB/s-2756MiB/s (2890MB/s-2890MB/s), io=161GiB (173GB), run=60002-60002msec
numjobs: 8  WRITE: bw=4444MiB/s (4659MB/s), 4444MiB/s-4444MiB/s (4659MB/s-4659MB/s), io=260GiB (280GB), run=60003-60003msec
numjobs: 16  WRITE: bw=3045MiB/s (3192MB/s), 3045MiB/s-3045MiB/s (3192MB/s-3192MB/s), io=178GiB (192GB), run=60006-60006msec
numjobs: 32  WRITE: bw=2977MiB/s (3122MB/s), 2977MiB/s-2977MiB/s (3122MB/s-3122MB/s), io=174GiB (187GB), run=60014-60014msec

File per job:
numjobs: 1  WRITE: bw=3236MiB/s (3393MB/s), 3236MiB/s-3236MiB/s (3393MB/s-3393MB/s), io=100GiB (107GB), run=31647-31647msec
numjobs: 2  WRITE: bw=8087MiB/s (8480MB/s), 8087MiB/s-8087MiB/s (8480MB/s-8480MB/s), io=200GiB (215GB), run=25324-25324msec
numjobs: 4  WRITE: bw=13.8GiB/s (14.8GB/s), 13.8GiB/s-13.8GiB/s (14.8GB/s-14.8GB/s), io=400GiB (429GB), run=28951-28951msec
numjobs: 8  WRITE: bw=20.4GiB/s (21.9GB/s), 20.4GiB/s-20.4GiB/s (21.9GB/s-21.9GB/s), io=800GiB (859GB), run=39266-39266msec
numjobs: 16  WRITE: bw=24.4GiB/s (26.2GB/s), 24.4GiB/s-24.4GiB/s (26.2GB/s-26.2GB/s), io=1462GiB (1569GB), run=60001-60001msec
numjobs: 32  WRITE: bw=20.1GiB/s (21.6GB/s), 20.1GiB/s-20.1GiB/s (21.6GB/s-21.6GB/s), io=1205GiB (1294GB), run=60002-60002msec



Patched:-

Single shared file:
numjobs: 1  WRITE: bw=2674MiB/s (2804MB/s), 2674MiB/s-2674MiB/s (2804MB/s-2804MB/s), io=100GiB (107GB), run=38288-38288msec
numjobs: 2  WRITE: bw=7945MiB/s (8331MB/s), 7945MiB/s-7945MiB/s (8331MB/s-8331MB/s), io=200GiB (215GB), run=25777-25777msec
numjobs: 4  WRITE: bw=14.3GiB/s (15.4GB/s), 14.3GiB/s-14.3GiB/s (15.4GB/s-15.4GB/s), io=400GiB (429GB), run=27935-27935msec
numjobs: 8  WRITE: bw=22.5GiB/s (24.2GB/s), 22.5GiB/s-22.5GiB/s (24.2GB/s-24.2GB/s), io=800GiB (859GB), run=35566-35566msec
numjobs: 16  WRITE: bw=23.7GiB/s (25.5GB/s), 23.7GiB/s-23.7GiB/s (25.5GB/s-25.5GB/s), io=1423GiB (1528GB), run=60001-60001msec
numjobs: 32  WRITE: bw=20.5GiB/s (22.1GB/s), 20.5GiB/s-20.5GiB/s (22.1GB/s-22.1GB/s), io=1233GiB (1324GB), run=60002-60002msec


File per job:
numjobs: 1  WRITE: bw=3546MiB/s (3718MB/s), 3546MiB/s-3546MiB/s (3718MB/s-3718MB/s), io=100GiB (107GB), run=28878-28878msec
numjobs: 2  WRITE: bw=7899MiB/s (8283MB/s), 7899MiB/s-7899MiB/s (8283MB/s-8283MB/s), io=200GiB (215GB), run=25927-25927msec
numjobs: 4  WRITE: bw=14.0GiB/s (15.0GB/s), 14.0GiB/s-14.0GiB/s (15.0GB/s-15.0GB/s), io=400GiB (429GB), run=28548-28548msec
numjobs: 8  WRITE: bw=20.9GiB/s (22.4GB/s), 20.9GiB/s-20.9GiB/s (22.4GB/s-22.4GB/s), io=800GiB (859GB), run=38308-38308msec
numjobs: 16  WRITE: bw=23.2GiB/s (24.9GB/s), 23.2GiB/s-23.2GiB/s (24.9GB/s-24.9GB/s), io=1391GiB (1493GB), run=60001-60001msec
numjobs: 32  WRITE: bw=20.3GiB/s (21.8GB/s), 20.3GiB/s-20.3GiB/s (21.8GB/s-21.8GB/s), io=1218GiB (1308GB), run=60002-60002msec


SSF gain in percentage:-
For 1 fio thread: +0%
For 2 fio threads: +0% 
For 4 fio threads: +148%
For 8 fio threads: +206.8%
For 16 fio threads: +695.8%
For 32 fio threads: +608%

We could see gain is huge. Also it brought single shared file as per file-per-job.

Dharmendra Singh (1):
  Allow parallel direct writes on the same file.

 fs/fuse/file.c            | 38 ++++++++++++++++++++++++++++++++++----
 include/uapi/linux/fuse.h |  2 ++
 2 files changed, 36 insertions(+), 4 deletions(-)

-- 
2.17.1

