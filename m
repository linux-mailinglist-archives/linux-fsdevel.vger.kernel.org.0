Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D63070F795
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 15:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjEXN3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 09:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjEXN3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 09:29:11 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8E6A9;
        Wed, 24 May 2023 06:29:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d3578c25bso1010724b3a.3;
        Wed, 24 May 2023 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684934949; x=1687526949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bL74JH2lI6U1XQYNxm+fHRQrQTqI+hx9xDVeUWPg440=;
        b=D/VgfMLTQQNXXadIlhH/E9u0pBYR7VvUwnqqyZ2fKtRsFAfgWDkAkJx9nf8iasjSgK
         f52HGDT44e114XWm7/RmzzPUp5Rh2pGAMpd1YyHZLqDUQ4f5CBFHNrfz2MGxKKBR2mvR
         T37p4HAe2CY/ouvNPlwr85y/cbDLoY9NXYrH/xROkldEh/Cjm4hLuqL9v4TjexBgi4on
         Cj/2OUNpVyRIe4MNhqBa6cG8/inukvMbRIqu7IYelbx1jgcES1yZXkAtU0eiwri5IBx2
         s1vg9W6XSSVWEvQbc0Ip+m7+w4evUsQJgNJJ4XLixmCJlpjM1M90Or4uDFDIVma0wtTJ
         yq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684934949; x=1687526949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bL74JH2lI6U1XQYNxm+fHRQrQTqI+hx9xDVeUWPg440=;
        b=XUTFwEd+JnrCsgMNekuHnxh1l9uuB+itXXtDKW45LlllMvO5xzoJU7TFm2itqnEdlT
         LzCvGvIP2w4E1kJeZnT2VE2QqG2MEDGeFqUQvtq2q5HpRnf4I9E/7etBIswq6Jp+UHr7
         mBDL3tAOu8ORjie5fz4pa/VpPy3ccFhsEdI9/xbd1MO/XWg6jPIITonQ3Zzpg2N8oD1S
         gxmkKo6vM8e3hXhTjsDbxUkgBNtWyRa7iBOgiTcwzUqFD3brxRwIoAcZ+yackJP7kkyk
         qTO44WPV/047tIH7+9LiBP8WO056ODXTqx62p/bHcZb831SEtompRuhQVfTX6teS08H/
         Spqg==
X-Gm-Message-State: AC+VfDx7togVfQkESVIZU02yj3w1sP6ByGcOk74JebH7eU5iz21rE33V
        Igqs2M0ltNfyGRw0bw/O7AiK50a9PIA=
X-Google-Smtp-Source: ACHHUZ77tlUfYz1j7kb2LrIvyD7B39mUKxG7RADKzFTAqqcQlmzhc2N4WNlEMVms+PkGk+Wldo7yRA==
X-Received: by 2002:a05:6a20:42a3:b0:10a:ee1b:fdc4 with SMTP id o35-20020a056a2042a300b0010aee1bfdc4mr14794875pzj.47.1684934948724;
        Wed, 24 May 2023 06:29:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c26-20020aa781da000000b0062dedfd3d73sm7671927pfn.95.2023.05.24.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 06:29:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 24 May 2023 06:29:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joel Granados <j.granados@samsung.com>
Cc:     mcgrof@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] sysctl: Refactor base paths registrations
Message-ID: <0085b175-4d82-4ba4-b19c-643422f73bec@roeck-us.net>
References: <20230518160705.3888592-1-j.granados@samsung.com>
 <CGME20230518160715eucas1p1973b53732f9b05aabbef2669124eb413@eucas1p1.samsung.com>
 <20230518160705.3888592-2-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518160705.3888592-2-j.granados@samsung.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 06:07:04PM +0200, Joel Granados wrote:
> This is part of the general push to deprecate register_sysctl_paths and
> register_sysctl_table. The old way of doing this through
> register_sysctl_base and DECLARE_SYSCTL_BASE macro is replaced with a
> call to register_sysctl. The 5 base paths affected are: "kernel", "vm",
> "debug", "dev" and "fs".
> 
> We remove the register_sysctl_base function and the DECLARE_SYSCTL_BASE
> macro since they are no longer needed.
> 
> In order to quickly acertain that the paths did not actually change I
> executed `find /proc/sys/ | sha1sum` and made sure that the sha was the
> same before and after the commit.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>

This patch results in the following warning, seen across almost
all architectures.

