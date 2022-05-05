Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2F551B7CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 08:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbiEEGQn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 02:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiEEGQm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 02:16:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC1C46650;
        Wed,  4 May 2022 23:13:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i17so3474603pla.10;
        Wed, 04 May 2022 23:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hPCChwN70fxKmAN8N/8qwui+OHfL43odd3gHeAPd0q8=;
        b=Y8DQ/E81oo8oXjq/OXlH0hSHb5JxT7Z7U2aSMklNhxdxESdRqmT07BwEoI9nufkmSh
         XXNl58Jrnf0WfDKwmfcyzU6qrJuB/N4yf5Q5FSw+8QVHrX31IZ49B6u20eNLP+/11PHr
         E/A9YuuogwWOfTmToJ3Xf/fHevzCaOWbARPWcZUxUZXuOBDyU5BrVxQ+3el74hhAxKod
         maGAQs7hN+/Qt8wb6KGsZh3V8/YbMqEQolsyvHmJPj9nJEDhl6udCy4T+Gc4kH8RDUqX
         YWYolo8NoN3kO0YoP17f/Jn8aU+SwlpB95YAjoeTA8xOaiZoydeb2yLqH+cu57aKv29g
         MRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPCChwN70fxKmAN8N/8qwui+OHfL43odd3gHeAPd0q8=;
        b=eIQt/VGRuIDsEFgUQkkWmL15W1nxPXVNjXMCM3mRPEW3enzBApJPHQb7rf5TS6IwZh
         QHWpdtfiFACJZqH5Ok8+tP57QUDiixyrDJH0J/7E1zZRMmg6/BuUhfQ4cz7GbbRKqyda
         04S3gBXydy0urqvUA2tS4pEvIQjLHJf2A39PXWgibEPLTm/2toJxQuMJKKc0xk5/F1Zp
         4cFkQ8SXkNPc16s3IYVlBaJ5VPw9jgMMzyBPNKOLry1DxKJ0X9Ke2vw5NN8W7fzWd50F
         23MkluFiQ6q/e5Ii/EH44k5ZkaJkwt645n5UYh/1K2N8j3Y+qETGd8BO+wZLv+gEB1jo
         ZYLQ==
X-Gm-Message-State: AOAM532hHaLVtmHuW5KEsHezU4paIBryzmGel4yh2HdMsiiCISdORXRV
        3GkO18t0PvdBWA0bIpuiodWAMoEE8bo7KX6K4UM=
X-Google-Smtp-Source: ABdhPJw6V7kYDj37Er8DF4ILO71pnBsQK8iCKJPJ9N4PizW0GXzcRhWAjr724/Exlo83fzJAffo4NfY5obanYQrRWa4=
X-Received: by 2002:a17:902:d2d1:b0:15e:9b06:28b3 with SMTP id
 n17-20020a170902d2d100b0015e9b0628b3mr21557574plc.148.1651731184006; Wed, 04
 May 2022 23:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220502102521.22875-1-dharamhans87@gmail.com> <YnLRnR3Xqu0cYPdb@redhat.com>
In-Reply-To: <YnLRnR3Xqu0cYPdb@redhat.com>
From:   Dharmendra Hans <dharamhans87@gmail.com>
Date:   Thu, 5 May 2022 11:42:51 +0530
Message-ID: <CACUYsyEsRph+iFC_fj3F6Ceqhq7NCTuFPH3up8R6C+_bGHktZg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] FUSE: Implement atomic lookup + open/create
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 5, 2022 at 12:48 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, May 02, 2022 at 03:55:18PM +0530, Dharmendra Singh wrote:
> > In FUSE, as of now, uncached lookups are expensive over the wire.
> > E.g additional latencies and stressing (meta data) servers from
> > thousands of clients. These lookup calls possibly can be avoided
> > in some cases. Incoming three patches address this issue.
>
> BTW, these patches are designed to improve performance by cutting down
> on number of fuse commands sent. Are there any performance numbers
> which demonstrate what kind of improvement you are seeing.
>
> Say, If I do kernel build, is the performance improvement observable?

Here are the numbers I took last time. These were taken on tmpfs to
actually see the effect of reduced calls. On local file systems it
might not be that much visible. But we have observed that on systems
where we have thousands of clients hammering the metadata servers, it
helps a lot (We did not take numbers yet as  we are required to change
a lot of our client code but would be doing it later on).

Note that for a change in performance number due to the new version of
these patches, we have just refactored the code and functionality has
remained the same since then.

here is the link to the performance numbers
https://lore.kernel.org/linux-fsdevel/20220322121212.5087-1-dharamhans87@gmail.com/
