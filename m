Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7569778CA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 15:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbfG2NUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 09:20:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54655 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbfG2NUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:20:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so53804758wme.4;
        Mon, 29 Jul 2019 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=32LEdh7LykxMmsxy8OKX2RgedO0t1mwvu3U/xLTsRlc=;
        b=aX4U9ugWLb8baTRc57n0eqJcpB6de0ic7qb+w+46wob8w0qvil/hHe/4yfhOxiJRf2
         FbXuKYokbEJkYgam7uf5ssQvoIxag6Rks0rEGWdiDOpkX8cCA9MCvEMS9zGPZe17dvWN
         yQUEpRigazKJHBWk3wHbV39afLKPLU1MYmUnrkV77uzO0ysj/kZtJD0irEHf5azkR31Y
         dQ4FXOiy9oCXS7ipQ9LrmrmQwU8OWw7H2S6wg56w9S+Z63hNClLMfQ+ePv7doSUOzT3V
         XhnV4/7f2CXG0dgNFinKpXJI3xCzBw2d3rVt7IrcrWJ2/g4fdraWloxJVp2EPjjcME7p
         MoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=32LEdh7LykxMmsxy8OKX2RgedO0t1mwvu3U/xLTsRlc=;
        b=XQxsZwUVMpTKURVbIVZnDtYERVpXc3TpPoNx+PWnJazV246cBtiigR+tuhAG55c9TM
         ZpMdCtWEYNZXsBDf7VUo6Hd7AYUlJ8duOXeg3pfvuEj6OXSefN0RPWExfL1Hvp5EeZS5
         HgW4XAfgbIGkNitU+VCa1dLYNt+QT1607/0hkqCTsPctJQZH+oqc2MBymvHG1kLFVBr2
         QC+v5pJw4xQfeUVZLb3NJIJ+rKkuMCimM/twGokP+xK+4xjFhHDOciezOhMJ//A6bXLq
         59yVMmzci8XAaTXjeei46z/voiO3IqtCxfC9e0Nr6Fhp5TZyVC/qR1wQ2WX42WGuM+R2
         SRUA==
X-Gm-Message-State: APjAAAVh8RASPoZ8ISPplSKcWsvM2CG1EAiDSFMBQrh3WSymjRDa3896
        rBLAz8+VNhI7cjOP8XcVrcE=
X-Google-Smtp-Source: APXvYqzeDjkhChVquCb2FPHIGR5Caewa5mcKLTpUNtIv8rEq2HcrFTJl55ldz2LN+MVUVk7w9Bu4kQ==
X-Received: by 2002:a1c:a848:: with SMTP id r69mr97100890wme.12.1564406405175;
        Mon, 29 Jul 2019 06:20:05 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id b19sm44246717wmj.13.2019.07.29.06.20.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:20:04 -0700 (PDT)
Date:   Mon, 29 Jul 2019 14:20:02 +0100
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        KVM list <kvm@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 18/30] virtio_fs, dax: Set up virtio_fs dax_device
Message-ID: <20190729132002.GB6771@stefanha-x1.localdomain>
References: <20190515192715.18000-19-vgoyal@redhat.com>
 <20190717192725.25c3d146.pasic@linux.ibm.com>
 <20190718131532.GA13883@redhat.com>
 <CAPcyv4i+2nKJYqkbrdm3hWcjaMYkCKUxqLBq96HOZe6xOZzGGg@mail.gmail.com>
 <c519011e-1df3-3f35-8582-2cb58367ff8a@de.ibm.com>
 <20190722105630.GC3035@work-vm>
 <cc96a4a7-ab24-ef2c-a210-dce0966e34c5@de.ibm.com>
 <20190722134317.39b148ce.cohuck@redhat.com>
 <b8239073-4c40-0ce6-2576-9d71ca0b1c18@de.ibm.com>
 <f7426953-8892-9f02-3f85-9f97cd12100b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <f7426953-8892-9f02-3f85-9f97cd12100b@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 02:08:02PM +0200, David Hildenbrand wrote:
