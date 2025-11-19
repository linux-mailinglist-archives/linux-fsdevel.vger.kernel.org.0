Return-Path: <linux-fsdevel+bounces-69106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEB1C6F2CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 0584F2EDD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AF836654E;
	Wed, 19 Nov 2025 14:13:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF4C352FA2
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561592; cv=none; b=L8dfJ/UNGrtGdShQG4HOjsCRQ0DJNfZOoGElxaIuHj0p8OrOqw+fF45wv0G1OcOSiOQMIysID+lvhNiYtrqpCUGpTHvvTN7wcrW2EzMNT4rrZAXV9oGKdeM30feteWhPq4ZxjdxusQ35rMSHjes9SuUNRMPpn+FavpO1Ubat7hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561592; c=relaxed/simple;
	bh=heIVYGrjoLL2ncRtnNd5ncKKpVlGpPUEOL61VpZTXKw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sVAeNjdxtvFd2p7MPyIRb2cHdw4+9KGa6IFYNTTg2rJutWEZpbftvYS8H+igR/OQRhjExj/7TaX4ZSLu/7svTOSX4r/ERwLu2vMsIIN5ct6+WAM/+m6syjFFzur3xyxZrJkzKD+8OLCrilPpZIWnlDAlEH4X3scWvMwANga/Lmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4337cb921c2so72800385ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 06:13:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763561589; x=1764166389;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1vWM8OOTb/83z09YOkdp3YgbdwSOLB6124kHhIvv7I=;
        b=ZZYFkZS1kOlDdmCk8OYM6kOfi4iMv/szBk/gyaS6i6yIS4m3coSg4B49lFwYAtzPWW
         ky8KZdJzaWcPMA0cFI+20/EIu3+pLncrCzK5z++Xdr6s5otRSmq7NjOu4pgkXWNzuSiZ
         qbsu+kbx7Zz1Bw1zPZHxaYovlYJ2U3DGtPwKJXKARDOQoQ1sIO5DiCaJW2Loguu/iUGa
         a9HLDRxhuAbcSjG2XJ/W8stOCaRHxP/uuenmv5fcDhBWzQ80wIjHBD5lk/rO8ra3lbxp
         OcgbkRjPHvV3/hSnMclWpb9Zb7HE1LGX791DIH5TA7EXB4UhgOCfgs8PdNfwYqPUj6ff
         yU4A==
X-Forwarded-Encrypted: i=1; AJvYcCUPdyC19wziwNBjiimJ4Ls4ADkltsNNi57cwM28h3uQDdKF2QXbq2yVwjTAbei6YnrjTkpHxkjU0gUY16TV@vger.kernel.org
X-Gm-Message-State: AOJu0YwHTIdYZd64iqkNJrfLEGuTSuBEzIMyAz3WLR8hWCrduaYQfk3y
	jAwaj2SEIwePJmo4KBgKBcUA+Dn5FQSXy+zOrKDvJCe5gDoKXMJdb8UaI6FnPg/wYmEeZAlQvvI
	SfrOALyx58ydFSXOlsiKCrkcUTTviwoPO9kQHZ4L9iZJn9aneBW4NH17bkhk=
X-Google-Smtp-Source: AGHT+IE+6S3LA2hOwrGyU9R1hsSSj2IzfWx0GU0Nk1pGNkSm1kvXmo5ZO+6tU/lAzGmNRqOBctFqe+J3YC2qjSafGfMoKz0a8i8u
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:50e:0:b0:434:96ea:ff4d with SMTP id
 e9e14a558f8ab-43496eaffe1mr164425775ab.38.1763561588677; Wed, 19 Nov 2025
 06:13:08 -0800 (PST)
Date: Wed, 19 Nov 2025 06:13:08 -0800
In-Reply-To: <20251119-leitmotiv-freifahrt-c706880c1f0b@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691dd074.a70a0220.2ea503.001a.GAE@google.com>
Subject: Re: [syzbot] [hfs?] memory leak in hfs_init_fs_context
From: syzbot <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
To: brauner@kernel.org, frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mehdi.benhadjkhelifa@gmail.com, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

pc

SYZFAIL: failed to recv rpc
fd=3D3 want=3D4 recv=3D0 n=3D0 (errno 9: Bad file descriptor)


