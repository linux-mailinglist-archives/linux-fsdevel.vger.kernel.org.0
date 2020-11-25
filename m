Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD612C47AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 19:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732790AbgKYScV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 13:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730781AbgKYScV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:32:21 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B1FC061A4F
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 10:32:14 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id 7so4439945ejm.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ecRcBDigyuzJpB4+DEEjbs/8q8jM472OmYKMrTaXLcM=;
        b=fz+eoZBmT7qC4mcDH7aY9dy2eKBuFqczfeivFyhSj4KSb3aiPp+PV5wLlMEk9+xfDe
         D/asPbT25lNO9mcusmQZ+k/2hkfHjCiK3Fl7iZkBex6CISwwhVaKVNCmMo5AcDlGrzV1
         9pmrY9xMY4DwAKIZifUHcsC0UvOeMFvEjZzBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecRcBDigyuzJpB4+DEEjbs/8q8jM472OmYKMrTaXLcM=;
        b=S1M68emWpdlJWSDyvtUVqN8UrPONMB0XFH22XJa25cME+I6CQzRUiNnVyLf3ssCGp9
         So8Q1inqYhEp30QFhoh71KuJgAa9gXnPlc0TfVZ64fgD6WBJuTDsKmcbo47ZWdMvBcfK
         YHe2nrxNHuejmURoS3xC7uKNp2o3m6DU7ESLanD/Yvr6uHVK65ztGeodYcwPE9DLZfek
         JjTwXwPZvVhQj64vYRe9yg6xi6f1MGv71Wm8YZj+Ij/aaXVsGbQLcRv1YmNyR8OkbTjV
         ayWICGZ8zZ1G5tvPp5pkXCxtOrQW7iSLopuTbKqjpbwgx8GAGje/asXja1GRqQWrNTb7
         i6UA==
X-Gm-Message-State: AOAM531yFoEddtw4elvTdKdHqc/2MqfgwXU59Nk21YIr4I1T9l3o6mk7
        SLwO3t/4b3k7Cw4pRnbkUWOdVSUlH7EgImF1iRWUSg==
X-Google-Smtp-Source: ABdhPJwlZrbCvfj3PJAGYPrC0QMaE1AMNMzD35MIDdb9brVL8P39XfFyTdj6VUET/3czQ86eRxr0KWaTeO3ROp0C5tc=
X-Received: by 2002:a17:906:6b86:: with SMTP id l6mr4318905ejr.524.1606329133305;
 Wed, 25 Nov 2020 10:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20201125104621.18838-1-sargun@sargun.me> <20201125104621.18838-3-sargun@sargun.me>
 <20201125181704.GD3095@redhat.com>
In-Reply-To: <20201125181704.GD3095@redhat.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Wed, 25 Nov 2020 10:31:36 -0800
Message-ID: <CAMp4zn_jR28x4P21QaHJV8AzG90ZZO3=K+pDVwNovP1m3hf7pw@mail.gmail.com>
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

On Wed, Nov 25, 2020 at 10:17 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Nov 25, 2020 at 02:46:20AM -0800, Sargun Dhillon wrote:
>
> [..]
> > @@ -1125,16 +1183,19 @@ static int ovl_workdir_cleanup_recurse(struct path *path, int level)
> >                       if (p->len == 2 && p->name[1] == '.')
> >                               continue;
> >               } else if (incompat) {
> > -                     pr_err("overlay with incompat feature '%s' cannot be mounted\n",
> > -                             p->name);
> > -                     err = -EINVAL;
> > -                     break;
> > +                     err = ovl_check_incompat(ofs, p, path);
> > +                     if (err < 0)
> > +                             break;
> > +                     /* Skip cleaning this */
> > +                     if (err == 1)
> > +                             continue;
> >               }
>
> Shouldn't we clean volatile/dirty on non-volatile mount. I did a
> volatile mount followed by a non-volatile remount and I still
> see work/incompat/volatile/dirty and "trusted.overlay.volatile" xattr
> on "volatile" dir. I would expect that this will be all cleaned up
> as soon as that upper/work is used for non-volatile mount.
>
>

Amir pointed out this is incorrect behaviour earlier.
You should be able to go:
non-volatile -> volatile
volatile -> volatile

But never
volatile -> non-volatile, since our mechanism is not bulletproof.

I will fix this in the next respin.
