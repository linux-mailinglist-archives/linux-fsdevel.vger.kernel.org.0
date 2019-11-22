Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F00C1105E25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 02:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKVB0E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 20:26:04 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:46645 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfKVB0D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 20:26:03 -0500
Received: by mail-il1-f194.google.com with SMTP id q1so5233881ile.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 17:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gNQBYjK9mvojs7fyhRCC+eFlcT8MtYhczIdNU2SSESs=;
        b=LsRjNgAH5P7PftTFfMP7oMfYMuFLCdWd/Q6IF5+PKLTOFz3EXsB9dApMLKLVoUo+Yn
         hFLlx4R1YilYnJPGKx3PHFr2xN5t0rkzdgfkdaIW9Oms8kxpHbKYI7QwNNDfg5vuY87X
         tRXqVSy/NQVddVFqjjxCJp5SRIhrJ2t/tnbz5kULERFINTt00P4gyItP+TurX0evzLjf
         moEESa+PObcCBbYdmCcuO9Kgs0ZVk3sMLyb9iyoIMCsxt5ye2RzEdQ1VvAfWpUDQ3+iJ
         A+0Ox040XWKz56Ed4i9+t2rgBd9gogISWrJ2XhSc8ndvbK9MuVt4wfKEP6B0Y62b5Szi
         Hiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gNQBYjK9mvojs7fyhRCC+eFlcT8MtYhczIdNU2SSESs=;
        b=RbOUwNu1GSO3Y8XbmG+5+yo9O19PNr8s4TAM11Ym6RcGoEr0BfMHZGnABh4EyITVYj
         lBy9M3mlbWt8f7QK9mNo0rkMByoe6lsxo3O8hynniYjrNXV2P8jR87tuxT3YkU88sBMy
         pKvVDFXta/f/jefANlxiash7gvE48guLgNjNoMlyskTgtGg4ZP48u8gj9GYw1uibFEKF
         rmxZn1gRKolEhHYAuzgKhbMAzkK5EXzxhzof5AjAwqHnq6mggsGP5iISRW8F7b5YJDw2
         b3eLls29zvKrwI2mOZrHus0pzwS6JfTV5byH9zDiUWID18tmJyF++DajDlHprCaferc8
         u3OA==
X-Gm-Message-State: APjAAAXxf7AlKQ+qyFAKlT4HlyNY9o7P/4alYTIsSz2R5keLZkJRjK5/
        BwHM8vS3GBHVku7JXh5DLozkaElHoJtubo1azANnbw==
X-Google-Smtp-Source: APXvYqyOfnKIzwFxyC+UBhjb4+RiOTZbSs0Qe7/mfHHqJaktk77TwWC+r4bG8aeQxxhSfZ1CkiOCWdPkrABZrPepE8U=
X-Received: by 2002:a92:495a:: with SMTP id w87mr14556769ila.133.1574385962926;
 Thu, 21 Nov 2019 17:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20191019161138.GA6726@magnolia> <CAHc6FU57p6p7FXoYCe1AQNz54Fg2BZ5UsEW3BBUnhLaGq2SmsQ@mail.gmail.com>
 <20191122012054.GB2981917@magnolia>
In-Reply-To: <20191122012054.GB2981917@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 22 Nov 2019 02:25:51 +0100
Message-ID: <CAHpGcMJPoZUWiT0F2Vtsq-ZMWZpbbT3L-sKrDF8uueB1rQm_BA@mail.gmail.com>
Subject: Re: [PATCH v4] splice: only read in as much information as there is
 pipe buffer space
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>, ebiggers@kernel.org,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Fr., 22. Nov. 2019 um 02:24 Uhr schrieb Darrick J. Wong
<darrick.wong@oracle.com>:
> On Thu, Nov 21, 2019 at 06:57:55PM +0100, Andreas Gruenbacher wrote:
> > On Sat, Oct 19, 2019 at 6:14 PM Darrick J. Wong <darrick.wong@oracle.co=
m> wrote:
> > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > >
> > > Andreas Gr=C3=BCnbacher reports that on the two filesystems that supp=
ort
> > > iomap directio, it's possible for splice() to return -EAGAIN (instead=
 of
> > > a short splice) if the pipe being written to has less space available=
 in
> > > its pipe buffers than the length supplied by the calling process.
> > >
> > > Months ago we fixed splice_direct_to_actor to clamp the length of the
> > > read request to the size of the splice pipe.  Do the same to do_splic=
e.
> > >
> > > Fixes: 17614445576b6 ("splice: don't read more than available pipe sp=
ace")
> > > Reported-by: Andreas Gr=C3=BCnbacher <andreas.gruenbacher@gmail.com>
> >
> > Reviewed-by: Andreas Gr=C3=BCnbacher <andreas.gruenbacher@gmail.com>
>
> Cool, thanks.  I'll try to push this to Linus next week.

That would be great, thanks.

Andreas
