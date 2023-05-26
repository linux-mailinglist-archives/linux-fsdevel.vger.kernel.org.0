Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F98712774
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 15:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjEZNZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 09:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbjEZNZY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 09:25:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7F912F;
        Fri, 26 May 2023 06:25:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f606a80d34so5685965e9.0;
        Fri, 26 May 2023 06:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685107521; x=1687699521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HShHppzRiA2afD7idA0kDlCaSnR/8d/LIwnMexDz04E=;
        b=R2isuQULlkXH0YYBi5gD32Fkr3TG8yDVfJ1SZVV7em4NfGBjX4bVPG+FKg55+DboUy
         xNw1y4PLZ0pqrv9V9WHS0FvRqBiarXByunSM8MzLauQE/bKpywSlCjLB9FSL4V0IukLp
         UQABcDgtNu9b1uRocJofhh/dRXZ+9UBOOLmZSySCchW2lCveBWzVvdxkYOkj/6bA2OEo
         Yy1ak5MiXh3QWYBLjiukrpaN0L0BzetweArXCOoOg47X1Eja1Jsrt2XjjW5c+lv+wNCU
         b4TLGokRtye3X/Fz1mKsDRFAKggAbXFrCDBYnrqtTOWOg3PZ/5DFdvpNsTt5XHOTSeVe
         qHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685107521; x=1687699521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HShHppzRiA2afD7idA0kDlCaSnR/8d/LIwnMexDz04E=;
        b=iIkR2QOxwFGBRXuVogB+APaIddbitey9W41ygGVR/JfDS5pytJvf7yWm9KZRWA+Sue
         rcLLoxY5Gjt4WuXj5xq4Kt9Kypr8/vP4+U0VVUaBeY6KL2f4WTyByYSG3gMoERvrgt+k
         8MyblJkriUtqzOsw9Nuv20UhWbUuSRaT1Oe1UcNBSY5KFj4TX+uGUskTNV+JYAPtK+hy
         p5JGqPmnck/KVm+bhT+azc8oXkVIMdbsctfcXyfQDd/SgU51zgjhKZS8XaQ1nCFXBzd/
         tvvrEoKXPhkhdV+J4N2vCs1MQ2hN4F2FSy5V8xveZhUF0txMLIfwztxAK4L3Lv00yE/j
         cdCg==
X-Gm-Message-State: AC+VfDyA17dHfEZXr7tORlGAytkYkRkVVrc1R9efQ7KYLYViCF9QK07u
        v/FoLMpCkgxuXI1m8G/S29hraqZXCD0=
X-Google-Smtp-Source: ACHHUZ5cUYpuKwSC5GNuQI4L1b0LxRQJaktaM3pMyNQhA9flteuuGt++y+NANX2R5ob81DqhZYQgAQ==
X-Received: by 2002:a5d:420c:0:b0:306:36ef:2e3b with SMTP id n12-20020a5d420c000000b0030636ef2e3bmr1329543wrq.70.1685107520644;
        Fri, 26 May 2023 06:25:20 -0700 (PDT)
Received: from suse.localnet (host-95-248-204-235.retail.telecomitalia.it. [95.248.204.235])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d522d000000b00307c8d6b4a0sm5128776wra.26.2023.05.26.06.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 06:25:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Date:   Fri, 26 May 2023 15:25:18 +0200
Message-ID: <2886258.e9J7NaK4W3@suse>
In-Reply-To: <5939173.lOV4Wx5bFT@suse>
References: <Y/gugbqq858QXJBY@ZenIV> <20230525201046.cth6qizdh7lwobxj@quack3>
 <5939173.lOV4Wx5bFT@suse>
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

On venerd=EC 26 maggio 2023 12:32:59 CEST Fabio M. De Francesco wrote:
> On gioved=EC 25 maggio 2023 22:10:46 CEST Jan Kara wrote:
> > On Mon 27-03-23 12:29:56, Fabio M. De Francesco wrote:
> > > On luned=EC 20 marzo 2023 13:47:25 CEST Jan Kara wrote:
> > > > On Mon 20-03-23 12:18:38, Fabio M. De Francesco wrote:
> > > > > On gioved=EC 16 marzo 2023 11:30:21 CET Fabio M. De Francesco wro=
te:
> > > > > > On gioved=EC 16 marzo 2023 10:00:35 CET Jan Kara wrote:
> > > > > > > On Wed 15-03-23 19:08:57, Fabio M. De Francesco wrote:
> > > > > > > > On mercoled=EC 1 marzo 2023 15:14:16 CET Al Viro wrote:
> > > [snip]
> > >=20
> > > > > > > > > I think I've pushed a demo patchset to vfs.git at some po=
int
> > > > > > > > > back
> > >=20
> > > in
> > >=20
> > > > > > > > > January... Yep - see #work.ext2 in there; completely=20
untested,
> > > > > > > > > though.
> > >=20
> > > Al,
> > >=20
> > > I reviewed and tested your patchset (please see below).
> > >=20
> > > I think that you probably also missed Jan's last message about how you
> > > prefer
> > > they to be treated.
> > >=20
> > > Jan asked you whether you will submit these patches or he should just=
=20
pull
> > > your branch into his tree.
> > >=20
> > > Please look below for my tags and Jan's question.
> >=20
> > Ok, Al didn't reply
>=20
> I noticed it...
>=20
> > so I've just pulled the patches from Al's tree,
>=20
> Thank you very much for doing this :-)
>=20
> > added
> > your Tested-by tag
>=20
> Did you also notice the Reviewed-by tags?
>=20

Well, it looks like you missed my Reviewed-by tags at https://lore.kernel.o=
rg/
lkml/3019063.4lk9UinFSI@suse/

=46WIW, I'd just like to say that I did the review of Al's patchset because=
 I=20
know the code that is modeled after a similar series to fs/sysv, which in t=
urn=20
I made following Al's suggestions.

However, I suppose it's up to you to decide whether or not is worth mention=
ing=20
my reviews :-)

Thanks,

=46abio

> > and push out the result into linux-next.
>=20
> Great!
> Again thanks,
>=20
> Fabio
>=20
>=20
> Honza
>=20
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR




