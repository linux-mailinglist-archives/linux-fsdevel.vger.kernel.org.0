Return-Path: <linux-fsdevel+bounces-31828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E0F99BD87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 03:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565C6281F40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 01:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D903B339A8;
	Mon, 14 Oct 2024 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIxRn+D+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B331798F;
	Mon, 14 Oct 2024 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728871112; cv=none; b=gk/JIJZ0O/uWPkYqG1sp015kK21q1JDzo2dS9cwBChX5eU/JjbqjLt8+mQilw455Yn0+x23PV2hhkI1/H/Zr/HbqF75vWzoflAf0I2YJuGD9p9LGmscI7Df2Dn4XUHvJwbtfrlZTvw9YqeAdwiTIUjhVQ0UXsJ9QsKcWCACY7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728871112; c=relaxed/simple;
	bh=w1M8vcbMDMDLsZQsKiC+xJ+xdy2E+kVvqRqET1tURww=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=entATY6vORXmgTFyor/FBWzwUkjx00pv4xwcTb5aXoTcWhUFs8u13SYjSL+mJhTaPqqASNp6M+pQ+1lc4I+VjkfOwFTwLJvdt8f5QGP53ebbGu4hZ4A1XutRWzDzewctfGexP+woIXkiaKWSCpf5YCr+nJjh9R/vmt+QOmGBrgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIxRn+D+; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-84fdf96b31aso623671241.2;
        Sun, 13 Oct 2024 18:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728871109; x=1729475909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w1M8vcbMDMDLsZQsKiC+xJ+xdy2E+kVvqRqET1tURww=;
        b=AIxRn+D+HxHdbMbpLaYRUVlSvA8UhlIuEgwhZhYmESOXH0CMa1pilObG5HfaHdGY71
         KNQvPoY4lPxsmMXPMCuVKCW9lU/8ZtxXLAMfwC9Si0tRHLsLuUvKJ9B8pdbwl+3IVmbv
         LhrSNEuV85rd+//TJYoyzYHzYiaNsbbbR6XfXjNS1hXSg98vmQlB7UHzhfok7qI5Xg6w
         VTAjAP1rFFhnsqcFW8kAhn/nLWDmgnrrV8J5OUjVVJbGFlc5F3AawAcOlZCoe3msQKBt
         3XXWdCFdQ9eEtHHJhRhXtomsuckZVo1VFIk0jJOBz2LbinNoQWybgbbvb/rw8sUsRvML
         s0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728871109; x=1729475909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1M8vcbMDMDLsZQsKiC+xJ+xdy2E+kVvqRqET1tURww=;
        b=Zn8/sEjuvDZgvjM64GmMss70GBG3o1lWZvRj98o2z/8KKA289Nac1kdhaLVHQRhgKR
         4KazBUmGnxl1sRH8+F/8rcEAY4DTpldBQRdIsy+RcXRE/CUn8c/UnLcsyX91sDR02U6+
         QmkOv1c6gqbcfqWUvFhHwNHonzKhmbJy6zIsyUi1fMwU6YiOMd3dJhKVMjbV6dKnTuXT
         pDqYuGTj2V1/iitbUu1aZxxuAEhgiXYszSrjYEyo6yaaBF1r9NPJGj7w0t5AXamr6MRa
         V0Zc2w+JV6c2wgl9BVTm5wO8BQu6dusbku8MsUkj/VRolAuI/bdoqqlo7149cs1Bw/oI
         An7g==
X-Forwarded-Encrypted: i=1; AJvYcCVnrqpVgaG7DbIL6VMZ+tZRM+HNYf4TaKGLmsUl+QgPXvdnbEsjGa+QMlVtZqmAh7vJcJMP9DEXBSaNzzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYpPZZ22wRllYlaSHJ5vPu5N5qnUGaOX6Y79VNGiFkP/fyuAeB
	WufibCQF97lgtA/x8OzQipDqWJ62PYKjhUIIOWObGLML/CagQrV6ZFOnRQusNMTdlgTk8bGlVWK
	+hK/CHOz71UUdq4EWFSHouSJ++0DXMJ+aWGw=
