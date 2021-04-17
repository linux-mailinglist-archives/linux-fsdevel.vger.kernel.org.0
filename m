Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792BA362D64
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 05:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhDQDzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 23:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhDQDzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 23:55:24 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032BCC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 20:54:58 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id k25so29948903oic.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 20:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WWUEp5Vn7+htXe/5/HVzSKfw6VtYTPZAq2BL/y29HHQ=;
        b=H3iC+58TiKpdqVjuZyV+FyW1l7ycvohcfFNeASkeocTbcrhFmPCTY28RmK9tIeEe70
         /Ql5dGqg2zkLJsoiU5c89kXsMRuzLg6gHA1PF8yNhgpsOA4GhOaNpSiQtO7NSWAB6RT4
         xfrmHwC1iFhq2j9lckQQAZhPnPhFh8X33G/gasswgTRESz97Sbq5HjpYvATBBe3XMIH3
         t+ncvAzg4mZsxmpQEaQ1KiaicbTGwbNYLu/lqmBaw0M6L7RU2Bi4XtoHHp0Y+GKNFxsP
         4hxG2yI0uUpMTKfacLQaTjE+EoU2S2rYflohMmU6hoCJ1AxjhIwip0ubzwlAM7E+YKTI
         E3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WWUEp5Vn7+htXe/5/HVzSKfw6VtYTPZAq2BL/y29HHQ=;
        b=OwyB1xICaMsTpMZi2XL+1MHZYWx0TTE7+joV1w028SZDTYxPqbLmbzFwS/BpNmxLO5
         Yw3Zrum6/cmH6tNyrsyF/FLc/ThjRAeL8GSL5Yv6VbztQkSkvS8Y+Pd2DIM0xRUB5NzZ
         XZdyVVp7DrLFEU4UbJrMcMiK2zQfTt/4zaZI2eg0yNehcaVho+VG9Uqtijg9L9osN11t
         852M8msbyYDs4OBK7UjOLqzeNXgmzFfh6xindIozW7XlGkrLmlPKTPs/Ckj0N+8RrgZQ
         o+sZKTO4BkdHnE/sS1XtZaAez4leAuaj2TslXoaU2KMeoEU5u4Jo3tSjir3u4kJhmLW9
         rkzQ==
X-Gm-Message-State: AOAM533wdVk41vQIC7DmdYN+RNIaG6xH4lEvy0PQJDfnlOpXzxZRZX/Y
        c5oAkdMBAhfG1TCuXhzx7B2fbw==
X-Google-Smtp-Source: ABdhPJyAn9fdWmCzFR/5jB19JYiuSZOWxqpN0zDrCdBgRtVRaEqGFYsTCi7lkvAqa6uQe1WT9TQR6w==
X-Received: by 2002:aca:c74a:: with SMTP id x71mr8546370oif.22.1618631698073;
        Fri, 16 Apr 2021 20:54:58 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e2sm1823558otk.70.2021.04.16.20.54.57
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 16 Apr 2021 20:54:57 -0700 (PDT)
Date:   Fri, 16 Apr 2021 20:54:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
cc:     Hugh Dickins <hughd@google.com>, Theodore Tso <tytso@mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] shmem: allow reporting fanotify events with file
 handles on tmpfs
In-Reply-To: <CAOQ4uxia0ETkPF7Af3YiYGb2QzD03UNEpvU2jyibf_+tajhe1A@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2104162042130.26690@eggly.anvils>
References: <20210322173944.449469-1-amir73il@gmail.com> <20210322173944.449469-3-amir73il@gmail.com> <20210325150025.GF13673@quack2.suse.cz> <CAOQ4uxia0ETkPF7Af3YiYGb2QzD03UNEpvU2jyibf_+tajhe1A@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 16 Apr 2021, Amir Goldstein wrote:
> On Thu, Mar 25, 2021 at 5:00 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 22-03-21 19:39:44, Amir Goldstein wrote:
> > > Since kernel v5.1, fanotify_init(2) supports the flag FAN_REPORT_FID
> > > for identifying objects using file handle and fsid in events.
> > >
> > > fanotify_mark(2) fails with -ENODEV when trying to set a mark on
> > > filesystems that report null f_fsid in stasfs(2).
> > >
> > > Use the digest of uuid as f_fsid for tmpfs to uniquely identify tmpfs
> > > objects as best as possible and allow setting an fanotify mark that
> > > reports events with file handles on tmpfs.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Hugh, any opinion on this patch?
> >
> >                                                                 Honza
> >
> > > ---
> > >  mm/shmem.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index b2db4ed0fbc7..162d8f8993bb 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -2846,6 +2846,9 @@ static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
> > >               buf->f_ffree = sbinfo->free_inodes;
> > >       }
> > >       /* else leave those fields 0 like simple_statfs */
> > > +
> > > +     buf->f_fsid = uuid_to_fsid(dentry->d_sb->s_uuid.b);
> > > +
> > >       return 0;
> > >  }
> > >
> 
> 
> Ping.
> 
> Hugh, are you ok with this change?
> 
> Thanks,
> Amir.

Yes, apologies for my delay to you, Amir and Jan:
sure I'm ok with this change, and thank you for taking care of tmpfs.

Acked-by: Hugh Dickins <hughd@google.com>

But you have more valuable acks on this little series already,
so don't bother rebasing some tree to add mine in now.  I don't yet
see the uuid_to_fsid() 1/2 which this depends on in linux-next, and
fear that's my fault for holding you back: sorry, please go ahead now.

Hugh
