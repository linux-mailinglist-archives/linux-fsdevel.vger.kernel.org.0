Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449ED41DE1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 17:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346978AbhI3P43 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 11:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346577AbhI3P42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:56:28 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C0AC06176A;
        Thu, 30 Sep 2021 08:54:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i4so27713049lfv.4;
        Thu, 30 Sep 2021 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LuCj9+8GFiHaMYgM8A65UudQg+qoOQQ2QUvcQ4XJ6s=;
        b=PXKNBxqcRYxhwIV2v2X64yZJayzFfGuPEaFJcRpO4WCNqMpCZwI1df/zPBhLNhmRG9
         7YWtoaofqurtGMdx0tYBEI6UfndHKtDaw4PBX49q9qi3J9QTKWYVNSDazJnLhCwGhWpW
         sQyH53wtu7PQHWXKpw0IKJFLkzoLewsXUWMxyWUFA0GoZc/geWBr365BCc9DFKmEuqTx
         QD1UXjg8vOB88FTGI55O4xvrqxi80eDmibsD2swnwubvtT8jN+7r24raClw1eWxICIMn
         Xqc+xF7xzZT7TnBUA1RA5nmOrLjD64wC+WGfBcYeYx3rm7565L5ZdR6xyKgYS9WfGChU
         NdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LuCj9+8GFiHaMYgM8A65UudQg+qoOQQ2QUvcQ4XJ6s=;
        b=XbBmZKylOYkv9SoXviPKr9BWXkZnTMEhN/fJ51HYr7LvZ50SCBNVHrOfV5SWpjYM2r
         Y2qiC9CZ/lZsMRA6GQqL2/yNfuvwmt01k+raQ/914z/0iuApGZgUMbKUALfvCbUniGRI
         gSalxO6Z+kngZPgLhCAU9cS1ehUiZTvEswwuJASnjNdOIUR0Z+riW4QpL82Pr+TXguTS
         2fDK3wKyn6cI/dVyVPlz5oC6323Y0CaVOJqjzh8gwILnBViU/sGrMjSLtCdVqkbFx6bt
         8hDoqhoj9aXS9t5aF9sa3JGdoOav5Q8f/6EcjMIWu/mSG6lZ8XF7xAHIVtuMFICV5S9y
         uQUg==
X-Gm-Message-State: AOAM530xbUXEPedn3z2RSBSh4SRFgiu7yX3y79mfdsl/iauHJLStOASh
        TzYK5mmp8+9+DBjHeQ/cTbqVveEdVpYvTtbgkUjRp9WQ
X-Google-Smtp-Source: ABdhPJyOHnVmMylaeGdsSDUQCs/a7NstziQ8gAm3Iq6Rldf9w/4qe7wGWECjl3a+7RS3TZsUTx6/zgFOVy33MH5VI2M=
X-Received: by 2002:a05:6512:32c5:: with SMTP id f5mr7091563lfg.234.1633017283958;
 Thu, 30 Sep 2021 08:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
 <163279868982.18792.10448745714922373194@noble.neil.brown.name>
In-Reply-To: <163279868982.18792.10448745714922373194@noble.neil.brown.name>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 30 Sep 2021 10:54:32 -0500
Message-ID: <CAH2r5msHO9HTQGeO6MoR2_U76B9kLeoFS=FRbMuiNsh=YeFdWg@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 0/9] mm: Use DIO for swap and fix NFS swapfiles
To:     NeilBrown <neilb@suse.de>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-block@vger.kernel.org,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-mm <linux-mm@kvack.org>, Bob Liu <bob.liu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Seth Jennings <sjenning@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Steve French <sfrench@samba.org>,
        Dan Magenheimer <dan.magenheimer@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:12 PM NeilBrown <neilb@suse.de> wrote:
>
> On Sat, 25 Sep 2021, David Howells wrote:
> > Whilst trying to make this work, I found that NFS's support for swapfiles
> > seems to have been non-functional since Aug 2019 (I think), so the first
> > patch fixes that.  Question is: do we actually *want* to keep this
> > functionality, given that it seems that no one's tested it with an upstream
> > kernel in the last couple of years?
>
> SUSE definitely want to keep this functionality.  We have customers
> using it.
> I agree it would be good if it was being tested somewhere....
>

I am trying to work through the testing of swap over SMB3 mounts
since there are use cases where you need to expand the swap
space to remote storage and so this requirement comes up.  The main difficulty
I run into is forgetting to mount with the mount options (to store mode bits)
(so swap file has the right permissions) and debugging some of the
xfstests relating to swap can be a little confusing.

-- 
Thanks,

Steve
