Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F5B3A6184
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 12:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhFNKsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 06:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhFNKqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:46:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC028C061A29;
        Mon, 14 Jun 2021 03:39:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ba2so44066992edb.2;
        Mon, 14 Jun 2021 03:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=O8WpJQZenICGzTZvriCS7Y4CfqGQZ2ql9+HdnGk6G6s=;
        b=bdcKxFXvOkmDTtQXzP7mf2LQcxv/EPW1OQtkL6J73K5mTitWzIfYRVzdiSvpiQeJoX
         huhkHtgWgEfWZKxgGWl3xWgNoP/IMwIs7Ok+MlGlYCXMe0o+eAsLK/WqfJkOmq7XkieW
         M6B4qYXVOGsBidnAlv0Lep/L9Q8+s6P7zsXGKC5NWzRSgUa2Pco2QT3xSRoi5y7MekDK
         /+k/KrhWaCFunhe6AA/aXWMytJp83lMd6utSGelUW8/dhx8qLCUQ+SRpOIx2NgBnUef6
         1Ka10/2H2cqsmvrCKBX8vIxmL5Zdhf7DSuac+57lYLvIDALS9bzCmlgBL9lerpOx0Omp
         f/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=O8WpJQZenICGzTZvriCS7Y4CfqGQZ2ql9+HdnGk6G6s=;
        b=PUZliGTrJXzF6R2yNs0e/7LXCg4MuMM17htXAaqSkA31HEZuXZLports7bzzS2alW1
         LgOPvolAwLgaDZRHmtA/h6keTu9oNefI3CLDCZdjme9t1/WI4gtdM/uWeHYPIIE7JwkF
         m2wdrjrBcwEyAdoaDU49UgaS6F89+8LyFheYaswc9+gMuK1x3KRtVGZAHiIAOEaTu+jd
         8+tNlGvkLME4O33D+4K2zubHLpYJ6/TYgwAWpG23qoXRH5U1cpOh04YN4bUc2r1aWx3p
         drRsZIBNxFphYFv0GJXYRJEgotH2uY680LXoHDQ19ZE3DFSC5P6G5GlyEk5A/b6LBY7f
         fCFw==
X-Gm-Message-State: AOAM533vgRtw3cYzqTzwSdmsIYWoIypOb+en85BAeHbDLD+VUieSmEAT
        0VwwkKJE8vlXDzL7RsjLtDX0Bi04NFbfv8NM9+TsfuSj/DQ=
X-Google-Smtp-Source: ABdhPJx7C6nm+tkdulhI7l2WHPhprlheB7uxotFwwYu2SNFXV928N8PWHkKv/cQvPNSUr2lsYZh2o7+yJcAdiC/yKI4=
X-Received: by 2002:a05:6402:3134:: with SMTP id dd20mr16058384edb.59.1623667166346;
 Mon, 14 Jun 2021 03:39:26 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 14 Jun 2021 16:09:15 +0530
Message-ID: <CAOuPNLi8_PDyxtt+=j8AsX9pwLWcT4LmVWKj+UcyFOnj4RDBzg@mail.gmail.com>
Subject: Kernel 4.14: SQUASHFS error: xz decompression failed, data probably corrupt
To:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel@kvack.org, Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

With Kernel 4.14 we are getting squashfs error during bootup resulting
in kernel panic.
The details are below:
Device: ARM-32 board with Cortex-A7 (Single Core)
Storage: NAND Flash 512MiB
Kernel Version: 4.14.170 (maybe with some Linaro updates)
File system: Simple busybox with systemd (without Android)
File system type: UBIFS + SQUASHFS
UBI Volumes supported: rootfs (ro), others (rw)
-------------------

When we try to flash the UBI images and then try to boot the device,
we observe the below errors:
{{{
[    5.608810] SQUASHFS error: xz decompression failed, data probably corrupt
[    5.608846] SQUASHFS error: squashfs_read_data failed to read block 0x4d7ffe
[    5.614745] SQUASHFS error: Unable to read data cache entry [4d7ffe]
[    5.621939] SQUASHFS error: Unable to read page, block 4d7ffe, size 7a3c
[    5.628274] SQUASHFS error: Unable to read data cache entry [4d7ffe]
[    5.634934] SQUASHFS error: Unable to read page, block 4d7ffe, size 7a3c
[    5.641309] SQUASHFS error: Unable to read data cache entry [4d7ffe]
[    5.647954] SQUASHFS error: Unable to read page, block 4d7ffe, size 7a3c
[    5.654304] SQUASHFS error: Unable to read data cache entry [4d7ffe]
[    5.660977] SQUASHFS error: Unable to read page, block 4d7ffe, size 7a3c
[    5.667309] SQUASHFS error: Unable to read data cache entry [4d7ffe]
[    5.673997] SQUASHFS error: Unable to read page, block 4d7ffe, size 7a3c
[    5.680497] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00007f00
[....]
}}}
We also observed that some of our Yocto build images will work and
boots fine, while sometimes the build images cause this issue.

So we wanted to know:
a) What could be the root cause of this issue ?
b) Is it related to squashfs ?
c) If yes, are there any fixes available already in the latest mainline ?
    Please share some references.

Please let us know if anybody encountered this similar issue with
squashfs and how did you handle it ?

Note:
Our current commit in fs/squashfs is pointing at:
Squashfs: Compute expected length from inode size rather than block length


Thanks,
Pintu
