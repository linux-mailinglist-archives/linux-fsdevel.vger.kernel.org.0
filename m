Return-Path: <linux-fsdevel+bounces-68418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A0CC5B4DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 05:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B61464E6EE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 04:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9442882A6;
	Fri, 14 Nov 2025 04:26:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE022874E1
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763094364; cv=none; b=XwMI50oGrNKWOriBaKhkPVhTheI3zLODou9vNKVm6HaTKlqLovKbwG7OzGVDTtqTGD+fLhZgNn7+xHsgAhI4WZOqn9Q8V9lcZE5tPwSOvPB4Jgq1AujLj2aK7jhkp0Cr5vyykaHIUVV1th0Rkrcfnti7/fRU1d75w8Hky8yqtUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763094364; c=relaxed/simple;
	bh=Ng/eM1PgTPVPOoKksj6f7kVTM4catSxk5MXlwNVmak8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PIhfdx6M2bpbTPU8Ehn5VlIz1o+UCBro/yJ2CV3J3S4PVf8EnsVOs243KQGMguQMdNk4AhxcdphcHnNJVx4arvvFmQSsVASJ3NRaGe8f2VkjdHriG5XXuXodbr6nnz4ibt8biQmLLn66pV21WQ4MUsHZskyMJpogK6sJPQlUEoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43377f5ae6fso52085835ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 20:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763094362; x=1763699162;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBLmI6eg2sMxjrM5ndxXAXO1I1DvnHsWL0ZDv7H3/Wk=;
        b=iqRCBAgdExDyiFM2cO/DCRQDhNyR/Ywt9cVhJue7i1D88otCDUpqyx59OSDyCUYcDm
         zjO6RPyjR7KckHHz9XaDG8J81vW4LjtL9fijkQTwtdtcFHv5n2UlRN0ZIqjI2qg26g9J
         DQVtNSTuiJdev7pV8i9lx6ehOtD/9AYGfM0iqjVFyH1evB4AwQ3pmt6mxGkHzoWan0Vl
         hzWti5AepRYQx2tMPfRBitGwfM4LmVboYDmGe4YaKDUjTRqLTPPfo66GBgV5+mZdw0+7
         4RAWjhpQH8DCZySdZuDUEmGMvCtIznXz5jfcxzMbvyo/ec9LD9xE44cmE1iILeG/45Ys
         +ocA==
X-Forwarded-Encrypted: i=1; AJvYcCUabLxVcHY33gtmlzG+FWfViU4UtCCd2ogWHXNUp1mFfLaQay+8qQqYFrx1zpF+f4ftGv1qX5JZwyjRCZda@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTheAky/PcxCwT2paLs/1PoYBbkhJ3bg5pVkm1uuFDSnyxJfz
	NUuGXVcec70aOzJ8kCvpxQXtHK4qjVTQ5HwOrzvr7d7R61h/3OtV7X4Z6lxZjq9jU569OVbGzR3
	8Vg8aZNQlTY7Nfr/+iqqjKGCfqODKAV2+WpYvbPH4XhJys2D1qyu7o5BxZYM=
X-Google-Smtp-Source: AGHT+IHkLKJdckB1HRGkI8gXUgGC6IHpDe81SETAtKrIRmWEhwwwm3Eh7TjtGBU7Ym506zImwUo6C4NhVpvSEGPFD+HWezCgbjQt
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:434:6f29:6cb with SMTP id
 e9e14a558f8ab-4348c91e6damr30884375ab.26.1763094361755; Thu, 13 Nov 2025
 20:26:01 -0800 (PST)
Date: Thu, 13 Nov 2025 20:26:01 -0800
In-Reply-To: <20251114051215.526577-1-mehdi.benhadjkhelifa@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6916af59.050a0220.3565dc.003a.GAE@google.com>
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


