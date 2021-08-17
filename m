Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4860E3EE7E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 09:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbhHQH4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 03:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234741AbhHQH4m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 03:56:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE6B66054E;
        Tue, 17 Aug 2021 07:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629186969;
        bh=ialWZUiGma+hiJ6vkQY6KCDbFYDPBfUEF0qvlOeHQf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fCAY0aWmgY4G3vZ1IAkz6dHYzN1/ODUqsvYo7yeLWv1j+ViKOgARmsZC4Yu4KPMRL
         HexDsoLGIYCg7MBa0n8BY1l0HUIwCv1hEpC4tcZznMNivKUF1mfg87eI/5PGA6lTNE
         uaxV+TTbtVo9gcv3TJLjrjZe5m3F7VuMeXCO8F1rBh0oAOWBGmnYHWlTF2T5cHjP6C
         Hwy+H7aS6lfgOASd2L1H2n+nGbRTEhRbutmNe+akyNM6uImXnGFQELvj6sOf7MWBfa
         w584KTmHAXudd90oBkArD45WBS6UsJhHgoAnYLmpeFZEhngAaqLRPuSLJEMI/fq+Ts
         8xywIR2CAKDTQ==
Date:   Tue, 17 Aug 2021 10:56:02 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] general protection fault when reading /proc/kcore
Message-ID: <YRtrktVtNlWMLVZR@kernel.org>
References: <YRqhqz35tm3hA9CG@krava>
 <1a05d147-e249-7682-2c86-bbd157bc9c7d@redhat.com>
 <YRqqqvaZHDu1IKrD@krava>
 <2b83f03c-e782-138d-6010-1e4da5829b9a@redhat.com>
 <YRq4typgRn342B4i@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YRq4typgRn342B4i@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 10:13:18PM +0300, Mike Rapoport wrote:
> On Mon, Aug 16, 2021 at 08:38:43PM +0200, David Hildenbrand wrote:
> > On 16.08.21 20:12, Jiri Olsa wrote:
> > > On Mon, Aug 16, 2021 at 07:49:15PM +0200, David Hildenbrand wrote:
> > > > On 16.08.21 19:34, Jiri Olsa wrote:
> > > > > hi,
> > > > > I'm getting fault below when running:
> > > > >=20
> > > > > 	# cat /proc/kallsyms | grep ksys_read
> > > > > 	ffffffff8136d580 T ksys_read
> > > > > 	# objdump -d --start-address=3D0xffffffff8136d580 --stop-address=
=3D0xffffffff8136d590 /proc/kcore
> > > > >=20
> > > > > 	/proc/kcore:     file format elf64-x86-64
> > > > >=20
> > > > > 	Segmentation fault
> > > > >=20
> > > > > any idea? config is attached
> > > >=20
> > > > Just tried with a different config on 5.14.0-rc6+
> > > >=20
> > > > [root@localhost ~]# cat /proc/kallsyms | grep ksys_read
> > > > ffffffff8927a800 T ksys_readahead
> > > > ffffffff89333660 T ksys_read
> > > >=20
> > > > [root@localhost ~]# objdump -d --start-address=3D0xffffffff89333660
> > > > --stop-address=3D0xffffffff89333670
> > > >=20
> > > > a.out:     file format elf64-x86-64
> > > >=20
> > > >=20
> > > >=20
> > > > The kern_addr_valid(start) seems to fault in your case, which is we=
ird,
> > > > because it merely walks the page tables. But it seems to complain a=
bout a
> > > > non-canonical address 0xf887ffcbff000
> > > >=20
> > > > Can you post your QEMU cmdline? Did you test this on other kernel v=
ersions?
> > >=20
> > > I'm using virt-manager so:
> > >=20
> > > /usr/bin/qemu-system-x86_64 -name guest=3Dfedora33,debug-threads=3Don=
 -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qem=
u/domain-13-fedora33/master-key.aes -machine pc-q35-5.1,accel=3Dkvm,usb=3Do=
ff,vmport=3Doff,dump-guest-core=3Doff,memory-backend=3Dpc.ram -cpu Skylake-=
Server-IBRS,ss=3Don,vmx=3Don,pdcm=3Don,hypervisor=3Don,tsc-adjust=3Don,clfl=
ushopt=3Don,umip=3Don,pku=3Don,stibp=3Don,arch-capabilities=3Don,ssbd=3Don,=
xsaves=3Don,ibpb=3Don,amd-stibp=3Don,amd-ssbd=3Don,skip-l1dfl-vmentry=3Don,=
pschange-mc-no=3Don -m 8192 -object memory-backend-ram,id=3Dpc.ram,size=3D8=
589934592 -overcommit mem-lock=3Doff -smp 20,sockets=3D20,cores=3D1,threads=
=3D1 -uuid 2185d5a9-dbad-4d61-aa4e-97af9fd7ebca -no-user-config -nodefaults=
 -chardev socket,id=3Dcharmonitor,fd=3D36,server,nowait -mon chardev=3Dchar=
monitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -global=
 kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global ICH9-LPC.di=
