Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F43C578488
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 15:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbiGRN5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 09:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbiGRN5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:57:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2437627FCB
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 06:57:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id tk8so10024074ejc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 06:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Q3uEtxXQH+8HtIo3iz32RrKcwyWRkxKSodo4gn5GDw=;
        b=Av8ODcnkmXm4r101+J5vII1aGyhOURJvXyyESQGrOE3uQ3ClZ/GZLd3In42FgfADLu
         r/IBatqVMR7kL2Z09tWfnrVGueOJRs56mC5MgGUXjq4HvIhSdFfKkThql0hYO7c4MZLb
         5hQAaoqW+iWISgMMTLHeh3Ca/2Gy06lQ9QjoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Q3uEtxXQH+8HtIo3iz32RrKcwyWRkxKSodo4gn5GDw=;
        b=GneZtNBLS8sy+v7vbb6M5puDvSw+b+QND4wo0/vrD0kHVPVxumxGjqRjIBroFCTNYo
         sz/YVvuYj4ZlfzedTJd50XHVopVzlUEwHeyAYLc0CF2SSbRp7FeVfLRSvVzWlad4mbxs
         X7eAE05/hO6uCLO6xyVi0uaU7WrdFJRkIFeO6IAhEPeTUeOXoRLqKQ2JS4neW+cLYh1p
         vhPFMCJ/hUuD4FjfRkA9OdzvX0b8wp53n8MhMJRCCgocmsRdPElpoDSdLAcxn4EI47UW
         5BVONw3BneBOPW9RkJU+zIzvnOQwH41IDpRBCdmKeFg7WfJTFr6EWbBEvT6t9h+elqcH
         HZ0A==
X-Gm-Message-State: AJIora/5o53L+Bg730ssqKIre8HKE6NmGWVblD1Xh6D2ZHPgFc96oYKh
        5FRbQ9LGnstBUzy01OBCVM2k1QHsZV0CqQJOpVVXgw==
X-Google-Smtp-Source: AGRyM1vs94xT5B5/wJUC8zscwbb9Bwm1tb4laNz7t+iuGAhiIIrztL5x2TPsz8NzEhW+my6SFW++4DHP/PxoCjfN0lc=
X-Received: by 2002:a17:907:75f1:b0:72b:9e40:c1a9 with SMTP id
 jz17-20020a17090775f100b0072b9e40c1a9mr23951238ejc.523.1658152648785; Mon, 18
 Jul 2022 06:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <490be4e0b984e146c93586507442de3dad8694bb.camel@mediatek.com> <20220705085308.32518-1-ed.tsai@mediatek.com>
In-Reply-To: <20220705085308.32518-1-ed.tsai@mediatek.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Jul 2022 15:57:17 +0200
Message-ID: <CAJfpegvez_DodKK+CJc1a7EHLDB+4wCSB2ay5NZWUCyoq1_ANw@mail.gmail.com>
Subject: Re: [PATCH 1/1] fuse: add fuse_d_iput to postponed the iput
To:     Ed Tsai <ed.tsai@mediatek.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        chenguanyou <chenguanyou9338@gmail.com>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?UTF-8?B?WW9uZy14dWFuIFdhbmcgKOeOi+ipoOiQsSk=?= 
        <Yong-xuan.Wang@mediatek.com>, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 5 Jul 2022 at 10:53, Ed Tsai <ed.tsai@mediatek.com> wrote:
>
> When all the references of an inode are dropped, and write of its dirty
> pages is serving in Daemon, reclaim may deadlock on a regular allocation
> in Daemon.
>
> Add fuse_dentry_iput and some FI_* flags to postponed the iput for the
> inodes be using in fuse_write_inode.

I don't understand.

The inode must have a positive refcount during fuse_write_inode(), so
how would delaying an iput() change anything?

Thanks,
Miklos
