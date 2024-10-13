Return-Path: <linux-fsdevel+bounces-31810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 219E499B7F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 04:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F9C1C21ACC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 02:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D78BA955;
	Sun, 13 Oct 2024 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luCi5fmF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15468BE0;
	Sun, 13 Oct 2024 02:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728786475; cv=none; b=K3Lwmyr9siGj+hH/9KvZNNwsF/x+9EefhENTseAHgwyI0TBMlCg2cHfxnUjgP/kwSZXK+48Av/HT4sEwOhE1isFsX3AviyHEy23vMEAEPgYvx5s3mK1IXUdmkNaMYYYR0pBFGJMvmm+B0HRHEWpHVIt72Q+WMHIYEahl/dLCp9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728786475; c=relaxed/simple;
	bh=jDGo2nN5dUKDbiI/XurwJIgywrT2r2cbqDp4KrCSiYo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YXh+hRtGUzWpsqRyAui8qOpIEgwaJRIz66Xg6oe2fMXGuqSGpILn4ShjC1lOoZlJ1TNZYI7gEEc2DUkmDcEZq0r4ybskI45hCBiScUl2W8wppkZEhH3nmCmIegHAkhhi1rOLif5VehLLpsnjmHNSX9b7L3v7AeWMqp/wWcz7vjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luCi5fmF; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-50d3d2d0775so196436e0c.3;
        Sat, 12 Oct 2024 19:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728786472; x=1729391272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jDGo2nN5dUKDbiI/XurwJIgywrT2r2cbqDp4KrCSiYo=;
        b=luCi5fmFSjyxL4XTm0L/4viYNe71Y1b6xCgDlFGaq+8qiJpZGq7zDLcoUTPvJ9ukJL
         cGaJFZGNjA8NMKoCO/2EsFWAwODR9adKmmtgi5sry4RC6x1wjXtGFXu4Awjd5zFSwYFJ
         CS3XPcXHHzDq7TI44BgRXxdETQuUOxUcOfecT65OwopAIvUVPqqGYujRxuDYDAQAvTFv
         99cEnpvO1YDgsKa+FeKF8DNnjPznGe3e4gpYDXQhwyE2JeOZQhAyU4rZG5TBnW8AaiSS
         due7apqBKL2mmT8FnDVo08IIpxaH2ZlKK4FIDR3B66Cy3sXzLVYOr87BquvSmiieQ+Kn
         RTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728786472; x=1729391272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDGo2nN5dUKDbiI/XurwJIgywrT2r2cbqDp4KrCSiYo=;
        b=Fd0w3TqX42Yli0jgV9KMsqkPHBnVWIu1muUZumQNLAIumYy+Mq86I8IN+ExDP0MGgF
         J/vZZyiJvQ3TzUJY2OZ9PO+SRGgdK2DS01tWMVhlxO1Kc7V+AYzA8bSwp1DbhfB9Tv4u
         sOExMSO7rJgrTfjjcEc6VpV6aGP4xRec0qusmHed0aXi7osY7gXZU90seQmKt96lBgX5
         XkBnFlDvUI0fMlZW1NlmsiYiR0ogQK10uCcHK+7OsGFQ5MpsC8FjRVqwElvANU4MRNz7
         yrDTvs7e2/y6Gp9k72vTD35gyltUazxAu6UXZeDMk46hJq5qaXgmdmHQV8+K6X3v5/ix
         60uw==
X-Forwarded-Encrypted: i=1; AJvYcCXIE33pxzpFAzfWRjIrluCVBAbWSeqCf7eX23xwD8qJD8q2HaDHlZlg8/wcqCuMSzUGgw1MNc1kEyO11uY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5m6D/6X1GW37OUv/bbxMKHQSr/pedmuVmdfPB4BSOBCzITbsP
	dQDzyZwNnaoFCoraJXxqT4bcUJERIejfvP2tDTKZTCwCsZHLY0Zg3ccR0rp9hrZOeTKIOuUmghm
	NOpg5q6wTy2Q2xxPmRPOA7ioLVbYQmsYQIO50NQ==
X-Google-Smtp-Source: AGHT+IF9wwS5H7JScIMWNbXIUKJp6KKnbqG+M50EZKUd2joWJx+e29DEoPVqtpHfQyWRb8h1IlSkvJm8ahqrt9Rjvrg=
X-Received: by 2002:a05:6122:da6:b0:501:1c74:bfc9 with SMTP id
 71dfb90a1353d-50d1f59c8aemr5736410e0c.12.1728786471999; Sat, 12 Oct 2024
 19:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hui Guo <guohui.study@gmail.com>
