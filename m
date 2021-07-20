Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CD53D0033
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 19:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhGTQqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 12:46:51 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40792 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhGTQqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 12:46:47 -0400
Received: by mail-wm1-f47.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so1929983wmf.5;
        Tue, 20 Jul 2021 10:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=N7iOkDTbFVkcyMX6wYcSBGgYmLYjg2HzoM77/UPDOg4=;
        b=dyiL8nOUQLkjNy+1XWARapEwXMgTiXAgwiCo8tjJDnKnHmdnvG24dZ3wsUybe0WRNW
         AKthGJE7351b5TZbmGPqwee19MrPa8iKfHIBLWhst7uH5jN/qQHiJGNuXxNkrNeCWWxs
         RFFrHAHW8DNOw5nX6kReyoNrDOM5bfd18Z4iQLGALw2AhxYclWc8y8LBtP8TrKhTMa9U
         UTYNKB7HwDwtu9yarSrRjXcKpIg52LKHtg2Z8dPNOMZzPfoDs1jG9V6w8U5LXtEIJAAv
         Lk2/PqBdwAMDmKF6pLIk6M7+wz3y/jP8/YUbTZ1hDIkSoiv5uY0X+ZvkP7a3/bHMCF1e
         +PdA==
X-Gm-Message-State: AOAM531vFJcGqhR3gUayb3Z27qpGIrvYIh27EIIBWWwSW7A6SmL8wzop
        tiisCAY2Wk/vLgVMUv4yPzA=
X-Google-Smtp-Source: ABdhPJzSvRKefzCend6nJFQAsS0uaCa1fK90wXmtgi8iW/HukxV3TCuQkr/LPawh1sUR5jy9AFko3g==
X-Received: by 2002:a05:600c:4656:: with SMTP id n22mr27973928wmo.37.1626802043421;
        Tue, 20 Jul 2021 10:27:23 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id y16sm3000360wmq.1.2021.07.20.10.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:27:21 -0700 (PDT)
Message-ID: <3ca56654449b53814a22e3f06179292bc959ae72.camel@debian.org>
Subject: Re: [PATCH v5 0/5] block: add a sequence number to disks
From:   Luca Boccassi <bluca@debian.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier =?ISO-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Date:   Tue, 20 Jul 2021 18:27:19 +0100
In-Reply-To: <20210712230530.29323-1-mcroce@linux.microsoft.com>
References: <20210712230530.29323-1-mcroce@linux.microsoft.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-l95ld3mPlgVO7/HvtvnM"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-l95ld3mPlgVO7/HvtvnM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-07-13 at 01:05 +0200, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
>=20
> Associating uevents with block devices in userspace is difficult and racy=
:
> the uevent netlink socket is lossy, and on slow and overloaded systems ha=
s
> a very high latency. Block devices do not have exclusive owners in
> userspace, any process can set one up (e.g. loop devices). Moreover, devi=
ce
> names can be reused (e.g. loop0 can be reused again and again). A userspa=
ce
> process setting up a block device and watching for its events cannot thus
> reliably tell whether an event relates to the device it just set up or
> another earlier instance with the same name.
>=20
> Being able to set a UUID on a loop device would solve the race conditions=
.
> But it does not allow to derive orderings from uevents: if you see a ueve=
nt
> with a UUID that does not match the device you are waiting for, you canno=
t
> tell whether it's because the right uevent has not arrived yet, or it was
> already sent and you missed it. So you cannot tell whether you should wai=
t
> for it or not.
>=20
> Being able to set devices up in a namespace would solve the race conditio=
ns
> too, but it can work only if being namespaced is feasible in the first
> place. Many userspace processes need to set devices up for the root
> namespace, so this solution cannot always work.
>=20
> Changing the loop devices naming implementation to always use
> monotonically increasing device numbers, instead of reusing the lowest
> free number, would also solve the problem, but it would be very disruptiv=
e
> to userspace and likely break many existing use cases. It would also be
> quite awkward to use on long-running machines, as the loop device name
> would quickly grow to many-digits length.
>=20
> Furthermore, this problem does not affect only loop devices - partition
> probing is asynchronous and very slow on busy systems. It is very easy to
> enter races when using LO_FLAGS_PARTSCAN and watching for the partitions =
to
> show up, as it can take a long time for the uevents to be delivered after
> setting them up.
>=20
> Associating a unique, monotonically increasing sequential number to the
> lifetime of each block device, which can be retrieved with an ioctl
> immediately upon setting it up, allows to solve the race conditions with
> uevents, and also allows userspace processes to know whether they should
> wait for the uevent they need or if it was dropped and thus they should
> move on.
>=20
> This does not benefit only loop devices and block devices with multiple
> partitions, but for example also removable media such as USB sticks or
> cdroms/dvdroms/etc.
>=20
> The first patch is the core one, the 2..4 expose the information in
> different ways, and the last one makes the loop device generate a media
> changed event upon attach, detach or reconfigure, so the sequence number
> is increased.
>=20
> If merged, this feature will immediately used by the userspace:
> https://github.com/systemd/systemd/issues/17469#issuecomment-762919781
>=20
> v4 -> v5:
> - introduce a helper to raise media changed events
> - use the new helper in loop instead of the full event code
> - unexport inc_diskseq() which is only used by the block code now
> - rebase on top of 5.14-rc1
>=20
> v3 -> v4:
> - rebased on top of 5.13
> - hook the seqnum increase into the media change event
> - make the loop device raise media change events
> - merge 1/6 and 5/6
> - move the uevent part of 1/6 into a separate one
> - drop the now unneeded sysfs refactor
> - change 'diskseq' to a global static variable
> - add more comments
> - refactor commit messages
>=20
> v2 -> v3:
> - rebased on top of 5.13-rc7
> - resend because it appeared archived on patchwork
>=20
> v1 -> v2:
> - increase seqnum on media change
> - increase on loop detach
>=20
> Matteo Croce (6):
>   block: add disk sequence number
>   block: export the diskseq in uevents
>   block: add ioctl to read the disk sequence number
>   block: export diskseq in sysfs
>   block: add a helper to raise a media changed event
>   loop: raise media_change event
>=20
>  Documentation/ABI/testing/sysfs-block | 12 ++++++
>  block/disk-events.c                   | 62 +++++++++++++++++++++------
>  block/genhd.c                         | 43 +++++++++++++++++++
>  block/ioctl.c                         |  2 +
>  drivers/block/loop.c                  |  5 +++
>  include/linux/genhd.h                 |  3 ++
>  include/uapi/linux/fs.h               |  1 +
>  7 files changed, 114 insertions(+), 14 deletions(-)