sysctl table check failed: kernel/usermodehelper Not a file
sysctl table check failed: kernel/usermodehelper No proc_handler
sysctl table check failed: kernel/usermodehelper bogus .mode 0555
sysctl table check failed: kernel/keys Not a file
sysctl table check failed: kernel/keys No proc_handler
sysctl table check failed: kernel/keys bogus .mode 0555
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-rc3-next-20230524 #1
Stack : ffffffff 801aed28 80e44644 00000004 81946ba4 00000000 810d3db4 b782f641
        810f0000 81269940 810f0000 810fa610 811bb193 00000001 810d3d58 00000000
        00000000 00000000 810099d8 000000f2 00000001 000000f3 00000000 00000000
        ffffffff 00000002 00000000 fff80000 810f0000 810099d8 00000001 ffffffea
        8013bab4 8113bb14 8013caa8 80fe0000 00000000 807b9d54 00000000 81270000
        ...
Call Trace:
[<8010a558>] show_stack+0x38/0x118
[<80d67edc>] dump_stack_lvl+0xa4/0xf0
[<8039c8e0>] __register_sysctl_table+0x5b4/0x7a0
[<811e55e4>] __register_sysctl_init+0x30/0x68
[<811d5164>] sysctl_init_bases+0x24/0x88
[<811e517c>] proc_root_init+0x94/0xa8
[<811ccebc>] start_kernel+0x704/0x740

failed when register_sysctl kern_table to kernel

Reverting this patch alone results in build failures. Reverting this patch
as well as the second patch in the series (to avoid the build failures)
fixes the problem.

Guenter

---
bisect log:

# bad: [cf09e328589a2ed7f6c8d90f2edb697fb4f8a96b] Add linux-next specific files for 20230524
# good: [44c026a73be8038f03dbdeef028b642880cf1511] Linux 6.4-rc3
git bisect start 'HEAD' 'v6.4-rc3'
# good: [a20d8ab9e26daaeeaf971139b736981cf164ab0a] Merge branch 'for-linux-next' of git://anongit.freedesktop.org/drm/drm-misc
git bisect good a20d8ab9e26daaeeaf971139b736981cf164ab0a
# good: [2714032dfd641b22695e14efd5f9dff08a5e3245] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
git bisect good 2714032dfd641b22695e14efd5f9dff08a5e3245
# good: [b2bc2854ec87557033538aa9290f70b9141a6653] Merge branch 'for-leds-next' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git
git bisect good b2bc2854ec87557033538aa9290f70b9141a6653
# good: [26931c8431566f9bec7d57512e4cad8ebaeb024f] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
git bisect good 26931c8431566f9bec7d57512e4cad8ebaeb024f
# good: [669623b562b5cd308eaa58eabe8c72007dbb37e2] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
git bisect good 669623b562b5cd308eaa58eabe8c72007dbb37e2
# good: [a0ef85b20ffa65a89dc79b0a22edb80a88199939] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching
git bisect good a0ef85b20ffa65a89dc79b0a22edb80a88199939
# bad: [a64335537001eb6af6e57a82317985441dafe4e7] Merge branch 'sysctl-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
git bisect bad a64335537001eb6af6e57a82317985441dafe4e7
# good: [ba3ad1554b569888f4a63a2e4a16a9009fdedd4e] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
git bisect good ba3ad1554b569888f4a63a2e4a16a9009fdedd4e
# good: [3133f141259d7f6e0729db272f22724614472661] Merge branch 'slab/for-6.5/prandom' into slab/for-next
git bisect good 3133f141259d7f6e0729db272f22724614472661
# good: [2716d45c6fdc1ae06e83db28f58f55f7e9415643] sysctl: stop exporting register_sysctl_table
git bisect good 2716d45c6fdc1ae06e83db28f58f55f7e9415643
# good: [8ccb380db3a4bcef9ade852da8b33fdcea01c8a5] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
git bisect good 8ccb380db3a4bcef9ade852da8b33fdcea01c8a5
# bad: [ee996cff1fb203bffc8de5c87cab6056d60df71d] sysctl: Remove register_sysctl_table
git bisect bad ee996cff1fb203bffc8de5c87cab6056d60df71d
# bad: [7eec88986dce2d85012fbe516def7a2d7d77735c] sysctl: Refactor base paths registrations
git bisect bad 7eec88986dce2d85012fbe516def7a2d7d77735c
# first bad commit: [7eec88986dce2d85012fbe516def7a2d7d77735c] sysctl: Refactor base paths registrations


