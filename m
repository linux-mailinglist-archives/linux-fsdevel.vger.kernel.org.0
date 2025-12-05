Return-Path: <linux-fsdevel+bounces-70907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42515CA9120
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 20:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8743A31EFBAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 19:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078034DCCF;
	Fri,  5 Dec 2025 19:06:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5934C9AE
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764961570; cv=none; b=iNTt/dEYS3xF+hDIswdPCaWdgH9jQyYWldTfH6kIhkXXEBwP9B1DVpALUzghPFdsoIeqv2jLNy2iTNQGK87D1d/EDG37AhKihZhcpWSaNhaSOfkaU1LRNibW2zkNDPqFsumGrd3ZA5Ii1FOV3ZzZLIFGeuLuXw+/tUhcSwbJP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764961570; c=relaxed/simple;
	bh=PO155ba4a20qVQX2XY849ECBEW/Z8ek4upl4fGENsxg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RhqscjTbo8xMeR3dWEJAir2BglvrzYBlEktDh4m0YmSbmkLuGEg/8+I1NKY/XA380nT1aDfYoEesmOoCi5WetU97AjE6ULrzYOVpSwCLcdsmm6xBjRNhtDI3r/LOce1KE4L+18Xx4tXvm0u+6ol/QBSgMFNr6kXjG/LkxrXiJ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7c754daf77fso5419679a34.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 11:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764961563; x=1765566363;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNXncR0jOGlh7BUJG35tpCD5YhIVNSyub9h+ojnCadM=;
        b=pKBjV9DTKdMaMjyx2viL3N2OQFhYHFSK7W3j3KqbkNRFvQe2XIXPYnauEwGrGhIzG4
         2m069wCVgZHjViSKkjSsC9MABwvlleWhX+c8AL5Aiy74qRMuqPoTdw1/+uKVKUzVTKDg
         YZsC0T2B7P53V+5fNGUu3se9THS1xrISoFMOHqRUUHpndaRok1wIt6TRlwTO9rLc1s86
         CI++KslWe6zKPSdaYDYjoon+mD46RZ6/XKGU75Tddd/bl3MWMiXIz4FhlshHxomRuv66
         QCcVSYEyrGUbzEi/DJLv2h67Lo2DORVcF/qoffbIY7uUUUViU414474QXu3WDIbcy7ea
         cXnA==
X-Forwarded-Encrypted: i=1; AJvYcCWFB78pSF8KxciG0eaaixYZDRwSwjcF7I3s6C8G1nqRk6E8+rEd7kPOEMgrq6iV9C/oQ5pfzmV1YpWW75EG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1uVESiWFoCuXQsqH7MjSoDa4M5w06GSMI6YmU9yZkEyCVMO8g
	flaKWWdPD1mZSPkWpwOvUS5zYqr74a9DGSwY2gRTvVVWM+g49jtqnbO/VVNUk4J7i4HyI0kOjGr
	WXROiqfx1CLxRaJBKnSX5LhMJQnVkvdjBpDtrTxoQIIXjaiZ7F/MR9m+EFLA=
X-Google-Smtp-Source: AGHT+IEnsvjuuFRgKaEmwHv4/1nGPez3fgTZ8H/0ICECHgmId/zpwV3/PLwYsk6GuCnbAkaFXlsQYrbwcdzRSWXWpu1XZxiRLl8/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4718:b0:659:9a49:8e18 with SMTP id
 006d021491bc7-6599a499b68mr163043eaf.10.1764961563626; Fri, 05 Dec 2025
 11:06:03 -0800 (PST)
Date: Fri, 05 Dec 2025 11:06:03 -0800
In-Reply-To: <20251206000902.71178-1-swarajgaikwad1925@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69332d1b.a70a0220.38f243.0008.GAE@google.com>
Subject: Re: [syzbot] [hfs?] memory leak in hfsplus_init_fs_context
From: syzbot <syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com>
To: david.hunter.linux@gmail.com, frank.li@vivo.com, 
	glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, slava@dubeyko.com, 
	swarajgaikwad1925@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

SYZFAIL: failed to recv rpc

SYZFAIL: failed to recv rpc
fd=3D3 want=3D4 recv=3D0 n=3D0 (errno 9: Bad file descriptor)