Date: Sun, 13 Oct 2024 10:27:40 +0800
Message-ID: <CAHOo4gKyvGsE7iT7yqrFXVsc8OXMQBuTC2_9yosxns8Ufj3AOQ@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in hfs_find_init
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org
Cc: syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kernel Maintainers,
we found a crash "BUG: unable to handle kernel NULL pointer
dereference in hfs_find_init" (it seems a KASAN and make the kernel
reboot) in upstream, we have successfully reproduced it manually:


HEAD Commit: 9852d85ec9d492ebef56dc5f229416c925758edc(tag 'v6.12-rc1')
kernel config: https://raw.githubusercontent.com/androidAppGuard/KernelBugs=
/main/6.12.config


repro report: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/=
main/9852d85ec9d492ebef56dc5f229416c925758edc/0f99fb17356ecba84aa11ff789259=
8348ab4a96b/repro.report
console output:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec=
9d492ebef56dc5f229416c925758edc/0f99fb17356ecba84aa11ff7892598348ab4a96b/lo=
g0
syz reproducer:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec=
9d492ebef56dc5f229416c925758edc/0f99fb17356ecba84aa11ff7892598348ab4a96b/re=
pro.prog
c reproducer: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/=
main/9852d85ec9d492ebef56dc5f229416c925758edc/0f99fb17356ecba84aa11ff789259=
8348ab4a96b/repro.cprog


Please let me know if there is anything I can help.
Best,
Hui Guo

