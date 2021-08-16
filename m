Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAFF3EDDAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 21:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhHPTNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 15:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhHPTNu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:13:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59BB760F35;
        Mon, 16 Aug 2021 19:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629141197;
        bh=MfGn258aaLrPNsfLMxzJS8p/bCXZ4kpH5puOFp2U4Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zp1kSM412nk5X3DdnzZF8VfqIEw4yt6YgXdnhp33+Ya/TNhc9N254nTUF9Z8ErNsn
         CIbOiVOWqVcUhGFqbQ1+OhpiFyg3cZ7Qv+JjEqC073qOAkcp3ReRIy3OMJow+b1lWC
         K8Q6DFyB/3yvdJFhOHl0DEu4ZLMWy1dA3kheiEMfTL5KLqbxUlNT4W6fA/Oay//Kde
         Kxbl6FzEi1lW83gS/LXMlFVuReAiUaxZJo6T+hbsxY2ymWjTc8ew3vmH6khCkMU+tr
         pzXDsjsr+ZS5Q88sDmQ7QwLX3Yyg0pkyW5Io5BZRwOVDvEXm+1FK0N+wvzoEPTf5kq
         li9E/E/0RBpKQ==
Date:   Mon, 16 Aug 2021 22:12:55 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] general protection fault when reading /proc/kcore
Message-ID: <YRq4typgRn342B4i@kernel.org>
References: <YRqhqz35tm3hA9CG@krava>
 <1a05d147-e249-7682-2c86-bbd157bc9c7d@redhat.com>
 <YRqqqvaZHDu1IKrD@krava>
 <2b83f03c-e782-138d-6010-1e4da5829b9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2b83f03c-e782-138d-6010-1e4da5829b9a@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 08:38:43PM +0200, David Hildenbrand wrote:
> On 16.08.21 20:12, Jiri Olsa wrote:
> > On Mon, Aug 16, 2021 at 07:49:15PM +0200, David Hildenbrand wrote:
> > > On 16.08.21 19:34, Jiri Olsa wrote:
> > > > hi,
> > > > I'm getting fault below when running:
> > > >=20
> > > > 	# cat /proc/kallsyms | grep ksys_read
> > > > 	ffffffff8136d580 T ksys_read
> > > > 	# objdump -d --start-address=3D0xffffffff8136d580 --stop-address=
=3D0xffffffff8136d590 /proc/kcore
> > > >=20
> > > > 	/proc/kcore:     file format elf64-x86-64
> > > >=20
> > > > 	Segmentation fault
> > > >=20
> > > > any idea? config is attached
> > >=20
> > > Just tried with a different config on 5.14.0-rc6+
> > >=20
> > > [root@localhost ~]# cat /proc/kallsyms | grep ksys_read
> > > ffffffff8927a800 T ksys_readahead
> > > ffffffff89333660 T ksys_read
> > >=20
> > > [root@localhost ~]# objdump -d --start-address=3D0xffffffff89333660
> > > --stop-address=3D0xffffffff89333670
> > >=20
> > > a.out:     file format elf64-x86-64
> > >=20
> > >=20
> > >=20
> > > The kern_addr_valid(start) seems to fault in your case, which is weir=
d,
> > > because it merely walks the page tables. But it seems to complain abo=
ut a
> > > non-canonical address 0xf887ffcbff000
> > >=20
> > > Can you post your QEMU cmdline? Did you test this on other kernel ver=
sions?
> >=20
> > I'm using virt-manager so:
> >=20
> > /usr/bin/qemu-system-x86_64 -name guest=3Dfedora33,debug-threads=3Don -=
S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/=
domain-13-fedora33/master-key.aes -machine pc-q35-5.1,accel=3Dkvm,usb=3Doff=
,vmport=3Doff,dump-guest-core=3Doff,memory-backend=3Dpc.ram -cpu Skylake-Se=
rver-IBRS,ss=3Don,vmx=3Don,pdcm=3Don,hypervisor=3Don,tsc-adjust=3Don,clflus=
hopt=3Don,umip=3Don,pku=3Don,stibp=3Don,arch-capabilities=3Don,ssbd=3Don,xs=
aves=3Don,ibpb=3Don,amd-stibp=3Don,amd-ssbd=3Don,skip-l1dfl-vmentry=3Don,ps=
change-mc-no=3Don -m 8192 -object memory-backend-ram,id=3Dpc.ram,size=3D858=
9934592 -overcommit mem-lock=3Doff -smp 20,sockets=3D20,cores=3D1,threads=
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
=20


> > so far I tested just bpf-next/master:
> >    git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> >=20
>=20
> Just tried with upstream Linux (5.14.0-rc6) and your config without
> triggering it. I'm using "-cpu host", though, on an AMD Ryzen 9 3900X

With Jiri's config and '-cpu <very long string>' it triggers for me on
v5.14-rc6.

I'll also try to take a look tomorrow.
=20
> > and jsut removed my changes to make sure it wasn't me ;-)
>=20
> :)
>=20
> >=20
> > I'll try to find a version that worked for me before
>=20
> Can you try with upstream Linux as well?
>=20
>=20
> --=20
> Thanks,
>=20
> David / dhildenb

--=20
Sincerely yours,
Mike.
