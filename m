Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE0CF1498B0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2020 05:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgAZEKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jan 2020 23:10:23 -0500
Received: from mout-p-102.mailbox.org ([80.241.56.152]:45856 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgAZEKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jan 2020 23:10:23 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 484ztj4mYPzKmmG;
        Sun, 26 Jan 2020 05:10:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id cyVBuGgdlFHA; Sun, 26 Jan 2020 05:10:18 +0100 (CET)
Date:   Sun, 26 Jan 2020 15:10:09 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 3/4] seccomp: Add SECCOMP_USER_NOTIF_FLAG_PIDFD to get
 pidfd on listener trap
Message-ID: <20200126041009.wubw4t5iaypf6bkk@yavin.dot.cyphar.com>
References: <20200124091743.3357-1-sargun@sargun.me>
 <20200124091743.3357-4-sargun@sargun.me>
 <20200124180332.GA4151@cisco>
 <CAMp4zn_WXwxJ6Md4rgFzdAY_xea4TmVDdQc1iJDObEMm5Yc79g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b547hxjkssbqtln5"
Content-Disposition: inline
In-Reply-To: <CAMp4zn_WXwxJ6Md4rgFzdAY_xea4TmVDdQc1iJDObEMm5Yc79g@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--b547hxjkssbqtln5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-24, Sargun Dhillon <sargun@sargun.me> wrote:
> On Fri, Jan 24, 2020 at 10:03 AM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > On Fri, Jan 24, 2020 at 01:17:42AM -0800, Sargun Dhillon wrote:
> > > Currently, this just opens the group leader of the thread that trigge=
re
> > > the event, as pidfds (currently) are limited to group leaders.
> >
> > I don't love the semantics of this; when they're not limited to thread
> > group leaders any more, we won't be able to change this. Is that work
> > far off?
> >
> > Tycho
>=20
> We would be able to change this in the future if we introduced a flag like
> SECCOMP_USER_NOTIF_FLAG_PIDFD_THREAD which would send a
> pidfd that's for the thread, and not just the group leader. The flag could
> either be XOR with SECCOMP_USER_NOTIF_FLAG_PIDFD, or
> could require both. Alternatively, we can rename
> SECCOMP_USER_NOTIF_FLAG_PIDFD to
> SECCOMP_USER_NOTIF_FLAG_GROUP_LEADER_PIDFD.

Possibly unpopular proposal -- would it make sense to just store the
pidfd_open(2) flags rather than coming up with our own set for
SECCOMP_USER_NOTIF? If/when pidfds are expanded to include non-leaders
there will be a corresponding flag for pidfd_open(2). Something like:

	struct seccomp_notif {
		__u64 id;
		__u32 pid;
		__u32 flags;
		struct seccomp_data data;
		__u64 pidfd_flags; // or __u32 -- not sure what Christian plans
		__u32 pidfd;
		__u32 __padding;
	};

This does mean there'll be an additional flags field, but I think it's a
slightly more consistent way to indicate "SECCOMP_USER_NOTIF_FLAG_PIDFD
implies a pidfd_open(2) on the traced task".

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--b547hxjkssbqtln5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXi0RHgAKCRCdlLljIbnQ
EhRBAP9kCf5WxYqsddLpbde2EDbbHMYUsQFCJzkEKqYgxO8v6gEAodewLdV9xQjY
t35JSLzrhWvvTNnq1B+Vvdyvj9MvDwA=
=bVpa
-----END PGP SIGNATURE-----

--b547hxjkssbqtln5--
