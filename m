Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE5E30AD20
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 17:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBAQxZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 11:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhBAQww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:52:52 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B4C061573;
        Mon,  1 Feb 2021 08:52:11 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id c3so7105291ybi.3;
        Mon, 01 Feb 2021 08:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qwbW8G2z+R0H/rCyvA3OX5oL3/sVr/Ik7CWUFrD1gK0=;
        b=AcgWNjhEOmIqNn+8fbSA0R8peOZboUMDNz4Z66znf5ipLz7lG2iL7z4aw2wsoF2DPA
         C/0gANRHZzfDIJ942NK4vvO7Wn+4jOta1hqr5p8k79YQhq5+MXmgZWSlbKUQVGTTYv7d
         +AMBVNAqUinemuF0jy6aGkkSZN/+QiOLlnO3JaCeppk0jUK+T2I8f9p+oLVqcJb+tkey
         oAhxq5dxvTxd0Lf+3phhwY6Bi30EShmWS+8bWv2GxFEMSj2uymmWxdbA1Ap8v1G78e06
         Zh6TY1u7NbV9hiIbsjU5CvKmV4gxVjJ770J/GgFEf947nkJTnOsMHpDX/9CWH/bFCJP3
         RBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qwbW8G2z+R0H/rCyvA3OX5oL3/sVr/Ik7CWUFrD1gK0=;
        b=CWUsfnvHFuzwymQudUzW3gFr3BOF+VvOB0i3N3fhJ1UCQ9UlbVcdsrKZ1aZKAncekR
         5yOWw2orxyvrn/gKA7pdtm1Z9cZoLnbYyWqB2BWftPNBQSFl2liyJhXtwF32ekY1ZW72
         nDDsfbHRE7jzeYne+eeeODTD3H1Pt7nPS5LcdsriloZMwwMX/+kqYnPHkxLUhnlhIGM+
         S0Ch2UOUi2a0MCJaOzgkKRLCy4BSzHiFGGWCuZGM9K1Ufr8RqS0zEDKJF2ThyV7hCsQw
         lZqo4/jXLAsgCJbp2sJTeHKQ54B5GECNNFeVGP42uJp7vfvTS3luPopW2v/VCBoKoPVP
         XhzQ==
X-Gm-Message-State: AOAM530w0QydfJOvlhKwXkflrqXfnqcZGAtRPl0Gu05Gf/402by/Q+MT
        ilsFYpXMB6dha/LNVqT8WKH7Y6tEScqPrXd28FftGBhygw6aCg==
X-Google-Smtp-Source: ABdhPJzpIYSB/LthDOVcsjTRxnlJdUqXnDKCUzYw7u83inL19YdICaPa+PqcTEDZFxnN9nPTj6yLQLqhBOqANUwiIRs=
X-Received: by 2002:a25:c605:: with SMTP id k5mr15317930ybf.34.1612198330634;
 Mon, 01 Feb 2021 08:52:10 -0800 (PST)
MIME-Version: 1.0
References: <20210129171316.13160-1-aaptel@suse.com> <CANT5p=ofvpimU9Z7jwj4cPXXa1E4KkcijYrxbVKQZf5JDiR-1g@mail.gmail.com>
 <877dns9izy.fsf@suse.com>
In-Reply-To: <877dns9izy.fsf@suse.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Mon, 1 Feb 2021 22:21:59 +0530
Message-ID: <CANT5p=oSrrCbCdXZSbjmPDM4P=z=1c=kj9w1DDTJO5UhtREo8g@mail.gmail.com>
Subject: Re: [PATCH v1] cifs: make nested cifs mount point dentries always
 valid to deal with signaled 'df'
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Steve French <smfrench@gmail.com>, Paulo Alcantara <pc@cjr.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm okay with returning valid for directory mount point.

But the point that I'm trying to make here is that VFS reacts
differently when d_validate returns an error VS when it just returns
invalid:
https://elixir.bootlin.com/linux/latest/source/fs/namei.c#L1409

Notice how it calls d_invalidate only when there's no error. And
d_invalidate seems to have detach_mounts.
It is likely that the umount happens there.

I'm suggesting that we should return errors inside d_validate
handlers, rather than just 0 or 1.
Makes sense?

Regards,
Shyam

On Mon, Feb 1, 2021 at 4:01 PM Aur=C3=A9lien Aptel <aaptel@suse.com> wrote:
>
> Shyam Prasad N <nspmangalore@gmail.com> writes:
> > Going by the documentation of d_revalidate:
> >> This function should return a positive value if the dentry is still
> >> valid, and zero or a negative error code if it isn't.
> >
> > In case of error, can we try returning the rc itself (rather than 0),
> > and see if VFS avoids a dentry put?
> > Because theoretically, the call execution has failed, and the dentry
> > is not found to be invalid.
>
> AFAIK mount points are pinned, you cannot rm or mv them so it seems we
> could make them always valid. I don't know if there are deeper and more
> subtle implications.
>
> The recent signal fixes are not fixing this issue.
>
> Cheers,
> --
> Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg,=
 DE
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=
=BCnchen)
>


--=20
-Shyam