> On 22.07.19 14:00, Christian Borntraeger wrote:
> >=20
> >=20
> > On 22.07.19 13:43, Cornelia Huck wrote:
> >> On Mon, 22 Jul 2019 13:20:18 +0200
> >> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >>
> >>> On 22.07.19 12:56, Dr. David Alan Gilbert wrote:
> >>>> * Christian Borntraeger (borntraeger@de.ibm.com) wrote: =20
> >>>>>
> >>>>>
> >>>>> On 18.07.19 16:30, Dan Williams wrote: =20
> >>>>>> On Thu, Jul 18, 2019 at 6:15 AM Vivek Goyal <vgoyal@redhat.com> wr=
ote: =20
> >>>>>>>
> >>>>>>> On Wed, Jul 17, 2019 at 07:27:25PM +0200, Halil Pasic wrote: =20
> >>>>>>>> On Wed, 15 May 2019 15:27:03 -0400
> >>>>>>>> Vivek Goyal <vgoyal@redhat.com> wrote:
> >>>>>>>> =20
> >>>>>>>>> From: Stefan Hajnoczi <stefanha@redhat.com>
> >>>>>>>>>
> >>>>>>>>> Setup a dax device.
> >>>>>>>>>
> >>>>>>>>> Use the shm capability to find the cache entry and map it.
> >>>>>>>>>
> >>>>>>>>> The DAX window is accessed by the fs/dax.c infrastructure and m=
ust have
> >>>>>>>>> struct pages (at least on x86).  Use devm_memremap_pages() to m=
ap the
> >>>>>>>>> DAX window PCI BAR and allocate struct page.
> >>>>>>>>> =20
> >>>>>>>>
> >>>>>>>> Sorry for being this late. I don't see any more recent version s=
o I will
> >>>>>>>> comment here.
> >>>>>>>>
> >>>>>>>> I'm trying to figure out how is this supposed to work on s390. M=
y concern
> >>>>>>>> is, that on s390 PCI memory needs to be accessed by special
> >>>>>>>> instructions. This is taken care of by the stuff defined in
> >>>>>>>> arch/s390/include/asm/io.h. E.g. we 'override' __raw_writew so i=
t uses
> >>>>>>>> the appropriate s390 instruction. However if the code does not u=
se the
> >>>>>>>> linux abstractions for accessing PCI memory, but assumes it can =
be
> >>>>>>>> accessed like RAM, we have a problem.
> >>>>>>>>
> >>>>>>>> Looking at this patch, it seems to me, that we might end up with=
 exactly
> >>>>>>>> the case described. For example AFAICT copy_to_iter() (3) resolv=
es to
> >>>>>>>> the function in lib/iov_iter.c which does not seem to cater for =
s390
> >>>>>>>> oddities.
> >>>>>>>>
> >>>>>>>> I didn't have the time to investigate this properly, and since v=
irtio-fs
> >>>>>>>> is virtual, we may be able to get around what is otherwise a
> >>>>>>>> limitation on s390. My understanding of these areas is admittedly
> >>>>>>>> shallow, and since I'm not sure I'll have much more time to
> >>>>>>>> invest in the near future I decided to raise concern.
> >>>>>>>>
> >>>>>>>> Any opinions? =20
> >>>>>>>
> >>>>>>> Hi Halil,
> >>>>>>>
> >>>>>>> I don't understand s390 and how PCI works there as well. Is there=
 any
> >>>>>>> other transport we can use there to map IO memory directly and ac=
cess
> >>>>>>> using DAX?
> >>>>>>>
> >>>>>>> BTW, is DAX supported for s390.
> >>>>>>>
> >>>>>>> I am also hoping somebody who knows better can chip in. Till that=
 time,
> >>>>>>> we could still use virtio-fs on s390 without DAX. =20
> >>>>>>
> >>>>>> s390 has so-called "limited" dax support, see CONFIG_FS_DAX_LIMITE=
D.
> >>>>>> In practice that means that support for PTE_DEVMAP is missing which
> >>>>>> means no get_user_pages() support for dax mappings. Effectively it=
's
> >>>>>> only useful for execute-in-place as operations like fork() and ptr=
ace
> >>>>>> of dax mappings will fail. =20
> >>>>>
> >>>>>
> >>>>> This is only true for the dcssblk device driver (drivers/s390/block=
/dcssblk.c
> >>>>> and arch/s390/mm/extmem.c).=20
> >>>>>
> >>>>> For what its worth, the dcssblk looks to Linux like normal memory (=
just above the
> >>>>> previously detected memory) that can be used like normal memory. In=
 previous time