X-Google-Smtp-Source: AGHT+IFe8kVVP5vGATDPNpFFbX26O52TCKAAGG/TlVueKqBiA7kHztvithklCGN4xX1t6TFS40yJHXDnavi7sX3LCo4=
X-Received: by 2002:a05:6122:251f:b0:50a:bdef:63ad with SMTP id
 71dfb90a1353d-50d1f4d239fmr6235987e0c.7.1728871108496; Sun, 13 Oct 2024
 18:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hui Guo <guohui.study@gmail.com>
Date: Mon, 14 Oct 2024 09:58:17 +0800
Message-ID: <CAHOo4gL4fKqPBL86cfc-H5yh0r-04djk8VrdAdyvi5FVj7+BBg@mail.gmail.com>
Subject: general protection fault in hfsplus_bnode_dump
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kernel Maintainers,
we found a crash "general protection fault in hfsplus_bnode_dump" (it
seems like a KASAN and makes the kernel reboot) in upstream, we also
have successfully reproduced it manually:


HEAD Commit: 9852d85ec9d492ebef56dc5f229416c925758edc(tag 'v6.12-rc1')
kernel config: https://raw.githubusercontent.com/androidAppGuard/KernelBugs=
/main/6.12.config

console output:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec=
9d492ebef56dc5f229416c925758edc/536923dbef66e6cdc0ffbc6839c30b98938529fa/lo=
g0
repro report: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/=
main/9852d85ec9d492ebef56dc5f229416c925758edc/536923dbef66e6cdc0ffbc6839c30=
b98938529fa/repro.report
syz reproducer:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec=
9d492ebef56dc5f229416c925758edc/536923dbef66e6cdc0ffbc6839c30b98938529fa/re=
pro.prog
c reproducer: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/=
main/9852d85ec9d492ebef56dc5f229416c925758edc/536923dbef66e6cdc0ffbc6839c30=
b98938529fa/repro.cprog


Please let me know if there is anything I can help.
Best,
Hui Guo

