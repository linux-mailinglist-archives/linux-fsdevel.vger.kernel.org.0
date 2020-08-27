Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99990254882
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgH0PG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 11:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgH0PEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:04:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B4EC061264
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 08:04:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w186so3563959pgb.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KtUav8kJRw7NW9MJAIseBMSxLDruLjM6HXWwKu/0M74=;
        b=GQ0jmdkWMjQEAalY++3/Ht0h8crzz739ENSMCZK40b0dOvb1c0kZUmimmf9K8t4Zgx
         Fao+oOBxd4WqUDkaMoDp6QkT7HgLYirHRqq+Fk9tpRQi8On7xp9MwFMWUauS7YXIVztA
         W9VmcStAzDZlNyQOegil/seXWpDF/Iz/wobtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KtUav8kJRw7NW9MJAIseBMSxLDruLjM6HXWwKu/0M74=;
        b=VpB4WbMBznsobFpEDOzNpJmpV4D9+shSLgnqfqkIPyBHkQ/SS7MYNIR/LM2zunveKo
         yu15GeCPCcjQZcigXu5aD/C9eyEudfQkMzTo2pNufIsWFkH1ueUaV2tspV8+tAIqAEzG
         U2lBS/nGPCsM/bmVdvGYHR1KIwaKUvJdp4z2tc5xCP559SYTi3kX2BzFC2rtd52JkPDa
         o77awHD65rws4e9CMnnw7uO7/zaBdic+gmPgc5SupCrZGlCu30KRtx/kBQMZDteAGc3W
         Td5VIzh+p2nCXNM426Ob1xtgIlKvXBAcVx1MG6ISyTBZZexj12BvdWuCyesVV+5FtQP1
         S1yg==
X-Gm-Message-State: AOAM533Fi/R/vVso8Onj2FVu4mDrcNsDEwWA5Ddh9I7IGJa7KSpFpmVl
        5fpC8HFxcrQnGlcs/Jx39RaPBw==
X-Google-Smtp-Source: ABdhPJwXBmp6C1isCRM1EzGs2j/sEIzbekMjfQYDts14g/FnXYPAwZwvsuLxGAshJVtz3JQiRyN6iw==
X-Received: by 2002:a63:1822:: with SMTP id y34mr15725223pgl.364.1598540657751;
        Thu, 27 Aug 2020 08:04:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o15sm298606pgr.62.2020.08.27.08.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:04:16 -0700 (PDT)
Date:   Thu, 27 Aug 2020 08:04:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <asarai@suse.de>,
        io-uring@vger.kernel.org
Subject: Re: [PATCH v4 3/3] io_uring: allow disabling rings during the
 creation
Message-ID: <202008270803.6FD7F63@keescook>
References: <20200813153254.93731-1-sgarzare@redhat.com>
 <20200813153254.93731-4-sgarzare@redhat.com>
 <202008261248.BB37204250@keescook>
 <20200827071802.6tzntmixnxc67y33@steredhat.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827071802.6tzntmixnxc67y33@steredhat.lan>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 09:18:02AM +0200, Stefano Garzarella wrote:
> On Wed, Aug 26, 2020 at 12:50:31PM -0700, Kees Cook wrote:
> > On Thu, Aug 13, 2020 at 05:32:54PM +0200, Stefano Garzarella wrote:
> > > This patch adds a new IORING_SETUP_R_DISABLED flag to start the
> > > rings disabled, allowing the user to register restrictions,
> > > buffers, files, before to start processing SQEs.
> > > 
> > > When IORING_SETUP_R_DISABLED is set, SQE are not processed and
> > > SQPOLL kthread is not started.
> > > 
> > > The restrictions registration are allowed only when the rings
> > > are disable to prevent concurrency issue while processing SQEs.
> > > 
> > > The rings can be enabled using IORING_REGISTER_ENABLE_RINGS
> > > opcode with io_uring_register(2).
> > > 
> > > Suggested-by: Jens Axboe <axboe@kernel.dk>
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > Where can I find the io_uring selftests? I'd expect an additional set of
> > patches to implement the selftests for this new feature.
> 
> Since the io_uring selftests are stored in the liburing repository, I created
> a new test case (test/register-restrictions.c) in my fork and I'll send it
> when this series is accepted. It's available in this repository:
> 
> https://github.com/stefano-garzarella/liburing (branch: io_uring_restrictions)

Ah-ha; thank you! Looks good. :)

-- 
Kees Cook
