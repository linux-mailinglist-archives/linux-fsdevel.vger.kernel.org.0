Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1779649EDF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 23:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiA0WK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 17:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiA0WKZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 17:10:25 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0EDC061714;
        Thu, 27 Jan 2022 14:10:25 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id b14so6432113ljb.0;
        Thu, 27 Jan 2022 14:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkUjSb/fdfaa3FAu68ePw4JIYSvRfOC6qyjCilb3MLA=;
        b=RZypLcBcYIUdWY9vV42TppO4LaQPblBv+kCbhi7sSIeity0kCuHxjxBkOW+017vQfl
         mGJzLUkiIibnMnTTVFBLt50VetVg1KzsVDl5jUao0XF5T7oAmS+N8pzAB7j2FNpZGYiq
         xbHy2XvQvsScldzehtVeFOoApJ3rHFqpSLvhJxxrFdkCY4SBOyNaqvrt+GIQFpxxuFFh
         CmyJh/SQOY6vLReOapEDPt77zxgz4JT8F/AZF2zWXE0KCoQ1ChkpEBN24khQj5g1i9qq
         aguCWoq8pgm51d0p5z0SrS13R+0j/TGLyIS5NFK+7PHw2xgpowySjWS1of9EUGPSq6jn
         /AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkUjSb/fdfaa3FAu68ePw4JIYSvRfOC6qyjCilb3MLA=;
        b=tfMmVXe40SSgzi1gp75b3U8T5saZ6sZiNg6gAv2dC0KikkIBgFISBUuR2tThVGspTw
         aravKdUXGq3zPkeylhkxfFugDTTrTL9ovBFHJLqlb8fMIAdVxzWnSPEdQS0Qorlj+E4F
         Ja+j24Fsky1MVRHsiUPpT5ZHbtv3ukeE3lqaEc6HyQ6TIgrNcu9eE7nlGWLNHXEiu5Tk
         sErDd5tW7ug4rKwW6CNTObgMD4y7GmuXnbUJLG0uCMMkNrWQUoN+50B5RSAfy6ZCY5Nf
         +5iovHwdqhSShoYvqEc4tNqacTehQMnkPclg2xrwupMRELVCN8LXcoYM+AUVBXZ3dUpR
         09vQ==
X-Gm-Message-State: AOAM530D/tqL6MhFDKXFf5sG2IzJRcf+9Bzs1m3Acmw814enhXbrSQDO
        3v5uoIek5bVj0cso6gM9x41dbZxlExK4LW4hSGw=
X-Google-Smtp-Source: ABdhPJy9dJl6L/bnRQi8tK1Am+5DPjPBZvatcTyLSMpbpD4vy19hTtp8mGF/Cl1TBx2f3Cw7TL+lgScx4mlljQ4behg=
X-Received: by 2002:a2e:5d3:: with SMTP id 202mr3981304ljf.330.1643321423317;
 Thu, 27 Jan 2022 14:10:23 -0800 (PST)
MIME-Version: 1.0
References: <164325106958.29787.4865219843242892726.stgit@noble.brown> <164325158955.29787.4769373293473421057.stgit@noble.brown>
In-Reply-To: <164325158955.29787.4769373293473421057.stgit@noble.brown>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 28 Jan 2022 07:10:11 +0900
Message-ID: <CAKFNMom4Z76ti4fp69UeKYf0d4x635OR7Q_CjVnBj+vQSuhESg@mail.gmail.com>
Subject: Re: [PATCH 2/9] Remove bdi_congested() and wb_congested() and related functions
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Linux MM <linux-mm@kvack.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 11:47 AM NeilBrown <neilb@suse.de> wrote:
>
> These functions are no longer useful as the only bdis that report
> congestion are in ceph, fuse, and nfs.  None of those bdis can be the
> target of the calls in drbd, ext2, nilfs2, or xfs.
>
> Removing the test on bdi_write_contested() in current_may_throttle()
> could cause a small change in behaviour, but only when PF_LOCAL_THROTTLE
> is set.
>
> So replace the calls by 'false' and simplify the code - and remove the
> functions.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/block/drbd/drbd_int.h |    3 ---
>  drivers/block/drbd/drbd_req.c |    3 +--
>  fs/ext2/ialloc.c              |    2 --
>  fs/nilfs2/segbuf.c            |   11 -----------
>  fs/xfs/xfs_buf.c              |    3 ---
>  include/linux/backing-dev.h   |   26 --------------------------
>  mm/vmscan.c                   |    4 +---
>  7 files changed, 2 insertions(+), 50 deletions(-)

for nilfs2 bits,

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