This is the crash log I got by reproducing the bug based on the above
environment=EF=BC=8C
I have piped this log through decode_stacktrace.sh to better
understand the cause of the bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
2024/10/14 01:45:41 parsed 1 programs
[ 454.579054][T16120] Adding 124996k swap on ./swap-file. Priority:0
extents:1 across:124996k
[ 455.437242][ T4652] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > 1
[ 455.439266][ T4652] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > 9
[ 455.440910][ T4652] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > 9
[ 455.442329][ T4652] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > 4
[ 455.443577][ T4652] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > 3
[ 455.445732][ T4652] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
[ 455.506461][ T3871] wlan0: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 455.507529][ T3871] wlan0: Creating new IBSS network, BSSID 50:50:50:50:5=
0:50
[ 455.510734][T16160] chnl_net:caif_netlink_parms(): no params data found
[ 455.512068][ T109] wlan1: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 455.513159][ T109] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50=
:50
[ 455.529655][T16160] bridge0: port 1(bridge_slave_0) entered blocking stat=
e
[ 455.530666][T16160] bridge0: port 1(bridge_slave_0) entered disabled stat=
e
[ 455.531617][T16160] bridge_slave_0: entered allmulticast mode
[ 455.532513][T16160] bridge_slave_0: entered promiscuous mode
[ 455.533541][T16160] bridge0: port 2(bridge_slave_1) entered blocking stat=
e
[ 455.534453][T16160] bridge0: port 2(bridge_slave_1) entered disabled stat=
e
[ 455.535378][T16160] bridge_slave_1: entered allmulticast mode
[ 455.536332][T16160] bridge_slave_1: entered promiscuous mode
[ 455.543600][T16160] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[ 455.545139][T16160] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[ 455.551614][T16160] team0: Port device team_slave_0 added
[ 455.552633][T16160] team0: Port device team_slave_1 added
[ 455.559202][T16160] batman_adv: batadv0: Adding interface: batadv_slave_0
[ 455.560110][T16160] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this inter.
[ 455.563370][T16160] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[ 455.564860][T16160] batman_adv: batadv0: Adding interface: batadv_slave_1
[ 455.565749][T16160] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this inter.
[ 455.569023][T16160] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[ 455.582692][T16160] hsr_slave_0: entered promiscuous mode
[ 455.583588][T16160] hsr_slave_1: entered promiscuous mode
[ 455.598984][T16160] netdevsim netdevsim6 netdevsim0: renamed from eth0
[ 455.600239][T16160] netdevsim netdevsim6 netdevsim1: renamed from eth1
[ 455.601443][T16160] netdevsim netdevsim6 netdevsim2: renamed from eth2
[ 455.602654][T16160] netdevsim netdevsim6 netdevsim3: renamed from eth3
[ 455.608933][T16160] bridge0: port 2(bridge_slave_1) entered blocking stat=
e
[ 455.609851][T16160] bridge0: port 2(bridge_slave_1) entered forwarding st=
ate
[ 455.610777][T16160] bridge0: port 1(bridge_slave_0) entered blocking stat=
e
[ 455.611678][T16160] bridge0: port 1(bridge_slave_0) entered forwarding st=
ate
[ 455.618089][T16160] 8021q: adding VLAN 0 to HW filter on device bond0
[ 455.620458][ T58] bridge0: port 1(bridge_slave_0) entered disabled state
[ 455.622174][ T58] bridge0: port 2(bridge_slave_1) entered disabled state
[ 455.624863][T16160] 8021q: adding VLAN 0 to HW filter on device team0
[ 455.626753][ T4025] bridge0: port 1(bridge_slave_0) entered blocking stat=
e
[ 455.628443][ T4025] bridge0: port 1(bridge_slave_0) entered forwarding st=
ate
[ 455.631039][ T4025] bridge0: port 2(bridge_slave_1) entered blocking stat=
e
[ 455.632694][ T4025] bridge0: port 2(bridge_slave_1) entered forwarding st=
ate
[ 455.653875][T16160] 8021q: adding VLAN 0 to HW filter on device batadv0
[ 455.680252][T16160] veth0_vlan: entered promiscuous mode
[ 455.681653][T16160] veth1_vlan: entered promiscuous mode
[ 455.684859][T16160] veth0_macvtap: entered promiscuous mode
[ 455.686005][T16160] veth1_macvtap: entered promiscuous mode
[ 455.688383][T16160] batman_adv: batadv0: Interface activated: batadv_slav=
e_0
[ 455.690494][T16160] batman_adv: batadv0: Interface activated: batadv_slav=
e_1
[ 455.691937][T16160] netdevsim netdevsim6 netdevsim0: set [1, 0] type
2 family 0 port 6081 - 0
[ 455.693055][T16160] netdevsim netdevsim6 netdevsim1: set [1, 0] type
2 family 0 port 6081 - 0
[ 455.694148][T16160] netdevsim netdevsim6 netdevsim2: set [1, 0] type
2 family 0 port 6081 - 0
[ 455.695241][T16160] netdevsim netdevsim6 netdevsim3: set [1, 0] type
2 family 0 port 6081 - 0
2024/10/14 01:45:45 executed programs: 0
[ 455.780225][ T4652] Bluetooth: hci1: unexpected cc 0x0c03 length: 249 > 1
[ 455.782248][ T4652] Bluetooth: hci1: unexpected cc 0x1003 length: 249 > 9
[ 455.784198][ T4652] Bluetooth: hci1: unexpected cc 0x1001 length: 249 > 9
[ 455.786268][ T4652] Bluetooth: hci1: unexpected cc 0x0c23 length: 249 > 4
[ 455.788537][ T4652] Bluetooth: hci1: unexpected cc 0x0c25 length: 249 > 3
[ 455.790528][ T4652] Bluetooth: hci1: unexpected cc 0x0c38 length: 249 > 2
[ 455.807393][T17538] chnl_net:caif_netlink_parms(): no params data found
[ 455.825424][T17538] bridge0: port 1(bridge_slave_0) entered blocking stat=
e
[ 455.826383][T17538] bridge0: port 1(bridge_slave_0) entered disabled stat=
e
[ 455.827364][T17538] bridge_slave_0: entered allmulticast mode
[ 455.828280][T17538] bridge_slave_0: entered promiscuous mode
[ 455.829526][T17538] bridge0: port 2(bridge_slave_1) entered blocking stat=
e
[ 455.830453][T17538] bridge0: port 2(bridge_slave_1) entered disabled stat=
e
[ 455.831381][T17538] bridge_slave_1: entered allmulticast mode
[ 455.832252][T17538] bridge_slave_1: entered promiscuous mode
[ 455.838008][T17538] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[ 455.839576][T17538] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[ 455.845364][T17538] team0: Port device team_slave_0 added
[ 455.846377][T17538] team0: Port device team_slave_1 added
[ 455.851601][T17538] batman_adv: batadv0: Adding interface: batadv_slave_0
[ 455.852537][T17538] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this inter.
[ 455.855920][T17538] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[ 455.857492][T17538] batman_adv: batadv0: Adding interface: batadv_slave_1
[ 455.858430][T17538] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this inter.
[ 455.861794][T17538] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[ 455.868959][T17538] hsr_slave_0: entered promiscuous mode
[ 455.869871][T17538] hsr_slave_1: entered promiscuous mode
[ 455.870735][T17538] debugfs: Directory 'hsr0' with parent 'hsr'
already present!
[ 455.871730][T17538] Cannot create hsr debugfs directory
[ 456.360504][T17538] netdevsim netdevsim0 netdevsim0: renamed from eth0
[ 456.361777][T17538] netdevsim netdevsim0 netdevsim1: renamed from eth1
[ 456.362967][T17538] netdevsim netdevsim0 netdevsim2: renamed from eth2
[ 456.364173][T17538] netdevsim netdevsim0 netdevsim3: renamed from eth3
[ 456.370041][T17538] bridge0: port 2(bridge_slave_1) entered blocking stat=
e
[ 456.371072][T17538] bridge0: port 2(bridge_slave_1) entered forwarding st=
ate
[ 456.372106][T17538] bridge0: port 1(bridge_slave_0) entered blocking stat=
e
[ 456.373194][T17538] bridge0: port 1(bridge_slave_0) entered forwarding st=
ate
[ 456.378903][T17538] 8021q: adding VLAN 0 to HW filter on device bond0
[ 456.381680][ T3871] bridge0: port 1(bridge_slave_0) entered disabled stat=
e
[ 456.384673][ T3871] bridge0: port 2(bridge_slave_1) entered disabled stat=
e
[ 456.389635][T17538] 8021q: adding VLAN 0 to HW filter on device team0
[ 456.391677][ T92] bridge0: port 1(bridge_slave_0) entered blocking state
[ 456.393321][ T92] bridge0: port 1(bridge_slave_0) entered forwarding stat=
e
[ 456.395813][ T3871] bridge0: port 2(bridge_slave_1) entered blocking stat=
e
[ 456.396619][ T3871] bridge0: port 2(bridge_slave_1) entered forwarding st=
ate
[ 456.416809][T17538] 8021q: adding VLAN 0 to HW filter on device batadv0
[ 456.421088][T17538] veth0_vlan: entered promiscuous mode
[ 456.422396][T17538] veth1_vlan: entered promiscuous mode
[ 456.425176][T17538] veth0_macvtap: entered promiscuous mode
[ 456.426280][T17538] veth1_macvtap: entered promiscuous mode
[ 456.428182][T17538] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_0
[ 456.429523][T17538] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[ 456.430975][T17538] batman_adv: batadv0: Interface activated: batadv_slav=
e_0
[ 456.432548][T17538] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3f) already exists on: batadv_slave_1
[ 456.433889][T17538] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[ 456.435356][T17538] batman_adv: batadv0: Interface activated: batadv_slav=
e_1
[ 456.436712][T17538] netdevsim netdevsim0 netdevsim0: set [1, 0] type
2 family 0 port 6081 - 0
[ 456.437900][T17538] netdevsim netdevsim0 netdevsim1: set [1, 0] type
2 family 0 port 6081 - 0
[ 456.439033][T17538] netdevsim netdevsim0 netdevsim2: set [1, 0] type
2 family 0 port 6081 - 0
[ 456.440167][T17538] netdevsim netdevsim0 netdevsim3: set [1, 0] type
2 family 0 port 6081 - 0
[ 456.498615][ T4025] wlan0: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 456.499502][ T4025] wlan0: Creating new IBSS network, BSSID 50:50:50:50:5=
0:50
[ 456.502903][ T92] wlan1: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 456.504010][ T92] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:=
50
[ 456.509512][T18584] loop0: detected capacity change from 0 to 1024
[ 456.511409][T18584] hfsplus: request for non-existent node 65536 in B*Tre=
e
[ 456.512389][T18584] hfsplus: request for non-existent node 65536 in B*Tre=
e
[ 456.513633][T18584] Oops: general protection fault, probably for
non-canonical address 0xffe728c23915e232: 0000 [#1] PREEMPT SMP NOPTI
[ 456.515275][T18584] CPU: 3 UID: 0 PID: 18584 Comm: syz.0.15 Not
tainted 6.12.0-rc1 #5
[ 456.516362][T18584] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[456.517618][T18584] RIP: 0010:memcpy_orig
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/lib/memc=
py_64.S:160)
[ 456.518331][T18584] Code: 0f 1f 44 00 00 83 fa 04 72 1b 8b 0e 44 8b
44 16 fc 89 0f 44 89 44 17 fc c3 cc cc cc cc 0f 1f 84 00 00 00 00 00
83 ea 01 72 19 <0f> b6 0e 74 12 4c 0c
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 0f 1f 44 00 00 nopl 0x0(%rax,%rax,1)
5: 83 fa 04 cmp $0x4,%edx
8: 72 1b jb 0x25
a: 8b 0e mov (%rsi),%ecx
c: 44 8b 44 16 fc mov -0x4(%rsi,%rdx,1),%r8d
11: 89 0f mov %ecx,(%rdi)
13: 44 89 44 17 fc mov %r8d,-0x4(%rdi,%rdx,1)
18: c3 ret
19: cc int3
1a: cc int3
1b: cc int3
1c: cc int3
1d: 0f 1f 84 00 00 00 00 nopl 0x0(%rax,%rax,1)
24: 00
25: 83 ea 01 sub $0x1,%edx
28: 72 19 jb 0x43
2a:* 0f b6 0e movzbl (%rsi),%ecx <-- trapping instruction
2d: 74 12 je 0x41
2f: 4c rex.WR
30: 0c .byte 0xc

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 0f b6 0e movzbl (%rsi),%ecx
3: 74 12 je 0x17
5: 4c rex.WR
6: 0c .byte 0xc
[ 456.520949][T18584] RSP: 0018:ffff8881091b7a40 EFLAGS: 00010202
[ 456.521776][T18584] RAX: ffff8881091b7a8a RBX: 0000000000000000 RCX:
0000000000000002
[ 456.522852][T18584] RDX: 0000000000000001 RSI: ffe728c23915e232 RDI:
ffff8881091b7a8a
[ 456.523937][T18584] RBP: ffff8881091b7a70 R08: 0000000000000032 R09:
0000000000000032
[ 456.525002][T18584] R10: 00000000000000ff R11: 7400740061007800 R12:
ffff8881091b7a8a
[ 456.526054][T18584] R13: 0000000000000002 R14: ffff888108e457a8 R15:
00000000000000ff
[ 456.527115][T18584] FS: 00007f0a31694640(0000)
GS:ffff88823be80000(0000) knlGS:0000000000000000
[ 456.528310][T18584] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 456.529190][T18584] CR2: 00007f0a30967a8c CR3: 00000001089be000 CR4:
00000000000006f0
[ 456.530250][T18584] Call Trace:
[ 456.530698][T18584] <TASK>
[456.531091][T18584] ? show_regs
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/d=
umpstack.c:479)
[456.531680][T18584] ? die_addr
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/d=
umpstack.c:421
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/du=
mpstack.c:460)
[456.532253][T18584] ? exc_general_protection
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/t=
raps.c:748
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/tr=
aps.c:693)
[456.533005][T18584] ? asm_exc_general_protection
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./arch/x86/includ=
e/asm/idtentry.h:617)
[456.533782][T18584] ? memcpy_orig
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/lib/memc=
py_64.S:160)
[456.534414][T18584] ? hfsplus_bnode_read
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfsplus/bnode.=
c:34)
[456.535093][T18584] hfsplus_bnode_dump
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfsplus/bnode.=
c:322)
[456.535788][T18584] hfsplus_brec_remove
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfsplus/brec.c=
:230)
[456.536486][T18584] __hfsplus_delete_attr
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfsplus/attrib=
utes.c:300)
[456.537197][T18584] hfsplus_delete_all_attrs
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfsplus/attrib=
utes.c:379)
[456.537952][T18584] hfsplus_delete_cat
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfsplus/catalo=
g.c:425)
[456.538641][T18584] hfsplus_unlink
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfsplus/dir.c:=
386)
[456.539260][T18584] ? inode_permission
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namei.c:544)
[456.539937][T18584] ? make_vfsgid
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/mnt_idmapping.=
c:135
(discriminator 1))
[456.540548][T18584] hfsplus_rename
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfsplus/dir.c:=
547)
[456.541166][T18584] vfs_rename
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namei.c:5015)
[456.541764][T18584] ? apparmor_path_rename
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/security/apparmor=
/lsm.c:442)
[456.542492][T18584] ? __sanitizer_cov_trace_const_cmp4
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/kcov.c:316=
)
[456.543331][T18584] ? security_path_rename
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/security/security=
.c:2022)
[456.544053][T18584] do_renameat2
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namei.c:5170)
[456.544674][T18584] __x64_sys_rename
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namei.c:5215)
[456.545311][T18584] x64_sys_call
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/sy=
scall_64.c:36)
[456.545964][T18584] do_syscall_64
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/co=
mmon.c:52
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/com=
mon.c:83)
[456.546595][T18584] entry_SYSCALL_64_after_hwframe
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/en=
try_64.S:130)
[ 456.547407][T18584] RIP: 0033:0x7f0a3079c62d
[ 456.547990][T18584] Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 78
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 02 b8 ff ff ff ff add -0x1(%rax),%bh
6: c3 ret
7: 66 0f 1f 44 00 00 nopw 0x0(%rax,%rax,1)
d: f3 0f 1e fa endbr64
11: 48 89 f8 mov %rdi,%rax
14: 48 89 f7 mov %rsi,%rdi
17: 48 89 d6 mov %rdx,%rsi
1a: 48 89 ca mov %rcx,%rdx
1d: 4d 89 c2 mov %r8,%r10
20: 4d 89 c8 mov %r9,%r8
23: 4c 8b 4c 24 08 mov 0x8(%rsp),%r9
28: 0f 05 syscall
2a:* 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax <-- trapping instructio=
n
30: 78 .byte 0x78

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax
6: 78 .byte 0x78
[ 456.550560][T18584] RSP: 002b:00007f0a31693f98 EFLAGS: 00000246
ORIG_RAX: 0000000000000052
[ 456.551682][T18584] RAX: ffffffffffffffda RBX: 00007f0a30965f80 RCX:
00007f0a3079c62d
[ 456.552738][T18584] RDX: 0000000000000000 RSI: 00000000200000c0 RDI:
0000000020000000
[ 456.553788][T18584] RBP: 00007f0a308264d3 R08: 0000000000000000 R09:
0000000000000000
[ 456.554850][T18584] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[ 456.555907][T18584] R13: 0000000000000000 R14: 00007f0a30965f80 R15:
00007f0a31674000
[ 456.556966][T18584] </TASK>
[ 456.557389][T18584] Modules linked in:
[ 456.557984][T18584] ---[ end trace 0000000000000000 ]---
[456.558724][T18584] RIP: 0010:memcpy_orig
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/lib/memc=
py_64.S:160)
[ 456.559437][T18584] Code: 0f 1f 44 00 00 83 fa 04 72 1b 8b 0e 44 8b
44 16 fc 89 0f 44 89 44 17 fc c3 cc cc cc cc 0f 1f 84 00 00 00 00 00
83 ea 01 72 19 <0f> b6 0e 74 12 4c 0c
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 0f 1f 44 00 00 nopl 0x0(%rax,%rax,1)
5: 83 fa 04 cmp $0x4,%edx
8: 72 1b jb 0x25
a: 8b 0e mov (%rsi),%ecx
c: 44 8b 44 16 fc mov -0x4(%rsi,%rdx,1),%r8d
11: 89 0f mov %ecx,(%rdi)
13: 44 89 44 17 fc mov %r8d,-0x4(%rdi,%rdx,1)
18: c3 ret
19: cc int3
1a: cc int3
1b: cc int3
1c: cc int3
1d: 0f 1f 84 00 00 00 00 nopl 0x0(%rax,%rax,1)
24: 00
25: 83 ea 01 sub $0x1,%edx
28: 72 19 jb 0x43
2a:* 0f b6 0e movzbl (%rsi),%ecx <-- trapping instruction
2d: 74 12 je 0x41
2f: 4c rex.WR
30: 0c .byte 0xc

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 0f b6 0e movzbl (%rsi),%ecx
3: 74 12 je 0x17
5: 4c rex.WR
6: 0c .byte 0xc
[ 456.562016][T18584] RSP: 0018:ffff8881091b7a40 EFLAGS: 00010202
[ 456.562835][T18584] RAX: ffff8881091b7a8a RBX: 0000000000000000 RCX:
0000000000000002
[ 456.563905][T18584] RDX: 0000000000000001 RSI: ffe728c23915e232 RDI:
ffff8881091b7a8a
[ 456.564987][T18584] RBP: ffff8881091b7a70 R08: 0000000000000032 R09:
0000000000000032
[ 456.566053][T18584] R10: 00000000000000ff R11: 7400740061007800 R12:
ffff8881091b7a8a
[ 456.567113][T18584] R13: 0000000000000002 R14: ffff888108e457a8 R15:
00000000000000ff
[ 456.568240][T18584] FS: 00007f0a31694640(0000)
GS:ffff88823be80000(0000) knlGS:0000000000000000
[ 456.569469][T18584] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 456.570355][T18584] CR2: 00007f0a30967a8c CR3: 00000001089be000 CR4:
00000000000006f0
[ 456.571434][T18584] Kernel panic - not syncing: Fatal exception
[ 456.572593][T18584] Kernel Offset: disabled
[ 456.573186][T18584] Rebooting in 86400 seconds..

