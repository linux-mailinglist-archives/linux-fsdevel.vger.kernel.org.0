Return-Path: <linux-fsdevel+bounces-68525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F45BC5E42F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 17:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00ACD36613C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E95F334689;
	Fri, 14 Nov 2025 15:29:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D010A334376
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134147; cv=none; b=qbaKwv4UM/qJaWlVr3ctTW/j3LZYc4YUi5A3zKEgkJEePQnYLWSKVydDxN4hBUKfWyscNKNZIjMYskpJGoKTGlx45bwrZ4mLGReyUTjKRAbh/Cam4so4gO8CWcW7P9NrIDzHm8A0O+jqZ2khRiyVm+ZWcFwyrJ14Z03IUleu7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134147; c=relaxed/simple;
	bh=Oy71zjUUE6ITzj+TQfDiyItxkilWR0FicHKR1XrIxF8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S0ezgOwt6U7Xyp0V3/6aUTIezbzHl0d3UMAE/xl2qXKPRROqRSX6SX3D92NJOCvcDbwO+zoBQlwq5+9BZitBMvyMx1ZjysEZiU8a0MBgrbNX29HTKYZSqciUyvOW4QOT/twQwTmp7kyDxzbzHCgFL/AljUwoPLD021tnueQJ61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43373024b5eso24371365ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 07:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763134144; x=1763738944;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrBB2ffg9yKc6gkgpK9or7HheidrlQ6drebOdlx+CL0=;
        b=bqICwBrQm8H4cZNhO/yvalhk7g+54n7zncjgKDIJJqJJLsCa++BGz4WyewyKb8EHwB
         9UHIb2+7uLdsoPTyShWQH5F/Xq7RvMVktXVp0jqOZa5CRZtk7nDhn3ck1BBNyYZF8AsG
         a15MIcmhjXgAGeiyyaPp20Lm4yL9fg6MrmlwNDPn+FRwbt+U9Pj2NaXmFdJpqE+gXmea
         fbeZ+cNw7TTHMnxgFXcrSQXgp7ZVfFMAWtHDgnTzE64Xgbu+Q8QcFOECxFYP2yn+LtXR
         Vo29XpbxGa49obwxN8UPvcCk34a5VfrZlTyhte699X4yu2wywaUrbO4Dj6+OtoLQBjEv
         WsyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSqu+jQJrACab+afRcDgIJE8mx3KbIORG2vzpLtGxeN2A4n9Cho8l6+EQvw1btVfk1t1m+A0EXg0M3VUdy@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyd5OvWozcPIwMq1rReRSAkYeRpsh8VAgVUL0dYuTP8ADjltBv
	D1tmEMYpU5vDLOnC8whkScJ7sl5FtTcw2V9kN4zs1MB4SxE2SH6EnjC8f2yULS0cbFnMooZ5esF
	Gt7rlAz+5TA1BQ2fA9WnbzIRW2rd+K6zHHj7KlJq87ehK9z6rWic+MwxLQmU=
X-Google-Smtp-Source: AGHT+IFnr48mgB5pYyPM/953EcN/htKgU0MTxKHZ+8TTDgOinWkH5Glta+o1ZrPCl+RoUBZfYKR8msrxeb72kzsIt0mrPVtlXBhW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0f:b0:434:96ea:ff74 with SMTP id
 e9e14a558f8ab-43496eb0258mr3089575ab.36.1763134143980; Fri, 14 Nov 2025
 07:29:03 -0800 (PST)
Date: Fri, 14 Nov 2025 07:29:03 -0800
In-Reply-To: <20251114160222.469860-1-mehdi.benhadjkhelifa@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69174abf.a70a0220.3124cb.0061.GAE@google.com>
Subject: Re: [syzbot] [hfs?] memory leak in hfs_init_fs_context
From: syzbot <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mehdi.benhadjkhelifa@gmail.com, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

SYZFAIL: failed to recv rpc

SYZFAIL: failed to recv rpc
fd=3D3 want=3D4 recv=3D0 n=3D0 (errno 9: Bad file descriptor)


