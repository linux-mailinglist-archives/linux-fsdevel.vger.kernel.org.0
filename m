Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3671DEF8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 20:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbgEVSyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 14:54:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48917 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730849AbgEVSyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 14:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590173645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/NY7atph5yZUS2SuBQhFRnCbvYDVMYgXeB+elMZM6I=;
        b=PZc/Ru1rAczb2iuw8XBVs2YRivxuGT6xRIJkYUE+UmbmO0AKqtg3XzVdQ6Lxrf6cpVMef1
        a4IG/bYzcLk4yuMjkCjfHul0Vo20Pb3kLgT6IfS9J0wqEgaKUsvAPUfuxwEknM8W8c23Sf
        5V7CTzRPlGX77kgTxsM/RPT5J0Y9XAI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-NhmzOV2RNi-nWOmJ0a2xTA-1; Fri, 22 May 2020 14:54:01 -0400
X-MC-Unique: NhmzOV2RNi-nWOmJ0a2xTA-1
Received: by mail-qk1-f200.google.com with SMTP id d19so11976652qkj.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 11:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/NY7atph5yZUS2SuBQhFRnCbvYDVMYgXeB+elMZM6I=;
        b=oiMpVLpo55Amosn1S0zys8rEUiWSTBpviU+VaE4Ir5cIthQ4zfVTdhUI00DzB+WXkH
         UekYrl5SOMZZxpZ/QQJvOBFnXLozIYTd8KFdAD2o6A/0n1jiO5yYafDSY9zB8bDe9tbr
         /Ew0RGM0Lt1V4F0uydZN2JdrPrG51155ReuFW+2n1FdZck1XzklBTXVzfZafImMR3Gts
         CIlGGigEhq8N7Kc2jVwltSleibWSI4hABi/P4SwKOZ+O/Jci7f+wTXAvDbCSGy39I2GK
         UD/tvmG5fqjRWhqFp27s+I6JchWFsWsDRrl9S041ltJdYqhLM5KvosGdo67ljs1a2wBz
         wBaQ==
X-Gm-Message-State: AOAM532tJ/w4Hq/oLHzjHx801tsoi5ue/lXLUTqi33hYHpIpVYfF3e2s
        KNI5mYntdTOB3wuCd5ErHKSq8ktpX4BNpn6ukAImn2zNrRHqVNc0/8uThSxGAsXJK09qC7L+v0M
        ayltrUjolfAj8Z0LxnrP22hUkI12DcYOgzEWFv912+w==
X-Received: by 2002:ac8:6a09:: with SMTP id t9mr17251952qtr.7.1590173641102;
        Fri, 22 May 2020 11:54:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbxr6F952pnH66Ybf4aYPRDiPNGnNWNtV2AqqamKyJkx4ekz3DUmjn2w4Ud12SVL+kOWfT5/QtW00UoW0ai/o=
X-Received: by 2002:ac8:6a09:: with SMTP id t9mr17251936qtr.7.1590173640781;
 Fri, 22 May 2020 11:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200522085723.29007-1-mszeredi@redhat.com> <20200522160815.GT23230@ZenIV.linux.org.uk>
 <CAOssrKcpQwYh39JpcNmV3JiuH2aPDJxgT5MADQ9cZMboPa9QaQ@mail.gmail.com> <CAOQ4uxi80CFLgeTYbnHvD7GbY_01z0uywP1jF8gZe76_EZYiug@mail.gmail.com>
In-Reply-To: <CAOQ4uxi80CFLgeTYbnHvD7GbY_01z0uywP1jF8gZe76_EZYiug@mail.gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 22 May 2020 20:53:49 +0200
Message-ID: <CAOssrKfXgpRykVN94EiEy8xT4j+HCedN96i31j9iHomtavFaLA@mail.gmail.com>
Subject: Re: [PATCH] ovl: make private mounts longterm
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 7:02 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > > -     mntput(ofs->upper_mnt);
> > > > -     for (i = 1; i < ofs->numlayer; i++) {
> > > > -             iput(ofs->layers[i].trap);
> > > > -             mntput(ofs->layers[i].mnt);
> > > > +
> > > > +     if (!ofs->layers) {
> > > > +             /* Deal with partial setup */
> > > > +             kern_unmount(ofs->upper_mnt);
> > > > +     } else {
> > > > +             /* Hack!  Reuse ofs->layers as a mounts array */
> > > > +             struct vfsmount **mounts = (struct vfsmount **) ofs->layers;
> > > > +
> > > > +             for (i = 0; i < ofs->numlayer; i++) {
> > > > +                     iput(ofs->layers[i].trap);
> > > > +                     mounts[i] = ofs->layers[i].mnt;
> > > > +             }
> > > > +             kern_unmount_many(mounts, ofs->numlayer);
> > > > +             kfree(ofs->layers);
> > >
> > > That's _way_ too subtle.  AFAICS, you rely upon ->upper_mnt == ->layers[0].mnt,
> > > ->layers[0].trap == NULL, without even mentioning that.  And the hack you do
> > > mention...  Yecchhh...  How many layers are possible, again?
> >
> > 500, mounts array would fit inside a page and a page can be allocated
> > with __GFP_NOFAIL. But why bother?  It's not all that bad, is it?
>
> FWIW, it seems fine to me.
> We can transfer the reference from upperdir_trap to layers[0].trap
> when initializing layers[0] for the sake of clarity.

Right, we should just get rid of ofs->upper_mnt and ofs->upperdir_trap
and use ofs->layers[0] to store those.

Thanks,
Miklos

