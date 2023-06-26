Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5799973E4C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjFZQRZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 12:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjFZQPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:15:10 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3224F213F;
        Mon, 26 Jun 2023 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687796092;
        bh=OIkRjszc/siuWMUIDxNvapcEayn+337GY3Qpd3+7L18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSEZKzZ8W8BY/c9VA/huUwf8P7oA3dABtsIZj55w5CEHOFkCz3lKsraJroah2g+MG
         tRkOlfvl2w8EXFulPteFcgOBf3QpomaWsRCZRt3HN7wAp8U47DDuCRc7CxzyyOrEvV
         l13/rUfx/wntBV8H/JxIw973v9szGtL9Dc5QcJdHLV+Lg1B74amvIg+j8i4CLknXMm
         DcHM7oFriUtJsxowVnzsKD3lVPXcYqq/03WYK7VEijJxWxjciXNqiMfgJ9R29ZCmq3
         7D4kEuABekLK8BZaSknKtiuNrCe2dIzxQkVfZUz9dYCGoY9rl9VDFl743YGuU5qPJ3
         Bc8YACOpQiRxA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DB9E9F70;
        Mon, 26 Jun 2023 18:14:52 +0200 (CEST)
Date:   Mon, 26 Jun 2023 18:14:51 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Pending splice(file -> FIFO) excludes all other FIFO operations
 forever (was: ... always blocks read(FIFO), regardless of O_NONBLOCK on read
 side?)
Message-ID: <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
 <20230626-vorverlegen-setzen-c7f96e10df34@brauner>
 <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
 <20230626-fazit-campen-d54e428aa4d6@brauner>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fwzvmdzb5y4r76ms"
Content-Disposition: inline
In-Reply-To: <20230626-fazit-campen-d54e428aa4d6@brauner>
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


--fwzvmdzb5y4r76ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 26, 2023 at 05:56:28PM +0200, Christian Brauner wrote:
> I mean, one workaround would probably be poll() even with O_NONBLOCK but
> I get why that's annoying and half of a solution.
poll() doesn't really change anything since it turns into a hotloop of
.revents=POLLHUP with a disconnected writer, cf.
  https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux/t/#m747e2bbd0c5cffb6baaf1955f6f8b0d97e216839
The only apparently-supported way to poll pipes under linux is to
sleep()/read(O_NONBLOCK) like in the bad old days.

And even if that was a working work-around, the fundamental problem of
./spl>fifo excluding all other access to fifo is quite unfortunate too.

> tl;dr it by splicing from a regular file to a pipe where the regular
> file in splice isn't O_NONBLOCK
(Most noticeable when the "regular file" is a tty and thus the I/O never
 completes by design.)

--fwzvmdzb5y4r76ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSZuXkACgkQvP0LAY0m
WPHx+Q//YSo///lAnPD1XvyEMH7UaLl3NN+xmawY2/rMIBL9nmQULjIx3x6/aWOg
CGR9WmnsbmcQdPZsObbHjau0RE6+2tjgwFzTFDVu3dnl8X2jyXss2Qp316En25Jx
XZ35/7PIH8LqP8PVmIZz2wnwG6sSwS8aNugx4De5ROC21+aBlJayQCvpKluuBRQv
GxvZrUgGevY46JeOX1UkiiojDFyLbtznL8HxoV5bYz/E3/imEsQSEAKGKU+AhgPa
y83Dsyha0k0b7yYdn0m5NnBUcZZgQx3QFuXpxYkxCT+YYp4wfFUoyIF/LQvgxycY
0o/YqMVjyQ2I+xMhE0AjMBfB+q2kHspEDKExqQuKz0a71bFrSR3AuYdnKWsiEK45
lvaApluTZvP8g/l7n6Qzgpobyhrt5yOW9F4dOky94V38C28cLGUYA7iXCmQPtYP6
Ikvfj1l7AgPXO4ZOToKhrHd/HTSo0DX1jZ9nQJ7nzFoxuKWKJAfUcXbwQThRLG+W
fHQKevvXaPwa5bnuUmCA4eqDabI5yBOUqOKLJE/amjxkIscO34FUgkacq127+ZuP
EMo4CqR+AwLNrNE3MwycDTx+yrGcZpXCgNhIZZQepV3IkNd2aI2Us9LA4mf44eMj
bQL1VNn1szC1BTJ0Iybhl9eoIDkOt7Wks+k4N9UqeUEoLWv/4C8=
=CLWF
-----END PGP SIGNATURE-----

--fwzvmdzb5y4r76ms--
