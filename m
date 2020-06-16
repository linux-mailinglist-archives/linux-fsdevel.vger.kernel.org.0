Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60691FADB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 12:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgFPKRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPKRp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:17:45 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233CC08C5C2;
        Tue, 16 Jun 2020 03:17:45 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t8so1827274ilm.7;
        Tue, 16 Jun 2020 03:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ClvGezN/jILcyWyyGs0/Rt2CB3tC7TLkLhNuWV+hMG8=;
        b=VFuoQMDppfECs4750kBTDddr5Q0xep48HMtbY3K2P9XcCrtIPmZy80S9vftY6+Fgug
         CK5NuxesnRW83QLnJGZxEI1cPsKArb6hjcB4gBK+6QpMosAhSxWt7hvfL564LG8aTbFf
         XUqU60XDASYQ8ry2wRwLRXSmgxzYYBDCr7BKYhv9zQ2dr2iU9OLvCedE/UYCk76JLqv9
         ePomG6GvJgMfHDmt22TxEf9AQiowvsdRYzlUl1LXP49Hs2iEnHuo5a7LrODDFocX1BcL
         Qd4w31r/iFPe6igBT1S0kmuZOkP4yd+ja/smcOfzpbL8lBdPrQBP1cpo9q/vt7zJD6iO
         aY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ClvGezN/jILcyWyyGs0/Rt2CB3tC7TLkLhNuWV+hMG8=;
        b=Hw7xxQ/IDcCSQ3cMkTQeECBk5ojd4fR5Di3LWoA08llvF41/J+fF7KaEFkSQWaNN3I
         q9wo4PF49ExlNnMOpKJmnrCgl5IvOShAZnIGREL3KMHyLWTwn8b5j/9M1OpLkbRCxDSM
         Twn/nn7OTAaZs48DnB2/VRPaIlPSYvjVqlYnML+MvZqGXkBV0AbQPE4RRG7NjdHA7gq3
         Hru/i6OW0pe32OvSEr9wH7fIwB//PDSQuKXPk4eBVIqQUqf94uyaJajFO9jK25Tk6BwL
         /NXiCnr0NfaxW/QlfCm/5vniEGUS+Gbmib4F4CgCFnh71zbG1Da2ntF7aNecYFx2KOMB
         b8kQ==
X-Gm-Message-State: AOAM532uGGdL1WRqxN3fy3Adeob0+88LUQUM/oLq98A5AsVPW9KbCKM8
        mwS3e2AGMRGO4Yg0fQtI/QkX0m1w6PPs0noWISc=
X-Google-Smtp-Source: ABdhPJzXVAgiCACjUYmsq8WCd22HZHDsC4jVtYcuQ9Gws7A7vDWzdqOqnzto/i+H5Bo2Pzy+HWKG59oXntP8M1FCknY=
X-Received: by 2002:a05:6e02:13cd:: with SMTP id v13mr2252314ilj.93.1592302664627;
 Tue, 16 Jun 2020 03:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <1592222181-9832-1-git-send-email-laoar.shao@gmail.com>
 <e4c7868a-9107-573f-c1f4-24c3aa4c9d1f@applied-asynchrony.com>
 <20200615145331.GK25296@dhcp22.suse.cz> <20200615230605.GV2040@dread.disaster.area>
