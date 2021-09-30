Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8809D41D64A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 11:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349390AbhI3J1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 05:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349353AbhI3J1k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:27:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85ABC06176C
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Sep 2021 02:25:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r18so19392385edv.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Sep 2021 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FgDEF5QsmroSdqP8VlZXdtzKOBTGAv2wQDQ0DgnPpR0=;
        b=QCYV6tF29tjuojWJgdO0HG/NOPDY9MR5//fKXB4SY/ecPmmDgA2RykkaV5ha66jFbK
         EU5lsCj1e70AdLYIB5mF23elFT5J8Z5Er29qjCUfvRlpeYmZ9jUaNq+WAnJVqg95Z413
         cPw+knm50vQfmgVWCEKBFmw6LvUch/NdiY2oHAl01Z5J7+PcEXrbW3A2lszynUzH6Fyn
         cZl5c8iP7KOtH0XpwqYBZgAm80LgVhhKiYOYpvsTHKKas1DrN0tA2kFot5+jkP2/kCjA
         SE6WhorwMsVkYAbw1+mczy6MVwa6CmIMZHyh4i758s0BL3mal3RyHLP/16RfWIERjMS2
         awog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FgDEF5QsmroSdqP8VlZXdtzKOBTGAv2wQDQ0DgnPpR0=;
        b=VWHmQqLWVufJqgFf6Z6KoUnROMeAXl/zchgYNFPpcCjkL99fsW30/zB/0h9BmO7XrA
         Y/BjJUnqE1+q6idygV2uT03+JZ+EyrEhZIp/kHr0uQQ/nOaHN2AnCWO96Eil/Ya4PJIL
         /uXdfkmAzXSQzXhzTOSCI5bTQvC8FPYRp6yNNXe1Q2KIl+pMM/UUwbIHpI7hEbhTY5pO
         +UqjRrrgxqbztwsqMOAQ77LqZoJuWT5YSr3bjUNkUsao/+bDMGIK7dIwFD7djSdnTjpj
         HT5H0pDIpE3QwbkYUE66yGmI3Y8BN2cOQMBi+5BkijHhUQD3gBcasF/y/1gt+7MLh8jG
         xeyw==
X-Gm-Message-State: AOAM530MI2cwlEqCnrRCMoY36VctqDfxlRn77F3POmVAA41EgJV2Cwzs
        Y2Kn9/eX85Q/egSD/sNWqsn4MBYsjcAUdjxJEAUh/RY7ckR1kA==
X-Google-Smtp-Source: ABdhPJzZdrOTJ/cjeQXXE5M89Ybzqqx6GYwyzwIVcXAQ/nNjdRbFzh3eTYO2u1ZzLxUERXiNtmxrqUF0V5mMCT6jfnc=
X-Received: by 2002:a50:e08a:: with SMTP id f10mr5990950edl.319.1632993956472;
 Thu, 30 Sep 2021 02:25:56 -0700 (PDT)
MIME-Version: 1.0
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 30 Sep 2021 11:25:45 +0200
Message-ID: <CADYN=9KXWCA-pi8VCS5r_JScsuRyWBEKqtdBFCAGzg1vq4M5FQ@mail.gmail.com>
Subject: regression: kernel panic: 9pnet_virtio: no channels available for
 device root
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

I've found a boot regression when ran my allmodconfig kernel on tag v5.15-rc1
I've bisected it down to commit f9259be6a9e7 ("init: allow mounting
arbitrary non-blockdevice filesystems as root"), see the bisect log
[1].


my qemu cmdline looks like this:
qemu-system-aarch64 --enable-kvm -cpu cortex-a53 -kernel
Image-bisect-1.gz -serial stdio -monitor none -nographic -m 2G -M virt
-fsdev local,id=root,path=/srv/kvm/tmp/stretch/arm64,security_model=none,writeout=immediate
-device virtio-rng-pci -device
virtio-9p-pci,fsdev=root,mount_tag=/dev/root -append "root=/dev/root
rootfstype=9p rootflags=trans=virtio console=ttyAMA0,38400n8
earlycon=pl011,0x9000000 initcall_debug softlockup_panic=0
security=none kpti=no"

This is a boot log snippet from [2]:

[   58.925779][    T1] random: get_random_u32 called from
kobject_release+0x44/0x180 with crng_init=0
[   58.925965][    T1] kobject: 'devlink' (ffff000007efb200):
kobject_release, parent 0000000000000000 (delayed 750)
[   58.937915][    T1] kobject:
'amba:9030000.pl061--platform:gpio-keys' (ffff000008496830):
kobject_release, parent 0000000000000000 (delayed 500)
[   58.945685][    T1] random: get_random_u32 called from
shuffle_freelist+0x44/0x1c0 with crng_init=0
[   59.089658][    T1] ALSA device list:
[   59.092985][    T1]   No soundcards found.
[   59.114787][    T1] uart-pl011 9000000.pl011: no DMA platform data
[   59.158409][    T1] 9pnet_virtio: no channels available for device root
[   59.163398][    T1] Kernel panic - not syncing: VFS: Unable to
mount root "root" (9p), err=-2
[   59.166946][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G
W       T 5.15.0-rc1 #1 ceb9159c1f47670faf7c7354800b02e393522bde
[   59.171816][    T1] Hardware name: linux,dummy-virt (DT)
[   59.174091][    T1] Call trace:
[   59.175561][    T1]  dump_backtrace+0x0/0x340
[   59.177509][    T1]  show_stack+0x28/0x80
[   59.179333][    T1]  dump_stack_lvl+0x88/0xd8
[   59.181274][    T1]  dump_stack+0x1c/0x44
[   59.183101][    T1]  panic+0x1f0/0x420
[   59.184806][    T1]  mount_nodev_root+0x1ac/0x260
[   59.186907][    T1]  mount_root+0x288/0x388
[   59.188781][    T1]  prepare_namespace+0x2fc/0x368
[   59.190904][    T1]  kernel_init_freeable+0x318/0x370
[   59.193140][    T1]  kernel_init+0x24/0x180
[   59.195132][    T1]  ret_from_fork+0x10/0x20
[   59.197741][    T1] Kernel Offset: disabled
[   59.199770][    T1] CPU features: 0x00001001,00000846
[   59.202082][    T1] Memory Limit: none
[   59.203923][    T1] ---[ end Kernel panic - not syncing: VFS:
Unable to mount root "root" (9p), err=-2 ]---

When I reverted, the two patches below it booted fine.
6e7c1770a212 ("fs: simplify get_filesystem_list / get_all_fs_names")
f9259be6a9e7 ("init: allow mounting arbitrary non-blockdevice
filesystems as root")

Do you have any idea what is going on here?


Cheers,
Anders
[1] http://ix.io/3Aod
[2] http://ix.io/3Aoh
