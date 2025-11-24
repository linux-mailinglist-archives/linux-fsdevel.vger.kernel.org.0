Return-Path: <linux-fsdevel+bounces-69619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD50C7EF5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 05:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7C9B3461D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 04:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84045258CE2;
	Mon, 24 Nov 2025 04:47:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1342C1F5EA
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 04:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763959627; cv=none; b=PHceJqcwBWnq/tnzHZgJQKhsSRn72t3ILt6n1S2iIkZ4xq2tUn5oJthz8XM+6OVWNC0ZpxRE02vDgZX4vgtTWLWBaxOnEdQz6zOrrzpyrcjJpMNPPqSh2bungJ0xBR5RWsnybiXE8sYU/se9F4WxwWCJkT+aib5pOwvRcxAfN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763959627; c=relaxed/simple;
	bh=4wjNSIYQKGE6napFK/eQ1JQi2oQ9ctPeaoSUdAbCHrw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X1aUX2vqVIk1oAyNMKTBg4rJHubmGAO/nXqsH8EC9EHIF11hm3qJh7dX9/YZEQ9XmF9HQir2pdRrB1q3RiVPQvV///SeIxBautD7Jg1AVbnV3S7UdxAfSJiV6dXYzjN4AXxufPCAMSZFp5NdmE6hpff6y+zMNTcd62h8ToDrO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43377f5ae6fso41026655ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 20:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763959624; x=1764564424;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cs59P8/cdoggRKwnXmfBLVoK/sziU47MqaItDW9kGp0=;
        b=QI4Z0lHqLPjdi7LvfSHpexgqTIexXCATAQodQZ6pMTcb3be2OLhhFIVpWmqIYtjB5s
         9l9bNe94msx/j3atcWOw3l/Nqm18YsFPvRQD+7KBaRHhqjZvPEddnthLmeBbyWlmYZiA
         5IWr+GgHq0Ro/8oo5+pRCV07NbMXmtA+KUU5YITklve/Ps1Go3LXa3+GSUhdXRpbRWNq
         akNNrmbPZzybpPv2LTonG0k+PifrsDSlGaWnrcEsOEVgRiPuWP7XrSEo1D4VdXCxqe48
         mz/VcuElzw9HXPUM+lI9ZY7ZpVmcIBVzEFaVgXp1jADkM1e/lOkiXQoBfIkavCe7ZPDh
         +xBA==
X-Forwarded-Encrypted: i=1; AJvYcCXCveyR9KfM3Xnx9tafuKX2OsufCWnBXnTm7oX0RNk3YucViDOu16RaI4D0WZhwed8BB1mx6V72ZTnVt1NK@vger.kernel.org
X-Gm-Message-State: AOJu0YwDNn2AWP9eXmaLLpd5DJDwqd5bMNz0gjoybYbmPxHiAqGWnLHQ
	FNfNz9Gse/d1PWVeLWB7op5EYWzV8JHnsbU3zOMeUB0vVJRcdUCSoaUrR4d6hNHP0YlPW9FzOF3
	2UtSibIkik6YttOmNqsfpOENo9M8RteOlNoOr7FdprJaqw5bo9GZbUWKjjLM=
X-Google-Smtp-Source: AGHT+IEcq3sLXE6UXli5y4+LI9UPBBu34Td0SxvUqZLLWsVXjoxbyxmVlxiG/YuBeMlB5dTi2gdFFfsJeumHHzliAPywz3rc+Hnb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fec:b0:434:a86a:f16b with SMTP id
 e9e14a558f8ab-435b98c5ff3mr79249825ab.22.1763959624117; Sun, 23 Nov 2025
 20:47:04 -0800 (PST)
Date: Sun, 23 Nov 2025 20:47:04 -0800
In-Reply-To: <qmudwtflrp63e6wfosnpmgwelcweam55mmqy6whdc5jmckexfz@znsb3w2fvhji>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6923e348.a70a0220.d98e3.0078.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
From: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
To: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, mjguzik@gmail.com, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

SYZFAIL: failed to recv rpc

SYZFAIL: failed to recv rpc
fd=3D3 want=3D4 recv=3D0 n=3D0 (errno 9: Bad file descriptor)


