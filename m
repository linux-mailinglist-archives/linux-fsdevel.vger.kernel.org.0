Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D68742910
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 17:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjF2PEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 11:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjF2PEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:04:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888032D7F;
        Thu, 29 Jun 2023 08:04:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc1fd6335so2179065e9.2;
        Thu, 29 Jun 2023 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688051069; x=1690643069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9T0VXws43hJjl+uJSROMwIKD7cE/AP2uivo3vISpPNI=;
        b=LcHVTWUlAJfeAteEoMNOZzMOCFJyhJGPkS6wUVdtw59FTCTto96bVF1KpqeqGelZQo
         0Iu0sdABeApD2lTFiZOA/uMOhhDn7AhL0BYSEbTBiJDN9ud03Ji8HTPtkfuM4UJVX2rU
         6xYmdghWM9EMRVdT8X5SJbCh6jrVlOkZ77aUETj0w+9tKc/9QTpdRFPUIqe/w+L0h1MK
         udFgXUtzZbWSbwc/j9UPcDozj/o7D0coV9AChyQTnGHx7Kn8PQ/PnyDfq8j/vQW9UOVy
         aZmROjYUEAH0AhRj1ENQTsguVQ0cOtOoaI4Fh0nuNZWsgnifjjpDutBh+vD70Lwnogq0
         1tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688051069; x=1690643069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9T0VXws43hJjl+uJSROMwIKD7cE/AP2uivo3vISpPNI=;
        b=QmvC1BuJH+DlJXqKYqSTSbxYm351+ws2rNpKqITYcsws0NOB8iyPxbt6th9t+s0hEW
         3cFylYysn7QT7Ck6f5LxMVRnfkkuAkl1CRG5fimJN+QyzJcdyoPohcPQFwAn55UGnume
         CuA3/Q/BKMXVZEuUJex6j0vWRNOqvjsEXI37G0IwzvM2TTOcIlR0fehykieBjGRZR7+M
         4BVBQf7teBH0nRb6th5/UUXJVjxkvCBcpH8Sjr6LRWbkyixRFIn3+jhtmu4tuGbsQDWi
         NZcw1AFmjO16gEh3mw8mUOGaWzr3aD3S/sD0nL1Y68mhfFC95iWQpons+zoKSx7bVruP
         NQBg==
X-Gm-Message-State: AC+VfDwG7/viP94avk4na8tAYsHmbGXXoXVSvRSTLa7bGw2eUUFuBGcQ
        ArivQqjS3+rk8GGCiRAhMSY=
X-Google-Smtp-Source: ACHHUZ4L1wP3qADBReKuZzejLsjm26j/3Ya7SyLGZc723LpSeVmdj8uvc7ZYJ78C4oJoKFHPOkHvig==
X-Received: by 2002:a05:600c:3657:b0:3f9:b804:1785 with SMTP id y23-20020a05600c365700b003f9b8041785mr22616536wmq.0.1688051068690;
        Thu, 29 Jun 2023 08:04:28 -0700 (PDT)
Received: from suse.localnet (host-87-3-108-126.retail.telecomitalia.it. [87.3.108.126])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c22d500b003f96d10eafbsm16731958wmg.12.2023.06.29.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:04:28 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>, Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Date:   Thu, 29 Jun 2023 17:04:26 +0200
Message-ID: <1810516.8hzESeGDPO@suse>
In-Reply-To: <ZJz3dO10o9+xV65F@casper.infradead.org>
References: <20230627135115.GA452832@sumitra.com> <6924669.18pcnM708K@suse>
 <ZJz3dO10o9+xV65F@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On gioved=EC 29 giugno 2023 05:16:04 CEST Matthew Wilcox wrote:
> On Thu, Jun 29, 2023 at 12:23:54AM +0200, Fabio M. De Francesco wrote:
> > > -	buf =3D kmap(page);
> > > +	do {
> >=20
> > Please let me understand why you are calling vboxsf_read() in a loop, a
> > PAGE_SIZE at a time.
>=20
> Because kmap_local_folio() can only (guarantee to) map one page at a
> time.

Yes, one page at a time. This part served to introduce the _main_ question=
=20
that is the one you answered below (i.e., since the current code maps a pag=
e a=20
a time with no loops, do we need to manage folios spanning more than a sing=
le=20
page?)

> Also vboxsf_read() is only tested with a single page at a time.
>=20
> > If I understand the current code it reads a single page at offset zero =
of=20
a
> > folio and then memset() with zeros from &buf[nread] up to the end of the
> > page. Then it seems that this function currently assume that the folio
> > doesn't need to be read until "offset < folio_size(folio)" becomes fals=
e.
> >=20
> > Does it imply that the folio is always one page sized? Doesn't it? I'm
> > surely
> > missing some basics...
>=20
> vboxsf does not yet claim to support large folios, so every folio that
> it sees will be only a single page in size.
> Hopefully at some point
> that will change.  Again, somebody would need to test that.  In the
> meantime, if someone is going to the trouble of switching over to using
> the folio API, let's actually include support for large folios.

"[...] at some point that will change." wrt larger folios spanning multiple=
=20
pages is the answer that justifies the loop. I couldn't know about this pla=
n.=20
Thanks for explaining that there is a plan towards that goal.

I think that Sumitra can address the task to re-use your patch to=20
vboxsf_read_folio() and then properly test it with VirtualBox.

Instead the much larger effort to implement vboxsf_readahead() and actually=
 do=20
an async call with deferred setting of the uptodate flag will surely requir=
e a=20
considerable amount of time and whoever wanted to address it would need you=
r=20
guidance.

You said that you are ready to provide consult, but I'm not sure whether=20
Sumitra would be allowed to spend a large part of her time to do an out of=
=20
scope task (wrt her internship).

If yes, I have nothing against. If not, I'm pretty sure that someone else c=
an=20
set aside enough time to address this large task ;-)

>=20
> > > -	kunmap(page);
> > > -	unlock_page(page);
> > > +	if (!err) {
> > > +		flush_dcache_folio(folio);
> > > +		folio_mark_uptodate(folio);
> > > +	}
> > > +	folio_unlock(folio);
> >=20
> > Shouldn't we call folio_lock() to lock the folio to be able to unlock w=
ith
> > folio_unlock()?
> >=20
> > If so, I can't find any neither a folio_lock() or a page_lock() in this
> > filesystem.
> >=20
> > Again sorry for not understanding, can you please explain it?
>=20
> Ira gave the minimal explanation, but a slightly fuller explanation is
> that the folio is locked while it is being fetched from backing store.

This explains why I could not easily find the call to lock it.=20

> That prevents both a second thread from reading from it while another
> thread is bringing it uptodate, and two threads trying to bring it
> uptodate at the same time.
>=20
> Most filesystems have an asynchronous read_folio, so you don't see the
> folio_unlock() in the read_folio() function; instead it's in the I/O
> completion path.  vboxsf is synchronous.

And this explains different implementation between synchronous and=20
asynchronous reads=20

Again thanks,

=46abio


