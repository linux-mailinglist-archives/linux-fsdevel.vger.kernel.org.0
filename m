Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B762484838
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 20:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiADTGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 14:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiADTGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:06:40 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F800C061761
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jan 2022 11:06:40 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id co15so32077940pjb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jan 2022 11:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wIU3J482L2HImj/M7R+fXYKFsH0w5gR4YGEoAmTcGjc=;
        b=JqUfSCH0gNRmBEZivXmIZBqiJWZC3f0gKXawXUk/5m81ir0nsEab8NnikNVCnTcv58
         DPY/ZNMzske4DAC3qW8/DLG5yzRvXWVhuec4ZfWH2YXtvLWPKvNcuksYK9i40dwOcMsP
         t6wQdZzdgqdWepVsDdwp1di0fLpKCOEH2XMYCtSYRmSTjflbk2gGiGDBKS1eX1xPLZRQ
         q/To+qpyyGftKnvUPpKii3aMYeQXLUAHc/jqnx54CAU+1xT5xU1Loi827jxvy+irpYRh
         AENMWfS4vjakeqFse5b3PrOSfU7XWqMqWP9U3MTNjZrqHOZXCK4QXcpG57MOvBety5jO
         5rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wIU3J482L2HImj/M7R+fXYKFsH0w5gR4YGEoAmTcGjc=;
        b=B9mef1exhFD3fO93aa5R73VAokwY3WtN6g2GvIu3D8K2J5fyPAyMCnVrmj9j+ycZ3h
         8vsyxSdn88a374Za8sUxuaAaaSF32cPnhxGDxwX9vnc12lDICeGz7xOtJUurV+Rs+IiU
         z9M3rwJIwOfN3m/YUiiwzo5u/KNZWP81SDYcuockFK5a8UvDbVmAPQ1/bUwGALtOGVG8
         uLpy2BahjbxV/hVWxemyo51B7R88B/UZXx7LEAHXjJNRyUPC9NUzY8mfNG8GY+96h6lv
         aRGpVIXVQOJAVTB7FNc4r8CSxMKZdZHQYhHcoNsnTtCIzNgRierRPWuDKyf6nny/m/BL
         kmow==
X-Gm-Message-State: AOAM533TtQ3Vr9nD/uACsiup5kxwT0kL2WKWKDX9DThjzLtCtWiQtKqj
        k2M0VDXasI8/xh/gM/E1MGROeQ==
X-Google-Smtp-Source: ABdhPJx2Knho2SUpw0270NeHzwWXeefQ77+9gVkZzvHPJPl8XnmGVGi0b0nSalDE/G82t9/BjYsRAA==
X-Received: by 2002:a17:90b:1b04:: with SMTP id nu4mr19349907pjb.205.1641323199661;
        Tue, 04 Jan 2022 11:06:39 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:7bfc])
        by smtp.gmail.com with ESMTPSA id x40sm40917010pfu.185.2022.01.04.11.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:06:39 -0800 (PST)
Date:   Tue, 4 Jan 2022 11:06:38 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v11 01/14] fs: export rw_verify_area()
Message-ID: <YdSavheBK2RcpKZ1@relinquished.localdomain>
References: <cover.1630514529.git.osandov@fb.com>
 <9cd494dbd55c46a22f07c56ca42a399af78accd1.1630514529.git.osandov@fb.com>
 <YZanS89YcCeN9i3y@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZanS89YcCeN9i3y@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 18, 2021 at 11:19:39AM -0800, Omar Sandoval wrote:
> On Wed, Sep 01, 2021 at 10:00:56AM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > I'm adding Btrfs ioctls to read and write compressed data, and rather
> > than duplicating the checks in rw_verify_area(), let's just export it.
> > 
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/internal.h      | 5 -----
> >  fs/read_write.c    | 1 +
> >  include/linux/fs.h | 1 +
> >  3 files changed, 2 insertions(+), 5 deletions(-)
> 
> Could I please get an ack from the VFS side on this patch and "fs:
> export variant of generic_write_checks without iov_iter"? We're going
> the route of doing this as a Btrfs ioctl since we couldn't agree on a
> generic interface, so this is all I need from the VFS.

Ping.
