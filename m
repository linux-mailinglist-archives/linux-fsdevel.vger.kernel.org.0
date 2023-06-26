Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DE673D616
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 05:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjFZDFN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jun 2023 23:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFZDFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:05:11 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0C37E58;
        Sun, 25 Jun 2023 20:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687748699;
        bh=0edVz5yigfQngdKgWO2r/1KXyXrbS0vsfLBCYGnjUOw=;
        h=Date:From:To:Subject:From;
        b=C3nJ8JBAe/bv3WPFX8kM/ZV6WDOz1qbfugBogTvfUUkP3Kn4rvtz0die0lhoLoaId
         5EFV6ULOBdwC0jI3f2Hg3C6V47JTlujPaqXqyTv5g+7Sq0bOFQl+rnaOSWw0bexuGd
         iFUPTqj4olJ+EbyeseyUhDNm6OLXeUMkK8FASAyM/ZLZ0g3+JhQoyoVKjhAAOPEc47
         AEU2pkaf6iOsDcxhjUZ1R6S5mCjQn6cyUb4Zy7Y3NXGfDCOg9qVXhDXCf0/xY60WI1
         TLLX2TpnlZWrd03k0ztuC2P+xMT/1nTWKlM+/3kQgihl71l6Wzs1dndvtp92EkMm8u
         /eoqLhpaawdcw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9C072C7A;
        Mon, 26 Jun 2023 05:04:59 +0200 (CEST)
Date:   Mon, 26 Jun 2023 05:04:58 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: splice(-> FIFO) never wakes up inotify IN_MODIFY?
Message-ID: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ld2mt2xgxgm2cqup"
Content-Disposition: inline
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ld2mt2xgxgm2cqup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Consider the following programs:
-- >8 --
==> ino.c <==
#define _GNU_SOURCE
#include <stdio.h>
#include <sys/inotify.h>
#include <unistd.h>
int main() {
  int ino = inotify_init1(IN_CLOEXEC);
  inotify_add_watch(ino, "/dev/fd/0", IN_MODIFY);

  char buf[64 * 1024];
  struct inotify_event ev;
  while (read(ino, &ev, sizeof(ev)) > 0) {
    fprintf(stderr, "%d: mask=%x, cook=%x, len=%x, name=%.*s\n", ev.wd, ev.mask,
            ev.cookie, ev.len, (int)ev.len, ev.name);
    fprintf(stderr, "rd=%zd\n", read(0, buf, sizeof(buf)));
  }
}

==> se.c <==
#define _GNU_SOURCE
#include <stdio.h>
#include <sys/sendfile.h>
int main() {
  ssize_t rd, acc = 0;
  while ((rd = sendfile(1, 0, 0, 128 * 1024 * 1024)) > 0)
    acc += rd;
  fprintf(stderr, "se=%zd: %m\n", acc);
}

==> sp.c <==
#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
int main() {
  ssize_t rd, acc = 0;
  while ((rd = splice(0, 0, 1, 0, 128 * 1024 * 1024, 0)) > 0)
    acc += rd;
  fprintf(stderr, "sp=%zd: %m\n", acc);
}
-- >8 --

By all means, ./sp | ./ino and ./se | ./ino should be equivalent,
right?

-- >8 --
$ make se sp ino
$ mkfifo fifo
$ ./ino < fifo &
[1] 230
$ echo a > fifo
$ echo a > fifo
1: mask=2, cook=0, len=0, name=
rd=4
$ echo c > fifo
1: mask=2, cook=0, len=0, name=
rd=2
$ ./se > fifo
abcdef
1: mask=2, cook=0, len=0, name=
asd
^D
se=11: Success
rd=11
1: mask=2, cook=0, len=0, name=
rd=0
$ ./sp > fifo
abcdefg
asd
dsasdadadad
sp=24: Success
$ < sp ./sp > fifo
sp=25856: Success
$ < sp ./sp > fifo
^C
$ echo sp > fifo
^C
-- >8 --

Note how in all ./sp > fifo cases, ./ino doesn't wake up!
Note also how, thus, we've managed to fill the pipe buffer with ./sp
(when it transferred 25856), and now we can't /ever/ write there again
(both splicing and normal writes block, since there's no space left in
 the pipe; ./ino hasn't seen this and will never wake up or service the
 pipe):
so we've effectively "denied service" by slickily using a different
syscall to do the write, right?

I consider this to be unexpected behaviour because (a) obviously and
(b) sendfile() sends the inotify event.

Happens on my linus checkout (v6.4-rc7-234-g547cc9be86f4) and bookworm (6.1.27-1).

--ld2mt2xgxgm2cqup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSZAFgACgkQvP0LAY0m
WPEj+xAArngJ5sIFn5AM1VnqV2Q9bCbBOdPAeibWSiD8aa9K5uGlaMRnAalHnHxf
rckHg8YpQ1gktG5tEME4hBmuPbpFPkbgK9dWgYBQQkuUzsltAav8P5uIof2EIe3y
Cq0CCEK0Jfw8/8N+X9Fgdw/ZcVgbbWMF6TvOHUPL+tvmdAXf083kJvORt5bV7AgU
o3BIns27GREBHxJA9sIdxhcHrx4MyldEI4q6Q/Yf2SuITnpBk6S9sjLONF9qVs63
fuoyr6DAle8/svSA2t1srMwJxYJsZChGBYi6Rec7UJupCGYQLJ3SM1rvmf5M5Kd/
nBnqw1fiXwTysgnJlpIyLZMjSf4m8akwRTQTW9AzOBfctijbkYzdqZUr9/rYfPTo
vM7tqV7Az85Ko0q3NL8fmXPYfJcuAeiiFnJlPrLdDxE/lnPmd/LEryucH+DRqVgb
P98Y3VWOJ/skGmX8BYaGV6hDgQafGaWjwPDCmd0Gq/WHBRnBbfG4P5KQvqlWnbMl
5SyjS8KSchRU3maBMFnpEcCpSvTqcWRHIpQunfBEdJBVQM5YNTSKy0WwEA6q9Qfb
mzlsxe8lEnjHz/i8gAclINpljWlUdhFOW1IR6bPGw1XTGpScFZrBogWLkbfh4qY5
mShDweKYE7u7kUU2XF7MeX2U0mWj/h4RrO2HdTKGYV+jsF8cUt0=
=lt2X
-----END PGP SIGNATURE-----

--ld2mt2xgxgm2cqup--
