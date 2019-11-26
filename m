Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1276A109A12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 09:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfKZISA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 03:18:00 -0500
Received: from mout.gmx.net ([212.227.15.18]:33383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfKZISA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574756278;
        bh=TC7ge7BJdfxov8l9GULCHWpFdaCFwHqshfQRKS0nbcI=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=IXK8THSu0p831GKuA8ckUJz2mlRjqhZcyVnXRKvT35S5sQRFLYo+j5p/AcNoevuNy
         8TzJMs+BDPKDOffbHUU1cwiEOPdAooVsJZhXUquOx1eHUB2PYMUcowVK88FiIkhjYL
         5NvrFN4xtEqUcIwAP4G8odTU+TgDsfQjGOX9M2+U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEV3I-1icGvH3798-00G3yI; Tue, 26
 Nov 2019 09:17:58 +0100
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: btrfs/058 deadlock with lseek
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <3310d598-bd2f-6024-e5ac-c1c6080c0fd7@gmx.com>
Date:   Tue, 26 Nov 2019 16:17:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sEsVUbBOM8Qf4ItnyAz7IpElG9Y0qw8kx"
X-Provags-ID: V03:K1:G/HR4NIeJZxoD4akmnh3paAT2Mq1IPk2MfwU5Ux1h0ovl1HVagj
 WOGoVSNxe34RBt90UyIKH+2U/OZvkpsZAZmOhd5L7IUo/3J21DSCdDWTbYocQmP+eNXCve+
 L4bCwDeBOjNcD2E4O/S8t+yGjUa5NRYJxW1wWX9/Uy5M7XPp8Lq7/iUxNdsEeRCMxs9jO4o
 QZkstBMBwIb+G4Dyd9gVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qdk1w21MHeE=:3cd1+ldbGWUI1VAEyaShRa
 iUtxRSWCtpq1FtkahPslAbk8qLJslwBOF0jl8lBCqyw4OYMaHJLAj968/5YbUZC7xDcS65fMc
 tAl9KAOJZjxSChhTauy6qWNooC6LgfZghEIDjyCLU4Y+BPGss3LuT4ZIbHmkljObWgW2sU8qo
 ckXqZ+T4Tot6cGVLWBfGRepHWNBhh+ijIbxIHhVvui/ibG8o2R8fIBn0HGJEA7KCKtEBppyr+
 LaNvauMWU/Ae2LMqmasE2eq2epW7y7pNwaPo/WjbGLmaAIC/AGxGd2ccZa0JejjQWG7RM92+7
 wLMrCBgcgA0+5Ovr4ZBekO/nWh/MB7BdsuyZLZ1Y8p5yaZpNJJvmCkbU9r+Ro4yLL5nSgGcTV
 CVD4xBuyawU9nYwJgoIe10Y+v4cC35N7EP+7zp8H+WwO6AmDobNeZtDnj1xL7JTMMTuS08SJ6
 VVdYzYJQtfuf/KkhR3HaAQw1BL04WisS72ewsIUEGpbf8kjWG+l9BuuTlNBXm4kVd49I1aj7B
 Sjocf4w0+ul7YUQcZi8YQUs5h6xCUpPDnwqwDAQr1MFHmVx16XNgSEAQjrRURNH+2tGBR1yJS
 CC6mQA3IYLMGIzZEhZMDXGdoTbcpNP2eUZQzhLHcou6t4BhMhIlfcr32vR2cQP448DHNwsd8q
 aDEc/s1cGv+tbQJNsnudJ3etDDCnXHIZ6E+pK+903R9F/8n4nJN6VMfXp7b4Uf9Fay5HGj5Eb
 mCLswL45g0zbqGib24gme60cLB6CzexXnfke8eFFhipImDUSewvbohX7vwcnnd/ZpyB6ynyci
 FgWtUSWL3X/FAgYF1xoNpUDyBHRDU4X9B+dUsY1BP/NxR5gRU2U8sqdL64vdGO3uBc7CnwLtM
 iOz0MYbULUhRBvk1zahugZXp+WvRCJ3nsvmLQGRMsocLSbN3TnP8yTyDgRBA9LAbLZf57wxSD
 vH0z6zCxRFTpBlMJhE7gHCg9agXVXaoBx0hG9044PW5wbrUdtk/PcS/a9jEjD5PfICClLnk9a
 pjcu69vKzXaSJCWqxEapqUKjr1U4EC8+48/MMso9LYq2b68LVnSHGOv0Yl+G3jCpNz9OHV1wz
 co79jIHr/owaayz/09WoFxwTqUu3tJ4VJdMITzcWVzeQCsRuu9lBoAf93mw2Fs1a5LkXMytDn
 COELn0aCMM6Et5lB4/Qcxco/FiHojA/EuyeP5kF6xh+/Oy1SUEK34QS9Je/on2Chbhx23Rkhx
 L55Dra9oNi15MKUpmhtOfchpoc4bZccq+tHtnNA7IofESXLL9oAPj2SxsOKQ=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sEsVUbBOM8Qf4ItnyAz7IpElG9Y0qw8kx
Content-Type: multipart/mixed; boundary="LAAT9lpIZKISOtIUwz4daR6aVcb8wrasr"

--LAAT9lpIZKISOtIUwz4daR6aVcb8wrasr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi guys,

Just got a reproducible error in btrfs/058.
The backtrace is completely in VFS territory, not btrfs related lock at a=
ll:

BTRFS info (device dm-5): checking UUID tree
sysrq: Show Blocked State
  task                        PC stack   pid father
rm              D    0 560678 560445 0x00000000
Call Trace:
 __schedule+0x5c7/0xea0
 ? __sched_text_start+0x8/0x8
 ? lock_downgrade+0x380/0x380
 ? lock_contended+0x730/0x730
 ? debug_check_no_locks_held+0x60/0x60
 schedule+0x7b/0x170
 schedule_preempt_disabled+0x18/0x30
 __mutex_lock+0x481/0xc70
 ? __fdget_pos+0x7e/0x80
 ? mutex_trylock+0x190/0x190
 ? debug_lockdep_rcu_enabled+0x26/0x40
 ? kmem_cache_free+0x157/0x3b0
 ? putname+0x73/0x80
 ? __ia32_sys_rmdir+0x30/0x30
 ? __check_object_size+0x134/0x1e6
 mutex_lock_nested+0x1b/0x20
 ? mutex_lock_nested+0x1b/0x20
 __fdget_pos+0x7e/0x80
 ksys_lseek+0x1d/0xf0
 __x64_sys_lseek+0x43/0x50
 do_syscall_64+0x79/0xe0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f7518e5652b
Code: Bad RIP value.
RSP: 002b:00007ffead7508e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000008
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7518e5652b
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f7518f267e0 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000002 R14: 00007f7518f2be68 R15: 00007f7518f287e0

Is this a known bug in VFS layer?

Thanks,
Qu


--LAAT9lpIZKISOtIUwz4daR6aVcb8wrasr--

--sEsVUbBOM8Qf4ItnyAz7IpElG9Y0qw8kx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3c37EACgkQwj2R86El
/qgEDQgAgV53rVzVEAYe9dMuz/9oLJFv1dSE4/aIv7MxNDX4wsZq/CRfdgApwEmc
9MnoblynhRxAuyEHhG22ba9sBZamqudSPbcbkkMxYUjZrXO1puH/NctTRDNLN92s
L/16wZrFjpmXjMNZ2jsOalRnCLgZ2bDOt4Px2LQQWcmKc99AFmRkt75HjqkgGTak
iGizg6wEUdqQb898uEpNowgyzyWNVp8cVQgkG87sXooxsKseExqArau4PUwW/TcP
kqFbfr1weRANQ33wbZsKGTRgUo6zTU0YBH5mpYkqPYMiGuFfWm0EclooBX8MBlh9
DdhuyMY0xvJHoLJ6vkBrCoOc5HE9wQ==
=SQOM
-----END PGP SIGNATURE-----

--sEsVUbBOM8Qf4ItnyAz7IpElG9Y0qw8kx--
