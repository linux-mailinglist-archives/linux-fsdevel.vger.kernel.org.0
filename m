Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03703E5890
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 12:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239895AbhHJKtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 06:49:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58732 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbhHJKtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:49:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 556CF1FE42;
        Tue, 10 Aug 2021 10:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628592564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KYnLfe8rxI2RgTfuKMaTKdPyUMNVBbFDlBySJHYvHZA=;
        b=p3Hk7hAC8JMFRrSCdJxIli4cfJqhRCjYZJGXLJuk6TuQ/sf4E4vWo3KPBg65VffhaY6isQ
        9KSd6tDx666fpkYGkTPX1gUs5qpKDieXYhqu1QPY+Bg5F+9l4SDhnEB+gIq5b/LVd3ljPg
        FrwnCuyckhfGNny2th74JoOraxEMnus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628592564;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KYnLfe8rxI2RgTfuKMaTKdPyUMNVBbFDlBySJHYvHZA=;
        b=Om0GxUCoB+RFDRlZR4sSXhx3rgcg5a+StNk7YTgulVyKgxjPFf19o/42JGDO3jfge6fPxd
        qQ74sYD8QOxnayCw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 341D1A3C69;
        Tue, 10 Aug 2021 10:49:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 12EDE1E3BFC; Tue, 10 Aug 2021 12:49:24 +0200 (CEST)
Date:   Tue, 10 Aug 2021 12:49:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 0/4] Performance optimization for no fsnotify marks
Message-ID: <20210810104924.GD18722@quack2.suse.cz>
References: <20210803180344.2398374-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803180344.2398374-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Tue 03-08-21 21:03:40, Amir Goldstein wrote:
> This idea was suggested on year ago [1], but I never got to test
> its performance benefits.
> 
> Following the performance improvement report from kernel robot [2],
> please consider these changes.
> 
> I have other optimization patches for no ignored mask etc, but the
> "no marks" case is the most low hanging improvement.

Thanks for the improvement! The series looks good except for that one
comment I had. If you respin the series with that addressed, I can take it
to my tree.

									Honza

> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgYpufPyhivOQyEhUQ0g+atKLwAAuefkSwaWXYAyMgw5Q@mail.gmail.com/
> [2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxisyDjVpWX1M6O4ugxBbcX+LWWf4NQJ+LQY1-3-9tN+BA@mail.gmail.com/
> 
> Amir Goldstein (4):
>   fsnotify: replace igrab() with ihold() on attach connector
>   fsnotify: count s_fsnotify_inode_refs for attached connectors
>   fsnotify: count all objects with attached connectors
>   fsnotify: optimize the case of no marks of any type
> 
>  fs/notify/fsnotify.c     |  6 ++--
>  fs/notify/mark.c         | 73 +++++++++++++++++++++++++++++++++-------
>  include/linux/fs.h       |  4 +--
>  include/linux/fsnotify.h |  9 +++++
>  4 files changed, 75 insertions(+), 17 deletions(-)
> 
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
