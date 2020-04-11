Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 547001A53EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 00:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDKW2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 18:28:34 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39485 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgDKW2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:28:34 -0400
Received: from dread.disaster.area (pa49-180-167-53.pa.nsw.optusnet.com.au [49.180.167.53])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B113558B984;
        Sun, 12 Apr 2020 08:28:30 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jNOc1-0005AG-Az; Sun, 12 Apr 2020 08:28:29 +1000
Date:   Sun, 12 Apr 2020 08:28:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] ovl: skip overlayfs superblocks at global sync
Message-ID: <20200411222829.GO10737@dread.disaster.area>
References: <158642098777.5635.10501704178160375549.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158642098777.5635.10501704178160375549.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=2xmR08VVv0jSFCMMkhec0Q==:117 a=2xmR08VVv0jSFCMMkhec0Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=7-415B0cAAAA:8 a=haEqjSr0uQTM00mUMRMA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 11:29:47AM +0300, Konstantin Khlebnikov wrote:
> Stacked filesystems like overlayfs has no own writeback, but they have to
> forward syncfs() requests to backend for keeping data integrity.
> 
> During global sync() each overlayfs instance calls method ->sync_fs()
> for backend although it itself is in global list of superblocks too.
> As a result one syscall sync() could write one superblock several times
> and send multiple disk barriers.
> 
> This patch adds flag SB_I_SKIP_SYNC into sb->sb_iflags to avoid that.

Why wouldn't you just remove the ->sync_fs method from overlay?

I mean, if you don't need the filesystem to do anything special for
one specific data integrity sync_fs call, you don't need it for any
of them, yes?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
