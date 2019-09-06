Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 419FAAC0FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 21:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbfIFTxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 15:53:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfIFTxl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:53:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A18E92A09AB;
        Fri,  6 Sep 2019 19:53:40 +0000 (UTC)
Received: from localhost (dhcp-10-20-1-130.bss.redhat.com [10.20.1.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4050B10018F8;
        Fri,  6 Sep 2019 19:53:40 +0000 (UTC)
From:   Robbie Harwood <rharwood@redhat.com>
To:     Ray Strode <rstrode@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray\, Debarshi" <debarshi.ray@gmail.com>
Subject: Re: Why add the general notification queue and its sources
In-Reply-To: <CAKCoTu70E9cbVu=jVG4EiXnTNiG-znvri6Omh2t++1zRw+639Q@mail.gmail.com>
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk> <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com> <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com> <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com> <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com> <CAKCoTu70E9cbVu=jVG4EiXnTNiG-znvri6Omh2t++1zRw+639Q@mail.gmail.com>
Date:   Fri, 06 Sep 2019 15:53:38 -0400
Message-ID: <jlg7e6l19rx.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 06 Sep 2019 19:53:40 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ray Strode <rstrode@redhat.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> That is *way* too specific to make for any kind of generic
>> notification mechanism.
>
> Well from my standpoint, I just don't want to have to poll... I don't
> have a strong opinion about how it looks architecturally to reach that
> goal.
>
> Ideally, at a higher level, I want the userspace api that gnome uses
> to be something like:
>
> err =3D krb5_cc_watch (ctx, ccache, (krb5_cc_change_fct) on_cc_change ,
> &watch_fd);
>
> then a watch_fd would get handed back and caller could poll on it. if
> it woke up poll(), caller would do
>
> krb5_cc_watch_update (ctx, ccache, watch_fd)
>
> or so and it would trigger on_cc_change to get called (or something like =
that).
>
> If under the hood, fd comes from opening /dev/watch_queue, and
> krb5_cc_watch_update reads from some mmap'ed buffer to decide whether
> or not to call on_cc_change, that's fine with me.
>
> If under the hood, fd comes from a pipe fd returned from some ioctl or
> syscall, and krb5_cc_watch_update reads messages directly from that fd
> to decide whether or not to call on_cc_change, that's fine with
> me. too.
>
> it could be an eventfd too, or whatever, too, just as long as its
> something I can add to poll() and don't have to intermittently poll
> ... :-)
>
>
>> And why would you do a broken big-key thing in the kernel in the
>> first place? Why don't you just have a kernel key to indirectly
>> encrypt using a key and "additional user space data". The kernel
>> should simply not take care of insane 1MB keys.
>
> =F0=9F=A4=B7 dunno.  I assume you're referencing the discussions from com=
ment 0
> on that 2013 bug.  I wasn't involved in those discussions, I just
> chimed in after they happened trying to avoid having to add polling
> :-)
>
> I have no idea why a ticket would get that large. I assume it only is
> in weird edge cases.

Sadly they're not weird, but yes.  Kerberos tickets can get decently
large due to Microsoft's PACs (see MS-PAC and MS-KILE), which we need to
process, understand, and store for Active Directory interop.  I'm not
sure if I've personally made one over 1MB, but it could easily occur
given enough claims (MS-ADTS).

> Anyway, gnome treats the tickets as opaque blobs.  it doesn't do anything
> with them other than tell the user when they need to get refreshed...
>
> all the actual key manipulation happens from krb5 libraries.
>
> of course, one advantage of having the tickets kernel side is nfs
> could in theory access them directly, rather than up calling back to
> userspace...

Easy availability to filesystems is in fact the main theoretical
advantage of the keyring for us in krb5 (and, for whatever it's worth,
is why we're interested in namespaced keyrings for containers).  Our
privilege separation mechanism (gssproxy) is cache-type agnostic, and we
do have other credential cache types (KCM and DIR/FILE) in the
implementation.

Thanks,
=2D-Robbie

=2D-
Robbie Harwood
Kerberos Development Lead
Security Engineering Team
Red Hat, Inc.
Boston, MA, US

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEA5qc6hnelQjDaHWqJTL5F2qVpEIFAl1yuUIACgkQJTL5F2qV
pEKhxBAApTOa699cr0sDXl0rHPK+Ibj1T49ryHpbykhJ30RKQmC9xRFoxqJmN/N9
sy+xVpHxUikuVktp6So7ZNXh6mcY7bKYzZUpT/LITdDRo/NZxgAwk3DSLxXVNwWx
6h0lJTX95uHxfdxLlYJOOTyndCgdXGDAr2jFovZo06mb/VPK1WL4q5mIjTKtN47u
lG2YnU6SyY/zLwL3BKaQnUq/VruFbuQm+28zwsrVmZEZxIBs/bNcnkD0vT+mOTTa
dXVqi6VNmXmtlsctsVbCXAQSNXOVC+K3qZBZAEJo5kObyRwctzIUOehOLnGZ89/K
5mny02IPPLCpvUBhvVYroE0lyLKHpbkWnXyGmcPTNpyKNa5bylsoZmN4DWZevdQn
hPrar7/gYlPoaQOot2VVYMeqn0rT4XJLf/DzG0YsSmMD5EUd5/0GZ8TVTw2iZKnj
FIhGdP0MwIYrGARma830/iffk4dLj/qzn8K1mpgr2aaYBzQOalyrE8DJ7xgba386
S1A+hlwSY7Byi4aFXT/vZgGrJ9FEPStD2N8xYHYdntZKe0t3TqCHEn8SM57yN6mR
aOvzPHaPG/4OsCuugySMtR/8uzGY/tSuItEQF/vLX8azZkeyPLsqBLRyUsCLPGAV
Zv+fpFJtNC8PYLtUiZXRYYk4THFX20bIU/Ky8LCiRs0vddyhHvc=
=Si8+
-----END PGP SIGNATURE-----
--=-=-=--