For the series:

Tested-by: Luca Boccassi <bluca@debian.org>

I have implemented the basic systemd support for this (ioctl + uevent,
sysfs will be done later), and tested with this series on x86_64 and
Debian 11 userspace, everything seems to work great. Thanks Matteo!

Here's the implementation, in draft state until the kernel side is
merged:

https://github.com/systemd/systemd/pull/20257

--=20
Kind regards,
Luca Boccassi

--=-l95ld3mPlgVO7/HvtvnM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmD3B3cACgkQKGv37813
JB5IIw//fwCAii36DiHJM7gFX5uokIF0r76YmrdkwIEVLWoKf2WoipYmVctA/NcF
Q6lyI/jrGr+0QqdmJJWvyzZRLFUid63eITUEmKPTlk5g9FPXH+kmmPqS4ROMkrBO
AzG+znOh4HuOGo/HTp3J8AKzFLE5xi0+99Rzu3KKeCMAeJ6DWjLHYek+9KkgzSCl
kawr2hOlCcCUDbtcOVT792DUNLtrSx66SFbwe65PA7D7TipxXDieCyIVpFHZ/j3N
OHEthOHzijQVUOFnyZ/6HEYmYzr/D+wPd0bJW9d0+c4kdqU3eTEMXbZazDMGZdit
XP7PfPWirYFHXPxjzBhn7DsrgIxvOHLU/JDGZsCsgTqOCNpcypV8Q+B62hR6btzt
TBwQK5QpEE05XVwj6E6szfyczo95t8U1mde3RGmXQ9ES1MAPtsx1GzrT969vXHaA
YIt4VtUxLiv/tiNIhDt7IwnyHuv68upoRS0Ok5BJTRjZqxCekpOeEBHLghTxlNX+
Lii0YJOTD6ns4e2WYerlYm/Ij5Bs+eRY3Pkx3U+akEdAuyfpR8HzaWcJnVMVyoVQ
MF/Cmc2XAOO6sdgtfxh65op3y/y7o5A0AMnRFmWNtzlqyzsQLJpLceYrI6YAxmbK
GAc0WGsulvjb4PXBiR0v7Z5npikfgF5amkVW97S77qTRebbnmQ4=
=nAxS
-----END PGP SIGNATURE-----

--=-l95ld3mPlgVO7/HvtvnM--