This is the crash log I got by reproducing the bug based on the above
environment=EF=BC=8C
I have piped this log through decode_stacktrace.sh for better
understand the cause of the bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
root@syzkaller:~# ./syz-execprog
/data/ghui/docker_data/workdir/upstream/ghui_syzkaller_upstream_linux_v6.11=
_2_upstream/crashes/0f99fb17356ecba84aa11ff7892598348ab4a96b/repro.pg
2024/10/13 02:13:14 parsed 1 programs
[ 1715.063040][T13595] Adding 124996k swap on ./swap-file. Priority:0
extents:1 across:124996k
[ 1715.956030][T13626] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[ 1715.957157][T13626] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[ 1715.958207][T13626] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[ 1715.959567][T13626] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[ 1715.960644][T13626] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > =
3
[ 1715.964767][T13626] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[ 1716.015110][T13760] wlan0: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 1716.016184][T13760] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[ 1716.031523][T13561] wlan1: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 1716.032577][T13561] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[ 1716.035527][T13625] chnl_net:caif_netlink_parms(): no params data found
[ 1716.061284][T13625] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[ 1716.062217][T13625] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[ 1716.063172][T13625] bridge_slave_0: entered allmulticast mode
[ 1716.064077][T13625] bridge_slave_0: entered promiscuous mode
[ 1716.065092][T13625] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[ 1716.066018][T13625] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[ 1716.066969][T13625] bridge_slave_1: entered allmulticast mode
[ 1716.067872][T13625] bridge_slave_1: entered promiscuous mode
[ 1716.073685][T13625] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[ 1716.075269][T13625] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[ 1716.083754][T13625] team0: Port device team_slave_0 added
[ 1716.084756][T13625] team0: Port device team_slave_1 added
[ 1716.090299][T13625] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[ 1716.091177][T13625] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this inter.
[ 1716.094348][T13625] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[ 1716.095772][T13625] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[ 1716.096636][T13625] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this inter.
[ 1716.099888][T13625] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[ 1716.110722][T13625] hsr_slave_0: entered promiscuous mode
[ 1716.112226][T13625] hsr_slave_1: entered promiscuous mode
[ 1716.126167][T13625] netdevsim netdevsim10 netdevsim0: renamed from eth0
[ 1716.127484][T13625] netdevsim netdevsim10 netdevsim1: renamed from eth1
[ 1716.128745][T13625] netdevsim netdevsim10 netdevsim2: renamed from eth2
[ 1716.130133][T13625] netdevsim netdevsim10 netdevsim3: renamed from eth3
[ 1716.135631][T13625] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[ 1716.136556][T13625] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[ 1716.137500][T13625] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[ 1716.138429][T13625] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[ 1716.144506][T13625] 8021q: adding VLAN 0 to HW filter on device bond0
[ 1716.146837][T13886] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[ 1716.148752][T13886] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[ 1716.151564][T13625] 8021q: adding VLAN 0 to HW filter on device team0
[ 1716.153279][T13886] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[ 1716.154090][T13886] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[ 1716.156241][T13886] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[ 1716.157869][T13886] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[ 1716.181717][T13625] 8021q: adding VLAN 0 to HW filter on device batadv0
[ 1716.209621][T13625] veth0_vlan: entered promiscuous mode
[ 1716.211036][T13625] veth1_vlan: entered promiscuous mode
[ 1716.214231][T13625] veth0_macvtap: entered promiscuous mode
[ 1716.215195][T13625] veth1_macvtap: entered promiscuous mode
[ 1716.217047][T13625] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[ 1716.218971][T13625] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[ 1716.220345][T13625] netdevsim netdevsim10 netdevsim0: set [1, 0]
type 2 family 0 port 6081 - 0
[ 1716.221464][T13625] netdevsim netdevsim10 netdevsim1: set [1, 0]
type 2 family 0 port 6081 - 0
[ 1716.222545][T13625] netdevsim netdevsim10 netdevsim2: set [1, 0]
type 2 family 0 port 6081 - 0
[ 1716.223534][T13625] netdevsim netdevsim10 netdevsim3: set [1, 0]
type 2 family 0 port 6081 - 0
2024/10/13 02:13:18 executed programs: 0
[ 1716.322303][ T4649] Bluetooth: hci1: unexpected cc 0x0c03 length: 249 > =
1
[ 1716.324231][ T4649] Bluetooth: hci1: unexpected cc 0x1003 length: 249 > =
9
[ 1716.325959][ T4649] Bluetooth: hci1: unexpected cc 0x1001 length: 249 > =
9
[ 1716.327813][ T4649] Bluetooth: hci1: unexpected cc 0x0c23 length: 249 > =
4
[ 1716.329786][ T4649] Bluetooth: hci1: unexpected cc 0x0c25 length: 249 > =
3
[ 1716.331450][ T4649] Bluetooth: hci1: unexpected cc 0x0c38 length: 249 > =
2
[ 1716.353232][T15016] chnl_net:caif_netlink_parms(): no params data found
[ 1716.373312][T15016] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[ 1716.374266][T15016] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[ 1716.375198][T15016] bridge_slave_0: entered allmulticast mode
[ 1716.376084][T15016] bridge_slave_0: entered promiscuous mode
[ 1716.377121][T15016] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[ 1716.378028][T15016] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[ 1716.378991][T15016] bridge_slave_1: entered allmulticast mode
[ 1716.379866][T15016] bridge_slave_1: entered promiscuous mode
[ 1716.385833][T15016] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[ 1716.387930][T15016] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[ 1716.396402][T15016] team0: Port device team_slave_0 added
[ 1716.398172][T15016] team0: Port device team_slave_1 added
[ 1716.406211][T15016] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[ 1716.407768][T15016] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this inter.
[ 1716.413399][T15016] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[ 1716.415633][T15016] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[ 1716.416987][T15016] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this inter.
[ 1716.420758][T15016] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[ 1716.426564][T15016] hsr_slave_0: entered promiscuous mode
[ 1716.427371][T15016] hsr_slave_1: entered promiscuous mode
[ 1716.428140][T15016] debugfs: Directory 'hsr0' with parent 'hsr'
already present!
[ 1716.429138][T15016] Cannot create hsr debugfs directory
[ 1716.953119][T15016] netdevsim netdevsim0 netdevsim0: renamed from eth0
[ 1716.955519][T15016] netdevsim netdevsim0 netdevsim1: renamed from eth1
[ 1716.957883][T15016] netdevsim netdevsim0 netdevsim2: renamed from eth2
[ 1716.960421][T15016] netdevsim netdevsim0 netdevsim3: renamed from eth3
[ 1716.968025][T15016] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[ 1716.970004][T15016] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[ 1716.971838][T15016] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[ 1716.973583][T15016] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[ 1716.980663][T15016] 8021q: adding VLAN 0 to HW filter on device bond0
[ 1716.983042][T15751] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[ 1716.985009][T15751] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[ 1716.988364][T15016] 8021q: adding VLAN 0 to HW filter on device team0
[ 1716.990438][T13561] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[ 1716.991352][T13561] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[ 1716.993024][T13561] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[ 1716.993948][T13561] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[ 1717.016034][T15016] 8021q: adding VLAN 0 to HW filter on device batadv0
[ 1717.021142][T15016] veth0_vlan: entered promiscuous mode
[ 1717.022564][T15016] veth1_vlan: entered promiscuous mode
[ 1717.025807][T15016] veth0_macvtap: entered promiscuous mode
[ 1717.026960][T15016] veth1_macvtap: entered promiscuous mode
[ 1717.028902][T15016] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_0
[ 1717.030270][T15016] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[ 1717.031702][T15016] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[ 1717.033580][T15016] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3f) already exists on: batadv_slave_1
[ 1717.034932][T15016] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[ 1717.036334][T15016] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[ 1717.037905][T15016] netdevsim netdevsim0 netdevsim0: set [1, 0]
type 2 family 0 port 6081 - 0
[ 1717.039133][T15016] netdevsim netdevsim0 netdevsim1: set [1, 0]
type 2 family 0 port 6081 - 0
[ 1717.040277][T15016] netdevsim netdevsim0 netdevsim2: set [1, 0]
type 2 family 0 port 6081 - 0
[ 1717.041440][T15016] netdevsim netdevsim0 netdevsim3: set [1, 0]
type 2 family 0 port 6081 - 0
[ 1717.116220][T13760] wlan0: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 1717.117190][T13760] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[ 1717.119939][T15751] wlan1: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 1717.121966][T15751] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[ 1717.128890][T16063] loop0: detected capacity change from 0 to 64
[ 1717.130222][T16063] BUG: kernel NULL pointer dereference, address:
0000000000000040
[ 1717.131287][T16063] #PF: supervisor read access in kernel mode
[ 1717.132067][T16063] #PF: error_code(0x0000) - not-present page
[ 1717.132844][T16063] PGD 129e5a067 P4D 129e5a067 PUD 1199de067 PMD 0
[ 1717.133700][T16063] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 1717.134454][T16063] CPU: 4 UID: 0 PID: 16063 Comm: syz.0.15 Not
tainted 6.12.0-rc1 #5
[ 1717.135494][T16063] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[1717.136709][T16063] RIP: 0010:hfs_find_init
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/bfind.c:21=
)
[ 1717.137407][T16063] Code: 0f 1f 00 55 48 89 e5 41 55 41 54 49 89 f4
53 48 89 fb e8 58 43 9f ff 49 89 5c 24 10 be c0 0c 00 00 49 c7 44 24
18 00 00 00 00 <8b> 43 40 8d 7c 00 09
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 0f 1f 00 nopl (%rax)
3: 55 push %rbp
4: 48 89 e5 mov %rsp,%rbp
7: 41 55 push %r13
9: 41 54 push %r12
b: 49 89 f4 mov %rsi,%r12
e: 53 push %rbx
f: 48 89 fb mov %rdi,%rbx
12: e8 58 43 9f ff call 0xffffffffff9f436f
17: 49 89 5c 24 10 mov %rbx,0x10(%r12)
1c: be c0 0c 00 00 mov $0xcc0,%esi
21: 49 c7 44 24 18 00 00 movq $0x0,0x18(%r12)
28: 00 00
2a:* 8b 43 40 mov 0x40(%rbx),%eax <-- trapping instruction
2d: 8d 7c 00 09 lea 0x9(%rax,%rax,1),%edi

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 8b 43 40 mov 0x40(%rbx),%eax
3: 8d 7c 00 09 lea 0x9(%rax,%rax,1),%edi
[ 1717.140059][T16063] RSP: 0018:ffff888125713978 EFLAGS: 00010293
[ 1717.141068][T16063] RAX: 0000000000000000 RBX: 0000000000000000
RCX: ffffffff81960dd1
[ 1717.142279][T16063] RDX: ffff888109814ec0 RSI: 0000000000000cc0
RDI: 0000000000000000
[ 1717.143481][T16063] RBP: ffff888125713990 R08: ffff888125713988
R09: 0000000000000000
[ 1717.144689][T16063] R10: 0000000000000000 R11: 0000000000000000
R12: ffff8881257139a8
[ 1717.145864][T16063] R13: 0000000000000000 R14: 0000000000000000
R15: 0000000000000004
[ 1717.147100][T16063] FS: 00007fe8154fd640(0000)
GS:ffff88813bb00000(0000) knlGS:0000000000000000
[ 1717.148462][T16063] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1717.149538][T16063] CR2: 0000000000000040 CR3: 000000011a2a2000
CR4: 00000000000006f0
[ 1717.150744][T16063] Call Trace:
[ 1717.151241][T16063] <TASK>
[1717.151699][T16063] ? show_regs
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/d=
umpstack.c:479)
[1717.152399][T16063] ? __die
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/d=
umpstack.c:421
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/du=
mpstack.c:434)
[1717.153004][T16063] ? page_fault_oops
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault=
.c:711)
[1717.153756][T16063] ? hfs_find_init
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/bfind.c:21=
)
[1717.154485][T16063] ? is_prefetch.constprop.0
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault=
.c:171)
[1717.155318][T16063] ? kernelmode_fixup_or_oops.constprop.0
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault=
.c:738)
[1717.156264][T16063] ? __bad_area_nosemaphore
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault=
.c:787)
[1717.157133][T16063] ? find_vma
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/mmap.c:968)
[1717.157795][T16063] ? bad_area_nosemaphore
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault=
.c:835)
[1717.158598][T16063] ? exc_page_fault
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault=
.c:1448
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault.=
c:1481
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault.=
c:1539)
[1717.159356][T16063] ? asm_exc_page_fault
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./arch/x86/includ=
e/asm/idtentry.h:623)
[1717.160156][T16063] ? hfs_ext_read_extent
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/extent.c:1=
96
(discriminator 1))
[1717.160959][T16063] ? hfs_find_init
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/bfind.c:21=
)
[1717.161722][T16063] ? hfs_find_init
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/bfind.c:19=
)
[1717.162442][T16063] hfs_ext_read_extent
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/extent.c:2=
01)
[1717.163230][T16063] ? __sanitizer_cov_trace_const_cmp1
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/kcov.c:302=
)
[1717.164225][T16063] ? __sanitizer_cov_trace_const_cmp4
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/kcov.c:316=
)
[1717.165186][T16063] hfs_get_block
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/extent.c:3=
67)
[1717.165961][T16063] block_read_full_folio
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/buffer.c:2402
(discriminator 3))
[1717.166799][T16063] ? __pfx_hfs_get_block
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/extent.c:3=
38)
[1717.167608][T16063] ? __pfx_hfs_read_folio
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/inode.c:33=
)
[1717.168420][T16063] hfs_read_folio
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/inode.c:35=
)
[1717.169111][T16063] filemap_read_folio
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/filemap.c:2367=
)
[1717.169867][T16063] do_read_cache_folio
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/filemap.c:3826=
)
[1717.170658][T16063] ? __pfx_hfs_read_folio
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/inode.c:33=
)
[1717.171463][T16063] read_cache_page
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/filemap.c:3892
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/filemap.c:3900)
[1717.172185][T16063] hfs_btree_open
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/btree.c:79=
)
[1717.172923][T16063] ? __bread_gfp
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/buffer.c:1496)
[1717.173609][T16063] hfs_mdb_get
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/mdb.c:199)
[1717.174275][T16063] hfs_fill_super
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/super.c:40=
8)
[1717.175009][T16063] ? __sanitizer_cov_trace_cmp4
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/kcov.c:289=
)
[1717.175887][T16063] ? __sanitizer_cov_trace_const_cmp4
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/kcov.c:316=
)
[1717.176832][T16063] ? sb_set_blocksize
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/block/bdev.c:189)
[1717.177615][T16063] ? setup_bdev_super
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:1595)
[1717.178363][T16063] ? __pfx_hfs_fill_super
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/super.c:38=
0)
[1717.179175][T16063] mount_bdev
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:1680)
[1717.179859][T16063] hfs_mount
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/super.c:45=
8)
[1717.180477][T16063] legacy_get_tree
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/fs_context.c:6=
64)
[1717.181166][T16063] vfs_get_tree
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:1801)
[1717.181861][T16063] path_mount
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:35=
08
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:383=
4)
[1717.182563][T16063] __x64_sys_mount
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:38=
48
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:405=
5
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:403=
2
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:403=
2)
[1717.183282][T16063] x64_sys_call
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/sy=
scall_64.c:36)
[1717.184009][T16063] do_syscall_64
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/co=
mmon.c:52
/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/com=
mon.c:83)
[1717.184714][T16063] entry_SYSCALL_64_after_hwframe
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/en=
try_64.S:130)
[ 1717.185613][T16063] RIP: 0033:0x7fe81479e49e
[ 1717.186289][T16063] Code: 48 c7 c0 ff ff ff ff eb aa e8 5e 20 00 00
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5
00 00 00 0f 05 <48> 3d 01 f0 ff ff 78
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 48 c7 c0 ff ff ff ff mov $0xffffffffffffffff,%rax
7: eb aa jmp 0xffffffffffffffb3
9: e8 5e 20 00 00 call 0x206c
e: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
15: 00 00 00
18: 0f 1f 40 00 nopl 0x0(%rax)
1c: f3 0f 1e fa endbr64
20: 49 89 ca mov %rcx,%r10
23: b8 a5 00 00 00 mov $0xa5,%eax
28: 0f 05 syscall
2a:* 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax <-- trapping instructio=
n
30: 78 .byte 0x78

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax
6: 78 .byte 0x78
[ 1717.189219][T16063] RSP: 002b:00007fe8154fcda8 EFLAGS: 00000246
ORIG_RAX: 00000000000000a5
[ 1717.190532][T16063] RAX: ffffffffffffffda RBX: 000000000000025c
RCX: 00007fe81479e49e
[ 1717.191730][T16063] RDX: 0000000020000240 RSI: 0000000020000040
RDI: 00007fe8154fce00
[ 1717.192929][T16063] RBP: 00007fe8154fce40 R08: 00007fe8154fce40
R09: 0000000003008800
[ 1717.194148][T16063] R10: 0000000003008800 R11: 0000000000000246
R12: 0000000020000240
[ 1717.195323][T16063] R13: 0000000020000040 R14: 00007fe8154fce00
R15: 0000000020000000
[ 1717.196566][T16063] </TASK>
[ 1717.197034][T16063] Modules linked in:
[ 1717.197632][T16063] CR2: 0000000000000040
[ 1717.198347][T16063] ---[ end trace 0000000000000000 ]---
[1717.199218][T16063] RIP: 0010:hfs_find_init
(/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/hfs/bfind.c:21=
)
[ 1717.200018][T16063] Code: 0f 1f 00 55 48 89 e5 41 55 41 54 49 89 f4
53 48 89 fb e8 58 43 9f ff 49 89 5c 24 10 be c0 0c 00 00 49 c7 44 24
18 00 00 00 00 <8b> 43 40 8d 7c 00 09
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 0f 1f 00 nopl (%rax)
3: 55 push %rbp
4: 48 89 e5 mov %rsp,%rbp
7: 41 55 push %r13
9: 41 54 push %r12
b: 49 89 f4 mov %rsi,%r12
e: 53 push %rbx
f: 48 89 fb mov %rdi,%rbx
12: e8 58 43 9f ff call 0xffffffffff9f436f
17: 49 89 5c 24 10 mov %rbx,0x10(%r12)
1c: be c0 0c 00 00 mov $0xcc0,%esi
21: 49 c7 44 24 18 00 00 movq $0x0,0x18(%r12)
28: 00 00
2a:* 8b 43 40 mov 0x40(%rbx),%eax <-- trapping instruction
2d: 8d 7c 00 09 lea 0x9(%rax,%rax,1),%edi

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 8b 43 40 mov 0x40(%rbx),%eax
3: 8d 7c 00 09 lea 0x9(%rax,%rax,1),%edi
[ 1717.202999][T16063] RSP: 0018:ffff888125713978 EFLAGS: 00010293
[ 1717.203929][T16063] RAX: 0000000000000000 RBX: 0000000000000000
RCX: ffffffff81960dd1
[ 1717.205136][T16063] RDX: ffff888109814ec0 RSI: 0000000000000cc0
RDI: 0000000000000000
[ 1717.206351][T16063] RBP: ffff888125713990 R08: ffff888125713988
R09: 0000000000000000
[ 1717.207566][T16063] R10: 0000000000000000 R11: 0000000000000000
R12: ffff8881257139a8
[ 1717.208763][T16063] R13: 0000000000000000 R14: 0000000000000000
R15: 0000000000000004
[ 1717.210026][T16063] FS: 00007fe8154fd640(0000)
GS:ffff88813bb00000(0000) knlGS:0000000000000000
[ 1717.211367][T16063] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1717.212372][T16063] CR2: 0000000000000040 CR3: 000000011a2a2000
CR4: 00000000000006f0
[ 1717.213617][T16063] Kernel panic - not syncing: Fatal exception
[ 1717.214884][T16063] Kernel Offset: disabled
[ 1717.215464][T16063] Rebooting in 86400 seconds..

