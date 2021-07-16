Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F633CB2CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 08:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhGPGps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 02:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbhGPGps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:45:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130E6C06175F;
        Thu, 15 Jul 2021 23:42:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so11575466eds.4;
        Thu, 15 Jul 2021 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=O5Zke66uI5LxZVkYWI95Tx+J3KNQ1bPBIGGmEE1oiJQ=;
        b=Zt8Vy0wAGBl/en8Xn9uzslyZHwSzjc1/gs/urvGIcRN9UWRy8/ZTbccFU1C7yY0/5Q
         axNSq7qTb4vh3bdcGoQ2ZVaY6LIsu0SdU5aB5RZGRBXe3+dIktx0R6ZiyiYpVGWC6hpY
         PrgwhbedATfheNR8ZKHjs/nYUokDMq+wmPjPMhMJhCSL9vwVx4bxSiTm+Ky6kFfOFo60
         J3RaSxMWubWBhbS6IkggABuT9FpMSN1c25AWbQTYy1qfUEZ4BEBH01fc2x44agUT4QAT
         dobKSzXd32r7LZh/EfpSdyUHSC/lxahmD2V0s/lnF0DLX6Qv8dBl8rkKFYZl++u3BjTp
         A+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=O5Zke66uI5LxZVkYWI95Tx+J3KNQ1bPBIGGmEE1oiJQ=;
        b=ncGTtNBBEATaCs/1lSaZILPPfPz+4LKfS/Cu/1qyLfcbj4XGx5oZH8E9HnF73XgUyN
         NWakxswAuWOqw/vZ6HhlpCpZ0mtfFZJUrtMRo36w4rfRg/tnYY3YumK/09qRUFlVJdF+
         oWEMjKiaWr6OWSDsfMzQObPsANuiu95ZQwI/xXIhc15KkIL/sNKze0uOYxrqrXKwpvwC
         6qkIaGf9z7M77tBKZFUGNnH6WTMR3dwkEehwEXNWsuhNhwsLao9ho2D/qMaCFFkZYtUj
         Jv+QrtY+HoibEnWiI/rmoTt6hecV5T/9pBXFiMpDGBVvBjxe9n2acIet4+zKFpMIsKTS
         PCJg==
X-Gm-Message-State: AOAM531q0LArk+4ThWKT+WFaCmat+MHAuozb79kP4cwnV7dnCpDUgFhp
        gKZ+wrHXuo/sn9A35uJ8vO6/tmHjCwTERvjq0jpLnrB7
X-Google-Smtp-Source: ABdhPJw+VGZgQAn0kjFh/ndkDCk6xrwoK9JC9hWPUgvQg28yCLKiLI1BqsD2UUYKC07wFnL249FnqDPk/Oo6olaRXT4=
X-Received: by 2002:aa7:dbc3:: with SMTP id v3mr12670927edt.63.1626417772479;
 Thu, 15 Jul 2021 23:42:52 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 16 Jul 2021 12:12:41 +0530
Message-ID: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
Subject: MTD: How to get actual image size from MTD partition
To:     open list <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Our ARM32 Linux embedded system consists of these:
* Linux Kernel: 4.14
* Processor: Qualcomm Arm32 Cortex-A7
* Storage: NAND 512MB
* Platform: Simple busybox
* Filesystem: UBIFS, Squashfs
* Consists of nand raw partitions, squashfs ubi volumes.

My requirement:
To find the checksum of a real image in runtime which is flashed in an
MTD partition.

Problem:
Currently, to find the checksum, we are using:
$ md5sum /dev/mtd14
This returns the proper checksum of the entire partition.
But we wanted to find the checksum only for the actual image data
which will be used by our C utility to validate the image.
Here, we don't know the actual image size.
We only know the "partition-size" and "erasesize".

So, is there a mechanism to somehow find the image size at runtime?

Regards,
Pintu
