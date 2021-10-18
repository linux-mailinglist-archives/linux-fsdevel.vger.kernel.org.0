Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707DA432616
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 20:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhJRSLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 14:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhJRSLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:11:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF409C061745
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 11:09:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso21792pjb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3QChYolV4P82u7ycKYONtu2TNnksSBgKfxFLCvKMno8=;
        b=3ATB7jLZgYDbiy8dG1QLj4my/tGYkmugndMQ8KdNeJOn6kqJLMy7GesiAfXx0EH0Dg
         Il5KVHGqqZF7kp0FVWrZyulBfxCzXySP2pPqy1J7U2eGOp7UjTCgYwswMbo2MGgXvyx8
         x7+XMXomUE4/s87KOTRAX11Bg+AzcUJilUdSwHMxncrJXVi3BDVOMMFTdnRTShIHKwSu
         cKL91G4Urs0TXkL6BIjeSFRSZcaU/0k20nTo6AO1/3FstvDQ1Y0cT4c+jlCuf8PAPjXt
         cBrqulLJ65p3Z+nfTb/nTv47hJM7cluH1QPfZyR+oB9SpySgwJEQj2YPWexqSDWgaBJZ
         RPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3QChYolV4P82u7ycKYONtu2TNnksSBgKfxFLCvKMno8=;
        b=XuUAtacKAaLJQ/6leDHB7dvzDzWTrYPRbMO6S/Mrguu4y232ZQO3SbKcAwWs/c9FB3
         vQbnh+c9iwEsDVDhtcNaItb+EGHXozplA0Csh7HYdFOxWwAP6m1hnATuYM+5Z7pBIwA/
         ceOw52GX8t1eQ6fzk5p0c6LeARjC46wUzulfMUZgF6SKCX/y4c5sBGHrryNBwrg+deau
         gQSMjcDdhrFMpdS4Zjp4RlV++JsYL4LwpJnl6fQavmGeAYLptRqtndlOaROsPanvbB3d
         jOFTtCYKmDzhmHjo4tknWaTkg2Mkh+Tf2i7Q9v5EbZ0MPwDzJedsqn5xJMqJxSgIhHQS
         Nz+Q==
X-Gm-Message-State: AOAM5324aoo5xwX+7VupaJhWp0/yKSJYJJOv2cF2TstfQiOZ1kOsTj4u
        TM93Mlax/6T0/5JLWE6qLkQeBA==
X-Google-Smtp-Source: ABdhPJy2aPtL/OFI2t0D9ZcLpHWDAPj5ie5SX0rQq+cpWtiioqKsH0gMLs1yXRC+dIScYJ2xAzJeIA==
X-Received: by 2002:a17:902:dac4:b0:13e:fcb8:eaf1 with SMTP id q4-20020a170902dac400b0013efcb8eaf1mr28868003plx.50.1634580573109;
        Mon, 18 Oct 2021 11:09:33 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:b911])
        by smtp.gmail.com with ESMTPSA id r19sm11231898pfh.14.2021.10.18.11.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 11:09:32 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:09:30 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v11 03/14] btrfs: don't advance offset for compressed
 bios in btrfs_csum_one_bio()
Message-ID: <YW24Wno9lyvBC+9J@relinquished.localdomain>
References: <cover.1630514529.git.osandov@fb.com>
 <40d0097d3b5e1ba14e6b6d090ba6d0e5c046985f.1630514529.git.osandov@fb.com>
 <3fa3456d-3d53-6025-e305-8ab8080c9ba5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fa3456d-3d53-6025-e305-8ab8080c9ba5@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 14, 2021 at 03:05:54PM +0300, Nikolay Borisov wrote:
> 
> 
> On 1.09.21 г. 20:00, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > btrfs_csum_one_bio() loops over each filesystem block in the bio while
> > keeping a cursor of its current logical position in the file in order to
> > look up the ordered extent to add the checksums to. However, this
> > doesn't make much sense for compressed extents, as a sector on disk does
> > not correspond to a sector of decompressed file data. It happens to work
> > because 1) the compressed bio always covers one ordered extent and 2)
> > the size of the bio is always less than the size of the ordered extent.
> > However, the second point will not always be true for encoded writes.
> > 
> > Let's add a boolean parameter to btrfs_csum_one_bio() to indicate that
> > it can assume that the bio only covers one ordered extent. Since we're
> > already changing the signature, let's get rid of the contig parameter
> > and make it implied by the offset parameter, similar to the change we
> > recently made to btrfs_lookup_bio_sums(). Additionally, let's rename
> > nr_sectors to blockcount to make it clear that it's the number of
> > filesystem blocks, not the number of 512-byte sectors.
> > 
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Code-wise this looks, though I don't know why we are guaranteed that a
> compressed extent will only cover a single OE.

See submit_compressed_extents(): we always add an ordered extent that
covers the whole range that we're submitting, and then
btrfs_submit_compressed_write() creates one or more bios that are
subsets of that range.

> But I trust you so:
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Thanks!