> >>>>> we even had struct pages for this memory - this was removed long ag=
o (when it was
> >>>>> still xip) to reduce the memory footprint for large dcss blocks and=
 small memory
> >>>>> guests.
> >>>>> Can the CONFIG_FS_DAX_LIMITED go away if we have struct pages for t=
hat memory?
> >>>>>
> >>>>> Now some observations:=20
> >>>>> - dcssblk is z/VM only (not KVM)
> >>>>> - Setting CONFIG_FS_DAX_LIMITED globally as a Kconfig option depend=
ing on wether
> >>>>>   a device driver is compiled in or not seems not flexible enough i=
n case if you
> >>>>>   have device driver that does have struct pages and another one th=
at doesn't
> >>>>> - I do not see a reason why we should not be able to map anything f=
rom QEMU
> >>>>>   into the guest real memory via an additional KVM memory slot.=20
> >>>>>   We would need to handle that in the guest somehow (and not as a P=
CI bar),
> >>>>>   register this with struct pages etc.
> >>
> >> You mean for ccw, right? I don't think we want pci to behave
> >> differently than everywhere else.
> >=20
> > Yes for virtio-ccw. We would need to have a look at how virtio-ccw can =
create a memory
> > mapping with struct pages, so that DAX will work.(Dan, it is just struc=
t pages that=20
> > you need, correct?)
> >=20
> >=20
> >>
> >>>>> - we must then look how we can create the link between the guest me=
mory and the
> >>>>>   virtio-fs driver. For virtio-ccw we might be able to add a new cc=
w command or
> >>>>>   whatever. Maybe we could also piggy-back on some memory hotplug w=
ork from David
> >>>>>   Hildenbrand (add cc).
> >>>>>
> >>>>> Regarding limitations on the platform:
> >>>>> - while we do have PCI, the virtio devices are usually plugged via =
the ccw bus.
> >>>>>   That implies no PCI bars. I assume you use those PCI bars only to=
 implicitely=20
> >>>>>   have the location of the shared memory
> >>>>>   Correct? =20
> >>>>
> >>>> Right. =20
> >>>
> >>> So in essence we just have to provide a vm_get_shm_region callback in=
 the virtio-ccw
> >>> guest code?
> >>>
> >>> How many regions do we have to support? One region per device? Or man=
y?
> >>> Even if we need more, this should be possible with a 2 new CCWs, e.g =
READ_SHM_BASE(id)
> >>> and READ_SHM_SIZE(id)
> >>
> >> I'd just add a single CCW with a control block containing id and size.
> >>
> >> The main issue is where we put those regions, and what happens if we
> >> use both virtio-pci and virtio-ccw on the same machine.
> >=20
> > Then these 2 devices should get independent memory regions that are add=
ed in an
> > independent (but still exclusive) way.
>=20
> I remember that one discussion was who dictates the physical address
> mapping. If I'm not wrong, PCI bars can be mapped freely by the guest
> intot he address space. So it would not just be querying the start+size.
> Unless we want a pre-determined mapping (which might make more sense for
> s390x).

Yes, guests can (re)map PCI BARs.  A PCI driver first probes the BAR to
determine the type (MMIO or PIO) and size.  Then it can set the address
but often this has been already been set by the firmware and the OS
keeps the existing location.

Stefan

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0+8oIACgkQnKSrs4Gr
c8hWrQf/Sdblp/8jCTgWznL9m81xTfmcsx+N4SI+QaKvYH6hCsNFCgWxdgC546uG
mv5zGUoZRfli1G/IyrLMjqv2DDP42CkHtvSbKyurSguxJy/GdQoGtXZeCK2pkoVw
1ZaCzKAX0QvtnF/6vM2hZZODozb0lMo6LDeKPnwAoHOS4+Yrgw9L1mNsbGxnRXbW
0aKWk+C1XjB85X0pw8B2ZF2A1lN5cZ3vGE41fx1sdwd57MBaEU0jLPNhXiNqapyV
tXqxfd359xNuGE2wQdt1t094EoS52A/VPBZd933SWmpsoyueHZ+QCxZ4I2XihzqL
E+DQ1lXAeGHi7M1jrCUiEG2K1OvUXA==
=NF/H
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
