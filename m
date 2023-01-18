Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC496728D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 20:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjART5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 14:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjART5h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:57:37 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C40853E7B;
        Wed, 18 Jan 2023 11:57:36 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id p96so12425554qvp.13;
        Wed, 18 Jan 2023 11:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jE7UUdy8PLtXYkvU/lzVvfasVo94/Kknt5WCrMd4jf8=;
        b=VcasuukNdtEloIk0KqvSta3EYTM8ZwqsTHtT/bj3ut3YYOeIS/OpCCwYsncX9MgQRw
         QWEoc9qVZ/F1XkKxrm0SezpXexHkMc2IoDHgj92Ev1dgX/+qT8dUCDddKGE3/h3H5PaG
         /dX/RwGKN0ssytQHtibN5gCczlEAFvoMYwmHJOqPvhB8Thwnd49IasG9B6MiWiYHTkjO
         E47xpO/Rg1kdUQ3y4gHWLCdjC/BUwgQfQpzbXhSUl1R2fScq70HsoJL64sgpxVBMurGC
         vUTlgCtmcTRnCy8d+lhL3ei1HpMNpreExkujXFgWArIfQ3+tzbwH9lsOVRX3jBA324Bj
         lVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jE7UUdy8PLtXYkvU/lzVvfasVo94/Kknt5WCrMd4jf8=;
        b=D83IBz0bwpDMCxSy3os6l2GZPH7bVib+14kZ/mUQKdlc4fCe070PuCgQmStoJcmM/I
         HOx+XxmVmdAOoznnKRfQ58cfoBaSaMeXoUelesMLgjkqHsj6s0q/ngjZYW4sA0iXmfHw
         L45Do2IQib7kxq1agY04kGl0Hf0e5Bbt0Ew0Jj5QGMR4asJ8qN/pDVIxm5N/vt8vFBY+
         SboUAcTvqO0qwoaQjum03RWWO5QirC+gTRw6IcQH1G1vso7WzgQzF13DfqxpCxT2imBJ
         XRnVRMndLb09sY+Otsrbj6ThM0jqff2BhVWLHm3g1xfAAMhEXx6o/l7FX5ffC7WgRZCb
         KHcA==
X-Gm-Message-State: AFqh2ko3yo+3mOjowHHuyHcU8wKkDgx3mzoe+eZ0ixop0pMfkR7pX7wL
        DQcTwe1ZRlpFNCwK1F5nwh2sMuaaP5OHz11gYXU=
X-Google-Smtp-Source: AMrXdXve2EgHGv+2cv1pHkrPy3geUJuLfVqUa2trthVWJaRmjDPV20b7EKg3SSIV8PR21z7dow6K6rvn9Y0mMDKfOqc=
X-Received: by 2002:a05:6214:5e05:b0:534:b3ca:8638 with SMTP id
 li5-20020a0562145e0500b00534b3ca8638mr437696qvb.19.1674071855381; Wed, 18 Jan
 2023 11:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20230108194034.1444764-1-agruenba@redhat.com> <20230108194034.1444764-9-agruenba@redhat.com>
 <20230108215911.GP1971568@dread.disaster.area> <CAHc6FU4z1nC8zdM8NvUyMqU29_J7_oNu1pvBHuOvR+M6gq7F0Q@mail.gmail.com>
 <20230109225453.GQ1971568@dread.disaster.area> <CAHpGcM+urV5LYpTZQWTRoK6VWaLx0sxk3mDe_kd3VznMY9woVw@mail.gmail.com>
 <Y8Q4FmhYehpQPZ3Z@magnolia> <Y8eeAmm1Vutq3Fc9@infradead.org> <Y8hCq+fIWgHfUufe@magnolia>
In-Reply-To: <Y8hCq+fIWgHfUufe@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 18 Jan 2023 20:57:24 +0100
Message-ID: <CAHpGcMJmi6gncj=a0NZrbm11AJoN5u0-F7GUnwFZRVbCL=Dpqw@mail.gmail.com>
Subject: Re: [RFC v6 08/10] iomap/xfs: Eliminate the iomap_valid handler
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mi., 18. Jan. 2023 um 20:04 Uhr schrieb Darrick J. Wong <djwong@kernel.org>:
>
> On Tue, Jan 17, 2023 at 11:21:38PM -0800, Christoph Hellwig wrote:
> > On Sun, Jan 15, 2023 at 09:29:58AM -0800, Darrick J. Wong wrote:
> > > I don't have any objections to pulling everything except patches 8 and
> > > 10 for testing this week.
> >
> > That would be great.  I now have a series to return the ERR_PTR
> > from __filemap_get_folio which will cause a minor conflict, but
> > I think that's easy enough for Linux to handle.
>
> Ok, done.
>
> > >
> > > 1. Does zonefs need to revalidate mappings?  The mappings are 1:1 so I
> > > don't think it does, but OTOH zone pointer management might complicate
> > > that.
> >
> > Adding Damien.
> >
> > > 2. How about porting the writeback iomap validation to use this
> > > mechanism?  (I suspect Dave might already be working on this...)
> >
> > What is "this mechanism"?  Do you mean the here removed ->iomap_valid
> > ?   writeback calls into ->map_blocks for every block while under the
> > folio lock, so the validation can (and for XFS currently is) done
> > in that.  Moving it out into a separate method with extra indirect
> > functiona call overhead and interactions between the methods seems
> > like a retrograde step to me.
>
> Sorry, I should've been more specific -- can xfs writeback use the
> validity cookie in struct iomap and thereby get rid of struct
> xfs_writepage_ctx entirely?

Already asked and answered in the same thread:

https://lore.kernel.org/linux-fsdevel/20230109225453.GQ1971568@dread.disaster.area/

> > > 2. Do we need to revalidate mappings for directio writes?  I think the
> > > answer is no (for xfs) because the ->iomap_begin call will allocate
> > > whatever blocks are needed and truncate/punch/reflink block on the
> > > iolock while the directio writes are pending, so you'll never end up
> > > with a stale mapping.
> >
> > Yes.
>
> Er... yes as in "Yes, we *do* need to revalidate directio writes", or
> "Yes, your reasoning is correct"?
>
> --D
