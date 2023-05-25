Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A7E71059B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 08:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjEYGPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 02:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjEYGPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 02:15:07 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F2CE6
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 23:15:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2536b4b3398so1020201a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 23:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684995305; x=1687587305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWj1NDHztpajdByGl8W9ETBey9E/craKURuflERme5A=;
        b=irJu/0HkrPgR40BbmgvreqkaM2s6s1J+fNgkoXZp74IJbNh5VwXtvXXPHdxVPynT0T
         mmOIltoV800LH/SE/ex3EspLQwYY2b9iV9NSdJvm6Aw9j2VfjI7UblX5/RX4B0+AzM32
         JOwMEtC8nsh3lfyOetM8RA7azSZnEu30o4L9+/vWfuAV0dQYfAcd/HV0lakgeR+u/N0j
         CfSnbK7YdKNUsv+83IYS9+zaO/Tp20JL2u3n+uTA/Xg8N1YXA++HrixSolt2vagu+UDu
         0DMcOlITNTrw8Mq6frP5w/hJm3PgnC+QtJ+YRGM9kHz976zhmEkWa/+sRJj7FHoFFLtC
         XwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684995305; x=1687587305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWj1NDHztpajdByGl8W9ETBey9E/craKURuflERme5A=;
        b=jZDbHUwjCnstBqjmT2FWhMVtP4cAja3Rc2Eic7ihkGz2ATZvwKcgnEXTAPxyv8AB3l
         KWOmCrqg6bc7u8j87wCyFdhzLmDpYpjMekIBbF8qUwM0z3iY71eYOBw+O5bvpIDeM5rH
         9suNlweMObR+6ZaaHKL6HpXyvLBclxExrCacbj/1OqrskWK+vCxm4ZzQwkFGXvM1BfqL
         Cdgj0lGxx+vBgjFvEak1548dRY+u4atO52BRI2flSGuoJEg4aVtoQP2MT629ks7nEWth
         Sj/sCZv1mQk7CHXAvMsXl/KRzrQCHu+kwAmCVrsR93cSxEHByVsUWgpyhMjUFMqDiaH/
         dYtg==
X-Gm-Message-State: AC+VfDwhooq1KJexZUV8p1rJoTI439qbPVHKk1qqgS+Qxg2R8e+lqo7F
        rkfH9d4lFiZ2a1CPKn7mUEBgskBEePH/PFTiYMs=
X-Google-Smtp-Source: ACHHUZ4TZTH+0zaquEfsgNr1vqFgjfKek1/wEZuZifn47Awn6TCsmUpojm5o1bYrQESref13pZlAmQ==
X-Received: by 2002:a17:90b:3841:b0:255:63ae:f943 with SMTP id nl1-20020a17090b384100b0025563aef943mr485225pjb.35.1684995305486;
        Wed, 24 May 2023 23:15:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a578300b00247735d1463sm476657pji.39.2023.05.24.23.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 23:15:04 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q24FZ-003cdd-2J;
        Thu, 25 May 2023 16:15:01 +1000
Date:   Thu, 25 May 2023 16:15:01 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     Eric Sandeen <sandeen@sandeen.net>, dchinner@redhat.com,
        djwong@kernel.org, heng.su@intel.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lkp@intel.com
Subject: Re: [Syzkaller & bisect] There is "soft lockup in __cleanup_mnt" in
 v6.4-rc3 kernel
Message-ID: <ZG785SwJtvR4pO/6@dread.disaster.area>
References: <ZG7PGdRED5A68Jyh@xpf.sh.intel.com>
 <f723cb17-ca68-4db9-c296-cf33b16c529c@sandeen.net>
 <ZG71v9dlDm0h4idA@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG71v9dlDm0h4idA@xpf.sh.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 01:44:31PM +0800, Pengfei Xu wrote:
> On 2023-05-24 at 22:51:27 -0500, Eric Sandeen wrote:
> > On 5/24/23 9:59 PM, Pengfei Xu wrote:
> > > Hi Dave,
> > > 
> > > Greeting!
> > > 
> > > Platform: Alder lake
> > > There is "soft lockup in __cleanup_mnt" in v6.4-rc3 kernel.
> > > 
> > > Syzkaller analysis repro.report and bisect detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230524_140757___cleanup_mnt
> > > Guest machine info: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/machineInfo0
> > > Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/repro.c
> > > Reproduced syscall: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/repro.prog
> > > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/bisect_info.log
> > > Kconfig origin: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/kconfig_origin
> > 
> > There was a lot of discussion yesterday about how turning the crank on
> > syzkaller and throwing un-triaged bug reports over the wall at stressed-out
> > xfs developers isn't particularly helpful.
> > 
> > There was also a very specific concern raised in that discussion:
> > 
> > > IOWs, the bug report is deficient and not complete, and so I'm
> > > forced to spend unnecessary time trying to work out how to extract
> > > the filesystem image from a weird syzkaller report that is basically
> > > just a bunch of undocumented blobs in a github tree.
> > 
> > but here we are again, with another undocumented blob in a github tree, and
> > no meaningful attempt at triage.
> > 
> > Syzbot at least is now providing filesystem images[1], which relieves some
> > of the burden on the filesystem developers you're expecting to fix these
> > bugs.
> > 
> > Perhaps before you send the /next/ filesystem-related syzkaller report, you
> > can at least work out how to provide a standard filesystem image as part of
> > the reproducer, one that can be examined with normal filesystem development
> > and debugging tools?
> > 
>   There is a standard filesystem image after
> 
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> image is named as centos8_3.img, and will boot by start3.sh.

No. That is not the filesystem image that is being asked for. The
syzkaller reproducer (i.e. what you call repro.c) contructs a
filesystem image in it's own memory which it then mounts and runs
the test operations on.  That's the filesystem image that we need
extracted into a separate image file because that's the one that is
corrupted and we need to look at when triaging these issues.
Google's syzbot does this now, so your syzkaller bot should also be
able to do it.

Please go and talk to the syzkaller authors to find out how they
extract filesystem images from the reproducer, and any other
information they've also been asked to provide for triage
purposes.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
