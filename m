Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0551A29C816
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 20:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829222AbgJ0TB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 15:01:29 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37869 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371430AbgJ0TB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:01:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id f7so2398222oib.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2020 12:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/ppSbcOSIkyb0WLxSLtuLH+l8WQbDgVdPBCEGLhzkg=;
        b=ITgfknbVMZfp35lpmLI31j4Nz1iCLqIjRADmmwWUK5/lEwTGJCtZuIg7KxFWy7ItTQ
         hfI9rUKmuyCzK+NN6zramPdeJQr3T/y85wtC502Wh1aA+EVeb5zEhSA9pSEyllBQ0ubV
         93+c6QQRkdWNThoyRK6g0NvSsnUYPyNsOg5A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/ppSbcOSIkyb0WLxSLtuLH+l8WQbDgVdPBCEGLhzkg=;
        b=c7fmmUJJL46VmJhlWP08z83XC1xhMuaYtYDLVvMxTw69B2/bOwPbnz5uzkmvgAfJOT
         z4+ZG94l6evKmnZb39AHlZBp3TgQd9hZ6V5CHY/WNvB/fTt7mvQ6iBlklAB+s4Xw+4u1
         PQYd5RgVJ2tyj0vbzj8lQ0wkL97Fgh9fdY6Hc46quGRcQDz2HWwrkorbmS0nrD1vebSM
         IxW+ysoJdfGYHwTP+bPx9F9015u+YRY4ZCPb10qJIh/SKE7j6kRU9ahMjIQB9kMwEMsE
         Jrb4Tuit20MkJEO8zGaGZWgAmvUOJZ/6PEDpXnP1NpwMcqeJHsozgQ3Q1gjRnNSlRAsn
         eOXQ==
X-Gm-Message-State: AOAM5324CpuD9t/WLz1XfNO/s7fcpr+9XXh/pFEb/G9fWjpOW7a47Yxj
        exyyEMIGcHtuAxkl1eyjc4NrLZKuBHenFNxseKfj9g==
X-Google-Smtp-Source: ABdhPJwHcWbTJCbJ7AAyjVib0AGCCVAs4xDrwxrSwOfpPtT8albuTTgqSli8X5JVplvyhTsqPY2DxlaYLA/ZcsBiLvA=
X-Received: by 2002:aca:39d6:: with SMTP id g205mr2530848oia.14.1603825286633;
 Tue, 27 Oct 2020 12:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201021163242.1458885-1-daniel.vetter@ffwll.ch>
 <20201023122216.2373294-1-daniel.vetter@ffwll.ch> <20201023122216.2373294-3-daniel.vetter@ffwll.ch>
 <20201027185100.GD12824@infradead.org>
In-Reply-To: <20201027185100.GD12824@infradead.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 27 Oct 2020 20:01:15 +0100
Message-ID: <CAKMK7uERSRmJ+E03SWsXcjVEbg24pzbVcXf7dpCvcR1JvnTcnA@mail.gmail.com>
Subject: Re: [PATCH 03/65] mm: Track mmu notifiers in fs_reclaim_acquire/release
To:     Christoph Hellwig <hch@infradead.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Qian Cai <cai@lca.pw>, linux-xfs@vger.kernel.org,
        "Thomas Hellstr??m" <thomas_os@shipmail.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        "Christian K??nig" <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 7:51 PM Christoph Hellwig <hch@infradead.org> wrote:
> Is there a list that has the cover letter and the whole series?
> I've only found fragments (and mostly the same fragments) while
> wading through my backlog in various list folders..

Typoed git send-email command that I only caught half-way through. I
tried to reply with apologies in a few spots, I guess I didn't cover
all the lists this spams :-/

The patch itself is still somewhere on my todo to respin, I want to
pep it up with some testcases since previous version was kinda badly
broken. Just didn't get around to that yet.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
