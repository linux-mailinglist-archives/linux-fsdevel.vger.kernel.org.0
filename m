Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EB33256C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 20:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhBYTdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 14:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhBYTas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:30:48 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BD0C061793;
        Thu, 25 Feb 2021 11:30:07 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id q14so7839559ljp.4;
        Thu, 25 Feb 2021 11:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OkaG0zgUB0LQ9IEIcoflOd9aydVR01x0iUG1991a+zE=;
        b=G0fHjaw1d+ouxuzkKitbrPKxS22xwKPQMpTJMi8Ye/cT/EPJV05IDg0nv0eEShBzpg
         xpaVvIsUE0hDrYg/YR4o92yd+HQ6joL1XqNnWA197Mvz60kmp2QAisAvcaeyvC0megS2
         rqnYBZITklAMHQICHIaZAe4MnsUFi3OQNIJrOT9dsIlIMF/xKpxsGGHowde3f2kQczMu
         RnlnNSR2JkwO0DtSm7pB5IJ3OfR+2z8jICHglr2vXR+UF5xNIdQMsPdtCCpUJURW9nsq
         7ncY4FMn92AfzREarpBx/NdEoj4n2t5Cs7MlWQXKaOSHIniz7yx343x3bZEOEQ+Y8aOx
         wg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OkaG0zgUB0LQ9IEIcoflOd9aydVR01x0iUG1991a+zE=;
        b=E9xjy4HCM0xH+A7gmAEBWsUJWFvQ6rdfkbnD4PzoHni54K71p3FEsUPkpWw4Y+JZh5
         wYIPq2K/eqDaFERrDhRK10ffDMGowkGl8WdyK140tX/lbq0bLdZTesf10L48imLXB78Z
         TjN1Sb+IbO8kQeViM2TzZ7GC3zm+oFQ4wBKeDbpvZMPhN65N/4mr6S/nD3n/1v86rnWS
         xEm6U2fqHW2/Z5WmAQ+idDR2ZZqWJOfYnrVnzoQvJGCQZxMdhbc7ZgF5Jd6KLlOFnmSa
         7vRo1GgvLK8PHpr6DMrEeHqcLj+lT9jiOVtKcstbTZWPNYv54kgWmXQIKzrG4xP/RKpx
         Qpbg==
X-Gm-Message-State: AOAM533BiHbOCr5byhhzZG+YENfDC979S5F5d5hqiq9Xfx1umE4ZE4oM
        J6FATTo+sR/LV9zilC1Zg3m3uUI7NFgKcJ5NIrI=
X-Google-Smtp-Source: ABdhPJyXIUveQdJhtGoDuoIiPuLgldfyZGCqdweNv311QEbef5eDVIbVUV16jgZ3nbbRSs06NxAzUHj9mCKKkbAPXIk=
X-Received: by 2002:a2e:9e48:: with SMTP id g8mr2477981ljk.477.1614281406394;
 Thu, 25 Feb 2021 11:30:06 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5ms9dJ3RW=_+c0HApLyUC=LD5ACp_nhE2jJQuS-121kV=w@mail.gmail.com>
 <87eehwnn2c.fsf@suse.com>
In-Reply-To: <87eehwnn2c.fsf@suse.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 25 Feb 2021 13:29:55 -0600
Message-ID: <CAH2r5muuEj_ZpbZ+yAGfnG-JPRP0mAzaBNVYhw7SnbReT8B1DA@mail.gmail.com>
Subject: Re: [PATCH] cifs: use discard iterator to discard unneeded network
 data more efficiently
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The other two routines initialize in iov_iter_bvec

iov->type
iov->bvec
iov->offset
iov->count

but iov_iter_discard already does the initialization:
iov_type
iov_offset
iov_count

and then we call cifs_readv_from_socket in all 3
which sets:
    iov->msg_control =3D NULL
    iov->msg_controllen =3D NULL

I will set the two additional ones to null
    iov->msg_name
and
    iov->msg_namelen



On Thu, Feb 4, 2021 at 4:29 AM Aur=C3=A9lien Aptel <aaptel@suse.com> wrote:
>
> Steve French <smfrench@gmail.com> writes:
> > +ssize_t
> > +cifs_discard_from_socket(struct TCP_Server_Info *server, size_t to_rea=
d)
> > +{
> > +     struct msghdr smb_msg;
> > +
> > +     iov_iter_discard(&smb_msg.msg_iter, READ, to_read);
> > +
> > +     return cifs_readv_from_socket(server, &smb_msg);
> > +}
> > +
>
> Shouldn't smb_msg be initialized to zeroes? Looking around this needs to
> be done for cifs_read_from_socket() and cifs_read_page_from_socket() too.
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
Thanks,

Steve
