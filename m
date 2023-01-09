Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD01662A6B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 16:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjAIPrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 10:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237232AbjAIPqy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:46:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE973B92C
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 07:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673279006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XAX19TTJR2VgCMVi/IEI/+PRXbV5myNOhGD9Pu+JHuY=;
        b=gtuFe8jjns91apOBgQsGjPNQr8hf4AFgi/Oge0iYs4FtnYvkUBBPliGBRLD03+ZDDgCJ8z
        BnzafnBCo4WI/IxJnJLWXvIsWmaP2OB9OeeIIIO18dDyhdZ1FEUrWlEoRklFcpkp5LZsqp
        9q0dLQMZIH9HNUU/gkU2CZ4t2gxRJ6w=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-292-ArLGrudwM2KYYIzujULXdw-1; Mon, 09 Jan 2023 10:43:24 -0500
X-MC-Unique: ArLGrudwM2KYYIzujULXdw-1
Received: by mail-vk1-f200.google.com with SMTP id j17-20020a1f2311000000b003bd40550849so2734525vkj.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 07:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAX19TTJR2VgCMVi/IEI/+PRXbV5myNOhGD9Pu+JHuY=;
        b=6L9S7ro7Inget0JMXnGJrC0+3Ygy/gNVIBL6vPhMX7noGFDwBtAaMSr+Bjqf4W56de
         /AUYnhW6pP5yZsU5z/vDkycm5zsXUZgOjZRVuJzD8EoPe7+h1wbPBehf5pfj2X8GB/hj
         V4J7kr/J7ES5OLI+LaWf2iZ/GcAT86db/jNU1FKQL9R65RcNrbgtQTSaIj3wEzqIFxWV
         7V73p+i2g70xS5DsPWBuDnmwaSp+97t8eCQnaxGNYbCNHfavH1kiu+/fI+uHAApr3rFm
         dvuSvOfc+jObgjrvsImxiVCvITQLUedNa/R/sQMM2WQ47dqiJFM90SPPjT0FPvU+yEHT
         aqKA==
X-Gm-Message-State: AFqh2kq5neZWi+ZaQuTthADUeDnV2FOsByxb/A4PTao8PGCK4Wel6P5F
        1a3HY/jsFwgCJD6N7lbM0bcJOsjMvl2FQPAfcr54GETFm4Q1Enwpr/WW72B2z6HIc+LWUnlA+AN
        VysgsNEgmikeFv25D0NXEREVk0w==
X-Received: by 2002:a67:fe11:0:b0:3ce:b8ab:3361 with SMTP id l17-20020a67fe11000000b003ceb8ab3361mr11051763vsr.31.1673279003662;
        Mon, 09 Jan 2023 07:43:23 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuIH6ysnvkOmi5DSNvrXcQWqB8jTFyv7H0UbloWZCjfUbifQMxhAHyuiD5gxHgCeoN7m69bxw==
X-Received: by 2002:a67:fe11:0:b0:3ce:b8ab:3361 with SMTP id l17-20020a67fe11000000b003ceb8ab3361mr11051737vsr.31.1673279003376;
        Mon, 09 Jan 2023 07:43:23 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b00704a9942708sm5520303qki.73.2023.01.09.07.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 07:43:22 -0800 (PST)
Message-ID: <5296e372cf8da5eeef37400d31f33b6611731228.camel@redhat.com>
Subject: Re: [PATCH 08/11] cifs: Remove call to filemap_check_wb_err()
From:   Jeff Layton <jlayton@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date:   Mon, 09 Jan 2023 10:43:22 -0500
In-Reply-To: <Y7wzAml5tAZXNMGV@casper.infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
         <20230109051823.480289-9-willy@infradead.org>
         <7d1499fadf42052711e39f0d8c7656f4d3a4bc9d.camel@redhat.com>
         <74c40f813d4dc2bf90fbf80a80a5f0ba15365a90.camel@redhat.com>
         <Y7wzAml5tAZXNMGV@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-01-09 at 15:30 +0000, Matthew Wilcox wrote:
> On Mon, Jan 09, 2023 at 10:14:12AM -0500, Jeff Layton wrote:
> > On Mon, 2023-01-09 at 09:42 -0500, Jeff Layton wrote:
> > > On Mon, 2023-01-09 at 05:18 +0000, Matthew Wilcox (Oracle) wrote:
> > > > filemap_write_and_wait() now calls filemap_check_wb_err(), so we ca=
nnot
> > > > glean any additional information by calling it ourselves.  It may a=
lso
> > > > be misleading as it will pick up on any errors since the beginning =
of
> > > > time which may well be since before this program opened the file.
> > > >=20
> > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > ---
> > > >  fs/cifs/file.c | 8 +++-----
> > > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> > > > index 22dfc1f8b4f1..7e7ee26cf77d 100644
> > > > --- a/fs/cifs/file.c
> > > > +++ b/fs/cifs/file.c
> > > > @@ -3042,14 +3042,12 @@ int cifs_flush(struct file *file, fl_owner_=
t id)
> > > >  	int rc =3D 0;
> > > > =20
> > > >  	if (file->f_mode & FMODE_WRITE)
> > > > -		rc =3D filemap_write_and_wait(inode->i_mapping);
> > > > +		rc =3D filemap_write_and_wait(file->f_mapping);
> > >=20
> > > If we're calling ->flush, then the file is being closed. Should this
> > > just be?
> > > 		rc =3D file_write_and_wait(file);
> > >=20
> > > It's not like we need to worry about corrupting ->f_wb_err at that
> > > point.
> > >=20
> >=20
> > OTOH, I suppose it is possible for there to be racing fsync syscall wit=
h
> > a filp_close, and in that case advancing the f_wb_err might be a bad
> > idea, particularly since a lot of places ignore the return from
> > filp_close. It's probably best to _not_ advance the f_wb_err on ->flush
> > calls.
>=20
> There's only so much we can do to protect an application from itself.
> If it's racing an fsync() against close(), it might get an EBADF from
> fsync(), or end up fsyncing entirely the wrong file due to a close();
> open(); associating the fd with a different file.
>=20

close() is not the worry, as it does return the error from ->flush. It's
the other callers of filp_close that concern me. A lot of those are
dealing with special "internal" struct files, but not all of them.

There's no benefit to advancing f_wb_err in ->flush, so I think we ought
to just avoid it. I think we don't even want to mark it SEEN in that
case either, so filemap_check_wb_err ought to be fine.

> > That said...wonder if we ought to consider making filp_close and ->flus=
h
> > void return functions. There's no POSIX requirement to flush all of the
> > data on close(), so an application really shouldn't rely on seeing
> > writeback errors returned there since it's not reliable.
> >=20
> > If you care about writeback errors, you have to call fsync -- full stop=
.
>=20
> Yes, most filesystems do not writeback dirty data on close().
> Applications can't depend on that behaviour.  Interestingly, if you read
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/close.html
> really carefully, it says:
>=20
>    If an I/O error occurred while reading from or writing to the file
>    system during close(), it may return -1 with errno set to [EIO];
>    if this error is returned, the state of fildes is unspecified.
>=20
> So if we return an error, userspace doesn't know if this fd is still
> open or not!  This feels like poor underspecification on POSIX's part
> (and probably stems from a historical unwillingness to declare any
> vendor's implementation as "not Unix").
>=20

It's a mess. On Linux we even=A0tear down the fd on EINTR and EAGAIN, so
retrying a close() on failure will always get you a EBADF. The only sane
thing for userland to do is to just ignore errors on close (aside from
maybe EBADF).
--=20
Jeff Layton <jlayton@redhat.com>

