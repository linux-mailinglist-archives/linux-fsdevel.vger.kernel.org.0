Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCF83EDCEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 20:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhHPSNf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 14:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhHPSNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629137582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ObwAiK1SanC6EIqEOVjwPOQt8lDrmZK5pIQ+0d+6crA=;
        b=hF7d7WA7LassJAtAtYwSrMb7EApID1B0E2mC1Ovm2o1JyjcnGmFLRK60dWQFcMCzdb3yU4
        GVIrHNtxRfW+rQjQ/i3KAPNh0frrk3tiebVm3Rbvgqw2tizWRmVQDjVMVMVBpgOWpl6Rz9
        a3d6UdcVhv8ZmKnWG+EjyUc7Kbfdros=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-G99DOzw_MNqo06G3sC1sJQ-1; Mon, 16 Aug 2021 14:13:01 -0400
X-MC-Unique: G99DOzw_MNqo06G3sC1sJQ-1
Received: by mail-wr1-f70.google.com with SMTP id n18-20020adfe792000000b00156ae576abdso2045753wrm.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Aug 2021 11:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ObwAiK1SanC6EIqEOVjwPOQt8lDrmZK5pIQ+0d+6crA=;
        b=ggQf8VuYo98hsMiyqmYS4whe99ktvYKPNBckwItYzZqjFY5Yge6ODtvLkoKMPIKy2W
         pUoWu107f29Ll5K7fU7gilXWQMHaDfgxvJCsO14veVHnAYvDLuv9WEPLUYm5Rb1ZT6Y6
         39LMmD++QRJMzBvL0LexsCAGtIUut9PlsOHzRC+bxtHqa8gfI7/Zj/ct3j4G20Xnyk0s
         RxLw9PH1e8G9dooeuIFo1gZURSYo6mbGG4ttU6Z0L5FYaUQ0R6YvtGT4tHlaRMiVm2Th
         Mf1ixZkypHIwL+ykwmVxxwHZTm5kbhCRSTRhoWz/mJ7HLJSGjUCtTMkvk28CDWvjQE41
         nVfg==
X-Gm-Message-State: AOAM531HeT4E7lcxoJmy2jVRWOk6YYL2RnhlN1kmWYIp68ssYKEgmxgx
        oOVH438bDvlBpVfUKUDjrxu5IYQXNN4LEEZ/JVcQR0C6pIoFXUESfjzgFQByQQkV3XSJd5K1y4P
        yKwbkWakBIqQ08zJVtmiw6H4XmA==
X-Received: by 2002:adf:f403:: with SMTP id g3mr20183222wro.222.1629137580034;
        Mon, 16 Aug 2021 11:13:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSkkSVax500dJoptbIZkzkC8VGwiA1i59fRi1lf7+73SVVl22U3bvekg7+YoUHgubxd2vmww==
X-Received: by 2002:adf:f403:: with SMTP id g3mr20183201wro.222.1629137579804;
        Mon, 16 Aug 2021 11:12:59 -0700 (PDT)
Received: from krava ([83.240.61.5])
        by smtp.gmail.com with ESMTPSA id n16sm12471749wru.79.2021.08.16.11.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 11:12:59 -0700 (PDT)
Date:   Mon, 16 Aug 2021 20:12:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] general protection fault when reading /proc/kcore
Message-ID: <YRqqqvaZHDu1IKrD@krava>
References: <YRqhqz35tm3hA9CG@krava>
 <1a05d147-e249-7682-2c86-bbd157bc9c7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1a05d147-e249-7682-2c86-bbd157bc9c7d@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 07:49:15PM +0200, David Hildenbrand wrote:
> On 16.08.21 19:34, Jiri Olsa wrote:
> > hi,
> > I'm getting fault below when running:
> >=20
> > 	# cat /proc/kallsyms | grep ksys_read
> > 	ffffffff8136d580 T ksys_read
> > 	# objdump -d --start-address=3D0xffffffff8136d580 --stop-address=3D0xf=
fffffff8136d590 /proc/kcore
> >=20
> > 	/proc/kcore:     file format elf64-x86-64
> >=20
> > 	Segmentation fault
> >=20
> > any idea? config is attached
>=20
> Just tried with a different config on 5.14.0-rc6+
>=20
> [root@localhost ~]# cat /proc/kallsyms | grep ksys_read
> ffffffff8927a800 T ksys_readahead
> ffffffff89333660 T ksys_read
>=20
> [root@localhost ~]# objdump -d --start-address=3D0xffffffff89333660
> --stop-address=3D0xffffffff89333670
>=20
> a.out:     file format elf64-x86-64
>=20
>=20
>=20
> The kern_addr_valid(start) seems to fault in your case, which is weird,
> because it merely walks the page tables. But it seems to complain about a
> non-canonical address 0xf887ffcbff000
>=20
> Can you post your QEMU cmdline? Did you test this on other kernel version=
s?

I'm using virt-manager so:

