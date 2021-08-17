Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73653EE84F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 10:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhHQIVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 04:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234907AbhHQIVN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:21:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BE7560E78;
        Tue, 17 Aug 2021 08:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629188441;
        bh=l54Urq7XdMCI7lBaM+epnAi6PCw4ioMj6x8D2t2mhT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ruFzCne9PmZ/zhk/24BHMFwR7Dwe4d3UfDPxVyfJTBk6G4bXFi9txCeh7/NInzcNu
         se9pZf+uUvQ/LewOUzF1/Ee6/vtN3tuWQDwX0jXCpZ2zRuFGaS76BQTtLiSQukx4ju
         tpmC3/kC5xy3wcVRUFcfRIL8IfApzgD+ZS/IRk87aJp5ztxSfKj38to+gRYzBphx4D
         GPs7LFjHeIhV8Q6DLkXXaTlNgMTosMTD4TtK016X/laBDGL/+axbpEihGehwcp60TF
         xxWy9jyFJb8cNjt81sorByHB4AskQxn8t4+SyDQQhYuyTTeTbqWEqmijg+GeWE0YMH
         AfSlrFPgD79yA==
Date:   Tue, 17 Aug 2021 11:20:35 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] general protection fault when reading /proc/kcore
Message-ID: <YRtxU8b0FCoG6G04@kernel.org>
References: <YRqhqz35tm3hA9CG@krava>
 <1a05d147-e249-7682-2c86-bbd157bc9c7d@redhat.com>
 <YRqqqvaZHDu1IKrD@krava>
 <2b83f03c-e782-138d-6010-1e4da5829b9a@redhat.com>
 <YRq4typgRn342B4i@kernel.org>
 <YRtrktVtNlWMLVZR@kernel.org>
 <0aa3aaca-4ac4-0f34-0012-78c5252b5650@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0aa3aaca-4ac4-0f34-0012-78c5252b5650@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 10:02:10AM +0200, David Hildenbrand wrote:
> On 17.08.21 09:56, Mike Rapoport wrote:
> > On Mon, Aug 16, 2021 at 10:13:18PM +0300, Mike Rapoport wrote:
> > > On Mon, Aug 16, 2021 at 08:38:43PM +0200, David Hildenbrand wrote:
> > > > On 16.08.21 20:12, Jiri Olsa wrote:
> > > > > On Mon, Aug 16, 2021 at 07:49:15PM +0200, David Hildenbrand wrote:
> > > > > > On 16.08.21 19:34, Jiri Olsa wrote:
> > > > > > > hi,
> > > > > > > I'm getting fault below when running:
> > > > > > >=20
> > > > > > > 	# cat /proc/kallsyms | grep ksys_read
> > > > > > > 	ffffffff8136d580 T ksys_read
> > > > > > > 	# objdump -d --start-address=3D0xffffffff8136d580 --stop-add=
ress=3D0xffffffff8136d590 /proc/kcore
> > > > > > >=20
> > > > > > > 	/proc/kcore:     file format elf64-x86-64
> > > > > > >=20
> > > > > > > 	Segmentation fault
> > > > > > >=20
> > > > > > > any idea? config is attached
> > > > > >=20
> > > > > > Just tried with a different config on 5.14.0-rc6+
> > > > > >=20
> > > > > > [root@localhost ~]# cat /proc/kallsyms | grep ksys_read
> > > > > > ffffffff8927a800 T ksys_readahead
> > > > > > ffffffff89333660 T ksys_read
> > > > > >=20
> > > > > > [root@localhost ~]# objdump -d --start-address=3D0xffffffff8933=
3660
> > > > > > --stop-address=3D0xffffffff89333670
> > > > > >=20
> > > > > > a.out:     file format elf64-x86-64
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > The kern_addr_valid(start) seems to fault in your case, which i=
s weird,
> > > > > > because it merely walks the page tables. But it seems to compla=
in about a
> > > > > > non-canonical address 0xf887ffcbff000
> > > > > >=20
> > > > > > Can you post your QEMU cmdline? Did you test this on other kern=
el versions?
> > > > >=20
> > > > > I'm using virt-manager so:
> > > > >=20
> > > > > /usr/bin/qemu-system-x86_64 -name guest=3Dfedora33,debug-threads=
=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvir=
t/qemu/domain-13-fedora33/master-key.aes -machine pc-q35-5.1,accel=3Dkvm,us=
b=3Doff,vmport=3Doff,dump-guest-core=3Doff,memory-backend=3Dpc.ram -cpu Sky=
lake-Server-IBRS,ss=3Don,vmx=3Don,pdcm=3Don,hypervisor=3Don,tsc-adjust=3Don=
,clflushopt=3Don,umip=3Don,pku=3Don,stibp=3Don,arch-capabilities=3Don,ssbd=
=3Don,xsaves=3Don,ibpb=3Don,amd-stibp=3Don,amd-ssbd=3Don,skip-l1dfl-vmentry=
=3Don,pschange-mc-no=3Don -m 8192 -object memory-backend-ram,id=3Dpc.ram,si=
ze=3D8589934592 -overcommit mem-lock=3Doff -smp 20,sockets=3D20,cores=3D1,t=
hreads=3D1 -uuid 2185d5a9-dbad-4d61-aa4e-97af9fd7ebca -no-user-config -node=
faults -chardev socket,id=3Dcharmonitor,fd=3D36,server,nowait -mon chardev=
=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew =
-global kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global ICH9=
-LPC.disable_s3=3D1 -global ICH9-LPC.disable_s4=3D1 -boot strict=3Don -kern=
el /home/jolsa/qemu/run/vmlinux -initrd /home/jolsa/qemu/run/initrd -append=
 root=3D/dev/mapper/fedora_fedora-root ro rd.lvm.lv=3Dfedora_fedora/root co=
