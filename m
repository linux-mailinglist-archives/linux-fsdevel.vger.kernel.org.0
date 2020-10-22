Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4FC296274
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 18:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901598AbgJVQPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 12:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901497AbgJVQPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:15:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B82C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 09:15:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c16so2905413wmd.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 09:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3U9VBQBuc5Q3i6L3LlgG5vm2ptKkL3S7VBdp7klPUkY=;
        b=PEYN4AsJm8FDRp0ciErKiSuDO3vSuEtAXt/TwjxSfS3UmqAo/9E+9UHg9mZ7FsrDOP
         PghzW/3E/2e0pbnWYvSPIt2MgVRdQCg2QmP/io79OGC0bWxIY5XdFuRrn1MuMca/fNO4
         4XD6CeiZyXyL9F1vavHftdBs1Idoif6I4wJmX34miYnovS9W8s6noeKUcbCh6O+z2fgO
         ZCDw+pYWY0Kf/9vm3TLsV6iboROjgsHp7mwk+eB+HINK7GsUt8jMQsJMB6plLj0JSHvi
         MUgeRLx9LLmXJwE4OVq2h3trduU2kxeGHDtPJKq/sXYGoehcl8QPQUz/HrTQ0c19n991
         2o5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3U9VBQBuc5Q3i6L3LlgG5vm2ptKkL3S7VBdp7klPUkY=;
        b=NC3PYmpDvErspcFDrfa3ZC+KlaX/lp28/pKH+NUYMIjycYMzwnA/5/iyhySMw8Rq0h
         hYqvkIQmiVlzhGFTzH/4kANdcINMfriXlqkvdSqeZjGp/lvfL6nEVRF6RRVA4dcohN++
         tqmfkfzE9wQI8D8Q3AHzlDr4fp9ARx41u3unKNSKyroyVRMGkdNZdaa64ml+ucLR2xFG
         q/HjfoDXF+eNoiAjrIuV2yTvlsBpLce6IuzXuIR58dOEjM4U+3kOAi7b8DCltKcZCnyZ
         UdPGxHj0aA5mEJFj4UMUS7vEIz/EhETG3cCOVRxZT1Gr/WIgDYaKhOORDyoibgkBqqlZ
         YxGw==
X-Gm-Message-State: AOAM531bzh3ft1v8WfK+w+V01RN6xl41uzAbTgwNWrV8+nJgrOds8GWc
        +rTezkUA98HdfYEwY/DsCCQ2dQ==
X-Google-Smtp-Source: ABdhPJwGBFX7yYENEslKp1esKvy183GV5GC1ELA5t8LCCzu1wMiKXhEeh/JvmE6iRQV3DiBnbVB/7g==
X-Received: by 2002:a1c:e089:: with SMTP id x131mr3440562wmg.78.1603383299988;
        Thu, 22 Oct 2020 09:14:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id c130sm3983763wma.1.2020.10.22.09.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 09:14:59 -0700 (PDT)
Date:   Thu, 22 Oct 2020 17:14:57 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Antonio SJ Musumeci <trapexit@spawn.link>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Alessio Balsini <balsini@android.com>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 2/4] fuse: Trace daemon creds
Message-ID: <20201022161457.GB36774@google.com>
References: <20200924131318.2654747-1-balsini@android.com>
 <20200924131318.2654747-3-balsini@android.com>
 <CAJfpegvvf4MfO4Jw5A=TJJfrxN_1xFTmwBJ2bb9UfzYBgkhzzQ@mail.gmail.com>
 <a5d94f04-a980-ee3f-bd8d-42df3a859777@spawn.link>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d94f04-a980-ee3f-bd8d-42df3a859777@spawn.link>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:16:20PM -0400, Antonio SJ Musumeci wrote:
> On 9/30/2020 2:45 PM, Miklos Szeredi wrote:
> > On Thu, Sep 24, 2020 at 3:13 PM Alessio Balsini <balsini@android.com> wrote:
> > > Add a reference to the FUSE daemon credentials, so that they can be used to
> > > temporarily raise the user credentials when accessing lower file system
> > > files in passthrough.
> > Hmm, I think it would be better to store the creds of the ioctl()
> > caller together with the open file.   The mounter may deliberately
> > have different privileges from the process doing the actual I/O.
> > 
> > Thanks,
> > Miklos
> 
> 
> In my usecase I'm changing euid/egid of the thread to whichever the uid/gid
> was passed to the server which is otherwise running as root.
> 

Ack, in the next patch set I will store the creds of the ioctl() caller.

Thanks,
Alessio

