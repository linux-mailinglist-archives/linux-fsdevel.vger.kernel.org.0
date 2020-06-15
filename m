Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D451F9B8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgFOPI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 11:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbgFOPI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:08:58 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54242C061A0E;
        Mon, 15 Jun 2020 08:08:58 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c75so15572227ila.8;
        Mon, 15 Jun 2020 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CdXI19ffeyY6WRTLT9+esIHJP/80L+l0kkbdQuiJhrY=;
        b=erBmHgGuqLDESD9mdlhGoK0umkwSwqGQksoZMaU1fN7M7L+2VlZx02Q/HGKNBymkQS
         VX4G9rbcVbbB/4c7M0Njf3ts+1GMUw6/5DzQ2xiWq2TYNdqBKK+mjahsn/P2wQFWPJbZ
         ahsLZ6U3cKbHclwh56uw02SxPBmRoNLw2mX17l1+G6FIvT1DhsLrq1ttlD9areZSwM5J
         kkAvOyQ+DnwxQud+xABW/x14FMM2EKJcWkB1v3f5GxKwen/SPb55DC2YRurvbf97yFCr
         x37VXNN7ZFx2wC68vCqPMKy4shgcuRzJmKxyjJseEJ8gQ1VYMEIvR7sq5CpruFTo8T/D
         U2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CdXI19ffeyY6WRTLT9+esIHJP/80L+l0kkbdQuiJhrY=;
        b=GlHzGKMIQYZT7GbotuLYCxr+zeZp6h61bSYsb4VRgpjuLn2teisULRIHyuGO/DmjzD
         Ap6fP0GZdCJhcpVRvqEx4TIyjBkDMjGuV7IpDtWAmRylIbcU387I19RpNSNjbc9fYPgE
         vGMCw+k4Ey0YtFhkLZPkF4Do7AjUSeWQ86KqCvK1qR1yFrWqlYzyQjLa5A1OMqLfmn7V
         aM0TXc5806FwWIqOIFzf8w5V0HDCzUAxMyvr1zgGMLT+k3uqjd9IeqhVCZvaqbPJtUEP
         7h9BU8nEBIcGCNxWzoKby1fAxpyF33CU42Dau5MXbCvFT5P/z//zEnBkACuswnDpSpg2
         Un6A==
X-Gm-Message-State: AOAM531sqrpdbeXXcJ975UZTHVgqSM9sm0HrzSY7NJMaB0IIbF2jJX8r
        FYyCUPNofIWQOInCBLwZLlYiPVycJetkhTNRE0Q=
X-Google-Smtp-Source: ABdhPJwRCc/XqfycakbU+ys1K6CJUetTIQW6G++/2ptBcZjrvKZV3xBG2Xg8WE0ZVi8o2Qm26i6QvN10kG2yF53HRI8=
X-Received: by 2002:a92:cf52:: with SMTP id c18mr26766350ilr.142.1592233737645;
 Mon, 15 Jun 2020 08:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <1592222181-9832-1-git-send-email-laoar.shao@gmail.com>
 <e4c7868a-9107-573f-c1f4-24c3aa4c9d1f@applied-asynchrony.com> <20200615145331.GK25296@dhcp22.suse.cz>
In-Reply-To: <20200615145331.GK25296@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 15 Jun 2020 23:08:21 +0800
Message-ID: <CALOAHbBcpYbMBoN+edEa5wp1VCf4mcbR8+SQTjVjRGpx7_v43A@mail.gmail.com>
Subject: Re: [PATCH v3] xfs: avoid deadlock when trigger memory reclaim in ->writepages
To:     Michal Hocko <mhocko@kernel.org>
Cc:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:53 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 15-06-20 16:25:52, Holger Hoffst=C3=A4tte wrote:
> > On 2020-06-15 13:56, Yafang Shao wrote:
> [...]
> > > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > > index b356118..1ccfbf2 100644
> > > --- a/fs/xfs/xfs_aops.c
> > > +++ b/fs/xfs/xfs_aops.c
> > > @@ -573,9 +573,21 @@ static inline bool xfs_ioend_needs_workqueue(str=
uct iomap_ioend *ioend)
> > >     struct writeback_control *wbc)
> > >   {
> > >     struct xfs_writepage_ctx wpc =3D { };
> > > +   unsigned int nofs_flag;
> > > +   int ret;
> > >     xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
> > > -   return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_op=
s);
> > > +
> > > +   /*
> > > +    * We can allocate memory here while doing writeback on behalf of
> > > +    * memory reclaim.  To avoid memory allocation deadlocks set the
> > > +    * task-wide nofs context for the following operations.
> > > +    */
> > > +   nofs_flag =3D memalloc_nofs_save();
> > > +   ret =3D iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_o=
ps);
> > > +   memalloc_nofs_restore(nofs_flag);
> > > +
> > > +   return ret;
> > >   }
> > >   STATIC int
> > >
> >
> > Not sure if I did something wrong, but while the previous version of th=
is patch
> > worked fine, this one gave me (with v2 removed obviously):
> >
> > [  +0.000004] WARNING: CPU: 0 PID: 2811 at fs/iomap/buffered-io.c:1544 =
iomap_do_writepage+0x6b4/0x780
>
> This corresponds to
>         /*
>          * Given that we do not allow direct reclaim to call us, we shoul=
d
>          * never be called in a recursive filesystem reclaim context.
>          */
>         if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
>                 goto redirty;
>
> which effectivelly says that memalloc_nofs_save/restore cannot be used
> for that code path.

Hi Michal,

My understanding is that this warning is to tell us we don't want a
recursive filesystem reclaim with PF_MEMALLOC_NOFS being specifically
set, but unfortunately PF_MEMALLOC_NOFS doesn't work so it comes here
again.

IOW, PF_MEMALLOC_NOFS can be set after this check, like what I did in v2. [=
1]


> Your stack trace doesn't point to a reclaim path
> which shows that this path is shared and also underlines that this is
> not really an intended use of the api. Please refer to
> Documentation/core-api/gfp_mask-from-fs-io.rst for more details but
> shortly the API should be used at the layer which defines a context
> which shouldn't allow to recurse. E.g. a lock which would be problematic
> in the reclaim recursion path.

Thanks for your information.
As pointed out by Dave in v1[2] that iomap_do_writepage() can be
called with a locked page
cache page and calls ->map_blocks from that context.

[1]. https://lore.kernel.org/linux-xfs/1591254347-15912-1-git-send-email-la=
oar.shao@gmail.com/
[2] https://lore.kernel.org/linux-xfs/20200603222741.GQ2040@dread.disaster.=
area/



--=20
Thanks
Yafang