In-Reply-To: <20200615230605.GV2040@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 16 Jun 2020 18:17:08 +0800
Message-ID: <CALOAHbBSa77_KajnFnWdb3q8_1KrmXXzs3J9T_OGtU3Fn8=7Yw@mail.gmail.com>
Subject: Re: [PATCH v3] xfs: avoid deadlock when trigger memory reclaim in ->writepages
To:     Dave Chinner <david@fromorbit.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 7:06 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Jun 15, 2020 at 04:53:31PM +0200, Michal Hocko wrote:
> > On Mon 15-06-20 16:25:52, Holger Hoffst=C3=A4tte wrote:
> > > On 2020-06-15 13:56, Yafang Shao wrote:
> > [...]
> > > > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > > > index b356118..1ccfbf2 100644
> > > > --- a/fs/xfs/xfs_aops.c
> > > > +++ b/fs/xfs/xfs_aops.c
> > > > @@ -573,9 +573,21 @@ static inline bool xfs_ioend_needs_workqueue(s=
truct iomap_ioend *ioend)
> > > >           struct writeback_control *wbc)
> > > >   {
> > > >           struct xfs_writepage_ctx wpc =3D { };
> > > > + unsigned int nofs_flag;
> > > > + int ret;
> > > >           xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
> > > > - return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_op=
s);
> > > > +
> > > > + /*
> > > > +  * We can allocate memory here while doing writeback on behalf of
> > > > +  * memory reclaim.  To avoid memory allocation deadlocks set the
> > > > +  * task-wide nofs context for the following operations.
> > > > +  */
> > > > + nofs_flag =3D memalloc_nofs_save();
> > > > + ret =3D iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_o=
ps);
> > > > + memalloc_nofs_restore(nofs_flag);
> > > > +
> > > > + return ret;
> > > >   }
> > > >   STATIC int
> > > >
> > >
> > > Not sure if I did something wrong, but while the previous version of =
this patch
> > > worked fine, this one gave me (with v2 removed obviously):
> > >
> > > [  +0.000004] WARNING: CPU: 0 PID: 2811 at fs/iomap/buffered-io.c:154=
4 iomap_do_writepage+0x6b4/0x780
> >
> > This corresponds to
> >         /*
> >          * Given that we do not allow direct reclaim to call us, we sho=
uld
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
>          * Refuse to write the page out if we are called from reclaim con=
text.
>          *
>          * This avoids stack overflows when called from deeply used stack=
s in
>          * random callers for direct reclaim or memcg reclaim.  We explic=
itly
>          * allow reclaim from kswapd as the stack usage there is relative=
ly low.
>          *
>          * This should never happen except in the case of a VM regression=
 so
>          * warn about it.
>          */
>         if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) =3D=
=3D
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
>
> History lesson time, eh?
>
> The recursion protection here -used- to use PF_FSTRANS, not
> PF_MEMALLOC_NOFS. See commit 9070733b4efac ("xfs: abstract
> PF_FSTRANS to PF_MEMALLOC_NOFS"). This hunk is most instructive
> when you look at the comment:
>
>          * Given that we do not allow direct reclaim to call us, we shoul=
d
>          * never be called while in a filesystem transaction.
>          */

This comment is more clear.

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
>
> So what we are seeing here is that the PF_FSTRANS ->
> PF_MEMALLOC_NOFS abstraction lost all the actual useful information
> about what type of error this check was protecting against.
>

Agreed. The check of PF_MEMALLOC_NOFS here really confused me before.
I think it will confuse others as well.

> > Your stack trace doesn't point to a reclaim path
> > which shows that this path is shared and also underlines that this is
> > not really an intended use of the api.
>
> Actually, Michal, it was your PF_FSTRANS -> PF_MEMALLOC_NOFS
> abstraction of this code that turned this from "exactly what
> PF_FSTRANS was intended to catch" to what you call "unintended use
> of the API"....
>
> IOWs, putting the iomap_writepage path under NOFS context is the
> right thing to do from a "prevent memory reclaim" perspective, but
> now we are hitting against the problems of repurposing filesystem
> specific flags for subtlely different generic semantics...
>
> I suspect we need to re-introduce PF_FSTRANS, set/clear/transfer it
> again in all the places XFS used to transfer it, and change this
> iomap check to use PF_FSTRANS and not PF_MEMALLOC_NOFS, because it's
> clearly not and never has been a memory reclaim recursion warning
> check....
>

Agree with you that it's better to convert it back to PF_FSTRANS,
otherwise it will mislead more people.
I would like to send a patch to change it back if there is no
objection to this proposal.



--
Thanks
Yafang
