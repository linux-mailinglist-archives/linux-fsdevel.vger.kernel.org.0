Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7DB32D362
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 13:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhCDMil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 07:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbhCDMi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:38:26 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D65C061756
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Mar 2021 04:37:45 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id v123so10278816vsv.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Mar 2021 04:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8UaE9csxwrHB+GKIj9/WjJw8ugPbi9uDRrPYm3++N4=;
        b=VCeRywpRl9tthKy/YkqPn830EDBnJC9oKrV74b7ty4YGvaW1GCRK46/SMFmPOVOrHl
         7srY5qdFvGd8rC717zUCHbh8BVf50YSyBvSbvz1jNunMeatfGNvLTsea9IJXbXW4RTgI
         M5/aaz3+f+4SQ/ZLYAoUOotIQudlbpttEozeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8UaE9csxwrHB+GKIj9/WjJw8ugPbi9uDRrPYm3++N4=;
        b=j2tsKcRezezzMQuYA6wKkabHKjM7js49UxLQIBjASR3k1lWXGO4lHKeuFIQaRWq+aO
         fSNdAOObOjqdiudbZxieVefDreD2k4OwtkQr/zSkpBx3FDMF0rjpgRZqyhihXX5135PC
         ztZk+i6uyTxa9Iqfgc2me4EuNQ+K8xPhPUcXW5SWa0x8VTRrfveVOuzCJ8oYbxxyFW21
         N3VhaTy8wtbmGum6IAHyu1cm3dkGA/oVySgqj8c3bNt6hMYuknnOlfhlGH7xaYzaNkmt
         lhfhQxiPYh8B1LNhsnjBw/jpKgVfkhYXDFY/qVwUPS7XrSA1ANt10Fk6hRK0fFc/3sG+
         i7OQ==
X-Gm-Message-State: AOAM532c1z+ncYhnRIOQ0I8b8LqVYDASdVsny6ykykmp5IdA7h1g7MBo
        AGF5UfpMYoHZrVZozoKnxPZpO8KWQP8eLiCDpQFF8Q==
X-Google-Smtp-Source: ABdhPJzt3IbiwcOcZzChDNLGDZsDtMGvPNVxRuD3h93EJEoWW2BbIuBHe7pv2bYK7bCXN3TDqdBLB0haa+fISDzjxUE=
X-Received: by 2002:a67:c992:: with SMTP id y18mr2211514vsk.7.1614861464960;
 Thu, 04 Mar 2021 04:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20210304090912.3936334-1-amir73il@gmail.com>
In-Reply-To: <20210304090912.3936334-1-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 4 Mar 2021 13:37:34 +0100
Message-ID: <CAJfpegu9E0qHyNuYnQncWowYjpB+W3ktmTr0_PT=AHVwKE1Dig@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix live lock in fuse_iget()
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 4, 2021 at 10:09 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Commit 5d069dbe8aaf ("fuse: fix bad inode") replaced make_bad_inode()
> in fuse_iget() with a private implementation fuse_make_bad().
>
> The private implementation fails to remove the bad inode from inode
> cache, so the retry loop with iget5_locked() finds the same bad inode
> and marks it bad forever.

Thanks, applied.

Miklos
