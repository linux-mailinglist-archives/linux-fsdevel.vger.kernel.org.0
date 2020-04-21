Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340731B1B34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 03:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDUBVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 21:21:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:36846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgDUBVN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 21:21:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 85D4EAEBE;
        Tue, 21 Apr 2020 01:21:09 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Matthew Wilcox <willy@infradead.org>
Date:   Tue, 21 Apr 2020 11:20:53 +1000
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
Subject: Re: [PATCH 5/9] usb: fix empty-body warning in sysfs.c
In-Reply-To: <Pine.LNX.4.44L0.2004181549020.8036-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.2004181549020.8036-100000@netrider.rowland.org>
Message-ID: <87368xskga.fsf@notabene.neil.brown.name>
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

On Sat, Apr 18 2020, Alan Stern wrote:

> On Sat, 18 Apr 2020, Matthew Wilcox wrote:
>
>> On Sat, Apr 18, 2020 at 11:41:07AM -0700, Randy Dunlap wrote:
>> > +++ linux-next-20200327/drivers/usb/core/sysfs.c
>> > @@ -1263,7 +1263,7 @@ void usb_create_sysfs_intf_files(struct
>> >  	if (!alt->string && !(udev->quirks & USB_QUIRK_CONFIG_INTF_STRINGS))
>> >  		alt->string =3D usb_cache_string(udev, alt->desc.iInterface);
>> >  	if (alt->string && device_create_file(&intf->dev, &dev_attr_interfac=
e))
>> > -		;	/* We don't actually care if the function fails. */
>> > +		do_empty(); /* We don't actually care if the function fails. */
>> >  	intf->sysfs_files_created =3D 1;
>> >  }
>>=20
>> Why not just?
>>=20
>> +	if (alt->string)
>> +		device_create_file(&intf->dev, &dev_attr_interface);
>
> This is another __must_check function call.
>
> The reason we don't care if the call fails is because the file
> being created holds the USB interface string descriptor, something
> which is purely informational and hardly ever gets set (and no doubt
> gets used even less often).
>
> Is this another situation where the comment should be expanded and the=20
> code modified to include a useless test and cast-to-void?
>
> Or should device_create_file() not be __must_check after all?

One approach to dealing with __must_check function that you don't want
to check is to cause failure to call
   pr_debug("usb: interface descriptor file not created");
or similar.  It silences the compiler, serves as documentation, and
creates a message that is almost certainly never seen.

This is what I did in drivers/md/md.c...

	if (mddev->kobj.sd &&
	    sysfs_create_group(&mddev->kobj, &md_bitmap_group))
		pr_debug("pointless warning\n");

(I give better warnings elsewhere - I must have run out of patience by
 this point).

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6eSnUACgkQOeye3VZi
gbn4EQ//WLEH1OYjzYF3ZAV16KgjXghaIeaNMOhGWUi79iqI/c9Zfe7VUDBPE5ip
xTdZh+pKAubrzHjja6sbwXCEpY1XaGBeyKxl8lc/w8bsG6yMdN0n3eP7jgMucCtN
U7DuAjjSjFvMLYDUBs6jhPbko+Qse3InDgyZH0gTueYI1QMmSag7EZs0xdvv6dAz
NgtTQbJ7MBv3CQTg3Y+O6pMvRQbwSYuUb118jv9BH5ktkRmfJ5lP0LGfDD1d/AeR
Z9oH8asOZK2ZprUXg6cuI/lf1kxFCNDGwXI9x0eDWpyt8akceeXLsxhg7Jw2KlZA
Ry4UOB//Ehxq5ZtqxQAcHNzbfXJM1JaZjbyk+Im8F3q0/i2aE2/9pGvREe91rX3u
gq2UO+5djv+TxKg1nZcFIHV/ycfdw4HWT6jKnYwOTahceJxkcswrRYqWBDePNqws
oeWTPfUxQIIMUAYl0Zsf8EXLCqKvOmVqRI3cY2jIZHOJraynmtfL+/FRsg3PNu5T
m5nSJbLvQMzITNuBTOf8BvdeAasCfR6v4RlIJYbonBJxXtUrXL7yeX0FclVpJ98+
noaE1F/eUxnG5t+n3Gr6C9ttT/avXsr7Gm7okuNwkY1vvZSoXbFPZG0VIW0SiLWY
kiqSFLeEDXCaNk4yYZlcNe17qTuJiZxx4RnTkF1IykZIcQv8haE=
=K7Ae
-----END PGP SIGNATURE-----
--=-=-=--
