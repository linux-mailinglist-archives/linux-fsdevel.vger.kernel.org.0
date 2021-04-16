Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE8E361DA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 12:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbhDPKA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 06:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbhDPKA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:00:26 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A465C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 03:00:01 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id v13so6598809ilj.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DViDG4e3ytZRzvQTdptvaQZPSuPxk5hDy5nR7A/4sS4=;
        b=M0bo3M3QEl0dAkA4HnpHsv6ANZSt38vaTsRShCNjN3ynn8qi8zc3antJ7vqCHU9I49
         KthR+ORsFF7wER836MByMmcwfpmEov6anHr+lzPRUP3jDKXkTULu3oe4XEnduVfupSTG
         UFmzCh4ph0y2pZvrVXSjc2fy9K8W1e7xCcANcVle8ECpRBj7HVuDHJdFB7AuPxQE3Myd
         yZmMFt3IemOmT/p/Vdd3x0NzVa/qH/Lhg7eNxuqVU/5nWOOxe1m0mk76yyOQ+6EKd856
         Uv8fhXWcEqcCF2SI/Ql7nk4mWF8j8YcRacmwbLQVmuX9L+pn1O81COAPb2oZ5p7H//Z/
         AwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DViDG4e3ytZRzvQTdptvaQZPSuPxk5hDy5nR7A/4sS4=;
        b=PbYRsqzQsX6D2jJ5LbSmGIogWR3lnsBY8Co6u2ewuH906cE6J2p+dMFfxL9oAPR+kc
         7DfbINzfJsAJD1xkVv6sbU20sh29Lh8M4/YDpY5wJpBj30d/I1zcWufZ7sdxiBT5e5Yh
         naTHs0tRAEWhavVQ2cxUqXU33J8srKprX47Olfsa9Y3cKKaY29Kemkf4K9ge1/pJeuv+
         X9huMnPHFaBSIn6JhGUMWozd5gy34GIgX/bElblLqQUJDoFY2gWBBlnHsHN2WtWFazkJ
         okG1LOwve5WFl3EOLJ5EO6Mf9bpOzCsLdCbsu3mDKPjN/tRgXw5pmJG2RRfEYjvGNJy4
         f6KQ==
X-Gm-Message-State: AOAM530Fr+85hybdzJZdz/AtYaVSfwBTRJWmLLZBNOuFIHGAKPNF1AcB
        4ReGiPf/gj6WxKRUSUuBYDq+pnIHue7rdar9rtw=
X-Google-Smtp-Source: ABdhPJyEvRq5Ckn6EgVkSJHvZdBF+edeoTwJdgRDMRKn0d5Y/42XyASjMqPZNcGhGRl2wqe4T76EBFTBnqFmFey70rI=
X-Received: by 2002:a05:6e02:1a21:: with SMTP id g1mr6373763ile.9.1618567201019;
 Fri, 16 Apr 2021 03:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210322173944.449469-1-amir73il@gmail.com> <20210322173944.449469-3-amir73il@gmail.com>
 <20210325150025.GF13673@quack2.suse.cz>
In-Reply-To: <20210325150025.GF13673@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 16 Apr 2021 12:59:49 +0300
Message-ID: <CAOQ4uxia0ETkPF7Af3YiYGb2QzD03UNEpvU2jyibf_+tajhe1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] shmem: allow reporting fanotify events with file
 handles on tmpfs
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 5:00 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 22-03-21 19:39:44, Amir Goldstein wrote:
> > Since kernel v5.1, fanotify_init(2) supports the flag FAN_REPORT_FID
> > for identifying objects using file handle and fsid in events.
> >
> > fanotify_mark(2) fails with -ENODEV when trying to set a mark on
> > filesystems that report null f_fsid in stasfs(2).
> >
> > Use the digest of uuid as f_fsid for tmpfs to uniquely identify tmpfs
> > objects as best as possible and allow setting an fanotify mark that
> > reports events with file handles on tmpfs.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Hugh, any opinion on this patch?
>
>                                                                 Honza
>
> > ---
> >  mm/shmem.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index b2db4ed0fbc7..162d8f8993bb 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2846,6 +2846,9 @@ static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
> >               buf->f_ffree = sbinfo->free_inodes;
> >       }
> >       /* else leave those fields 0 like simple_statfs */
> > +
> > +     buf->f_fsid = uuid_to_fsid(dentry->d_sb->s_uuid.b);
> > +
> >       return 0;
> >  }
> >


Ping.

Hugh, are you ok with this change?

Thanks,
Amir.
