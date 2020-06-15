Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F961F9AF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 16:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgFOOxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 10:53:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38374 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730529AbgFOOxg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:53:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id f185so15145235wmf.3;
        Mon, 15 Jun 2020 07:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bVlgLw5K9ZgRrPe2t+yOf/onVI5NsVTfDFdGR/zdJbs=;
        b=L3jyMJgvFjxrUHOH3qhp8SzfZmwfYlwkYfXeWK4IkFm1qIPIXnTrDRYybr4bXeI/F8
         jCgLanLEGmj4F75qEaMIFfuR5dHGhGWiI4ipRkNKNjGv++5GpMsNPVVbfcWTzg4wX72Y
         fEjyiBqpzdi2cOwxxFji/+qacxfiCeJMsmbj+J7G+av7bRK/Y7+H7gWn3tDCfIVsW6sJ
         nuykZGzifm0ylhwScoGO+xdzSreOQbA6FB1mvZYmJ0oThIqLQmeQiKBS3L0eathFvjyn
         U+raE8dU1wqVShjR0Yg8Vbi14kA2fydR5jjB6+6o+k4mwpluPxC83Ecby9FuJthZiQG+
         i4XQ==
X-Gm-Message-State: AOAM533vCn0izYLOTiYrNEbhCAfkhpvBe/8pfjWjla6borFRo/dRp7u9
        KUU1aSxOjDrE+lJaDQhHrd0=
X-Google-Smtp-Source: ABdhPJyVv5tx/nm/l6AJJBZvJxROTg39Cgylcu/qLDQNBjikfDW9tkcfO8tIgnrH24kXjyv4lpb1BA==
X-Received: by 2002:a7b:cd94:: with SMTP id y20mr13023943wmj.87.1592232813795;
        Mon, 15 Jun 2020 07:53:33 -0700 (PDT)
Received: from localhost (ip-37-188-174-201.eurotel.cz. [37.188.174.201])
        by smtp.gmail.com with ESMTPSA id r12sm26167608wrc.22.2020.06.15.07.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:53:32 -0700 (PDT)
Date:   Mon, 15 Jun 2020 16:53:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] xfs: avoid deadlock when trigger memory reclaim in
 ->writepages
Message-ID: <20200615145331.GK25296@dhcp22.suse.cz>
References: <1592222181-9832-1-git-send-email-laoar.shao@gmail.com>
 <e4c7868a-9107-573f-c1f4-24c3aa4c9d1f@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4c7868a-9107-573f-c1f4-24c3aa4c9d1f@applied-asynchrony.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 15-06-20 16:25:52, Holger Hoffstätte wrote:
> On 2020-06-15 13:56, Yafang Shao wrote:
[...]
> > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > index b356118..1ccfbf2 100644
> > --- a/fs/xfs/xfs_aops.c
> > +++ b/fs/xfs/xfs_aops.c
> > @@ -573,9 +573,21 @@ static inline bool xfs_ioend_needs_workqueue(struct iomap_ioend *ioend)
> >   	struct writeback_control *wbc)
> >   {
> >   	struct xfs_writepage_ctx wpc = { };
> > +	unsigned int nofs_flag;
> > +	int ret;
> >   	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
> > -	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> > +
> > +	/*
> > +	 * We can allocate memory here while doing writeback on behalf of
> > +	 * memory reclaim.  To avoid memory allocation deadlocks set the
> > +	 * task-wide nofs context for the following operations.
> > +	 */
> > +	nofs_flag = memalloc_nofs_save();
> > +	ret = iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> > +	memalloc_nofs_restore(nofs_flag);
> > +
> > +	return ret;
> >   }
> >   STATIC int
> > 
> 
> Not sure if I did something wrong, but while the previous version of this patch
> worked fine, this one gave me (with v2 removed obviously):
> 
> [  +0.000004] WARNING: CPU: 0 PID: 2811 at fs/iomap/buffered-io.c:1544 iomap_do_writepage+0x6b4/0x780

This corresponds to
        /*
         * Given that we do not allow direct reclaim to call us, we should
         * never be called in a recursive filesystem reclaim context.
         */
        if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
                goto redirty;

which effectivelly says that memalloc_nofs_save/restore cannot be used
for that code path. Your stack trace doesn't point to a reclaim path
which shows that this path is shared and also underlines that this is
not really an intended use of the api. Please refer to
Documentation/core-api/gfp_mask-from-fs-io.rst for more details but
shortly the API should be used at the layer which defines a context
which shouldn't allow to recurse. E.g. a lock which would be problematic
in the reclaim recursion path.
-- 
Michal Hocko
SUSE Labs
