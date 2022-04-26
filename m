Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C253150FEA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiDZNRR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 09:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350807AbiDZNRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:17:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6A76FF76
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 06:14:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b24so22269420edu.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91VDyMZL2pDLREBt1Sv1LATwJNqE3xyYOjKPv10r2YY=;
        b=BVng6uySVdOqe68r/6n0N/r0x6IdfyFl+MLiaN3QvIYyZYryHVWX3bIVXsSdhVXJKC
         YXCRWLdo3NijEwxlmY0K6f0Dk1aoTuEDzQObIAxO4LI9+xinjZsdS07NFLIaJUcf7Qew
         cRmpWiMS60HM53MLooW+WumYUs3ITPHqG38tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91VDyMZL2pDLREBt1Sv1LATwJNqE3xyYOjKPv10r2YY=;
        b=KeANijbvFPDrDxPH12yW4Xqafl+udpRESo6Vq642yjL0EwhQ5d4gNODsTvCcRMPoYD
         yGN8H11SXFLauFxmcRfiP/+0a95x7tIRvCk0YUCTjQRVR12Bhl04NB/LdRvHiUnuPDfE
         AayN2c+uhIuSJ+Zx/l9+HFaeFVqG+gV+3y/QzY+hb6KYRdLN7lxXOBJDY/MECPBP8A8D
         YT7EbRlmyEcxEql+rZN6EgF2HtD2Xc9PHq8xK6QskaU7rU29CgfxTRs1DDjivz5idanB
         wRV/DIbRFUrzX5kWQlyiaVNzJns/4N9Kq7IPq+YOo972wiGDxg0EV2sH/vh7BL3Qqrmk
         iM8g==
X-Gm-Message-State: AOAM5317ybTgxIfo69eWUciBnQWEvShgln1Na0cf+ZPSXldVuPlPLN+f
        DaHLjWUjuHb4Ve9D5GeIvmCKZ8e1+KLDuObT1gvSew==
X-Google-Smtp-Source: ABdhPJzm55kg4MK49oObjpEyqrN7KOj0CtVUJrghFia29cDfoIdVZQ4cDNH9C6+4jVN1DAQzTOKeSPz+Sa5eHOeDhxI=
X-Received: by 2002:a05:6402:270e:b0:424:55a:d8a3 with SMTP id
 y14-20020a056402270e00b00424055ad8a3mr24447568edd.221.1650978841608; Tue, 26
 Apr 2022 06:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <165002363635.1457422.5930635235733982079.stgit@localhost>
 <CAJfpegs=_bzBrmPSv_V3yQWaW7NR_f9CviuUTwfbcx9Wzudoxg@mail.gmail.com>
 <YmUKZQKNAGimupv7@redhat.com> <CAJfpegsUfANp4a4gmAKLjenkdjoA-Gppja=LmwdF_1Gh3wdL4g@mail.gmail.com>
 <YmftOLZ59j359zGG@redhat.com>
In-Reply-To: <YmftOLZ59j359zGG@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 26 Apr 2022 15:13:50 +0200
Message-ID: <CAJfpegv3UfJbzkXTk0V80hiY-d4hRBbrn67DMnTR6Svw8+11cw@mail.gmail.com>
Subject: Re: [PATCH] fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT flag
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Dharmendra Singh <dsingh@ddn.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        German Maglione <gmaglione@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 26 Apr 2022 at 15:01, Vivek Goyal <vgoyal@redhat.com> wrote:

> Agree that it probably is a nice change if we had introduced this in the
> beginning itself. Its like extra saftey net. But now if we add it, it
> will break things which is not nice. So at this point of time, it probably
> is better to fix fuse servers instead and set ->flags2 to zero, IMHO.

I think the question is whether the "unfixed" virtiofsd
implementations made it into any sort of release or not.

If not, then I think it's fine to break unreleased versions, since
they are ephemeral anyway.

Thanks,
Miklos