nsole=3Dtty0 console=3DttyS0,115200 -device pcie-root-port,port=3D0x10,chas=
sis=3D1,id=3Dpci.1,bus=3Dpcie.0,multifunction=3Don,addr=3D0x2 -device pcie-=
root-port,port=3D0x11,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,addr=3D0x2.0x1 -d=
evice pcie-root-port,port=3D0x12,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,addr=
=3D0x2.0x2 -device pcie-root-port,port=3D0x13,chassis=3D4,id=3Dpci.4,bus=3D=
pcie.0,addr=3D0x2.0x3 -device pcie-root-port,port=3D0x14,chassis=3D5,id=3Dp=
ci.5,bus=3Dpcie.0,addr=3D0x2.0x4 -device pcie-root-port,port=3D0x15,chassis=
=3D6,id=3Dpci.6,bus=3Dpcie.0,addr=3D0x2.0x5 -device pcie-root-port,port=3D0=
x16,chassis=3D7,id=3Dpci.7,bus=3Dpcie.0,addr=3D0x2.0x6 -device qemu-xhci,p2=
=3D15,p3=3D15,id=3Dusb,bus=3Dpci.2,addr=3D0x0 -device virtio-serial-pci,id=
=3Dvirtio-serial0,bus=3Dpci.3,addr=3D0x0 -blockdev {"driver":"file","filena=
me":"/var/lib/libvirt/images/fedora33.qcow2","node-name":"libvirt-2-storage=
","auto-read-only":true,"discard":"unmap"} -blockdev {"node-name":"libvirt-=
2-format","read-only":false,"driver":"qcow2","file":"libvirt-2-storage","ba=
cking":null} -device virtio-blk-pci,bus=3Dpci.4,addr=3D0x0,drive=3Dlibvirt-=
2-format,id=3Dvirtio-disk0,bootindex=3D1 -device ide-cd,bus=3Dide.0,id=3Dsa=
ta0-0-0 -netdev tap,fd=3D38,id=3Dhostnet0,vhost=3Don,vhostfd=3D39 -device v=
irtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:f3:c6:e7,bus=3Dpci=
=2E1,addr=3D0x0 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3D=
charserial0,id=3Dserial0 -chardev socket,id=3Dcharchannel0,fd=3D40,server,n=
owait -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharch=
annel0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 -chardev spicevmc,id=3Dc=
harchannel1,name=3Dvdagent -device virtserialport,bus=3Dvirtio-serial0.0,nr=
=3D2,chardev=3Dcharchannel1,id=3Dchannel1,name=3Dcom.redhat.spice.0 -device=
 usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice port=3D5900,addr=3D127.=
0.0.1,disable-ticketing,image-compression=3Doff,seamless-migration=3Don -de=
vice qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_si=
ze_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1 -device ic=
h9-intel-hda,id=3Dsound0,bus=3Dpcie.0,addr=3D0x1b -device hda-duplex,id=3Ds=
ound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev spicevmc,id=3Dcharredir0,name=
=3Dusbredir -device usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,=
port=3D2 -chardev spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-redi=
r,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virtio-ball=
oon-pci,id=3Dballoon0,bus=3Dpci.5,addr=3D0x0 -object rng-random,id=3Dobjrng=
0,filename=3D/dev/urandom -device virtio-rng-pci,rng=3Dobjrng0,id=3Drng0,bu=
s=3Dpci.6,addr=3D0x0 -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,s=
pawn=3Ddeny,resourcecontrol=3Ddeny -msg timestamp=3Don
> > > > > so far I tested just bpf-next/master:
> > > > >     git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> > > > >=20
> > > >=20
> > > > Just tried with upstream Linux (5.14.0-rc6) and your config without
> > > > triggering it. I'm using "-cpu host", though, on an AMD Ryzen 9 390=
0X
> > >=20
> > > With Jiri's config and '-cpu <very long string>' it triggers for me on
> > > v5.14-rc6.
> > >=20
> > > I'll also try to take a look tomorrow.
> >=20
> > There are some non-zero PMDs that are not present in the high kernel
> > mappings. The patch below fixes for me the issue in kern_addr_valid()
> > trying to access a not-present PMD. Jiri, can you check if it works for
> > you?
> >=20
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index ddeaba947eb3..07b56e90db5d 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1433,18 +1433,18 @@ int kern_addr_valid(unsigned long addr)
> >   		return 0;
> >   	p4d =3D p4d_offset(pgd, addr);
> > -	if (p4d_none(*p4d))
> > +	if (p4d_none(*p4d) || !p4d_present(*p4d))
> >   		return 0;
> >   	pud =3D pud_offset(p4d, addr);
> > -	if (pud_none(*pud))
> > +	if (pud_none(*pud) || !pud_present(*pud))
> >   		return 0;
> >   	if (pud_large(*pud))
> >   		return pfn_valid(pud_pfn(*pud));
> >   	pmd =3D pmd_offset(pud, addr);
> > -	if (pmd_none(*pmd))
> > +	if (pmd_none(*pmd) || !pmd_present(*pmd))
> >   		return 0;
> >   	if (pmd_large(*pmd))
> >=20
>=20
> However, wouldn't that mean that that TEXT segment isn't actually accessi=
ble
> at all? Or is this some weird kind of TEXT protection (not even being able
> to read it, weird, no?)

It does not seem like TEXT isn't accessible. There are unused parts in that
virtual range, but for some reason the PMDs there are not zero.
=20
> We don't support swapping and all that stuff for kernel memory. So what d=
oes
> !present even indicate here? (smells like a different BUG, but I might be
> wrong, of course)

Don't know yet. For now I've only found the cause for kern_addr_valid() to
crash.

--=20
Sincerely yours,
Mike.
