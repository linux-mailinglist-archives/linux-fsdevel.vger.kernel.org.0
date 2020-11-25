Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F36B2C4885
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 20:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgKYThc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 14:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgKYTh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:37:29 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65045C0613D4;
        Wed, 25 Nov 2020 11:37:19 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id s10so3311326ioe.1;
        Wed, 25 Nov 2020 11:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kv0ywmjDrikfiXNda4p2YSL8CO62TgmzmONVIiK1GDE=;
        b=ZtHBfgqeyVUq/3qwVShe4VJbF6/OmRFQ9IjzKMbc2GEfLkVygx0RgnpKrKsyakr9gx
         W+eT8IE93nUY6qAzE68+za69fd8mMtGFnaQyNdT70Wbm9KlDF3Q61JCdsXTfMUz9FTnb
         PKbrtncHW0Ep4QkO74s6mokIUG5R/CCKUn4hxMd6Kx5nMOpZzKoYTNGiNc14TWexPhUb
         347/YEYxVrZFsgkKKEAEQENOrTDJBAiZLp73tBiLWXB8swYMjTwCEE8v0OdRqTVCtujP
         kg40V42YxMeG45jOwS+Tx4urgBLzSuRntEkxoPz6HRjcaW3x20jGYNIccWd0MYHcG/7W
         dYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kv0ywmjDrikfiXNda4p2YSL8CO62TgmzmONVIiK1GDE=;
        b=YWaCWhued9jWW8CoI/3iQAbtlD6b9KKEPFzWclHEdMYEDEfdN6JhnxME5uUiG07dRU
         SNqmck/Lf9aNx5VD4/kUnKrH2nUK88mxZAuEGUKhfEK/MVwVTEZS1cQPvHwxSzaGUi+Z
         6DT111TIV3LtriTDCEQPYmIZUwn0irqtoIjiyosMY9aaY/dER/YQRtThhVXygNyvoZ4E
         iPP4z1zx1Ji39UYY46MpgpDRrLnL385c4uZasucuQcUpcg8WbnjOhszuK+vvo5RX0EVC
         xDkxK4knCUJq0IYcbOaaJ5+Ezaa6LRsFgqOF0axXOLTBF/5ny7nd4ATeI9unbAsFlHQo
         Gc7g==
X-Gm-Message-State: AOAM531eQkV3cyZuxlvlpIsp/1vAgVRizHumb71qszJT6zpR123CjDXx
        ZQJPSR9PCc7lbQrirUi0KqEbmCIQwtVf8+TKAlQy6OEM
X-Google-Smtp-Source: ABdhPJw159Jp6wcopt9L+RL9T0MaafiPkYlPy0VpYrKy0jOwc8fMTkdKb2R4Dz6tv9NHP1YFy+k2SRJDF2Sp/59W6rs=
X-Received: by 2002:a02:70ce:: with SMTP id f197mr4845114jac.120.1606333038733;
 Wed, 25 Nov 2020 11:37:18 -0800 (PST)
MIME-Version: 1.0
References: <20201125104621.18838-1-sargun@sargun.me> <20201125104621.18838-3-sargun@sargun.me>
 <20201125181704.GD3095@redhat.com> <CAMp4zn_jR28x4P21QaHJV8AzG90ZZO3=K+pDVwNovP1m3hf7pw@mail.gmail.com>
 <20201125184305.GE3095@redhat.com> <CAMp4zn-fRa9i=D1N4GTU3bB891vG0qkaALzOOh3mzokNme=YbA@mail.gmail.com>
 <20201125185232.GF3095@redhat.com>
In-Reply-To: <20201125185232.GF3095@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Nov 2020 21:37:07 +0200
Message-ID: <CAOQ4uxj9HYv5XXOx=Z2JhQCZauUey7V_T5_AA+=Wn=+hWLOy1g@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] overlay: Add the ability to remount volatile
 directories when safe
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 8:52 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Nov 25, 2020 at 10:47:38AM -0800, Sargun Dhillon wrote:
> > On Wed, Nov 25, 2020 at 10:43 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Wed, Nov 25, 2020 at 10:31:36AM -0800, Sargun Dhillon wrote:
> > > > On Wed, Nov 25, 2020 at 10:17 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > >
> > > > > On Wed, Nov 25, 2020 at 02:46:20AM -0800, Sargun Dhillon wrote:
> > > > >
> > > > > [..]
> > > > > > @@ -1125,16 +1183,19 @@ static int ovl_workdir_cleanup_recurse(struct path *path, int level)
> > > > > >                       if (p->len == 2 && p->name[1] == '.')
> > > > > >                               continue;
> > > > > >               } else if (incompat) {
> > > > > > -                     pr_err("overlay with incompat feature '%s' cannot be mounted\n",
> > > > > > -                             p->name);
> > > > > > -                     err = -EINVAL;
> > > > > > -                     break;
> > > > > > +                     err = ovl_check_incompat(ofs, p, path);
> > > > > > +                     if (err < 0)
> > > > > > +                             break;
> > > > > > +                     /* Skip cleaning this */
> > > > > > +                     if (err == 1)
> > > > > > +                             continue;
> > > > > >               }
> > > > >
> > > > > Shouldn't we clean volatile/dirty on non-volatile mount. I did a
> > > > > volatile mount followed by a non-volatile remount and I still
> > > > > see work/incompat/volatile/dirty and "trusted.overlay.volatile" xattr
> > > > > on "volatile" dir. I would expect that this will be all cleaned up
> > > > > as soon as that upper/work is used for non-volatile mount.
> > > > >
> > > > >
> > > >
> > > > Amir pointed out this is incorrect behaviour earlier.
> > > > You should be able to go:
> > > > non-volatile -> volatile
> > > > volatile -> volatile
> > > >
> > > > But never
> > > > volatile -> non-volatile, since our mechanism is not bulletproof.
> > >
> > > Ok, so one needs to manually remove volatile/dirty to be able to
> > > go from volatile to non-volatile.
> > >
> > > I am wondering what does this change mean in terms of user visible
> > > behavior. So far, if somebody tried a remount of volatile overlay, it
> > > will fail. After this change, it will most likely succeed. I am
> > > hoping nobody relies on remount failure of volatile mount and
> > > complain that user visible behavior changed after kernel upgrade.
> > >
> > > Thanks
> > > Vivek
> > >
> > If I respin this shortly, can we get it in rc6, or do we want to wait
> > until 5.11?
>
> I think that trying to squeeze it in this late in cycle is probably
> not a good idea. If above is a valid concern, then this feature probably
> needs to be an opt-in.
>

Doesn't sound like a concern to me.

Thanks,
Amir.
