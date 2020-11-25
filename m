Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D1C2C47E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 19:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbgKYSsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 13:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732599AbgKYSsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:48:16 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FE9C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 10:48:15 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id lv15so4412808ejb.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 10:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/C7vSMdg8WTy1Dqg2eemAACyCfJa7f2PMQw/1q85t9U=;
        b=qef9uyhwGUK8nKHoK3Pd8NfQE2T4VPO6bNnj8SE177elVetYhBFuu7Y0tPagzVIRZE
         xkrQFz77zsk182Xfxjxjcp36XTEC/2zhAIO7aqkRRiSLg6I6pMGm2ioBeWMTMPwRGTSi
         R3zJ/hOTsZzC87/puIA1sxmCc+CpjzJB9MVzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/C7vSMdg8WTy1Dqg2eemAACyCfJa7f2PMQw/1q85t9U=;
        b=Kdhuw0xCm3Lu3wThwelViUJpVuZoQNYlcJSnNcNJQPk2u48ipkV2qlpLTdFE5Ptb8v
         iy9S5/XbMGMB6Qq8DbWtLu24XMpvXAG6L6UxeT64Y7mKMJm5LEt09mLareDJaUWcbEBM
         XblKpZYcvD3z9I4NuVWLXQEV1qeWQl8r7/IanFmV1JK5GW/ttVQksCaF20U9mS3XiNAY
         aZavzp592xFdkEWrPLxS1pjsISTs/y/s7aGgnCypRMI//TuFF+WP6wxzWnLFZMehOvf8
         I4W8c9tqaVWBc5aYxK3a3PJ3ggoreodSfPoH5IEHdWkCYHtkN9wJ/Rzq7/7bYNmOTLcM
         SiEQ==
X-Gm-Message-State: AOAM531Hw0+YHk5cY4prc0Q6oT6ccWW2mlgIf2EtxqBKXgqKpvJrHOEi
        uyf7jNiIx7L4wRke1nbld82IX9nwOz8uKZTq2G7u7A==
X-Google-Smtp-Source: ABdhPJzHRgVye5GWVdNjm616fLYDKlIPLh/tueMOkDG4uMje1zs/V8o0OFSKiXoLiI5CLnI/HfTafd2zi1Wi0UkGslY=
X-Received: by 2002:a17:906:80d1:: with SMTP id a17mr4164522ejx.269.1606330094533;
 Wed, 25 Nov 2020 10:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20201125104621.18838-1-sargun@sargun.me> <20201125104621.18838-3-sargun@sargun.me>
 <20201125181704.GD3095@redhat.com> <CAMp4zn_jR28x4P21QaHJV8AzG90ZZO3=K+pDVwNovP1m3hf7pw@mail.gmail.com>
 <20201125184305.GE3095@redhat.com>
In-Reply-To: <20201125184305.GE3095@redhat.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Wed, 25 Nov 2020 10:47:38 -0800
Message-ID: <CAMp4zn-fRa9i=D1N4GTU3bB891vG0qkaALzOOh3mzokNme=YbA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] overlay: Add the ability to remount volatile
 directories when safe
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 10:43 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Nov 25, 2020 at 10:31:36AM -0800, Sargun Dhillon wrote:
> > On Wed, Nov 25, 2020 at 10:17 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Wed, Nov 25, 2020 at 02:46:20AM -0800, Sargun Dhillon wrote:
> > >
> > > [..]
> > > > @@ -1125,16 +1183,19 @@ static int ovl_workdir_cleanup_recurse(struct path *path, int level)
> > > >                       if (p->len == 2 && p->name[1] == '.')
> > > >                               continue;
> > > >               } else if (incompat) {
> > > > -                     pr_err("overlay with incompat feature '%s' cannot be mounted\n",
> > > > -                             p->name);
> > > > -                     err = -EINVAL;
> > > > -                     break;
> > > > +                     err = ovl_check_incompat(ofs, p, path);
> > > > +                     if (err < 0)
> > > > +                             break;
> > > > +                     /* Skip cleaning this */
> > > > +                     if (err == 1)
> > > > +                             continue;
> > > >               }
> > >
> > > Shouldn't we clean volatile/dirty on non-volatile mount. I did a
> > > volatile mount followed by a non-volatile remount and I still
> > > see work/incompat/volatile/dirty and "trusted.overlay.volatile" xattr
> > > on "volatile" dir. I would expect that this will be all cleaned up
> > > as soon as that upper/work is used for non-volatile mount.
> > >
> > >
> >
> > Amir pointed out this is incorrect behaviour earlier.
> > You should be able to go:
> > non-volatile -> volatile
> > volatile -> volatile
> >
> > But never
> > volatile -> non-volatile, since our mechanism is not bulletproof.
>
> Ok, so one needs to manually remove volatile/dirty to be able to
> go from volatile to non-volatile.
>
> I am wondering what does this change mean in terms of user visible
> behavior. So far, if somebody tried a remount of volatile overlay, it
> will fail. After this change, it will most likely succeed. I am
> hoping nobody relies on remount failure of volatile mount and
> complain that user visible behavior changed after kernel upgrade.
>
> Thanks
> Vivek
>
If I respin this shortly, can we get it in rc6, or do we want to wait
until 5.11?
