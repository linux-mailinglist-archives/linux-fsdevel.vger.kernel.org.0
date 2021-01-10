Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B692F0705
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Jan 2021 13:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbhAJMGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jan 2021 07:06:45 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:36451 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbhAJMGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:06:45 -0500
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jan 2021 07:06:43 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610280231;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:From:
        Subject:Sender;
        bh=suxnFiUZXehwYdxu3HHH3yerlSomJchhrhNdK2IYwzY=;
        b=lLTjhRmhEUaJ8mH9nOuSgFQofOERmvgNdgRjeCdPva6huk5KBiYlK7YoXquh0o3Hge
        ONKTz4i4i/O2Lzov5hHfvoomU27DzGBuGPGiMAgY1Ujn/LRNRugGFFYOWmKBdenicQWs
        kfJ5UigOGudgjm/QYPWkPU5sWbuEXGCmMlkZuDPVy4J6Lzy6d4SonNx1+vPhyM7uJv8O
        DvtYPSm6gGL6G0IrjJhK8Xtr8C28Pux3ZcEL+QHqIdqBWjnm7kIGv1hsFnwoEuxKfSg/
        P9Zxhdhd7hWGGZ2GMS5jglFy4Tjk955VOVghhjUO3BflKMpccWc1gdq/Otj4PvMMmIg7
        /hqA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGHPrrwDOsPyQ="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id m056b3x0ABrBL8P
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Sun, 10 Jan 2021 12:53:11 +0100 (CET)
Subject: Re: [patch V3 13/37] mips/mm/highmem: Switch to generic kmap atomic
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=iso-8859-1
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <DUUPMQ.U53A0W7YJPGM@crapouillou.net>
Date:   Sun, 10 Jan 2021 12:53:10 +0100
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        tglx@linutronix.de, airlied@linux.ie, airlied@redhat.com,
        akpm@linux-foundation.org, arnd@arndb.de, bcrl@kvack.org,
        bigeasy@linutronix.de, bristot@redhat.com, bsegall@google.com,
        bskeggs@redhat.com, chris@zankel.net, christian.koenig@amd.com,
        clm@fb.com, davem@davemloft.net, deanbo422@gmail.com,
        dietmar.eggemann@arm.com,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        dsterba@suse.com, green.hu@gmail.com, hch@lst.de,
        intel-gfx@lists.freedesktop.org, jcmvbkbc@gmail.com,
        josef@toxicpanda.com, juri.lelli@redhat.com, kraxel@redhat.com,
        linux-aio@kvack.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>, linux-mm@kvack.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
        mgorman@suse.de, mingo@kernel.org, monstr@monstr.eu,
        mpe@ellerman.id.au, nickhu@andestech.com,
        nouveau@lists.freedesktop.org, paulmck@kernel.org,
        paulus@samba.org, peterz@infradead.org, ray.huang@amd.com,
        rodrigo.vivi@intel.com, rostedt@goodmis.org,
        sparclinux@vger.kernel.org, spice-devel@lists.freedesktop.org,
        sroland@vmware.com, torvalds@linuxfoundation.org,
        vgupta@synopsys.com, vincent.guittot@linaro.org,
        viro@zeniv.linux.org.uk, virtualization@lists.linux-foundation.org,
        x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B074439-2E91-4FCF-84C8-82AE13D8C7F0@goldelico.com>
References: <JUTMMQ.NNFWKIUV7UUJ1@crapouillou.net> <20210108235805.GA17543@alpha.franken.de> <20210109003352.GA18102@alpha.franken.de> <DUUPMQ.U53A0W7YJPGM@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> Am 10.01.2021 um 12:35 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Thomas,
>=20
> Le sam. 9 janv. 2021 =E0 1:33, Thomas Bogendoerfer =
<tsbogend@alpha.franken.de> a =E9crit :
>> On Sat, Jan 09, 2021 at 12:58:05AM +0100, Thomas Bogendoerfer wrote:
>>> On Fri, Jan 08, 2021 at 08:20:43PM +0000, Paul Cercueil wrote:
>>> > Hi Thomas,
>>> >
>>> > 5.11 does not boot anymore on Ingenic SoCs, I bisected it to this =
commit.

Just for completeness, I have no such problems booting CI20/jz4780 or =
Skytone400/jz4730 (unpublished work) with 5.11-rc2.
But may depend on board capabilites (ram size, memory layout or =
something else).

>>> >
>>> > Any idea what could be happening?
>>> not yet, kernel crash log of a Malta QEMU is below.
>> update:
>> This dirty hack lets the Malta QEMU boot again:
>> diff --git a/mm/highmem.c b/mm/highmem.c
>> index c3a9ea7875ef..190cdda1149d 100644
>> --- a/mm/highmem.c
>> +++ b/mm/highmem.c
>> @@ -515,7 +515,7 @@ void *__kmap_local_pfn_prot(unsigned long pfn, =
pgprot_t prot)
>> 	vaddr =3D __fix_to_virt(FIX_KMAP_BEGIN + idx);
>> 	BUG_ON(!pte_none(*(kmap_pte - idx)));
>> 	pteval =3D pfn_pte(pfn, prot);
>> -	set_pte_at(&init_mm, vaddr, kmap_pte - idx, pteval);
>> +	set_pte(kmap_pte - idx, pteval);
>> 	arch_kmap_local_post_map(vaddr, pteval);
>> 	current->kmap_ctrl.pteval[kmap_local_idx()] =3D pteval;
>> 	preempt_enable();
>> set_pte_at() tries to update cache and could do an kmap_atomic() =
there.
>> Not sure, if this is allowed at this point.
>=20
> Yes, I can confirm that your workaround works here too.
>=20
> Cheers,
> -Paul
>=20
>=20