Warning: Permanently added '10.128.10.29' (ED25519) to the list of known ho=
sts.
2025/11/19 14:11:52 parsed 1 programs
[   42.022753][ T5811] cgroup: Unknown subsys name 'net'
[   42.175712][ T5811] cgroup: Unknown subsys name 'cpuset'
[   42.182256][ T5811] cgroup: Unknown subsys name 'rlimit'
Setting up swapspace version 1, size =3D 127995904 bytes
[   50.184013][ T5811] Adding 124996k swap on ./swap-file.  Priority:0 exte=
nts:1 across:124996k=20
[   51.419720][ T5824] soft_limit_in_bytes is deprecated and will be remove=
d. Please report your usecase to linux-mm@kvack.org if you depend on this f=
unctionality.
[   51.816926][   T58] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   51.825249][   T58] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   51.836771][   T31] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   51.844633][   T31] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   51.992800][ T5887] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   52.000051][ T5887] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   52.007203][ T5887] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   52.014500][ T5887] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   52.021816][ T5887] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   52.104921][ T5895] chnl_net:caif_netlink_parms(): no params data found
[   52.123774][ T5895] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   52.130962][ T5895] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   52.138313][ T5895] bridge_slave_0: entered allmulticast mode
[   52.144523][ T5895] bridge_slave_0: entered promiscuous mode
[   52.151904][ T5895] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   52.159070][ T5895] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   52.166257][ T5895] bridge_slave_1: entered allmulticast mode
[   52.172607][ T5895] bridge_slave_1: entered promiscuous mode
[   52.184675][ T5895] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   52.194790][ T5895] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   52.210335][ T5895] team0: Port device team_slave_0 added
[   52.216530][ T5895] team0: Port device team_slave_1 added
[   52.226332][ T5895] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   52.233294][ T5895] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   52.259593][ T5895] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   52.270857][ T5895] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   52.277950][ T5895] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   52.304091][ T5895] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   52.330778][ T5895] hsr_slave_0: entered promiscuous mode
[   52.337739][ T5895] hsr_slave_1: entered promiscuous mode
[   52.365548][ T5895] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   52.373816][ T5895] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   52.382570][ T5895] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   52.390442][ T5895] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   52.402050][ T5895] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   52.409208][ T5895] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   52.416560][ T5895] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   52.424189][ T5895] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   52.442787][ T5895] 8021q: adding VLAN 0 to HW filter on device bond0
[   52.452023][   T31] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   52.461111][   T31] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   52.470558][ T5895] 8021q: adding VLAN 0 to HW filter on device team0
[   52.479109][   T31] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   52.486350][   T31] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   52.496004][ T2979] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   52.503421][ T2979] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   52.520122][ T5895] hsr0: Slave A (hsr_slave_0) is not up; please bring =
it up to get a fully working HSR network
[   52.531213][ T5895] hsr0: Slave B (hsr_slave_1) is not up; please bring =
it up to get a fully working HSR network
[   52.567709][ T5895] 8021q: adding VLAN 0 to HW filter on device batadv0
[   52.582539][ T5895] veth0_vlan: entered promiscuous mode
[   52.589714][ T5895] veth1_vlan: entered promiscuous mode
[   52.600093][ T5895] veth0_macvtap: entered promiscuous mode
[   52.606771][ T5895] veth1_macvtap: entered promiscuous mode
[   52.615855][ T5895] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   52.625167][ T5895] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   52.634137][   T58] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   52.642907][   T58] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   52.652172][   T58] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   52.661018][   T58] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   52.696362][   T35] netdevsim netdevsim0 netdevsim3 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   52.736176][   T35] netdevsim netdevsim0 netdevsim2 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   52.776000][   T35] netdevsim netdevsim0 netdevsim1 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
2025/11/19 14:12:05 executed programs: 0
[   52.826029][   T35] netdevsim netdevsim0 netdevsim0 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   55.913007][   T35] bridge_slave_1: left allmulticast mode
[   55.924242][   T35] bridge_slave_1: left promiscuous mode
[   55.930898][   T35] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   55.939182][   T35] bridge_slave_0: left allmulticast mode
[   55.945141][   T35] bridge_slave_0: left promiscuous mode
[   55.951004][   T35] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   56.026188][   T35] bond0 (unregistering): (slave bond_slave_0): Releasi=
ng backup interface
[   56.036592][   T35] bond0 (unregistering): (slave bond_slave_1): Releasi=
ng backup interface
[   56.046139][   T35] bond0 (unregistering): Released all slaves
[   56.106597][   T35] hsr_slave_0: left promiscuous mode
[   56.112214][   T35] hsr_slave_1: left promiscuous mode
[   56.118098][   T35] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_0
[   56.126443][   T35] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[   56.133898][   T35] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_1
[   56.141694][   T35] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[   56.150927][   T35] veth1_macvtap: left promiscuous mode
[   56.157067][   T35] veth0_macvtap: left promiscuous mode
[   56.163187][   T35] veth1_vlan: left promiscuous mode
[   56.168965][   T35] veth0_vlan: left promiscuous mode
[   56.196836][   T35] team0 (unregistering): Port device team_slave_1 remo=
ved
[   56.205815][   T35] team0 (unregistering): Port device team_slave_0 remo=
ved
[   58.084150][ T5133] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   58.091289][ T5133] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   58.098477][ T5133] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   58.105739][ T5133] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   58.112872][ T5133] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   58.147089][ T5988] chnl_net:caif_netlink_parms(): no params data found
[   58.166338][ T5988] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   58.173578][ T5988] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   58.180784][ T5988] bridge_slave_0: entered allmulticast mode
[   58.187051][ T5988] bridge_slave_0: entered promiscuous mode
[   58.193583][ T5988] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   58.200740][ T5988] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   58.207833][ T5988] bridge_slave_1: entered allmulticast mode
[   58.214030][ T5988] bridge_slave_1: entered promiscuous mode
[   58.225238][ T5988] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   58.235910][ T5988] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   58.251413][ T5988] team0: Port device team_slave_0 added
[   58.257776][ T5988] team0: Port device team_slave_1 added
[   58.267463][ T5988] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   58.274482][ T5988] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   58.300974][ T5988] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   58.311990][ T5988] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   58.318969][ T5988] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   58.344994][ T5988] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   58.362193][ T5988] hsr_slave_0: entered promiscuous mode
[   58.368062][ T5988] hsr_slave_1: entered promiscuous mode
[   58.548290][ T5988] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   58.556831][ T5988] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   58.564665][ T5988] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   58.572522][ T5988] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   58.586118][ T5988] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   58.593280][ T5988] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   58.600654][ T5988] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   58.607726][ T5988] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   58.630191][ T5988] 8021q: adding VLAN 0 to HW filter on device bond0
[   58.640402][   T58] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   58.649632][   T58] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   58.659837][ T5988] 8021q: adding VLAN 0 to HW filter on device team0
[   58.669532][   T58] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   58.676712][   T58] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   58.686492][   T35] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   58.693655][   T35] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   58.709390][ T5988] hsr0: Slave A (hsr_slave_0) is not up; please bring =
it up to get a fully working HSR network
[   58.720129][ T5988] hsr0: Slave B (hsr_slave_1) is not up; please bring =
it up to get a fully working HSR network
[   58.769091][ T5988] 8021q: adding VLAN 0 to HW filter on device batadv0
[   58.787789][ T5988] veth0_vlan: entered promiscuous mode
[   58.795800][ T5988] veth1_vlan: entered promiscuous mode
[   58.808550][ T5988] veth0_macvtap: entered promiscuous mode
[   58.816434][ T5988] veth1_macvtap: entered promiscuous mode
[   58.826869][ T5988] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   58.837590][ T5988] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   58.847552][ T2979] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   58.862969][ T2979] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   58.881016][ T2979] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   58.894676][   T35] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   58.903471][   T35] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
SYZFAIL: failed to recv rpc
fd=3D3 want=3D4 recv=3D0 n=3D0 (errno 9: Bad file descriptor)
[   58.917260][   T31] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   58.925507][ T2979] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   58.934333][   T31] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
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
 -ffile-prefix-map=3D/tmp/go-build3582148735=3D/tmp/go-build -gno-record-gc=
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
/usr/bin/ld: /tmp/ccMkllK7.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D10715332580000


Tested on:

commit:         058747ce hfs: ensure sb->s_fs_info is always cleaned up
git tree:       https://github.com/brauner/linux.git work.hfs.fixes
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df30cc590c4f6da4=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dad45f827c88778ff7=
df6
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils=
 for Debian) 2.40

Note: no patches were applied.

