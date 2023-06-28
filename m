Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D55B740E1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 12:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjF1KGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 06:06:22 -0400
Received: from jpmail1.chowchi.com ([172.104.66.65]:57064 "EHLO
        jpmail1.chowchi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjF1Jzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:55:46 -0400
Received: from jpmail1.chowchi.com (jpmail1.chowchi.com [127.0.0.1])
        by jpmail1.chowchi.com (Postfix) with ESMTP id 4F53E3D6B4
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 17:55:45 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at jpmail1.chowchi.com
X-Spam-Flag: NO
X-Spam-Score: -2.91
X-Spam-Level: 
X-Spam-Status: No, score=-2.91 tagged_above=-999 required=6.31
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, T_SCC_BODY_TEXT_LINE=-0.01]
        autolearn=ham autolearn_force=no
Received: from jpmail1.chowchi.com ([127.0.0.1])
        by jpmail1.chowchi.com (jpmail1.chowchi.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yaPF6rR57kCQ for <linux-fsdevel@vger.kernel.org>;
        Wed, 28 Jun 2023 17:55:44 +0800 (HKT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by jpmail1.chowchi.com (Postfix) with ESMTPSA id 8D3D43CA5A
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 17:55:44 +0800 (HKT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3942c6584f0so4271602b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 02:55:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDzf3TC0uW43qgHs2GsLkfcD/QRDHdZOzn6m/vO2zJovSq63qcr7
        Ja3Cnlr6z7QC4ZWVzgZXIcI45EL35O/krxsko9Y=
X-Google-Smtp-Source: ACHHUZ70tFxzYyZfuZBhcha4U2b8CRYL0+CL1jj9RhS5mMnbD/x9Lhd5qMgJ5R06dVMY0mfoRg6ihSasy7R/DQFIdJo=
X-Received: by 2002:a05:6808:5d4:b0:3a1:ddc1:e25 with SMTP id
 d20-20020a05680805d400b003a1ddc10e25mr7502771oij.58.1687946136432; Wed, 28
 Jun 2023 02:55:36 -0700 (PDT)
MIME-Version: 1.0
From:   Sam Wong <sam@hellosam.net>
Date:   Wed, 28 Jun 2023 17:55:00 +0800
X-Gmail-Original-Message-ID: <CAMohUi+3r3YCQrqA_v05LLVyRcjBS+D8N+JP_P0Tda3hvD4hCg@mail.gmail.com>
Message-ID: <CAMohUi+3r3YCQrqA_v05LLVyRcjBS+D8N+JP_P0Tda3hvD4hCg@mail.gmail.com>
Subject: ask for help: Overlay FS - user failed to write when lower directory
 has no R-bit but only W-bit
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I hope this is the write mailing list. I was debugging a container
problem after upgrading kubernetes nodes on my cloud provider, and
turns out it's an overlay fs related issue and has nothing to do with
the container technology.

I made a repro script and it consistently reproduce the issue. Thing
breaks in the newer kernel version (5.10.134-13.1.al8.x86_64), and
works in the older version (5.10.84-10.2.al8.x86_64). Test cases and
the situation is explained in the script.

---

#### Synopsis
## Things work as expected in 5.10.84-10.2.al8.x86_64
## Things break as expected in 5.10.134-13.1.al8.x86_64

## Note: bin, rpc is just some non-privilege user/group

#### Preparation ####
# Cleanup Folder
umount /root/test/mount && cd / && rm -fr /root/test
# Create empty folders
mkdir -p /root/test && cd /root/test; mkdir -p lower/target_bad1
lower/target_bad2 lower/target_good1 lower/target_good2 upper work
mount;
# Prepare testing conditions in lower
chmod 1730 lower/target_bad1; chown root:bin lower/target_bad1;
chmod 0737 lower/target_bad2; chown root:bin lower/target_bad2;
chmod 0777 lower/target_good1; chown root:bin lower/target_good1;
chmod 0707 lower/target_good2; chown root:rpc lower/target_good2;
# Create Overlay FS mount
mount -t overlay -o
lowerdir=/root/test/lower,upperdir=/root/test/upper,workdir=/root/test/work
null /root/test/mount;

#### Test Case ####
# Expectation: all 4 case success. files are touched and created.
# In 5.10.134-13.1.al8.x86_64 however, the bad1, bad2 fails with
`permisison denied`. good1, good2 behaves as expected.

# Case 1: group permission bits are -wx, no r. Not working in
5.10.134-13.1.al8.x86_64
# This is the original problem I am working on, command crontab fail
to write to /var/spool/cron/crontabs which has permission 1730.
sudo -u bin -g bin touch mount/target_bad1/RANDOM
# Case 2: I simplified the case a bit.
# group permission bits is -wx, no r. Not working in 5.10.134-13.1.al8.x86_64
sudo -u bin -g bin touch mount/target_bad2/RANDOM
# Case 3: group permission bits are rwx. It works in both
sudo -u bin -g bin touch mount/target_good1/RANDOM
# Case 4: directory ownership is rpc, I am sudo'ing to bin. It works in both
sudo -u bin -g bin touch mount/target_good2/RANDOM

---

I have not yet bisect or upgraded to the latest kernel version, that's
something I might be doing next, but since I am on Alicloud, upgrading
the kernel is not the easiest thing I could do. I did some searches
here and there for similar problems but to no avail. I am also
reaching out to Alicloud support. I hope if this is a known problem
and if someone could point me to a related bug / issue, that would be
a very great help and I could use that argument to push them to
upgrade their kernel.

Thank you very much
Sam Wong
