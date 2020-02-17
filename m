Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD4416088F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 04:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgBQDSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 22:18:23 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:35715 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgBQDSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:18:23 -0500
Received: by mail-wm1-f52.google.com with SMTP id b17so16810156wmb.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Feb 2020 19:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=GVtB47ggrwZFRbF2en1LTjsI9Athjmuxky8H4l9OTC0=;
        b=C2rldD8WFPkAc1NbktyvKnwJETzm6m+rTl0wDsvfX7gpgYuT9GUEAR1ZvnZhDKwfFE
         yVejbrSUS8QV9IF6afDXiI3vVpymTzACBTyffyFgSjMXNtUFVhtnXPQFsk4UTyijnlYK
         KgDMm5YN2AJ+3wl/iOg3vt20pgyL6uILBOMMKQS2Uwb7eNcKdPFqgRrSiy5bi7hGMmem
         svlfknT/YVILiZtQ6Go9oVlMwRxqnrcsCYbDTIZQKgBJEvQ+xJ5vdgDgDM+/QHZA1gzM
         clC/bEN8Ehr6tRrRSuVriO9TCPzNoAPe5jLMY0CCImzz132xQyY/h1QZv331ovnvYuK+
         gnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GVtB47ggrwZFRbF2en1LTjsI9Athjmuxky8H4l9OTC0=;
        b=XxQLg0YKQnQAwc14L7fL8i9oBZHn+u17PnjVGFiwPEWpihIwyId54IJ+3B0WV3cjj0
         9dxj9Vg0Vyq9p2YWkrcm3gL7RHqm3LoLXbJEw7LxtfZg51hNINqh+MVllWprFtfOvSW5
         jh5Org19l+Ki/QqtvJCWLSEMUSdOnfTnY2v0QHEv4pw+UZXjr/34OW7hkF7GvF8O1Lzu
         Fl9x9wfy9gux8GGSOGcuKfzu0rrwFtIUMWwXWblmaqPE8J4WCFk5ZKE41dL6q7puJtnH
         STCt06c3QaVotrlTmjSvdIejXcB+O7PYGYz3r/zfgBehYvoATp38cIgLcF4NwwUE5aSq
         hMEQ==
X-Gm-Message-State: APjAAAWkwx5NM8whxH8D5hq+M5H5j/bv7OtrRW0FSGB7Sma3xDDT6LdV
        tjQIlYQl79GZRCRLuDz4JgaL/mwYmLrZvF8sxLkbovF1fNw=
X-Google-Smtp-Source: APXvYqy7u0EUG43cZpAVRj99cIrnVoUn1NBx+i9Q7fhJl4jCaHMJVIc0hHETjfoGt+ZlAvlPH2TnLf+IKx6eU1lVJIA=
X-Received: by 2002:a05:600c:217:: with SMTP id 23mr19257499wmi.124.1581909500919;
 Sun, 16 Feb 2020 19:18:20 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 16 Feb 2020 20:18:05 -0700
Message-ID: <CAJCQCtSUzj4V__vo5LxrF1Jv2MgUNux=d8JwXq6H_VN=sYunvA@mail.gmail.com>
Subject: dev loop ~23% slower?
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
I see an approximately 23% reduction in performance through a loop
device. Is it expected? This is kernel 5.5.3.

The setup is SSD, plain partitions, no LVM or encryption, Btrfs. This
scrub performance is typical.

$ sudo btrfs scrub status /
UUID:             b8e290d5-1dc5-429f-8201-10ca5b2c0b95
Scrub started:    Sun Feb 16 19:39:01 2020
Status:           finished
Duration:         0:00:54
Total to scrub:   28.00GiB
Rate:             531.06MiB/s
Error summary:    no errors found
[chris@fmac ~]$

On this file system is a sparse file, chattr +C is set, and it's
attached to /dev/loop0 and mounted at /mnt.

$ sudo btrfs scrub status /mnt
UUID:             63a7e2b9-6a5e-4e94-9cc9-f90d01de7541
Scrub started:    Sun Feb 16 20:06:51 2020
Status:           finished
Duration:         0:00:13
Total to scrub:   5.15GiB
Rate:             405.79MiB/s
Error summary:    no errors found
$

I don't think file system over accounts for much more than a couple
percent of this, so I'm curious where the slow down might be
happening? The "hosting" Btrfs file system is not busy at all at the
time of the loop mounted filesystem's scrub. I did issue 'echo 3 >
/proc/sys/vm/drop_caches' before the loop mount image being scrubbed,
otherwise I get ~1.72GiB/s scrubs which exceeds the performance of the
SSD (which is in the realm of 550MiB/s max)


Thanks,

-- 
Chris Murphy