/usr/bin/qemu-system-x86_64 -name guest=3Dfedora33,debug-threads=3Don -S -o=
bject secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/doma=
in-13-fedora33/master-key.aes -machine pc-q35-5.1,accel=3Dkvm,usb=3Doff,vmp=
ort=3Doff,dump-guest-core=3Doff,memory-backend=3Dpc.ram -cpu Skylake-Server=
-IBRS,ss=3Don,vmx=3Don,pdcm=3Don,hypervisor=3Don,tsc-adjust=3Don,clflushopt=
=3Don,umip=3Don,pku=3Don,stibp=3Don,arch-capabilities=3Don,ssbd=3Don,xsaves=
=3Don,ibpb=3Don,amd-stibp=3Don,amd-ssbd=3Don,skip-l1dfl-vmentry=3Don,pschan=
ge-mc-no=3Don -m 8192 -object memory-backend-ram,id=3Dpc.ram,size=3D8589934=
592 -overcommit mem-lock=3Doff -smp 20,sockets=3D20,cores=3D1,threads=3D1 -=
uuid 2185d5a9-dbad-4d61-aa4e-97af9fd7ebca -no-user-config -nodefaults -char=
dev socket,id=3Dcharmonitor,fd=3D36,server,nowait -mon chardev=3Dcharmonito=
r,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -global kvm-p=
it.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global ICH9-LPC.disable_=
s3=3D1 -global ICH9-LPC.disable_s4=3D1 -boot strict=3Don -kernel /home/jols=
a/qemu/run/vmlinux -initrd /home/jolsa/qemu/run/initrd -append root=3D/dev/=
mapper/fedora_fedora-root ro rd.lvm.lv=3Dfedora_fedora/root console=3Dtty0 =
console=3DttyS0,115200 -device pcie-root-port,port=3D0x10,chassis=3D1,id=3D=
pci.1,bus=3Dpcie.0,multifunction=3Don,addr=3D0x2 -device pcie-root-port,por=
t=3D0x11,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,addr=3D0x2.0x1 -device pcie-ro=
ot-port,port=3D0x12,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,addr=3D0x2.0x2 -dev=
ice pcie-root-port,port=3D0x13,chassis=3D4,id=3Dpci.4,bus=3Dpcie.0,addr=3D0=
x2.0x3 -device pcie-root-port,port=3D0x14,chassis=3D5,id=3Dpci.5,bus=3Dpcie=
=2E0,addr=3D0x2.0x4 -device pcie-root-port,port=3D0x15,chassis=3D6,id=3Dpci=
=2E6,bus=3Dpcie.0,addr=3D0x2.0x5 -device pcie-root-port,port=3D0x16,chassis=
=3D7,id=3Dpci.7,bus=3Dpcie.0,addr=3D0x2.0x6 -device qemu-xhci,p2=3D15,p3=3D=
15,id=3Dusb,bus=3Dpci.2,addr=3D0x0 -device virtio-serial-pci,id=3Dvirtio-se=
rial0,bus=3Dpci.3,addr=3D0x0 -blockdev {"driver":"file","filename":"/var/li=
b/libvirt/images/fedora33.qcow2","node-name":"libvirt-2-storage","auto-read=
-only":true,"discard":"unmap"} -blockdev {"node-name":"libvirt-2-format","r=
ead-only":false,"driver":"qcow2","file":"libvirt-2-storage","backing":null}=
 -device virtio-blk-pci,bus=3Dpci.4,addr=3D0x0,drive=3Dlibvirt-2-format,id=
=3Dvirtio-disk0,bootindex=3D1 -device ide-cd,bus=3Dide.0,id=3Dsata0-0-0 -ne=
tdev tap,fd=3D38,id=3Dhostnet0,vhost=3Don,vhostfd=3D39 -device virtio-net-p=
ci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:f3:c6:e7,bus=3Dpci.1,addr=3D0=
x0 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,i=
d=3Dserial0 -chardev socket,id=3Dcharchannel0,fd=3D40,server,nowait -device=
 virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dc=
hannel0,name=3Dorg.qemu.guest_agent.0 -chardev spicevmc,id=3Dcharchannel1,n=
ame=3Dvdagent -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,chardev=
=3Dcharchannel1,id=3Dchannel1,name=3Dcom.redhat.spice.0 -device usb-tablet,=
id=3Dinput0,bus=3Dusb.0,port=3D1 -spice port=3D5900,addr=3D127.0.0.1,disabl=
e-ticketing,image-compression=3Doff,seamless-migration=3Don -device qxl-vga=
,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0,vg=
amem_mb=3D16,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1 -device ich9-intel-hda=
,id=3Dsound0,bus=3Dpcie.0,addr=3D0x1b -device hda-duplex,id=3Dsound0-codec0=
,bus=3Dsound0.0,cad=3D0 -chardev spicevmc,id=3Dcharredir0,name=3Dusbredir -=
device usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -cha=
rdev spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-redir,chardev=3Dc=
harredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virtio-balloon-pci,id=3D=
balloon0,bus=3Dpci.5,addr=3D0x0 -object rng-random,id=3Dobjrng0,filename=3D=
/dev/urandom -device virtio-rng-pci,rng=3Dobjrng0,id=3Drng0,bus=3Dpci.6,add=
r=3D0x0 -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,r=
esourcecontrol=3Ddeny -msg timestamp=3Don

so far I tested just bpf-next/master:
  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

and jsut removed my changes to make sure it wasn't me ;-)

I'll try to find a version that worked for me before


thanks,
jirka

