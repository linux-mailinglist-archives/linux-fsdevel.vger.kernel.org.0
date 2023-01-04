Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB58865DC44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 19:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbjADShA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 13:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbjADSgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:36:37 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C0217E0E;
        Wed,  4 Jan 2023 10:36:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso24966827wmb.3;
        Wed, 04 Jan 2023 10:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rygkofvzOv4xwaY/JKfoRBXfGetYwDagXRjgt1zIpD0=;
        b=OMkxtzrVCOrPcYJv+voq3zup5Nbwy88VB/lX3PlD3ZGZqRMrWsmcHexZZG5tTpuL+6
         XMR2qeCpmZ4j+mNjvlSCNPYKeeVkL3wHar+nc+X1jQI7b/jCFNFXsyB/HRq7rUeatxK/
         +mL6al7z960gVc+xNYaVXBVUU9gLwQhowwEQsW5x47RGMJCiOyto4XB4NwdWehahe25J
         m/iJTKKKAPiYAk0qnFez/LVBwO7SlezMdFcabwl5RS1KXiBO34vWMHECWkdnFrpgpAUN
         Ga7dWIxXAV0l0y45ODxfhvhkeDnLL//6qBCtOoFUQviUop8Tyo7t/tjFyz/GAFvUu9/y
         nKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rygkofvzOv4xwaY/JKfoRBXfGetYwDagXRjgt1zIpD0=;
        b=wOaWdXYV6xOyJXhFLtlGOmvsHziqYJG2KZJ2if6CKGp3eyWJtyOM7dztqAPwZmDjmf
         r/lcUK1elpzKQWsOiJNhgL1H5eT97PKKJ6WrUX+ll/UW5ZEvRzFNMnRhAqTaH8CetqUU
         nwNj4HZrDijmHBMZbDatPnQYMv4iDjRz1v0M6ndNpmAY2zTZ6RulEqQS4oXmQ5E86uaj
         0Nvc5gDnSAdskTSz2rqkQ/lNCQ7XbUUwuT3nuv7BeJYGuY1B19ViZ1OzaOHBfvxzrvMJ
         IOoHbzRqFu4fHugdY5PDAY9rhsxqMezBgA8rVE2uspoyBUM7+NdpwY94SuERQqE91KY8
         OhMg==
X-Gm-Message-State: AFqh2kr7cuQAmlDXlTK+OE1O+BmoltKlz2rxR78PSTvGofNfkBxWSiWN
        ecmZjVbYl+Vt2YhJ/gHuvw==
X-Google-Smtp-Source: AMrXdXuj7lbhu8dfpTGGBU8qUISxvGXWxG5dyoYk0/Th6BTOnYUwCvJLv9Rra/k2RKMLEuBUWo3Yiw==
X-Received: by 2002:a7b:cd99:0:b0:3d3:5506:1bac with SMTP id y25-20020a7bcd99000000b003d355061bacmr35060471wmj.30.1672857394124;
        Wed, 04 Jan 2023 10:36:34 -0800 (PST)
Received: from p183 ([46.53.251.191])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c354200b003d35acb0fd7sm55836505wmq.34.2023.01.04.10.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 10:36:33 -0800 (PST)
Date:   Wed, 4 Jan 2023 21:36:31 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: BUG: core dump in selftest of proc fs
Message-ID: <Y7XHL8ZRBf7TA/q7@p183>
References: <fd9206f6-3ec4-cafc-e313-dfddf957bd5e@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd9206f6-3ec4-cafc-e313-dfddf957bd5e@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 04, 2023 at 07:27:40PM +0100, Mirsad Goran Todorovac wrote:
> Trying to complete `make kselftest` for the first time, so maybe I'm doing something wrong?
> 
> Or we are having a regression in 6.2-rc2 release candidate ...
> 
> However, the output of selftest run is:

> # proc-empty-vm: proc-empty-vm.c:184: test_proc_pid_maps: Assertion `rv == 0' failed.
> # /usr/bin/timeout: the monitored command dumped core
> # Aborted
> not ok 5 selftests: proc: proc-empty-vm # exit=134
> # selftests: proc: proc-pid-vm
> # proc-pid-vm: proc-pid-vm.c:365: main: Assertion `rv == len' failed.
> # /usr/bin/timeout: the monitored command dumped core
> # Aborted
> 
> Please find attached lshw output, dmesg, config and lsmod.
> 
> I am available for further diagnostics.
> 
> The platform is Ubuntu 22.10 kinetic kudu on a Lenovo Ideapad 3 15ITL6 laptop.

What the output of "cat /proc/self/maps" ?
