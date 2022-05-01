Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4A7516287
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 May 2022 09:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiEAIDP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 May 2022 04:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiEAIDO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 May 2022 04:03:14 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091D27B575
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 00:59:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 4so15124469ljw.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 May 2022 00:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=bwS6neoJgwAscLo7SMr+briaL7cQkz+klklthFb5lCU=;
        b=cY9xiKClPzQfCMz80gVj3KC8oirqpcOaA49JLl1+D5f+dtBt0xpRAm8iFoK/+NkSUw
         KjJQgwMoGYF6NG4HVB8h4RIK++OlZ/2fPHOjNCOI10JsGKnGnBPFTJU7majqwl91uYl3
         IM8y/RL1P2EfDPdTsf5UhkE34NhiFe8wRaoAsuDKoJtyEYpXDrSE/0iuT0JKzI2xvwLN
         dabg7oqfUWmMgB2K2NVXcHYz1WOCiMOoiI9qFP3zKwA2rtNex2LO03rQcnBra04VgrUA
         MH0T2f5I0oyVUEeTa2VAdIzlvRRKr0JA4tmyHRzZ3Yo40zuNUMO7Q2/FecTh2UBEZ5nY
         b5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=bwS6neoJgwAscLo7SMr+briaL7cQkz+klklthFb5lCU=;
        b=DxxbymZ5HNQ31kbHj7XyLr0+8nEfyLGRX1353JEWx7T/mNYOpFoyIl7hxWcwe2S+CM
         5tMqEY9OW1/XNPHbJuG1Ys5LXWQ7u6nqnS5w3+iHzs12NbkyELmRo2X706U3cm8jvKfM
         8XoxMeJtWrGXkffhm2vPrk4q6Zy6P4rVrOQXiig3HuVRTGLCWnmvbZ8Pxnt8+WODJHY4
         bIQ754jZikxQKJL40ZejoSyuBDG9rv97FALc78IK3r7y1Zzf7xQpChccr88uKH72JNOY
         xui2Unn6k9ngkjEXLorHBH5cgZuTejswJV3zWeeDMPTAp1UlTx4RLTXSGM0pauClq9Of
         3sQw==
X-Gm-Message-State: AOAM533069n7/JamQS1dUJPl5UaJ//Al10CbiBkFJIGchrbguOrDd3hb
        xPrFavHo/6rVL/ILgekdvEITfUC0tzeCZCtHOfWR6A==
X-Google-Smtp-Source: ABdhPJwVs2ZVv+Eaq5VyLrhX5r9W7NBvf4my2q1OF2UJtKn+DFVoi8+nGzLLoOvLndBDI7z5HBcmwn406loffgvhLno=
X-Received: by 2002:a05:651c:4c7:b0:24f:4017:a2ce with SMTP id
 e7-20020a05651c04c700b0024f4017a2cemr4870748lji.5.1651391987333; Sun, 01 May
 2022 00:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220428233849.321495-1-yinxin.x@bytedance.com> <YmvbwKSdiCosPhAV@B-P7TQMD6M-0146.local>
In-Reply-To: <YmvbwKSdiCosPhAV@B-P7TQMD6M-0146.local>
From:   Xin Yin <yinxin.x@bytedance.com>
Date:   Sun, 1 May 2022 15:59:37 +0800
Message-ID: <CAK896s701pZ_VzRUGLA=g5poAc+oqHqD=Swp14AVxND7ZVvg3A@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 0/1] erofs: change to use asynchronous
 io for fscache readahead
To:     jefflexu@linux.alibaba.com, xiang@kernel.org, dhowells@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, boyu.mt@taobao.com,
        lizefan.x@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 29, 2022 at 8:36 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> Hi Xin,
>
> On Fri, Apr 29, 2022 at 07:38:48AM +0800, Xin Yin wrote:
> > Hi Jeffle & Xiang
> >
> > I have tested your fscache,erofs: fscache-based on-demand read semantics
> > v9 patches sets https://www.spinics.net/lists/linux-fsdevel/msg216178.html.
> > For now , it works fine with the nydus image-service. After the image data
> > is fully loaded to local storage, it does have great IO performance gain
> > compared with nydus V5 which is based on fuse.
>
> Yeah, thanks for your interest and efforts. Actually I'm pretty sure you
> could observe CPU, bandwidth and latency improvement on the dense deployed
> scenarios since our goal is to provide native performance when the data is
> ready, as well as image on-demand read, flexible cache data management to
> end users.
>
> >
> > For 4K random read , fscache-based erofs can get the same performance with
> > the original local filesystem. But I still saw a performance drop in the 4K
> > sequential read case. And I found the root cause is in erofs_fscache_readahead()
> > we use synchronous IO , which may stall the readahead pipelining.
> >
>
> Yeah, that is a known TODO, in principle, when such part of data is locally
> available, it will have the similar performance (bandwidth, latency, CPU
> loading) as loop device. But we don't implement asynchronous I/O for now,
> since we need to make the functionality work first, so thanks for your
> patch addressing this.
>
> > I have tried to change to use asynchronous io during erofs fscache readahead
> > procedure, as what netfs did. Then I saw a great performance gain.
> >
> > Here are my test steps and results:
> > - generate nydus v6 format image , in which stored a large file for IO test.
> > - launch nydus image-service , and  make image data fully loaded to local storage (ext4).
> > - run fio with below cmd.
> > fio -ioengine=psync -bs=4k -size=5G -direct=0 -thread -rw=read -filename=./test_image  -name="test" -numjobs=1 -iodepth=16 -runtime=60
>
> Yeah, although I can see what you mean (to test buffered I/O), the
> argument is still somewhat messy (maybe because we don't support
> fscache-based direct I/O for now. That is another TODO but with
> low priority.)
>
> >
> > v9 patches: 202654 KB/s
> > v9 patches + async readahead patch: 407213 KB/s
> > ext4: 439912 KB/s
>
> May I ask if such ext4 image is through a loop device? If not, that is
> reasonable. Anyway, it's not a big problem for now, we could optimize
> it later since it should be exactly the same finally.
>

This ext4 image is not through a loop device ,  just the same test
file stored in native ext4.  Actually , after further tests , I could
see that fscache-based erofs with async readahead patch almost achieve
native performance in sequential buffer read cases.

Thanks,
Xin Yin

> And I will drop a message to Jeffle for further review since we're
> closing to another 5-day national holiday.
>
> Thanks again!
> Gao Xiang
>