sable_s3=3D1 -global ICH9-LPC.disable_s4=3D1 -boot strict=3Don -kernel /hom=
e/jolsa/qemu/run/vmlinux -initrd /home/jolsa/qemu/run/initrd -append root=
=3D/dev/mapper/fedora_fedora-root ro rd.lvm.lv=3Dfedora_fedora/root console=
=3Dtty0 console=3DttyS0,115200 -device pcie-root-port,port=3D0x10,chassis=
=3D1,id=3Dpci.1,bus=3Dpcie.0,multifunction=3Don,addr=3D0x2 -device pcie-roo=
t-port,port=3D0x11,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,addr=3D0x2.0x1 -devi=
ce pcie-root-port,port=3D0x12,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,addr=3D0x=
2.0x2 -device pcie-root-port,port=3D0x13,chassis=3D4,id=3Dpci.4,bus=3Dpcie.=
0,addr=3D0x2.0x3 -device pcie-root-port,port=3D0x14,chassis=3D5,id=3Dpci.5,=
bus=3Dpcie.0,addr=3D0x2.0x4 -device pcie-root-port,port=3D0x15,chassis=3D6,=
id=3Dpci.6,bus=3Dpcie.0,addr=3D0x2.0x5 -device pcie-root-port,port=3D0x16,c=
hassis=3D7,id=3Dpci.7,bus=3Dpcie.0,addr=3D0x2.0x6 -device qemu-xhci,p2=3D15=
,p3=3D15,id=3Dusb,bus=3Dpci.2,addr=3D0x0 -device virtio-serial-pci,id=3Dvir=
tio-serial0,bus=3Dpci.3,addr=3D0x0 -blockdev {"driver":"file","filename":"/=
var/lib/libvirt/images/fedora33.qcow2","node-name":"libvirt-2-storage","aut=
o-read-only":true,"discard":"unmap"} -blockdev {"node-name":"libvirt-2-form=
at","read-only":false,"driver":"qcow2","file":"libvirt-2-storage","backing"=
:null} -device virtio-blk-pci,bus=3Dpci.4,addr=3D0x0,drive=3Dlibvirt-2-form=
at,id=3Dvirtio-disk0,bootindex=3D1 -device ide-cd,bus=3Dide.0,id=3Dsata0-0-=
0 -netdev tap,fd=3D38,id=3Dhostnet0,vhost=3Don,vhostfd=3D39 -device virtio-=
net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:f3:c6:e7,bus=3Dpci.1,add=
r=3D0x0 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharseri=
al0,id=3Dserial0 -chardev socket,id=3Dcharchannel0,fd=3D40,server,nowait -d=
evice virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,i=
d=3Dchannel0,name=3Dorg.qemu.guest_agent.0 -chardev spicevmc,id=3Dcharchann=
el1,name=3Dvdagent -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,cha=
rdev=3Dcharchannel1,id=3Dchannel1,name=3Dcom.redhat.spice.0 -device usb-tab=
let,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice port=3D5900,addr=3D127.0.0.1,di=
sable-ticketing,image-compression=3Doff,seamless-migration=3Don -device qxl=
-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=3D=
0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1 -device ich9-intel=
-hda,id=3Dsound0,bus=3Dpcie.0,addr=3D0x1b -device hda-duplex,id=3Dsound0-co=
dec0,bus=3Dsound0.0,cad=3D0 -chardev spicevmc,id=3Dcharredir0,name=3Dusbred=
ir -device usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 =
-chardev spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-redir,chardev=
=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virtio-balloon-pci,i=
d=3Dballoon0,bus=3Dpci.5,addr=3D0x0 -object rng-random,id=3Dobjrng0,filenam=
e=3D/dev/urandom -device virtio-rng-pci,rng=3Dobjrng0,id=3Drng0,bus=3Dpci.6=
,addr=3D0x0 -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Dde=
ny,resourcecontrol=3Ddeny -msg timestamp=3Don
> =20
> > > so far I tested just bpf-next/master:
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> > >=20
> >=20
> > Just tried with upstream Linux (5.14.0-rc6) and your config without
> > triggering it. I'm using "-cpu host", though, on an AMD Ryzen 9 3900X
>=20
> With Jiri's config and '-cpu <very long string>' it triggers for me on
> v5.14-rc6.
>=20
> I'll also try to take a look tomorrow.

There are some non-zero PMDs that are not present in the high kernel
mappings. The patch below fixes for me the issue in kern_addr_valid()
trying to access a not-present PMD. Jiri, can you check if it works for
you?

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ddeaba947eb3..07b56e90db5d 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1433,18 +1433,18 @@ int kern_addr_valid(unsigned long addr)
 		return 0;
=20
 	p4d =3D p4d_offset(pgd, addr);
-	if (p4d_none(*p4d))
+	if (p4d_none(*p4d) || !p4d_present(*p4d))
 		return 0;
=20
 	pud =3D pud_offset(p4d, addr);
-	if (pud_none(*pud))
+	if (pud_none(*pud) || !pud_present(*pud))
 		return 0;
=20
 	if (pud_large(*pud))
 		return pfn_valid(pud_pfn(*pud));
=20
 	pmd =3D pmd_offset(pud, addr);
-	if (pmd_none(*pmd))
+	if (pmd_none(*pmd) || !pmd_present(*pmd))
 		return 0;
=20
 	if (pmd_large(*pmd))

--=20
Sincerely yours,
Mike.
