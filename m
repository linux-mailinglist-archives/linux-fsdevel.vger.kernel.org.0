Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03DA1E71DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 03:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438205AbgE2BCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 21:02:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:45104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438203AbgE2BCH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 21:02:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7C7F6AE65;
        Fri, 29 May 2020 01:02:05 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Fri, 29 May 2020 11:01:59 +1000
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: The file_lock_operatoins.lock API seems to be a BAD API.
In-Reply-To: <20200528220112.GD20602@fieldses.org>
References: <87a71s8u23.fsf@notabene.neil.brown.name> <20200528220112.GD20602@fieldses.org>
Message-ID: <87y2pb7dvc.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, May 28 2020, J. Bruce Fields wrote:

> On Thu, May 28, 2020 at 04:14:44PM +1000, NeilBrown wrote:
>> I don't think we should just fix all those bugs in those filesystems.
>> I think that F_UNLCK should *always* remove the lock/lease.
>> I imaging this happening by  *always* calling posix_lock_file() (or
>> similar) in the unlock case - after calling f_op->lock() first if that
>> is appropriate.
>>=20
>> What do people think?  It there on obvious reason that is a non-starter?
>
> Isn't NFS unlock like close, in that it may be our only chance to return
> IO errors?

Is it?  fcntl() isn't documented as returning ENOSPC, EDQUOT or EIO.

>
> But I guess you're not saying that unlock can't return errors, just that
> it should always remove the lock whether it returns 0 or not.

No I wasn't, but I might.
One approach that I was considering for making the API more robust was
to propose a separate "unlock" file_operation.  All unlock requests
would go through this, and it would have a 'void' return type.
Would that be sufficient to encourage programmers to handle their own
errors and not think they can punt?

But yes - even if unlock returns an error, it should (locally) remove
any locks - much as 'close()' will always close the fd (if it was
actually open) even if it reports an error.

Thanks,
NeilBrown

>
> Hm.
>
> --b.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl7QXwgACgkQOeye3VZi
gbkNrA//XNPo/2bBaBqvUeK80lQS+apCOkTpR3Fpeu6TuYVYBexdM0YC+WqYPJtr
5LoI6/2Xdyvdfdvfyp88hrcUuwTsqC5PTt8laU47p0sAMlh52390e3kHYL7uY0qo
U/I5f6VO8s/Y7NjvL6Op1ZbQF7+Fw4W43f9s6PjUNdw84B5BhJ42/eZ6HO6brEKG
nEsOAyuKe6Wv7NncgXbdzFxsgc9vJa4APuSbBMRy0tT8FRkQUMUuYjGXwh/xdif8
Ox9jTdG1p2Boz8xvz++vICtwQjFvJ40qhl8T8Nm6+8teUcs/xqXBd3cbFgXZ2nAe
2Mw5Cl67AG4iyUf7y+PXNvnMiLUMGYLtMeJiK+h3eBG2wquTFIDk/io9Ens+z7Bd
tMc2Ws1FFVH5jFSrhbrs8Dk7ufRrOsZnasTz1AYcF2fp0yrQ3hd2tauT2CYF4B5I
V0QpaYIf5VGsql61ReoqwqNVZ6m8HnXZfBB7Ffg15IVqtebrELQ5DxDkpKg5OW/g
01if7qG8XkfHX4vomSDdhtPZYJR8Bf3fF76dzZE2goA3yX5yXWuiGCbc4+to2nu3
xTU4c7owc2/tNx2hWfO7f+ROz0zCPekdYp8CGLwUdxL34fHAlZ3OJDZuydAefHkA
BgDok4yIO2ZvzKku3VPaKIS4Y1vX3g5UuBU3enNKiPxclkWPEN4=
=oWcw
-----END PGP SIGNATURE-----
--=-=-=--
