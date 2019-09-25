Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC2EBE87C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 00:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfIYWwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 18:52:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45929 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbfIYWwG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:52:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id z67so167131qkb.12;
        Wed, 25 Sep 2019 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hG7SOKz8MptTnrQvudDejoJqBWoC1kIuXyUc2ynrKEk=;
        b=hVyZutPx4fToHseEJGWiYk6Zw0UTkw2TRa7mx4CbiE5Glb04+9EPpvMZj8sShIuHY2
         CggxBBqjNVGEdeX45OeY9zst6MSlQsPA5wJmNRMkD4W+Fa6CVgBXVU+bSHeT85S8/MWG
         rkCUuLoHb94sZB58qIk6uoZAdMth0g/6D++RPPzBmnlLlcbjnaNkTYir2wZEKPRkNaIm
         LFkjo1PeU+7dpoGUVacv1Wpz48W7toIosHQmTvOsOsuzT23FAPUp8J4u2SB4WNlQdy/K
         EZCHotEuENbyfbd1jpvISTKpbmTRSWcj8BAZEQmXUnDbym6vHucjpqD/NBwMImlhZBAI
         nrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hG7SOKz8MptTnrQvudDejoJqBWoC1kIuXyUc2ynrKEk=;
        b=TNCReg1v8W422/Fe5l6ZU1CqI+RzQonbn9PeQaHlqnOE+44ejIFpQ4Zf2Svg0Edzsr
         q1RCzMyRCAYHUEjfs1526lYrovTr6TvHAtZMee9ql6wCej5C8P6kYbuPYgH36iXt1vkl
         Yn6OLxkJiJblXp4gwGsFq3iBjrT7ulDLwW1nbtxa3wVcvWwiNCwtmexD+84SwWcZSq3J
         1k0x7h7YIkhiFo0v1A/QYeUxkOJpQxc9T+1t8WWC95Fcw/7PHeg5v0GhGFU/gWCAJngc
         RGwE2MMNs6NVr3wfJAaW8y3bt85nVib7IulPGwXOxo6k8YJ2OgJ3SzIEMBLLu9gZTbvy
         YVwg==
X-Gm-Message-State: APjAAAX1HxzozpvyQsnep09vH4EugETPHr7OO0/3qQbsshvuPABH5TJP
        suqD8YRZd03LizR/BWY5xQsQII6iNBg3NK4TO6mw3vTB
X-Google-Smtp-Source: APXvYqxVXs1ZfbJU+FoZjOcEMrSTttWKrOEV9XXx5bCQ3hemdKq2MTCX4OFrCSCY2jLSFuo62HJHEtCqp/bUayED1XY=
X-Received: by 2002:a37:a205:: with SMTP id l5mr361422qke.488.1569451925129;
 Wed, 25 Sep 2019 15:52:05 -0700 (PDT)
MIME-Version: 1.0
From:   Jianshen Liu <ljishen@gmail.com>
Date:   Wed, 25 Sep 2019 15:51:27 -0700
Message-ID: <CAMgD0BoT82ApOQ=Fk6o5KYMsC=z7M88zkNCw9XuMtB0y-xaAmw@mail.gmail.com>
Subject: Question: Modifying kernel to handle all I/O requests without page cache
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I am working on a project trying to evaluate the performance of a
workload running on a storage device. I don't want the benchmark
result depends on a specific platform (e.g., a platform with X GiB of
physical memory). Because it prevents people from reproducing the same
result on a different platform configuration. Think about you are
benchmarking a read-heavy workload, with data caching enabled you may
end up with just testing the performance of the system memory.

Currently, I'm thinking how to eliminate the cache effects created by
the page cache. Direct I/O is a good option for testing with a single
application but is not good for testing with unknown
applications/workloads. Therefore, it is not feasible to ask people to
modify the application source code before running the benchmark.

Making changes within the kernel may only be the option because it is
transparent to all user-space applications. The problem is I don't
know how to modify the kernel so that it does not use the page cache
for any IOs to a specific storage device. I have tried to append a
fadvise64() call with POSIX_FADV_DONTNEED to the end of each
read/write system calls. The performance of this approach is far from
using Direct I/O. It is also unable to eliminate the caching effects
under concurrent I/Os. I'm looking for any advice here to point me an
efficient way to remove the cache effects from the page cache.

Thanks,
Jianshen
