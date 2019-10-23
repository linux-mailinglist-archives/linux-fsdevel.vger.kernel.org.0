Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32328E259F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 23:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407606AbfJWVpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 17:45:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43873 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392570AbfJWVpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571867109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0D4EQ8thGQKRRU/Fz2c1O7VtA1gRTINZXqgRy6HfSuk=;
        b=R0V7DxSapSFPev4UGzimkxUEIrMclUZodFMOePwyBjdC3PkoEX9IHO8CiV/9e3ccXmQ+JC
        4A7d90Cfe7WgzZmiok371uhmCno8Tx+Mt6X3tW1OKYEj5fCZSYkXuFHlMG9NatkMTXLOVE
        xRIUi6+z9xhMdPFbyJ284vd00qkuzMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-m8GaqF_nOUal1pqA5AbW-g-1; Wed, 23 Oct 2019 17:45:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FAFE100550E;
        Wed, 23 Oct 2019 21:45:03 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 401405DA8D;
        Wed, 23 Oct 2019 21:44:55 +0000 (UTC)
Message-ID: <6759dfc6c5c721b5060d75e6c5f5a0b1dbb9a80b.camel@redhat.com>
Subject: Re: [PATCH v2 7/8] scsi: sr: workaround VMware ESXi cdrom emulation
 bug
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc:     linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 23 Oct 2019 17:44:54 -0400
In-Reply-To: <20191023162313.GE938@kitsune.suse.cz>
References: <cover.1571834862.git.msuchanek@suse.de>
         <abf81ec4f8b6139fffc609df519856ff8dc01d0d.1571834862.git.msuchanek@suse.de>
         <08f1e291-0196-2402-1947-c0cdaaf534da@suse.de>
         <20191023162313.GE938@kitsune.suse.cz>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: m8GaqF_nOUal1pqA5AbW-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-10-23 at 18:23 +0200, Michal Such=C3=A1nek wrote:
> On Wed, Oct 23, 2019 at 04:13:15PM +0200, Hannes Reinecke wrote:
> > On 10/23/19 2:52 PM, Michal Suchanek wrote:
> > > The WMware ESXi cdrom identifies itself as:
> > > sr 0:0:0:0: [sr0] scsi3-mmc drive: vendor: "NECVMWarVMware SATA CD001=
.00"
> > > model: "VMware SATA CD001.00"
> > > with the following get_capabilities print in sr.c:
> > >         sr_printk(KERN_INFO, cd,
> > >                   "scsi3-mmc drive: vendor: \"%s\" model: \"%s\"\n",
> > >                   cd->device->vendor, cd->device->model);
> > >=20
> > > So the model looks like reliable identification while vendor does not=
.
> > >=20
> > > The drive claims to have a tray and claims to be able to close it.
> > > However, the UI has no notion of a tray - when medium is ejected it i=
s
> > > dropped in the floor and the user must select a medium again before t=
he
> > > drive can be re-loaded.  On the kernel side the tray_move call to clo=
se
> > > the tray succeeds but the drive state does not change as a result of =
the
> > > call.
> > >=20
> > > The drive does not in fact emulate the tray state. There are two ways=
 to
> > > get the medium state. One is the SCSI status:
> > >=20
> > > Physical drive:
> > >=20
> > > Fixed format, current; Sense key: Not Ready
> > > Additional sense: Medium not present - tray open
> > > Raw sense data (in hex):
> > >         70 00 02 00 00 00 00 0a  00 00 00 00 3a 02 00 00
> > >         00 00
> > >=20
> > > Fixed format, current; Sense key: Not Ready
> > > Additional sense: Medium not present - tray closed
> > >  Raw sense data (in hex):
> > >         70 00 02 00 00 00 00 0a  00 00 00 00 3a 01 00 00
> > >         00 00
> > >=20
> > > VMware ESXi:
> > >=20
> > > Fixed format, current; Sense key: Not Ready
> > > Additional sense: Medium not present
> > >   Info fld=3D0x0 [0]
> > >  Raw sense data (in hex):
> > >         f0 00 02 00 00 00 00 0a  00 00 00 00 3a 00 00 00
> > >         00 00
> > >=20
> > > So the tray state is not reported here. Other is medium status which =
the
> > > kernel prefers if available. Adding a print here gives:
> > >=20
> > > cdrom: get_media_event success: code =3D 0, door_open =3D 1, medium_p=
resent =3D 0
> > >=20
> > > door_open is interpreted as open tray. This is fine so long as tray_m=
ove
> > > would close the tray when requested or report an error which never
> > > happens on VMware ESXi servers (5.5 and 6.5 tested).
> > >=20
> > > This is a popular virtualization platform so a workaround is worthwhi=
le.
> > >=20
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > >  drivers/scsi/sr.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
> > > index 4664fdf75c0f..8090c5bdec09 100644
> > > --- a/drivers/scsi/sr.c
> > > +++ b/drivers/scsi/sr.c
> > > @@ -867,6 +867,7 @@ static void get_capabilities(struct scsi_cd *cd)
> > >  =09unsigned int ms_len =3D 128;
> > >  =09int rc, n;
> > > =20
> > > +=09static const char *model_vmware =3D "VMware";
> > >  =09static const char *loadmech[] =3D
> > >  =09{
> > >  =09=09"caddy",
> > > @@ -922,6 +923,11 @@ static void get_capabilities(struct scsi_cd *cd)
> > >  =09=09  buffer[n + 4] & 0x20 ? "xa/form2 " : "",=09/* can read xa/fr=
om2 */
> > >  =09=09  buffer[n + 5] & 0x01 ? "cdda " : "", /* can read audio data =
*/
> > >  =09=09  loadmech[buffer[n + 6] >> 5]);
> > > +=09if (!strncmp(cd->device->model, model_vmware, strlen(model_vmware=
))) {
> > > +=09=09buffer[n + 6] &=3D ~(0xff << 5);
> > > +=09=09sr_printk(KERN_INFO, cd,
> > > +=09=09=09  "VMware ESXi bug workaround: tray -> caddy\n");
> > > +=09}
> > >  =09if ((buffer[n + 6] >> 5) =3D=3D 0)
> > >  =09=09/* caddy drives can't close tray... */
> > >  =09=09cd->cdi.mask |=3D CDC_CLOSE_TRAY;
> > >=20
> >=20
> > This looks something which should be handled via a blacklist flag, not
> > some inline hack which everyone forgets about it...
>=20
> AFAIK we used to have a blacklist but don't have anymore. So either it
> has to be resurrected for this one flag or an inline hack should be good
> enough.
>=20

I agree with Hannes.  We should have a blacklist flag for this.
Putting inline code in the sr driver that special cases on a particular
device model string is not clean.  The "VMware ESXi bug workaround" message
is not particularly descriptive either.

-Ewan