Warning: Permanently added '10.128.0.245' (ED25519) to the list of known ho=
sts.
2025/12/05 19:05:15 parsed 1 programs
[   55.119214][ T5818] cgroup: Unknown subsys name 'net'
[   55.259974][ T5818] cgroup: Unknown subsys name 'cpuset'
[   55.266582][ T5818] cgroup: Unknown subsys name 'rlimit'
Setting up swapspace version 1, size =3D 127995904 bytes
[   63.696572][ T5818] Adding 124996k swap on ./swap-file.  Priority:0 exte=
nts:1 across:124996k=20
[   65.016628][ T5828] soft_limit_in_bytes is deprecated and will be remove=
d. Please report your usecase to linux-mm@kvack.org if you depend on this f=
unctionality.
[   65.422993][ T5880] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   65.430458][ T5880] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   65.437558][ T5880] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   65.445167][ T5880] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   65.452744][ T5880] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   65.561974][ T5890] chnl_net:caif_netlink_parms(): no params data found
[   65.584453][ T5890] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   65.591882][ T5890] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   65.599824][ T5890] bridge_slave_0: entered allmulticast mode
[   65.606225][ T5890] bridge_slave_0: entered promiscuous mode
[   65.612881][ T5890] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   65.619978][ T5890] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   65.627492][ T5890] bridge_slave_1: entered allmulticast mode
[   65.634027][ T5890] bridge_slave_1: entered promiscuous mode
[   65.645743][ T5890] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   65.655760][ T5890] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   65.669914][ T5890] team0: Port device team_slave_0 added
[   65.676301][ T5890] team0: Port device team_slave_1 added
[   65.686571][ T5890] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   65.693917][ T5890] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   65.720230][ T5890] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   65.731988][ T5890] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   65.739356][ T5890] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   65.766444][ T5890] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   65.787487][ T5890] hsr_slave_0: entered promiscuous mode
[   65.793267][ T5890] hsr_slave_1: entered promiscuous mode
[   65.822570][ T5890] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   65.830459][ T5890] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   65.838351][ T5890] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   65.846563][ T5890] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   65.860377][ T5890] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   65.867973][ T5890] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   65.875564][ T5890] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   65.882626][ T5890] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   65.899327][ T5890] 8021q: adding VLAN 0 to HW filter on device bond0
[   65.908810][   T65] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   65.916368][   T65] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   65.926332][ T5890] 8021q: adding VLAN 0 to HW filter on device team0
[   65.935247][   T55] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   65.942415][   T55] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   65.952498][   T55] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   65.959571][   T55] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   66.001572][ T5890] 8021q: adding VLAN 0 to HW filter on device batadv0
[   66.016258][ T5890] veth0_vlan: entered promiscuous mode
[   66.023938][ T5890] veth1_vlan: entered promiscuous mode
[   66.035919][ T5890] veth0_macvtap: entered promiscuous mode
[   66.043178][ T5890] veth1_macvtap: entered promiscuous mode
[   66.052173][ T5890] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   66.061801][ T5890] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   66.071356][   T55] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   66.081780][   T55] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   66.091070][   T55] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   66.100260][   T55] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   66.142913][   T55] netdevsim netdevsim0 netdevsim3 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   66.164181][   T31] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   66.172643][   T31] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   66.182052][   T55] netdevsim netdevsim0 netdevsim2 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   66.195368][   T31] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   66.203729][   T31] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   66.230379][   T55] netdevsim netdevsim0 netdevsim1 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   66.280211][   T55] netdevsim netdevsim0 netdevsim0 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
2025/12/05 19:05:28 executed programs: 0
[   69.506006][   T55] bridge_slave_1: left allmulticast mode
[   69.511800][   T55] bridge_slave_1: left promiscuous mode
[   69.517491][   T55] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   69.525504][   T55] bridge_slave_0: left allmulticast mode
[   69.531369][   T55] bridge_slave_0: left promiscuous mode
[   69.537068][   T55] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   69.601288][   T55] bond0 (unregistering): (slave bond_slave_0): Releasi=
ng backup interface
[   69.611079][   T55] bond0 (unregistering): (slave bond_slave_1): Releasi=
ng backup interface
[   69.620253][   T55] bond0 (unregistering): Released all slaves
[   69.670943][   T55] hsr_slave_0: left promiscuous mode
[   69.676955][   T55] hsr_slave_1: left promiscuous mode
[   69.682958][   T55] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_0
[   69.691003][   T55] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[   69.698476][   T55] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_1
[   69.706532][   T55] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[   69.715577][   T55] veth1_macvtap: left promiscuous mode
[   69.721203][   T55] veth0_macvtap: left promiscuous mode
[   69.726728][   T55] veth1_vlan: left promiscuous mode
[   69.732096][   T55] veth0_vlan: left promiscuous mode
[   69.757386][   T55] team0 (unregistering): Port device team_slave_1 remo=
ved
[   69.766234][   T55] team0 (unregistering): Port device team_slave_0 remo=
ved
[   70.169404][ T1309] ieee802154 phy0 wpan0: encryption failed: -22
[   70.175683][ T1309] ieee802154 phy1 wpan1: encryption failed: -22
[   72.047051][ T5134] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   72.054869][ T5134] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   72.062046][ T5134] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   72.070042][ T5134] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   72.077520][ T5134] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   72.113196][ T5989] chnl_net:caif_netlink_parms(): no params data found
[   72.132758][ T5989] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   72.140022][ T5989] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   72.147223][ T5989] bridge_slave_0: entered allmulticast mode
[   72.153712][ T5989] bridge_slave_0: entered promiscuous mode
[   72.160489][ T5989] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   72.167745][ T5989] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   72.174993][ T5989] bridge_slave_1: entered allmulticast mode
[   72.181245][ T5989] bridge_slave_1: entered promiscuous mode
[   72.192621][ T5989] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   72.202629][ T5989] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   72.217391][ T5989] team0: Port device team_slave_0 added
[   72.224120][ T5989] team0: Port device team_slave_1 added
[   72.234181][ T5989] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   72.241867][ T5989] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   72.268532][ T5989] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   72.280051][ T5989] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   72.287416][ T5989] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   72.314180][ T5989] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   72.331466][ T5989] hsr_slave_0: entered promiscuous mode
[   72.337615][ T5989] hsr_slave_1: entered promiscuous mode
[   72.513584][ T5989] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   72.521437][ T5989] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   72.529452][ T5989] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   72.537435][ T5989] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   72.551368][ T5989] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   72.558478][ T5989] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   72.565936][ T5989] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   72.573710][ T5989] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   72.596776][ T5989] 8021q: adding VLAN 0 to HW filter on device bond0
[   72.606884][   T31] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   72.615077][   T31] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   72.625976][ T5989] 8021q: adding VLAN 0 to HW filter on device team0
[   72.634865][   T31] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   72.642139][   T31] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   72.660348][   T31] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   72.667635][   T31] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   72.717525][ T5989] 8021q: adding VLAN 0 to HW filter on device batadv0
[   72.736386][ T5989] veth0_vlan: entered promiscuous mode
[   72.743922][ T5989] veth1_vlan: entered promiscuous mode
[   72.757219][ T5989] veth0_macvtap: entered promiscuous mode
[   72.764388][ T5989] veth1_macvtap: entered promiscuous mode
[   72.774941][ T5989] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   72.784711][ T5989] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   72.794630][   T35] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   72.807307][   T35] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   72.816371][  T723] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   72.828572][  T723] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   72.847366][   T35] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   72.856762][   T35] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
SYZFAIL: failed to recv rpc
fd=3D3 want=3D4 recv=3D0 n=3D0 (errno 9: Bad file descriptor)
[   72.870318][  T723] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   72.878614][  T723] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
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
 -ffile-prefix-map=3D/tmp/go-build1479309889=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
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
HEAD detached at d6526ea3e
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3Dd6526ea3e6ad9081c902859bbb80f9f840377cb4 -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20251126-113115"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3Dd6526ea3e6ad9081c902859bbb80f9f840377cb4 -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20251126-113115"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dd6526ea3e6ad9081c902859bbb80f9f840377cb4 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20251126-113115"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"d6526ea3e6ad9081c902859bbb80f9f840=
377cb4\"
/usr/bin/ld: /tmp/ccXWETje.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null



Tested on:

commit:         e69c7c17 Merge tag 'timers_urgent_for_v6.18_rc8' of gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df30cc590c4f6da4=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3D99f6ed51479b86ac4=
c41
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils=
 for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D14477cc25800=
00


