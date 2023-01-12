Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29A76684D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 22:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbjALVAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 16:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240344AbjALU6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:58:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119243DBD1;
        Thu, 12 Jan 2023 12:42:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bk16so19261209wrb.11;
        Thu, 12 Jan 2023 12:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrIck5ao7PDl0gXYa+erLdjTlEjrxSHeKI8TQvNSwaY=;
        b=K1cKi1/OT7K52Tvz3gUWxUGoJKpYo7JWtFlUXztCQaSUVjIL4OBpv7O/fLZ6Fq30tR
         1nCUiiGI8Oj6CSCoCFzW9mgmU6gHNw++4qK0li5pk98wAfSQnq1yok0upPcpaWFbHB1q
         mSRpVV5mL0W4VdKB1h322qazpJA9KWwppLt9La7uxELblE+MTUUtzZDtsA0o7w5KGm0j
         OUQtV3bTK2NhKM5WEX8Ep88bsxaPvxrzTFC4Lt++X5a6c9ZpRjupGLwCjJDmHb4yX/6p
         RxNtdlm5O6wyNzwYhoC2XDyZ7dfY1UNAxScpf4/W5F6uinoH1qyAth9jWJsHZ/TEaXVo
         gnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrIck5ao7PDl0gXYa+erLdjTlEjrxSHeKI8TQvNSwaY=;
        b=asOXDC2daNzM1X6U3MBkXt+ZqcdXePMv/gQPuiDKYCTKELVWkN1Jh36gSVfk4Ldrlr
         akApprXuSk/jWOwr4Ivst0EtWAx/DrVuJ3O2BYvlfkwJFQhdKn7chSKCp6NTxUemGGsP
         xkbNOcsN5w3McJtbHubI+9NNGHDlEpF4Eixq6GFJ/hwtm6qmMgRg+PlSsNASQfMPDzuk
         l767tgMXtoISFYx0a3yH3BpR5hQFURTmS6y4/kSM8hfuGcVOFVbH52loxdSLXW+0oPsR
         s+iXxsJke/vYva/QsvH8kdNOJ5MqWe6DUJxzoGxLOD5wS5lgdsJ3KXDKtIhHlMwDYE9l
         gb7g==
X-Gm-Message-State: AFqh2krbtqR+WQjqG8uC/oZNffwHg+QGtdakbDH0AU3JRXVFMFx2VGGI
        SNjOgyFRWSa0E2hjc9uyJSQlRT6kR4k=
X-Google-Smtp-Source: AMrXdXs4Aq39IuzlqVj7kU6FC5te3VmhqT7aDHEhnzQSzqRz7kV+CrZdKpTmyUBgelRMPtM41IB/tg==
X-Received: by 2002:a05:6000:11d2:b0:2bd:d542:e010 with SMTP id i18-20020a05600011d200b002bdd542e010mr2154894wrx.46.1673556155457;
        Thu, 12 Jan 2023 12:42:35 -0800 (PST)
Received: from suse.localnet (host-79-42-161-127.retail.telecomitalia.it. [79.42.161.127])
        by smtp.gmail.com with ESMTPSA id q11-20020adf9dcb000000b00268aae5fb5bsm17593359wre.3.2023.01.12.12.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:42:34 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jeff Moyer <jmoyer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] fs/aio: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Thu, 12 Jan 2023 21:42:33 +0100
Message-ID: <3477941.iIbC2pHGDl@suse>
In-Reply-To: <Y77dkghufF6GVq1Y@ZenIV>
References: <20230109175629.9482-1-fmdefrancesco@gmail.com>
 <x498ri9ma5n.fsf@segfault.boston.devel.redhat.com> <Y77dkghufF6GVq1Y@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On mercoled=EC 11 gennaio 2023 17:02:26 CET Al Viro wrote:
> On Wed, Jan 11, 2023 at 09:13:40AM -0500, Jeff Moyer wrote:
> > Hi, Al,
> >=20
> > Al Viro <viro@zeniv.linux.org.uk> writes:
> > > On Mon, Jan 09, 2023 at 06:56:29PM +0100, Fabio M. De Francesco wrote:
> > >> -	ring =3D kmap_atomic(ctx->ring_pages[0]);
> > >> +	ring =3D kmap_local_page(ctx->ring_pages[0]);
> > >>=20
> > >>  	ring->nr =3D nr_events;	/* user copy */
> > >>  	ring->id =3D ~0U;
> > >>  	ring->head =3D ring->tail =3D 0;
> > >>=20
> > >> @@ -575,7 +575,7 @@ static int aio_setup_ring(struct kioctx *ctx,
> > >> unsigned int nr_events)> >>=20
> > >>  	ring->compat_features =3D AIO_RING_COMPAT_FEATURES;
> > >>  	ring->incompat_features =3D AIO_RING_INCOMPAT_FEATURES;
> > >>  	ring->header_length =3D sizeof(struct aio_ring);
> > >>=20
> > >> -	kunmap_atomic(ring);
> > >> +	kunmap_local(ring);
> > >>=20
> > >>  	flush_dcache_page(ctx->ring_pages[0]);
> > >=20
> > > I wonder if it would be more readable as memcpy_to_page(), actually...
> >=20
> > I'm not sure I understand what you're suggesting.
>=20
> 	memcpy_to_page(ctx->ring_pages[0], 0, &(struct aio_ring){
> 			.nr =3D nr_events, .id =3D ~0U, .magic =3D=20
AIO_RING_MAGIC,
> 			.compat_features =3D AIO_RING_COMPAT_FEATURES,
> 			.in_compat_features =3D=20
AIO_RING_INCOMPAT_FEATURES,
> 			.header_length =3D sizeof(struct aio_ring)},
> 			sizeof(struct aio_ring));
>=20
> instead of the lines from kmap_atomic to flush_dcache_page...

Actually, I'd prefer Ira's solution for readability, but I have nothing=20
against yours. I will send you the code in the way you rewrote it.

> > >>  	return 0;
> > >>=20
> > >> @@ -678,9 +678,9 @@ static int ioctx_add_table(struct kioctx *ctx,=20
struct
> > >> mm_struct *mm)> >>=20
> > >>  					 * we are protected from=20
page migration
> > >>  					 * changes ring_pages by -
>ring_lock.
> > >>  					 */
> > >>=20
> > >> -					ring =3D kmap_atomic(ctx-
>ring_pages[0]);
> > >> +					ring =3D kmap_local_page(ctx-
>ring_pages[0]);
> > >>=20
> > >>  					ring->id =3D ctx->id;
> > >>=20
> > >> -					kunmap_atomic(ring);
> > >> +					kunmap_local(ring);
> > >=20
> > > Incidentally, does it need flush_dcache_page()?
> >=20
> > Yes, good catch.

Yes, I missed it :-(

However, with the use of memcpy_to_page() we no longer need that explicit c=
all=20
to flush_dcache_page().

Thank you,

=46abio