Warning: Permanently added '10.128.1.240' (ED25519) to the list of known ho=
sts.
2025/11/24 04:46:07 parsed 1 programs
[   90.555532][ T5834] cgroup: Unknown subsys name 'net'
[   90.669357][ T5834] cgroup: Unknown subsys name 'cpuset'
[   90.678428][ T5834] cgroup: Unknown subsys name 'rlimit'
Setting up swapspace version 1, size =3D 127995904 bytes
[   92.016508][   T10] cfg80211: failed to load regulatory.db
[   92.473167][ T5834] Adding 124996k swap on ./swap-file.  Priority:0 exte=
nts:1 across:124996k=20
[   95.487085][ T5846] soft_limit_in_bytes is deprecated and will be remove=
d. Please report your usecase to linux-mm@kvack.org if you depend on this f=
unctionality.
[   96.148644][ T5858] chnl_net:caif_netlink_parms(): no params data found
[   96.250234][ T5858] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   96.258110][ T5858] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   96.265979][ T5858] bridge_slave_0: entered allmulticast mode
[   96.273344][ T5858] bridge_slave_0: entered promiscuous mode
[   96.283227][ T5858] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   96.290745][ T5858] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   96.298585][ T5858] bridge_slave_1: entered allmulticast mode
[   96.306164][ T5858] bridge_slave_1: entered promiscuous mode
[   96.340272][ T5858] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   96.353486][ T5858] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   96.386615][ T5858] team0: Port device team_slave_0 added
[   96.394597][ T5858] team0: Port device team_slave_1 added
[   96.423182][ T5858] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   96.430950][ T5858] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   96.457421][ T5858] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   96.470037][ T5858] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   96.477137][ T5858] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   96.503196][ T5858] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   96.549258][ T5858] hsr_slave_0: entered promiscuous mode
[   96.556089][ T5858] hsr_slave_1: entered promiscuous mode
[   96.709149][ T5858] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   96.721617][ T5858] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   96.733093][ T5858] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   96.744474][ T5858] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   96.779618][ T5858] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   96.786970][ T5858] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   96.794851][ T5858] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   96.802116][ T5858] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   96.863750][ T5858] 8021q: adding VLAN 0 to HW filter on device bond0
[   96.883749][   T12] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   96.893131][   T12] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   96.915600][ T5858] 8021q: adding VLAN 0 to HW filter on device team0
[   96.931688][ T3534] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   96.938987][ T3534] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   96.952476][   T12] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   96.959687][   T12] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   97.144886][ T5858] 8021q: adding VLAN 0 to HW filter on device batadv0
[   97.200647][ T5858] veth0_vlan: entered promiscuous mode
[   97.212659][ T5858] veth1_vlan: entered promiscuous mode
[   97.247394][ T5858] veth0_macvtap: entered promiscuous mode
[   97.257672][ T5858] veth1_macvtap: entered promiscuous mode
[   97.279295][ T5858] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   97.293604][ T5858] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   97.311084][   T36] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   97.321470][   T36] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   97.333512][   T36] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   97.343962][   T36] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   97.489573][   T36] netdevsim netdevsim0 netdevsim3 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   97.557912][   T36] netdevsim netdevsim0 netdevsim2 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   97.656263][   T36] netdevsim netdevsim0 netdevsim1 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   97.752469][   T36] netdevsim netdevsim0 netdevsim0 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   98.236218][ T5896] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   98.244431][ T5896] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   98.253946][ T5896] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   98.264492][ T5896] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   98.272338][ T5896] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   99.530883][ T4188] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   99.539839][ T4188] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   99.571626][ T3534] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   99.579614][ T3534] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[  100.426458][   T36] bridge_slave_1: left allmulticast mode
[  100.447450][   T36] bridge_slave_1: left promiscuous mode
[  100.454127][   T36] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[  100.480752][   T36] bridge_slave_0: left allmulticast mode
[  100.490779][   T36] bridge_slave_0: left promiscuous mode
[  100.505305][   T36] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
2025/11/24 04:46:20 executed programs: 0
[  100.676852][ T5896] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[  100.686417][ T5896] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[  100.696621][ T5896] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[  100.710027][ T5896] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[  100.729116][ T5896] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[  101.000183][   T36] bond0 (unregistering): (slave bond_slave_0): Releasi=
ng backup interface
[  101.015387][   T36] bond0 (unregistering): (slave bond_slave_1): Releasi=
ng backup interface
[  101.029740][   T36] bond0 (unregistering): Released all slaves
[  101.191106][   T36] hsr_slave_0: left promiscuous mode
[  101.198191][   T36] hsr_slave_1: left promiscuous mode
[  101.204127][   T36] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_0
[  101.212520][   T36] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[  101.221975][   T36] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_1
[  101.229631][   T36] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[  101.245879][   T36] veth1_macvtap: left promiscuous mode
[  101.251698][   T36] veth0_macvtap: left promiscuous mode
[  101.258200][   T36] veth1_vlan: left promiscuous mode
[  101.263553][   T36] veth0_vlan: left promiscuous mode
[  101.580646][   T36] team0 (unregistering): Port device team_slave_1 remo=
ved
[  101.610626][   T36] team0 (unregistering): Port device team_slave_0 remo=
ved
[  102.143766][ T5949] chnl_net:caif_netlink_parms(): no params data found
[  102.560717][ T5949] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[  102.575166][ T5949] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[  102.582540][ T5949] bridge_slave_0: entered allmulticast mode
[  102.591585][ T5949] bridge_slave_0: entered promiscuous mode
[  102.614286][ T5949] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[  102.621909][ T5949] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[  102.629681][ T5949] bridge_slave_1: entered allmulticast mode
[  102.638831][ T5949] bridge_slave_1: entered promiscuous mode
[  102.698198][ T5949] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[  102.711869][ T5949] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[  102.815644][ T5149] Bluetooth: hci0: command tx timeout
[  103.123913][ T5949] team0: Port device team_slave_0 added
[  103.139960][ T5949] team0: Port device team_slave_1 added
[  103.229026][ T5949] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[  103.239890][ T5949] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[  103.266203][ T5949] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[  103.297209][ T5949] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[  103.304455][ T5949] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[  103.331586][ T5949] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[  103.553894][ T5949] hsr_slave_0: entered promiscuous mode
[  103.584330][ T5949] hsr_slave_1: entered promiscuous mode
[  104.403096][ T5949] netdevsim netdevsim0 netdevsim0: renamed from eth0
[  104.420683][ T5949] netdevsim netdevsim0 netdevsim1: renamed from eth1
[  104.435325][ T5949] netdevsim netdevsim0 netdevsim2: renamed from eth2
[  104.449213][ T5949] netdevsim netdevsim0 netdevsim3: renamed from eth3
[  104.617044][ T5949] 8021q: adding VLAN 0 to HW filter on device bond0
[  104.649084][ T5949] 8021q: adding VLAN 0 to HW filter on device team0
[  104.669296][ T3534] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[  104.676566][ T3534] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[  104.700338][ T3534] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[  104.707610][ T3534] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[  104.896202][ T5149] Bluetooth: hci0: command tx timeout
[  105.029734][ T5949] 8021q: adding VLAN 0 to HW filter on device batadv0
[  105.112846][ T5949] veth0_vlan: entered promiscuous mode
[  105.132429][ T5949] veth1_vlan: entered promiscuous mode
[  105.181476][ T5949] veth0_macvtap: entered promiscuous mode
[  105.200419][ T5949] veth1_macvtap: entered promiscuous mode
[  105.228009][ T5949] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[  105.248759][ T5949] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[  105.270101][ T3534] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[  105.283869][ T3534] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[  105.294419][ T3534] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[  105.317774][ T3534] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[  105.417418][   T36] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[  105.434266][   T36] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[  105.481687][ T3534] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[  105.490831][ T3534] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
SYZFAIL: failed to recv rpc
fd=3D3 want=3D4 recv=3D0 n=3D0 (errno 9: Bad file descriptor)


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
 -ffile-prefix-map=3D/tmp/go-build3558344338=3D/tmp/go-build -gno-record-gc=
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
HEAD detached at 26ee52375
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3D26ee5237507419c1fa5dea5b2a84a0b7dcce9307 -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20251119-085940"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3D26ee5237507419c1fa5dea5b2a84a0b7dcce9307 -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20251119-085940"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D26ee5237507419c1fa5dea5b2a84a0b7dcce9307 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20251119-085940"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"26ee5237507419c1fa5dea5b2a84a0b7dc=
ce9307\"
/usr/bin/ld: /tmp/cchUMbrN.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null



Tested on:

commit:         d724c6f8 Add linux-next specific files for 20251121
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D68d11c703cf8e4a=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3D2fefb910d2c20c069=
8d8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D118836125800=
00


