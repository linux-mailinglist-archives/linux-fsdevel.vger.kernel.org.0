Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A0949EA40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 19:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbiA0SSz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 13:18:55 -0500
Received: from mta-102b.oxsus-vadesecure.net ([51.81.61.67]:32901 "EHLO
        nmtao102.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231634AbiA0SSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:18:55 -0500
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jan 2022 13:18:55 EST
DKIM-Signature: v=1; a=rsa-sha256; bh=/BRShNVdKgc2NB7ksbRd1t/eXCno4EgKa5VoNh
 uFtuA=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1643307214;
 x=1643912014; b=RkHGGvdz9t3wGyKNksysx0BxXoUwp5zuO7IPmE9zUxifX+DpkhC9v1o
 SjtXqU7MOPbHup8nQZNw3D0SqJwknKvsjO9hQGCulZMCcdBr0v7Lc8w3xaKXfu0R5ONBZzQ
 iatbsk1x+mfUl+ihiaWt0h2zytmYLvSEoq/4oc4DhSJLgo9wbxCbr5xxTC5xZz3aGA3qt9C
 1yPNl1vZ0BSqpqOYHr21zKbIA6HKWQAVSdQyOEaIZ+EDg/1JgtI640TjhFaGDP7hNt5A899
 cNg2SxhjmhAjO6UqPE250X9g1M6O5qItLB/oXH3yMK952+XuIFrD308IlMYmZRgBYSSCrLK
 nSg==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus1nmtao02p with ngmta
 id a9125241-16ce33345da6aead; Thu, 27 Jan 2022 18:13:34 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Chuck Lever'" <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
In-Reply-To:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
Subject: RE: [PATCH RFC 0/6] NFSD size, offset, and count sanity
Date:   Thu, 27 Jan 2022 10:13:34 -0800
Message-ID: <0c1b01d813a9$999f62f0$ccde28d0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQKO8nboN3E3HrnOnFzqwoPhEsOg2asJbVlw
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ooh, lots to consider for Ganesha...

And I see you are proposing a new pynfs test case, which I will have to =
remember the thought behind it and make sure that's covered for NFS v3 =
when I get back to the pynfs 3 tests.

Frank

> -----Original Message-----
> From: Chuck Lever [mailto:chuck.lever@oracle.com]
> Sent: Thursday, January 27, 2022 8:08 AM
> To: linux-nfs@vger.kernel.org; linux-fsdevel@vger.kernel.org
> Subject: [PATCH RFC 0/6] NFSD size, offset, and count sanity
>=20
> Dan Aloni reported a problem with the way NFSD's READ implementation =
deals
> with the very upper end of file sizes, and I got interested in how =
some of the
> other operations handled it. I found some issues, and have started a =
(growing)
> pile of patches to deal with them.
>=20
> Since at least the SETATTR case appears to cause a crash on some =
filesystems, I
> think several of these are 5.17-rc fodder (i.e., priority bug fixes). =
I see that NLM
> also has potential problems with how the max file size is handled, but =
since
> locking doesn't involve the page cache, I think fixes in that area can =
be delayed a
> bit.
>=20
> Dan's still working on the READ issue. I need some input on whether I
> understand the problem correctly and whether the NFS status codes I've =
chosen
> to use are going to be reasonable or a problem for NFS clients. I've =
attempted to
> stay within the bound of the NFS specs, but sometimes the spec doesn't =
provide
> a mechanism in the protocol to indicate that the client passed us a =
bogus
> size/offset/count.
>=20
> ---
>=20
> Chuck Lever (6):
>       NFSD: Fix NFSv4 SETATTR's handling of large file sizes
>       NFSD: Fix NFSv3 SETATTR's handling of large file sizes
>       NFSD: COMMIT operations must not return NFS?ERR_INVAL
>       NFSD: Replace directory offset placeholder
>       NFSD: Remove NFS_OFFSET_MAX
>       NFSD: Clamp WRITE offsets
>=20
>=20
>  fs/nfsd/nfs3proc.c  | 32 +++++++++++++++++++++------
>  fs/nfsd/nfs3xdr.c   |  4 ++--
>  fs/nfsd/nfs4proc.c  |  7 +++++-
>  fs/nfsd/nfs4xdr.c   |  2 +-
>  fs/nfsd/vfs.c       | 53 =
++++++++++++++++++++++++++++++---------------
>  fs/nfsd/vfs.h       |  4 ++--
>  include/linux/nfs.h |  8 -------
>  7 files changed, 72 insertions(+), 38 deletions(-)
>=20
> --
> Chuck Lever

