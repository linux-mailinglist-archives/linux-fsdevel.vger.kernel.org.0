Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569F91FAA8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 09:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgFPH4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 03:56:12 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:46081 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgFPH4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:56:11 -0400
Received: by mail-ej1-f68.google.com with SMTP id p20so20412284ejd.13;
        Tue, 16 Jun 2020 00:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dN+mDKrpnDn717I3S9kv2L1TUXLfxVtMTVGOj5fL0pU=;
        b=oJ5ME8JrfOtDf+hRKJmAFcJbxA1LyTEokH4B0LMuuSdANc17JjlqBS/Gk8WfKmV0Ro
         IhISHCNRehrygaew9g8IJaqhX37xUiI4Hu8KkuEfQcJoWxkzKJkn5MtOz9Yi1jB0tG5Y
         pdD7AOqiMzIiU0Blvuf7KVZ1zNdcWbxuy3PxTEA0Tp3PuBdlFQwI3u+5ihBPizf1WTmb
         ebrqmPu5ozkILWuUcMcxcdiORIGV/Y3PLRd6MNGO674RoHMYOhU4h78SJ/5QvO8kaqdz
         0qDk6lDsNSQy8jWDe/jRfPmSSuHbrCLqCi22bFsqsRZcgtvYW20w8Vs3qqQxVoUKzA5P
         swnA==
X-Gm-Message-State: AOAM532sqmVWTeV6vtB9SbnL84aESUhA2xYQvLINRace2JSJfz6YxJSW
        6im6SP6Y3lrtM5TwWfui1tg=
X-Google-Smtp-Source: ABdhPJzByjd93nmO3buc4jKoO9YB5XnF7cfyMVfnCbUp6aMudgOe+Uw+L0TpkhUkHA/fWUQfUAmzaw==
X-Received: by 2002:a17:906:2e83:: with SMTP id o3mr1576329eji.312.1592294168594;
        Tue, 16 Jun 2020 00:56:08 -0700 (PDT)
Received: from localhost (ip-37-188-174-201.eurotel.cz. [37.188.174.201])
        by smtp.gmail.com with ESMTPSA id o5sm10596109eje.66.2020.06.16.00.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:56:07 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:56:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] xfs: avoid deadlock when trigger memory reclaim in
 ->writepages
Message-ID: <20200616075606.GB9499@dhcp22.suse.cz>
References: <1592222181-9832-1-git-send-email-laoar.shao@gmail.com>
 <e4c7868a-9107-573f-c1f4-24c3aa4c9d1f@applied-asynchrony.com>
 <20200615145331.GK25296@dhcp22.suse.cz>
 <20200615230605.GV2040@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615230605.GV2040@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-06-20 09:06:05, Dave Chinner wrote:
> On Mon, Jun 15, 2020 at 04:53:31PM +0200, Michal Hocko wrote:
> > On Mon 15-06-20 16:25:52, Holger Hoffstätte wrote:
> > > On 2020-06-15 13:56, Yafang Shao wrote:
> > [...]
> > > > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > > > index b356118..1ccfbf2 100644
> > > > --- a/fs/xfs/xfs_aops.c
> > > > +++ b/fs/xfs/xfs_aops.c
> > > > @@ -573,9 +573,21 @@ static inline bool xfs_ioend_needs_workqueue(struct iomap_ioend *ioend)
> > > >   	struct writeback_control *wbc)
> > > >   {
> > > >   	struct xfs_writepage_ctx wpc = { };
> > > > +	unsigned int nofs_flag;
> > > > +	int ret;
> > > >   	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
> > > > -	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> > > > +
> > > > +	/*
> > > > +	 * We can allocate memory here while doing writeback on behalf of
> > > > +	 * memory reclaim.  To avoid memory allocation deadlocks set the
> > > > +	 * task-wide nofs context for the following operations.
> > > > +	 */
> > > > +	nofs_flag = memalloc_nofs_save();
> > > > +	ret = iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> > > > +	memalloc_nofs_restore(nofs_flag);
> > > > +
> > > > +	return ret;
> > > >   }
> > > >   STATIC int
> > > > 
> > > 
> > > Not sure if I did something wrong, but while the previous version of this patch
> > > worked fine, this one gave me (with v2 removed obviously):
> > > 
> > > [  +0.000004] WARNING: CPU: 0 PID: 2811 at fs/iomap/buffered-io.c:1544 iomap_do_writepage+0x6b4/0x780
> > 
> > This corresponds to
> >         /*
> >          * Given that we do not allow direct reclaim to call us, we should
> >          * never be called in a recursive filesystem reclaim context.
> >          */
> >         if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> >                 goto redirty;
> > 
> > which effectivelly says that memalloc_nofs_save/restore cannot be used
> > for that code path.
> 
> No it doesn't. Everyone is ignoring the -context- of this code, most
> especially the previous 3 lines of code and it's comment:
> 
>         /*
>          * Refuse to write the page out if we are called from reclaim context.
>          *
>          * This avoids stack overflows when called from deeply used stacks in
>          * random callers for direct reclaim or memcg reclaim.  We explicitly
>          * allow reclaim from kswapd as the stack usage there is relatively low.
>          *
>          * This should never happen except in the case of a VM regression so
>          * warn about it.
>          */
>         if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
>                         PF_MEMALLOC))
>                 goto redirty;
> 
> You will see that we specifically avoid this path from reclaim
> context except for kswapd. And kswapd always runs with GFP_KERNEL
> context so we allow writeback from it, so it will pass both this
> check and the NOFS check above. 
> 
> IOws, we can't trigger to the WARN_ON_ONCE(current->flags &
> PF_MEMALLOC_NOFS)) check from a memory reclaim context: this
> PF_MEMALLOC_NOFS check here is not doing what people think it is.

You are right.

> History lesson time, eh?
> 
> The recursion protection here -used- to use PF_FSTRANS, not
> PF_MEMALLOC_NOFS. See commit 9070733b4efac ("xfs: abstract
> PF_FSTRANS to PF_MEMALLOC_NOFS"). This hunk is most instructive
> when you look at the comment:
> 
>          * Given that we do not allow direct reclaim to call us, we should
>          * never be called while in a filesystem transaction.
>          */
> -       if (WARN_ON_ONCE(current->flags & PF_FSTRANS))
> +       if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
>                 goto redirty;
> 
> It wasn't for memory allocation recursion protection in XFS - it was
> for transaction reservation recursion protection by something trying
> to flush data pages while holding a transaction reservation. Doing
> this could deadlock the journal because the existing reservation
> could prevent the nested reservation for being able to reserve space
> in the journal and that is a self-deadlock vector.
> 
> IOWs, this check is not protecting against memory reclaim recursion
> bugs at all (that's the previous check I quoted). This check is
> protecting against the filesystem calling writepages directly from a
> context where it can self-deadlock.

Thanks for the clarification.

> So what we are seeing here is that the PF_FSTRANS ->
> PF_MEMALLOC_NOFS abstraction lost all the actual useful information
> about what type of error this check was protecting against.

I have to admit that I am not familiar with the xfs code and the
PF_TRANS abstraction to PF_MEMALLOC_NOFS was mostly automatic and I
relied on xfs maintainers to tell me I was doing something stupid.
Now after your explanation it makes more sense that the warning is
indeed protecting from a different kind of issue.
-- 
Michal Hocko
SUSE Labs