Warning: Permanently added '10.128.1.132' (ED25519) to the list of known ho=
sts.
2025/11/14 04:25:22 parsed 1 programs
[   38.568834][ T5812] cgroup: Unknown subsys name 'net'
[   38.681579][ T5812] cgroup: Unknown subsys name 'cpuset'
[   38.687948][ T5812] cgroup: Unknown subsys name 'rlimit'
Setting up swapspace version 1, size =3D 127995904 bytes
[   47.206806][ T5812] Adding 124996k swap on ./swap-file.  Priority:0 exte=
nts:1 across:124996k=20
[   48.634442][ T5821] soft_limit_in_bytes is deprecated and will be remove=
d. Please report your usecase to linux-mm@kvack.org if you depend on this f=
unctionality.
[   49.057992][   T31] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   49.068464][   T31] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   49.080224][   T12] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   49.088091][   T12] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   49.177421][ T5870] chnl_net:caif_netlink_parms(): no params data found
[   49.197720][ T5870] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   49.205546][ T5870] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   49.212806][ T5870] bridge_slave_0: entered allmulticast mode
[   49.219093][ T5870] bridge_slave_0: entered promiscuous mode
[   49.226954][ T5870] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   49.234019][ T5870] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   49.241114][ T5870] bridge_slave_1: entered allmulticast mode
[   49.247273][ T5870] bridge_slave_1: entered promiscuous mode
[   49.257812][ T5870] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   49.267520][ T5870] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   49.283802][ T5870] team0: Port device team_slave_0 added
[   49.289970][ T5870] team0: Port device team_slave_1 added
[   49.299659][ T5870] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   49.306737][ T5870] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   49.332781][ T5870] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   49.344098][ T5870] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   49.351244][ T5870] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   49.377242][ T5870] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   49.395484][ T5870] hsr_slave_0: entered promiscuous mode
[   49.401255][ T5870] hsr_slave_1: entered promiscuous mode
[   49.429633][ T5870] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   49.437511][ T5870] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   49.445536][ T5870] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   49.453283][ T5870] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   49.466311][ T5870] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   49.473549][ T5870] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   49.480828][ T5870] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   49.487888][ T5870] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   49.506659][ T5870] 8021q: adding VLAN 0 to HW filter on device bond0
[   49.515852][   T31] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   49.523955][   T31] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   49.533442][ T5870] 8021q: adding VLAN 0 to HW filter on device team0
[   49.541649][   T31] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   49.548678][   T31] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   49.557491][ T4775] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   49.564551][ T4775] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   49.609789][ T5870] 8021q: adding VLAN 0 to HW filter on device batadv0
[   49.624774][ T5870] veth0_vlan: entered promiscuous mode
[   49.632240][ T5870] veth1_vlan: entered promiscuous mode
[   49.642980][ T5870] veth0_macvtap: entered promiscuous mode
[   49.649568][ T5870] veth1_macvtap: entered promiscuous mode
[   49.658587][ T5870] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   49.667884][ T5870] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   49.677213][ T4775] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   49.685998][ T4775] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   49.696282][ T4775] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   49.705044][ T4775] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   49.739615][ T5893] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   49.746762][ T5893] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   49.754212][ T5893] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   49.761539][ T5893] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   49.768803][ T5893] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   49.777506][   T12] netdevsim netdevsim0 netdevsim3 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   49.811620][   T12] netdevsim netdevsim0 netdevsim2 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   49.872308][   T12] netdevsim netdevsim0 netdevsim1 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   49.932883][   T12] netdevsim netdevsim0 netdevsim0 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
2025/11/14 04:25:36 executed programs: 0
[   52.871628][   T12] bridge_slave_1: left allmulticast mode
[   52.877509][   T12] bridge_slave_1: left promiscuous mode
[   52.883233][   T12] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   52.890693][   T12] bridge_slave_0: left allmulticast mode
[   52.896320][   T12] bridge_slave_0: left promiscuous mode
[   52.902081][   T12] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   52.942851][   T12] bond0 (unregistering): (slave bond_slave_0): Releasi=
ng backup interface
[   52.951925][   T12] bond0 (unregistering): (slave bond_slave_1): Releasi=
ng backup interface
[   52.960999][   T12] bond0 (unregistering): Released all slaves
[   53.054718][   T12] hsr_slave_0: left promiscuous mode
[   53.060223][   T12] hsr_slave_1: left promiscuous mode
[   53.065682][   T12] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_0
[   53.073538][   T12] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[   53.081030][   T12] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_1
[   53.088412][   T12] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[   53.097247][   T12] veth1_macvtap: left promiscuous mode
[   53.102787][   T12] veth0_macvtap: left promiscuous mode
[   53.108333][   T12] veth1_vlan: left promiscuous mode
[   53.113692][   T12] veth0_vlan: left promiscuous mode
[   53.146117][   T12] team0 (unregistering): Port device team_slave_1 remo=
ved
[   53.154944][   T12] team0 (unregistering): Port device team_slave_0 remo=
ved
[   55.775892][ T5893] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   55.783123][ T5893] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   55.790299][ T5893] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   55.797638][ T5893] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   55.805009][ T5893] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   55.842807][ T5987] chnl_net:caif_netlink_parms(): no params data found
[   55.861642][ T5987] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   55.868694][ T5987] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   55.876286][ T5987] bridge_slave_0: entered allmulticast mode
[   55.882536][ T5987] bridge_slave_0: entered promiscuous mode
[   55.888863][ T5987] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   55.896054][ T5987] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   55.903160][ T5987] bridge_slave_1: entered allmulticast mode
[   55.909310][ T5987] bridge_slave_1: entered promiscuous mode
[   55.921259][ T5987] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   55.931363][ T5987] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   55.946114][ T5987] team0: Port device team_slave_0 added
[   55.952406][ T5987] team0: Port device team_slave_1 added
[   55.962372][ T5987] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   55.969330][ T5987] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   55.995474][ T5987] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   56.006426][ T5987] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   56.013527][ T5987] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   56.039738][ T5987] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   56.056635][ T5987] hsr_slave_0: entered promiscuous mode
[   56.062419][ T5987] hsr_slave_1: entered promiscuous mode
[   56.253249][ T5987] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   56.261855][ T5987] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   56.269702][ T5987] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   56.278553][ T5987] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   56.294272][ T5987] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   56.301460][ T5987] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   56.308739][ T5987] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   56.315923][ T5987] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   56.338321][ T5987] 8021q: adding VLAN 0 to HW filter on device bond0
[   56.348077][   T31] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   56.356081][   T31] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   56.366155][ T5987] 8021q: adding VLAN 0 to HW filter on device team0
[   56.374820][   T49] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   56.381909][   T49] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   56.400099][   T49] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   56.407204][   T49] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   56.458214][ T5987] 8021q: adding VLAN 0 to HW filter on device batadv0
[   56.477365][ T5987] veth0_vlan: entered promiscuous mode
[   56.485374][ T5987] veth1_vlan: entered promiscuous mode
[   56.498620][ T5987] veth0_macvtap: entered promiscuous mode
[   56.506001][ T5987] veth1_macvtap: entered promiscuous mode
[   56.516830][ T5987] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   56.526501][ T5987] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   56.536259][   T31] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   56.554454][   T31] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   56.571101][   T49] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   56.579028][   T49] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   56.589211][   T31] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
SYZFAIL: failed to recv rpc
fd=3D3 want=3D4 recv=3D0 n=3D0 (errno 9: Bad file descriptor)
[   56.602245][   T35] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   56.602375][   T31] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   56.610080][   T35] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
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
 -ffile-prefix-map=3D/tmp/go-build2609802501=3D/tmp/go-build -gno-record-gc=
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
HEAD detached at 4e1406b4def
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
/usr/bin/ld: /tmp/ccG1R0tu.o: in function `Connection::Connect(char const*,=
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D16ceb60a5800=
00


