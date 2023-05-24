Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CA670F4FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 13:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjEXLXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 07:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjEXLX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 07:23:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC2F1B9
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 04:23:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f655a8135bso1865005e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684927402; x=1687519402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XnHfsKcNH/cNGJ6XNCOWz/0q5ZKOE9Q1MtdFrXQQHlg=;
        b=HP1A3H0LJ3yGNLAb/iW11BhivBLLgjUIeGYq0rXzNJnrb8iiey3QkvYn1SYsziMNLw
         s+gOaE3U7WNFm0ChMlLJ/d4XzPHRSrKhEc3nI90nt8TaFhOtbohRVKRUwJyi+3ZMrwa7
         OyzjT7n42Um1ezPKnOWUEqzfPEoqtP9Jy1B9knhtDQRG4eoOFAssdIMHPGz4Ty9ynHPi
         2ODWAy4wTo5Z9scvqLUjg29hHX9AHT920fVBiQt6acbMXpxh4HnnMz6suc+MBYPXGpWa
         sDTOhlLEkcxVjd2C0CUsNDQ2rH6AWgk5uy3YgFtOSPhC0T6yoUfgRL6j81ikJ3+UARD/
         +/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684927402; x=1687519402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnHfsKcNH/cNGJ6XNCOWz/0q5ZKOE9Q1MtdFrXQQHlg=;
        b=FN5sWeO/+aAuB7fPLsLY00TIyYLR8NDiPZew7Z+NkT4qq8w9xey+3RgVlWVXczyOUA
         TYh4cs+5dOAoruJquKCXGcZSMmg63CyhQs7x4fP6eN3l28HaADplfpWZzHwlg/HJ+8eW
         gaU0qr9s55nLVi2AqF5rOdeqC87I9/btSMzdpYvqL/saO66btengOOZyFpzUeQMzCvBV
         nkxNy3QUkUH4hEMZAH2nFwIn7DjEpcIo4FTyuxj6sneHCAIUQJ1Pjc8LsmrOMDkdYfk3
         fN7zfAQ8R1R16g3izWQJAoAwAihAhdggE09v8Cbwe8e8ioNhH01foyQ5Bkw0G7utBk8q
         f+NQ==
X-Gm-Message-State: AC+VfDxdlz+ztalIO3mze+/ihyavq1I462HQuKuDtbirfcMJABe5Ojk1
        GHGhBD9oHLH3/bpLNuiR83KZAA==
X-Google-Smtp-Source: ACHHUZ4MJroqG+izF3TpvDWSMNs8ThwUAbnXvlX+TBLtv5iVz+aYg4Q/LNEqQCuFBIUxNT0Gc2Fh5Q==
X-Received: by 2002:a1c:cc1a:0:b0:3f5:fc21:5426 with SMTP id h26-20020a1ccc1a000000b003f5fc215426mr8660954wmb.41.1684927401874;
        Wed, 24 May 2023 04:23:21 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c020200b003f50e29bce3sm1968526wmi.48.2023.05.24.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 04:23:20 -0700 (PDT)
Date:   Wed, 24 May 2023 14:23:16 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Joel Granados <j.granados@samsung.com>
Cc:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org,
        chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: LTP: syscalls: statx06.c:138: TFAIL: Modified time > after_time
Message-ID: <784b9a90-9d56-4e53-8f92-676e76e49665@kili.mountain>
References: <CA+G9fYvGM6a3wct+_o0z-B=k1ZBg1FuBBpfLH71ULihnTo5RrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvGM6a3wct+_o0z-B=k1ZBg1FuBBpfLH71ULihnTo5RrQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am pretty sure this is caused by commit 7eec88986dce ("sysctl:
Refactor base paths registrations").  Add Joel to the CC list.

Before we used to use register_sysctl_table() to register that table.

regards,
dan carpenter

On Wed, May 24, 2023 at 04:18:42PM +0530, Naresh Kamboju wrote:
> LTP syscalls statx06 fails on NFS mounted devices using external hard drives
> for testing and running on Linux next 6.4.0-rc3-next-20230524.
> 
> Test case fails on x86_64, i386 and arm64 Juno-r2.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> 
> Linux version 6.4.0-rc3-next-20230524 (tuxmake@tuxmake)
> (x86_64-linux-gnu-gcc (Debian 11.3.0-12) 11.3.0, GNU ld (GNU Binutils
> for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1684908723
> ...
> 
> [    1.396191] Mountpoint-cache hash table entries: 32768 (order: 6,
> 262144 bytes, linear)
> [    1.397234] sysctl table check failed: kernel/usermodehelper Not a file
> [    1.398166] sysctl table check failed: kernel/usermodehelper No proc_handler
> [    1.399165] sysctl table check failed: kernel/usermodehelper bogus .mode 0555
> [    1.400166] sysctl table check failed: kernel/keys Not a file
> [    1.401165] sysctl table check failed: kernel/keys No proc_handler
> [    1.402165] sysctl table check failed: kernel/keys bogus .mode 0555
> [    1.403166] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 6.4.0-rc3-next-20230524 #1
> [    1.404165] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.5 11/26/2020
> [    1.404165] Call Trace:
> [    1.404165]  <TASK>
> [    1.404165]  dump_stack_lvl+0x72/0x90
> [    1.404165]  dump_stack+0x14/0x20
> [    1.404165]  __register_sysctl_table+0x570/0x840
> [    1.404165]  __register_sysctl_init+0x29/0x60
> [    1.404165]  sysctl_init_bases+0x27/0x80
> [    1.404165]  proc_sys_init+0x37/0x40
> [    1.404165]  proc_root_init+0x7b/0x90
> [    1.404165]  start_kernel+0x403/0x6a0
> [    1.404165]  x86_64_start_reservations+0x1c/0x30
> [    1.404165]  x86_64_start_kernel+0xcb/0xe0
> [    1.404165]  secondary_startup_64_no_verify+0x179/0x17b
> [    1.404165]  </TASK>
> [    1.404165] failed when register_sysctl kern_table to kernel
> 
> ....
> ./runltp -f syscalls -d /scratch
> 
> ...
> 
> [ 1192.088987] loop0: detected capacity change from 0 to 614400
> tst_device.c:93: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='-I 256'
> extra opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> [ 1192.337350] EXT4-fs (loop0): mounted filesystem
> dfe9283c-5d2f-43f8-840e-a2bbbff5b202 r/w with ordered data mode. Quota
> mode: none.
> tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
> 
> statx06.c:140: TPASS: Birth time Passed
> statx06.c:138: TFAIL: Modified time > after_time
> statx06.c:140: TPASS: Access time Passed
> statx06.c:140: TPASS: Change time Passed
> 
> 
> links,
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230524/testrun/17171892/suite/ltp-syscalls/test/statx06/log
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230524/testrun/17171892/suite/ltp-syscalls/test/statx06/history/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230524/testrun/17171892/suite/ltp-syscalls/test/statx06/details/
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
