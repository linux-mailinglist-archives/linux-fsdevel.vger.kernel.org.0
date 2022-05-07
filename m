Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3980F51E6E9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 14:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384695AbiEGMav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 08:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384721AbiEGMap (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 08:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 784A93DDFF
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651926417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4+dYLAG02stwqQPLlW+dyXHUvNyUyia86wRiZi589s=;
        b=V8xSqt2om0S4vujzcJA8BQ5wShTB2EtNVGJkOL3G0ZHKxGfID705ptrOIGLkdyccCqNIgd
        dTIj0MmFmJsjeuXWpRAzcqyrAL3w8Th3FRysYQbTe2/NxlV4Ac3MKtLRhtsvYv8sILAiq6
        Q4e1JIarLaEeplct2wO/kgTLLD3YqEk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-rBI4eQqgNb-VwRQ2Iygwmw-1; Sat, 07 May 2022 08:26:56 -0400
X-MC-Unique: rBI4eQqgNb-VwRQ2Iygwmw-1
Received: by mail-qt1-f200.google.com with SMTP id a18-20020ac85b92000000b002f3c5e0a098so4288323qta.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 May 2022 05:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=t4+dYLAG02stwqQPLlW+dyXHUvNyUyia86wRiZi589s=;
        b=VZGw4RKf6cRsa8mAXK95HJrHQ/zJVFoGqo5IJ9mIy85R2VrxDQYJptQ9E0zwFV/uMs
         wHjDfo/z4m9tAYCdzpyUI+Uc3GL0rq5dUxRzsIzufO8Puot5u8jQfN25rBGH/6LazkEy
         kt82Uw5RxJ83NthO0KSRn1yKTwZBFEIL4LzNrPVYlPjaYQUbRIJw73lzPsJD1lIt7Emf
         G9OF7WdB+yrEgVkPS4eDH0Rf4eAyk6sqbphbTZ+xf3lYBLQBU6/P3MPlg8Hco35/kXfm
         31J1WtazBKUlh4VfSYLGtjzgtLlYahd3iJVASwmgCQhCgeI8V1mSRwDY3xt9w720MYBm
         eLNQ==
X-Gm-Message-State: AOAM5311834DyQkQj1pBIJi3iIV6kR8TJRzyeNS58X08dnOzpH5PKNvC
        QeRWkzEMpp3O08w0XxOTqTgQve144thAm0TSwCtYozNC8f96NpaYisCgY8AAAaoTFvQOHDF87LF
        q5aMIqQ+PW7UGsdb7/QpYYRmZPw==
X-Received: by 2002:ac8:5bd5:0:b0:2f3:b654:694d with SMTP id b21-20020ac85bd5000000b002f3b654694dmr7030511qtb.435.1651926415815;
        Sat, 07 May 2022 05:26:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLfIZo5FGr8KN6oBnh0aJ4xtGpFQU6VqGeZ8V9zz19d4uro3J2m/5wT+lMQ6dQ4XflVWGPUQ==
X-Received: by 2002:ac8:5bd5:0:b0:2f3:b654:694d with SMTP id b21-20020ac85bd5000000b002f3b654694dmr7030494qtb.435.1651926415569;
        Sat, 07 May 2022 05:26:55 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i22-20020ac871d6000000b002f3ad89629dsm4190439qtp.2.2022.05.07.05.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:26:55 -0700 (PDT)
Date:   Sat, 7 May 2022 20:26:49 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] idmapped-mounts: Reset errno to zero after detect
 fs_allow_idmap
Message-ID: <20220507122649.dp7iopuu7rllli7k@zlang-mailbox>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>,
        "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6275DAB9.5030700@fujitsu.com>
 <20220507085209.ortk2ybj3t2nemkc@zlang-mailbox>
 <20220507114032.za7ejzgh2bspz6kv@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220507114032.za7ejzgh2bspz6kv@wittgenstein>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 07, 2022 at 01:40:32PM +0200, Christian Brauner wrote:
> On Sat, May 07, 2022 at 04:52:09PM +0800, Zorro Lang wrote:
> > On Sat, May 07, 2022 at 01:33:33AM +0000, xuyang2018.jy@fujitsu.com wrote:
> > > Hi Zorro
> > > 
> > > Since  Christian doesn't send  a new patchset(for rename idmap-mount)
> > > based on lastest xfstests, should I send a v4 patch for the following
> > > patches today?
> > > "idmapped-mounts: Reset errno to zero after detect fs_allow_idmap"
> > > " idmapped-mounts: Add mknodat operation in setgid test"
> > > "idmapped-mounts: Add open with O_TMPFILE operation in setgid test"
> > > 
> > > So you can merge these three patches if you plan to announce a new
> > > xfstests version in this weekend.
> > > 
> > > What do you think about it?
> > 
> > Sure, you can send V4 of patch 1/5 ～ 3/5 (base on latest for-next branch
> > please), as they have been reviewed and tested. Christian's patch (about
> > refactor idmapped testing) might need more review, he just sent it out to
> > get some review points I think (cc Christian).
> 
> LSFMM happened last week so with travel and conference there simply was
> no time to rebase. It should be ready for merging once rebased.

Yes, there's only a few of patches be reviewed this week, due to most of
related people are in LSF meeting :)

> 
> > 
> > If you'd like to catch up the release of this weekend, please send your
> > v4 patch ASAP. Due to I need time to do regression test before pushing.
> > It'll wait for next week if too late.
> 
> Rebasing the patchset is _massively_ painful which is why in the cover
> letter to it I requested that patches which is why I requested
> that currently pending patchsets that touch the same code please be
> applied on top of it. (I'm happy to apply them manually on top of my
> branch.)

Understand, I did tend to merge your change soon, due to it changes the
fundament of whole idmapped test, but I can't refused other people's
patches if they're ready. One of you or XuYang has to do once rebase at
least, so I have to comply with the sequence of patch reviewed.

If you'd like to merge your patch next week, I'll notice others wait one
more week in the [ANNOUNCE] of this week, if they want to write idmapped
related patches. Is that good to you? Please try to give your patch enough
test, make sure it won't bring in big regression, then we can merge it
quickly and smoothly :)

Thanks,
Zorro

> 
> In any case, I'll have a rebased version ready on Monday (If there's no
> urgent issues I have to address somewhere else that I missed during
> travel.)
> 
> Christian
> 