Warning: Permanently added '10.128.1.80' (ED25519) to the list of known hos=
ts.
2025/11/14 15:28:16 parsed 1 programs
[   40.296558][ T5813] cgroup: Unknown subsys name 'net'
[   40.388732][ T5813] cgroup: Unknown subsys name 'cpuset'
[   40.395379][ T5813] cgroup: Unknown subsys name 'rlimit'
Setting up swapspace version 1, size =3D 127995904 bytes
[   48.529645][ T5813] Adding 124996k swap on ./swap-file.  Priority:0 exte=
nts:1 across:124996k=20
[   49.725319][ T5826] soft_limit_in_bytes is deprecated and will be remove=
d. Please report your usecase to linux-mm@kvack.org if you depend on this f=
unctionality.
[   50.124830][ T5874] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   50.132081][ T5874] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   50.139390][ T5874] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   50.146668][ T5874] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   50.153951][ T5874] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   50.211546][ T5881] chnl_net:caif_netlink_parms(): no params data found
[   50.232138][ T5881] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   50.239234][ T5881] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   50.246331][ T5881] bridge_slave_0: entered allmulticast mode
[   50.252736][ T5881] bridge_slave_0: entered promiscuous mode
[   50.259377][ T5881] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   50.266469][ T5881] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   50.273698][ T5881] bridge_slave_1: entered allmulticast mode
[   50.279872][ T5881] bridge_slave_1: entered promiscuous mode
[   50.291361][ T5881] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   50.301121][ T5881] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   50.314859][ T5881] team0: Port device team_slave_0 added
[   50.321138][ T5881] team0: Port device team_slave_1 added
[   50.337350][ T5881] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   50.344455][ T5881] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   50.370408][ T5881] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   50.381546][ T5881] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   50.388602][ T5881] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   50.414701][ T5881] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   50.432432][ T5881] hsr_slave_0: entered promiscuous mode
[   50.438187][ T5881] hsr_slave_1: entered promiscuous mode
[   50.464974][ T5881] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   50.472557][ T5881] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   50.480523][ T5881] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   50.488191][ T5881] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   50.501383][ T5881] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   50.508462][ T5881] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   50.515715][ T5881] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   50.522863][ T5881] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   50.540612][ T5881] 8021q: adding VLAN 0 to HW filter on device bond0
[   50.549623][   T31] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   50.557084][   T31] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   50.566000][ T5881] 8021q: adding VLAN 0 to HW filter on device team0
[   50.574224][   T74] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   50.581282][   T74] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   50.589909][   T31] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   50.596984][   T31] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   50.635045][ T5881] 8021q: adding VLAN 0 to HW filter on device batadv0
[   50.648984][ T5881] veth0_vlan: entered promiscuous mode
[   50.655799][ T5881] veth1_vlan: entered promiscuous mode
[   50.666178][ T5881] veth0_macvtap: entered promiscuous mode
[   50.672895][ T5881] veth1_macvtap: entered promiscuous mode
[   50.681496][ T5881] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   50.690818][ T5881] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   50.699598][   T74] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.708503][   T74] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.717969][   T74] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.727859][   T31] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.770674][   T31] netdevsim netdevsim0 netdevsim3 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   50.781957][  T989] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   50.790035][  T989] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   50.800571][   T12] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   50.808621][   T12] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   50.816550][   T31] netdevsim netdevsim0 netdevsim2 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   50.869426][   T31] netdevsim netdevsim0 netdevsim1 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   50.899153][   T31] netdevsim netdevsim0 netdevsim0 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
2025/11/14 15:28:29 executed programs: 0
[   53.832316][   T31] bridge_slave_1: left allmulticast mode
[   53.838115][   T31] bridge_slave_1: left promiscuous mode
[   53.843745][   T31] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   53.851578][   T31] bridge_slave_0: left allmulticast mode
[   53.857222][   T31] bridge_slave_0: left promiscuous mode
[   53.862866][   T31] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   53.918713][   T31] bond0 (unregistering): (slave bond_slave_0): Releasi=
ng backup interface
[   53.927986][   T31] bond0 (unregistering): (slave bond_slave_1): Releasi=
ng backup interface
[   53.936965][   T31] bond0 (unregistering): Released all slaves
[   53.989491][   T31] hsr_slave_0: left promiscuous mode
[   53.995049][   T31] hsr_slave_1: left promiscuous mode
[   54.000970][   T31] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_0
[   54.008418][   T31] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[   54.015806][   T31] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_1
[   54.023374][   T31] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[   54.031704][   T31] veth1_macvtap: left promiscuous mode
[   54.037164][   T31] veth0_macvtap: left promiscuous mode
[   54.042886][   T31] veth1_vlan: left promiscuous mode
[   54.048139][   T31] veth0_vlan: left promiscuous mode
[   54.071579][   T31] team0 (unregistering): Port device team_slave_1 remo=
ved
[   54.079731][   T31] team0 (unregistering): Port device team_slave_0 remo=
ved
[   56.471062][ T5135] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   56.478199][ T5135] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   56.485237][ T5135] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   56.492501][ T5135] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   56.499741][ T5135] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   56.533269][ T5987] chnl_net:caif_netlink_parms(): no params data found
[   56.551048][ T5987] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   56.558200][ T5987] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   56.565306][ T5987] bridge_slave_0: entered allmulticast mode
[   56.571616][ T5987] bridge_slave_0: entered promiscuous mode
[   56.578339][ T5987] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   56.585394][ T5987] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   56.592725][ T5987] bridge_slave_1: entered allmulticast mode
[   56.599055][ T5987] bridge_slave_1: entered promiscuous mode
[   56.609383][ T5987] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   56.619214][ T5987] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   56.633179][ T5987] team0: Port device team_slave_0 added
[   56.639450][ T5987] team0: Port device team_slave_1 added
[   56.649461][ T5987] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   56.656391][ T5987] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   56.682534][ T5987] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   56.693636][ T5987] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   56.700652][ T5987] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   56.726541][ T5987] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   56.742791][ T5987] hsr_slave_0: entered promiscuous mode
[   56.748575][ T5987] hsr_slave_1: entered promiscuous mode
[   56.899621][ T5987] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   56.907406][ T5987] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   56.916005][ T5987] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   56.923914][ T5987] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   56.936978][ T5987] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   56.944085][ T5987] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   56.951366][ T5987] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   56.958429][ T5987] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   56.978679][ T5987] 8021q: adding VLAN 0 to HW filter on device bond0
[   56.988116][   T31] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   56.995621][   T31] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   57.009787][ T5987] 8021q: adding VLAN 0 to HW filter on device team0
[   57.019929][   T31] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   57.026986][   T31] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   57.035013][   T31] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   57.042090][   T31] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   57.091660][ T5987] 8021q: adding VLAN 0 to HW filter on device batadv0
[   57.108045][ T5987] veth0_vlan: entered promiscuous mode
[   57.115202][ T5987] veth1_vlan: entered promiscuous mode
[   57.128314][ T5987] veth0_macvtap: entered promiscuous mode
[   57.135072][ T5987] veth1_macvtap: entered promiscuous mode
[   57.144855][ T5987] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   57.153327][ T5987] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   57.163642][   T74] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   57.175835][   T74] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   57.187129][   T74] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   57.200636][   T74] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   57.217417][   T12] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   57.227482][   T12] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   57.228996][   T74] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
SYZFAIL: failed to recv rpc
fd=3D3 want=3D4 recv=3D0 n=3D0 (errno 9: Bad file descriptor)
[   57.243335][   T74] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50


syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build3285272391=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.24.4'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at 4e1406b4d
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3D4e1406b4defac0e2a9d9424c70706f79a7750cf3 -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20251106-151142"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3D4e1406b4defac0e2a9d9424c70706f79a7750cf3 -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20251106-151142"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D4e1406b4defac0e2a9d9424c70706f79a7750cf3 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20251106-151142"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"4e1406b4defac0e2a9d9424c70706f79a7=
750cf3\"
/usr/bin/ld: /tmp/ccvacM34.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null



Tested on:

commit:         6da43bbe Merge tag 'vfio-v6.18-rc6' of https://github...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcb128cd5cb43980=
9
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dad45f827c88778ff7=
df6
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils=
 for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D140237cd9800=
00


