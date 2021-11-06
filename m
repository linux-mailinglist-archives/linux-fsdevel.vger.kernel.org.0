Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF18446EF3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Nov 2021 17:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhKFQcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Nov 2021 12:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhKFQcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Nov 2021 12:32:32 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5A5C061570;
        Sat,  6 Nov 2021 09:29:51 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 2so10925964iou.1;
        Sat, 06 Nov 2021 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GaApS5bIUkc9MY5fVgKY/PbCh5chvfhYnlb7YL8kqNU=;
        b=Duh2MaPx/buCtF9836CWcR4rEOCnb/YDt/hdeeOms25VTz9TZS9lstj/gyvk8ZVUsb
         voNezZcjtyP18jigs/8cR6mCIeSLykgIiyV275HR8wZsbns6ISLInwAHwLU+5XmnIFnI
         xnka5k41NBdCWSdyCCa8zEjW9P5XX5WYRVP2aBWbAmvoaHt19lltlRe24Dhr5pVwkuhc
         XKHNggPShuw9k7bVOCx90gr5b7ya+sxAOMNsayRGIkR5GRIU63BYn6yfsebUda7JCeA8
         VtzP5iy8gpnZiergdSfc99VP6O2V+eo3nRiIdkuZvo7p4XysHrUZsWKHvd/Lvxt4fZn2
         4tNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaApS5bIUkc9MY5fVgKY/PbCh5chvfhYnlb7YL8kqNU=;
        b=YzypKC7pKMvTA97+1IG0ecF3awBD6vzvmpshLheqs6BTi9Jj78uR0pZcw8B1KhMFYq
         e4BdYjE2xjeLPMMTFq4u/HaArQ0ncmaJtj1xMqaZqQaBDcPBtJvMyOIdejCfwIQEIX1m
         s7YW7EYsfczM8exZLtC5SyoLsb1/mrCwU3y5PT9UDIYUKyMoXa13FwglLy0ACxGCrjc2
         6Qc6vcd1gUmCgyJg0Rwa966re2vqG/5yLyVYSMY9J7rk/cxKdGdOVmWNd5jwYkAg28vy
         TnYnzx3rSAfXvtJtPUxbkCWtTSL1QHdWyclOQnWo/ZdudWJu/Eq8IixO084EPddeWDzx
         Tzfw==
X-Gm-Message-State: AOAM530uqT//dBV+Fk7Ak82fA4/TLOwHjXFZlTXvyXqBnZ2KErbjlIUK
        istWCfs2MlP5ynTQRiUuWuE1a+etlLyBg682GhQ=
X-Google-Smtp-Source: ABdhPJypuaoEV1xk4K4l0LvYT51mlFb3a8pivcImhfFoSpT5rfsALwkGmAkDigfdpnf4It4BSuDFBWfi9G6XqkPaiJY=
X-Received: by 2002:a5d:804a:: with SMTP id b10mr4765629ior.197.1636216190872;
 Sat, 06 Nov 2021 09:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211029114028.569755-1-amir73il@gmail.com>
In-Reply-To: <20211029114028.569755-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 6 Nov 2021 18:29:39 +0200
Message-ID: <CAOQ4uxjazEx=bL6ZfLaGCfH6pii=OatQDoeWc+74AthaaUC49g@mail.gmail.com>
Subject: Re: [PATCH 0/7] Report more information in fanotify dirent events
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 2:40 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Jan,
>
> This patch set follows up on the discussion on FAN_REPORT_TARGET_FID [1]
> from 3 months ago.
>
> With FAN_REPORT_PIDFD in 5.15 and FAN_FS_ERROR on its way to 5.16,
> I figured we could get an early (re)start of the discussion on
> FAN_REPORT_TARGET_FID towards 5.17.
>
> The added information in dirent events solves problems for my use case -
> It helps getting the following information in a race free manner:
> 1. fid of a created directory on mkdir
> 2. from/to path information on rename of non-dir
>
> I realize those are two different API traits, but they are close enough
> so I preferred not to clutter the REPORT flags space any further than it
> already is. The single added flag FAN_REPORT_TARGET_FID adds:
> 1. child fid info to CREATE/DELETE/MOVED_* events
> 2. new parent+name info to MOVED_FROM event
>
> Instead of going the "inotify way" and trying to join the MOVED_FROM/
> MOVED_TO events using a cookie, I chose to incorporate the new
> parent+name intomation only in the MOVED_FROM event.
> I made this choice for several reasons:
> 1. Availability of the moved dentry in the hook and event data
> 2. First info record is the old parent+name, like FAN_REPORT_DFID_NAME
> 3. Unlike, MOVED_TO, MOVED_FROM was useless for applications that use
>    DFID_NAME info to statat(2) the object as we suggested
>
> I chose to reduce testing complexity and require all other FID
> flags with FAN_REPORT_TARGET_FID and there is a convenience
> macro FAN_REPORT_ALL_FIDS that application can use.

Self comment - Don't use ALL_ for macro names in uapi...
There are 3 comment of "Deprecated ..."  for ALL flags in fanotify.h alone...

BTW, I did not mention the FAN_RENAME event alternative proposal in this posting
not because I object to FAN_RENAME, just because it was simpler to implement
the MOVED_FROM alternative, so I thought I'll start with this proposal
and see how
it goes.

Thanks,
Amir.
