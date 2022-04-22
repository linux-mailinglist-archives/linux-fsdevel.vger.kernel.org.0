Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE4550B586
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446657AbiDVKud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 06:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349112AbiDVKuc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:50:32 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD12455204
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 03:47:39 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id f14so5211804qtq.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UiT5hnNiHqxC+u6rf+KKMMFRCg5OQPEXs7W1dxrcf+U=;
        b=EdFrdPEYxOFB71fDaLKtrw9VpzPH4Bp7PIDQYCoBNfBwmRPpX/xUjV6Pov2h/CZdsg
         h9KVbMqvfO7suOvMh0yFMpnIsJGRvNuNbCAiXEkxuiNCTrE/lSmSpD/OkZGAm79rq8a+
         dxoyuKjtRwfPNhaGaWnVYn6Hca2nWHukCzoy0WVfrI2RDtKIrO28gIXb8wdSgLJ/tO8W
         vOmVS1qocLiolASMP9dyiNwyX7UXzKRIdo7DvtjBu9Qp1Y/Ovt8tRpMLPA270gyDvIzS
         rB9WJNC8/cuopPRTMEdDq6N19ZV2RUdbTjQWW+/AWWwkP5e304ovch2wnpj4KxciJkzZ
         y1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UiT5hnNiHqxC+u6rf+KKMMFRCg5OQPEXs7W1dxrcf+U=;
        b=7TmXRXd2vWxnEa+EHCX1S27EjyKo7EOzwPUS9v8t+DkM7ZM6j3STD/poVQfAlfJ7rk
         X2oZdkc6xs7NXrBVntao+dFUsJgi3WBm3ZAH86hyXAxN014Y0BLE6/QvQNMR+9Zi0F8x
         CX3YiDLEYMoh4hl+toH0ZEC438cDGLMvtzFIraH7KDBl2wfiEqDj5cLpD8pBBZJq3tK/
         cKKiEPXawFZ24RujtIzRJzbnoAqc9xelP2Qa9Uy7Hz/wloGSuza2D908QuEouswbzxJs
         303BYsCAFR8xlJcHuJNje128kzFF/4/bepA/K3vEMruRSIIK7HifyCJS4zKIIchXdVX6
         1Rsw==
X-Gm-Message-State: AOAM533F1xDSJkk1OqToB4QhQbxORPDWY0Pmly598g/E75vkcukPa1r7
        gBvuemAYnThmpp0uu0SmV7Hre+Qwd12033BLeqs=
X-Google-Smtp-Source: ABdhPJzBeR3M6QrFQSZcGInfz0bwdBs6GEGCIpnGBXxM7Mm6n66NCxrGBAkNFExH7loiKJDi8+ZcZu4NLESjPzbJPm8=
X-Received: by 2002:ac8:5cc7:0:b0:2f3:5996:7667 with SMTP id
 s7-20020ac85cc7000000b002f359967667mr1008473qta.2.1650624458903; Fri, 22 Apr
 2022 03:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220413090935.3127107-1-amir73il@gmail.com> <20220413090935.3127107-15-amir73il@gmail.com>
 <20220421154005.vb6ms3o4fho2z7d6@quack3.lan>
In-Reply-To: <20220421154005.vb6ms3o4fho2z7d6@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 22 Apr 2022 13:47:27 +0300
Message-ID: <CAOQ4uxiz3Yc5EqJeLuPzYWE9XPPNOs0n5doNJzhNPLnJWnsZKA@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] fanotify: implement "evictable" inode marks
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

On Thu, Apr 21, 2022 at 6:40 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 13-04-22 12:09:33, Amir Goldstein wrote:
> > When an inode mark is created with flag FAN_MARK_EVICTABLE, it will not
> > pin the marked inode to inode cache, so when inode is evicted from cache
> > due to memory pressure, the mark will be lost.
> >
> > When an inode mark with flag FAN_MARK_EVICATBLE is updated without using
> > this flag, the marked inode is pinned to inode cache.
> >
> > When an inode mark is updated with flag FAN_MARK_EVICTABLE but an
> > existing mark already has the inode pinned, the mark update fails with
> > error EEXIST.
> >
> > Evictable inode marks can be used to setup inode marks with ignored mask
> > to suppress events from uninteresting files or directories in a lazy
> > manner, upon receiving the first event, without having to iterate all
> > the uninteresting files or directories before hand.
> >
> > The evictbale inode mark feature allows performing this lazy marks setup
> > without exhausting the system memory with pinned inodes.
> >
> > This change does not enable the feature yet.
> >
> > Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Just one nit below...
>
> > @@ -1097,6 +1099,18 @@ static int fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
> >                       *recalc = true;
> >       }
> >
> > +     if (fsn_mark->connector->type != FSNOTIFY_OBJ_TYPE_INODE ||
> > +         want_iref == !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
> > +             return 0;
> > +
> > +     /*
> > +      * NO_IREF may be removed from a mark, but not added.
> > +      * When removed, fsnotify_recalc_mask() will take the inode ref.
> > +      */
> > +     WARN_ON_ONCE(!want_iref);
> > +     fsn_mark->flags &= ~FSNOTIFY_MARK_FLAG_NO_IREF;
> > +     *recalc = true;
> > +
> >       return 0;
> >  }
>
> Since we always return 0 from this function, we may as well just drop the
> 'recalc' argument and return whether mask recalc is needed?
>

I agree, but in this case, I rather also return recalc from
fanotify_mark_add_to_mask() and keep fsnotify_recalc_mask()
in fanotify_add_mark() and it is now.

Thanks,
Amir.
