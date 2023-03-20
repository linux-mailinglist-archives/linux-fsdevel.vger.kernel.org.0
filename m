Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61AB6C2447
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 23:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCTWK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 18:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCTWKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:10:54 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08C25E03;
        Mon, 20 Mar 2023 15:10:46 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PgTSx6k6Sz9sxR;
        Mon, 20 Mar 2023 23:10:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1679350241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GzNNaWZ1C50P/spthhGScyRaiwHsZl9yMNP95Nfl4Xk=;
        b=TSydWil3tzUKXfRPn17760l1aRZjOZL6YUg2uVUM+gfDm5PzO9PyDDiPkgjcktNN9tr35m
        vNtFKiQIOYo0FLaYOKxnnkibXjzaDQ4j1iqK9S1Pt1JykmhhXx5nnN2725JwoGfcB4DqEb
        +U7SH1QNLDZ9CIqvbheKFQnJb+YrLqbG0wMYlcD3k3mWNei85QyrQx5fMFujBDkMlpv6VN
        8cRobvl6tzVxpOOSsASUh9UojPRMQP7BdCeWjpMbIrCbJjfDLQYOGKmzf+6345ILvsGIuI
        lnXF+lUSTK1KksWKyy8WGYF5Rn8gpO0T/NH8JVv2NcsW+ihjy5WZJbSyjfbAEw==
Date:   Tue, 21 Mar 2023 09:10:28 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
Message-ID: <20230320221028.srckvaqtsbmnwczh@senku>
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein>
 <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
 <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zagdemnwfnh74ik5"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
X-Rspamd-Queue-Id: 4PgTSx6k6Sz9sxR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--zagdemnwfnh74ik5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-03-20, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> What about O_PATH? I guess it's fine to create a file and only get a
> path fd to the result?

O_PATH ignores the O_CREAT flag so it's the same as just passing O_PATH.
This is the case for all flags not in O_PATH_FLAGS (so only O_DIRECTORY,
O_NOFOLLOW, O_CLOEXEC have an effect on O_PATH). With openat2, passing
any other flag with O_PATH returns -EINVAL.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--zagdemnwfnh74ik5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZBjZ0AAKCRAol/rSt+lE
b3wSAP4sPo9spWjM1uUierit/HugmmAfiYDK9yKmdqVgz9TvggEAwMEdcmq429Dd
1aqSa1Lk6yqp6R9txbEsb/9Z6Ljqowo=
=oS6R
-----END PGP SIGNATURE-----

--zagdemnwfnh74ik5--
