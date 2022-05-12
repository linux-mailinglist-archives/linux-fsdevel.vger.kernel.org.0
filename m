Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC6A5248AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 11:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351872AbiELJPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 05:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351862AbiELJPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 05:15:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3420D227831;
        Thu, 12 May 2022 02:15:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id bo5so4257770pfb.4;
        Thu, 12 May 2022 02:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1yVCgY4QE8l5qFrVqFzJJ9uTK3QajC1JSeAXUrEX5mM=;
        b=MGUdJx5o67V+c7ivUhgeC/BUEADviIwlhokhBxj+J+gl6IETIqORALQLeC353MYEdq
         2Pv50dWwl1qTvK4mqNFOHI069/CG7FyZ13loxUH6lrmM2YVeNsaUmHum8Mp+TTRs/oeh
         ZBGlq/iUg4CymqPWX6MatUagIwHh9sqigv1U1pwp/IFJZbcDC/sE8Y+G0OKSNa80eWYW
         BLyjSxh1M6W5n5yjCmzKLV+ZcSFkjUbkiXtb+XgBTqTcLJ/SB7G8DkotwTzZEmEbSOsa
         oNAFvZbwt1QeW4GoMUD5qskyCou5gc5b1XU1x3Lv9xQyif6Bg+WLMnX/LxkveG9KxCuB
         sqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1yVCgY4QE8l5qFrVqFzJJ9uTK3QajC1JSeAXUrEX5mM=;
        b=lLRz/8h4NizjwgN8zoRozPJbvNPyIQBVNxFc/iUuFBpY7WDnWaV2138zYnD81GnNLm
         30tcGYNNrWfeHmdltgQdGYniLiTT18FOISFaVX6v2JItia+fkm4ovaaG4mT3zs+TpBud
         M14UGMuPkezOXY+m1Ro9PUKv91WkIxp7YpobxURf7JosYRcehDxGp04xBiU+qaN80YRN
         3HG10ZYle0roxs/eiJTckZJApb+FqrZh+XnURV/rYSvGFQgtxLtRNeYNWlB72Pk0ezjd
         E20xX15YCHWJGKis9tGmnj2udTBHDxfH2lCb9XaE3fMFrfpeqI7wHf0zu/gx2TZoquzc
         67xw==
X-Gm-Message-State: AOAM530ZejMVa6hcqdYCAce1jrg5m9lF/RmP93z+48aHiiYJ6hpV5Mo8
        stX+ppHOxBlWhXVRVhjwmU0=
X-Google-Smtp-Source: ABdhPJxaigst32EHE9ix2EpasU4GC9GvtV1b4JcFlMBs/Eobm4jyuO5205pcB0haARI31D6QIfoeng==
X-Received: by 2002:a05:6a00:885:b0:510:950f:f787 with SMTP id q5-20020a056a00088500b00510950ff787mr22839855pfj.83.1652346911472;
        Thu, 12 May 2022 02:15:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:6c64])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902724300b0015e8d4eb20esm3353001pll.88.2022.05.12.02.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 02:15:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 11 May 2022 23:15:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     torvalds@linux-foundation.org, holt@sgi.com, mcgrof@kernel.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jack@suse.com,
        jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
        djwong@kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com
Subject: Re: [REPORT] syscall reboot + umh + firmware fallback
Message-ID: <YnzQHWASAxsGL9HW@slm.duckdns.org>
References: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
 <20220512052557.GD18445@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512052557.GD18445@X58A-UD3R>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Just took a look out of curiosity.

On Thu, May 12, 2022 at 02:25:57PM +0900, Byungchul Park wrote:
> PROCESS A	PROCESS B	WORKER C
> 
> __do_sys_reboot()
> 		__do_sys_reboot()
>  mutex_lock(&system_transition_mutex)
>  ...		 mutex_lock(&system_transition_mutex) <- stuck
> 		 ...
> 				request_firmware_work_func()
> 				 _request_firmware()
> 				  firmware_fallback_sysfs()
> 				   usermodehelper_read_lock_wait()
> 				    down_read(&umhelper_sem)
> 				   ...
> 				   fw_load_sysfs_fallback()
> 				    fw_sysfs_wait_timeout()
> 				     wait_for_completion_killable_timeout(&fw_st->completion) <- stuck
>  kernel_halt()
>   __usermodehelper_disable()
>    down_write(&umhelper_sem) <- stuck
> 
> --------------------------------------------------------
> All the 3 contexts are stuck at this point.
> --------------------------------------------------------
> 
> PROCESS A	PROCESS B	WORKER C
> 
>    ...
>    up_write(&umhelper_sem)
>  ...
>  mutex_unlock(&system_transition_mutex) <- cannot wake up B
> 
> 		 ...
> 		 kernel_halt()
> 		  notifier_call_chain()
> 		   hw_shutdown_notify()
> 		    kill_pending_fw_fallback_reqs()
> 		     __fw_load_abort()
> 		      complete_all(&fw_st->completion) <- cannot wake up C
> 
> 				   ...
> 				   usermodeheler_read_unlock()
> 				    up_read(&umhelper_sem) <- cannot wake up A

I'm not sure I'm reading it correctly but it looks like "process B" column
is superflous given that it's waiting on the same lock to do the same thing
that A is already doing (besides, you can't really halt the machine twice).
What it's reporting seems to be ABBA deadlock between A waiting on
umhelper_sem and C waiting on fw_st->completion. The report seems spurious:

1. wait_for_completion_killable_timeout() doesn't need someone to wake it up
   to make forward progress because it will unstick itself after timeout
   expires.

2. complete_all() from __fw_load_abort() isn't the only source of wakeup.
   The fw loader can be, and mainly should be, woken up by firmware loading
   actually completing instead of being aborted.

I guess the reason why B shows up there is because the operation order is
such that just between A and C, the complete_all() takes place before
__usermodehlper_disable(), so the whole thing kinda doesn't make sense as
you can't block a past operation by a future one. Inserting process B
introduces the reverse ordering.

Thanks.

-- 
tejun
