Return-Path: <linux-fsdevel+bounces-70644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C49CA32FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 11:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BADF30F126B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 10:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4E9331A65;
	Thu,  4 Dec 2025 10:13:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6032DA77D
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843185; cv=none; b=Mx8N9rdMsautUW/Y87EL6a3W95g9ZnlxUkvD/UXvF8JtXo8VQ/7O6qiTHo050P3tsHSTpNMnWZCqN4CKAahyyBgzCPdf5+h5RIWg2Rgy5ACI1h60JKm3pJSeYttM6ghjEBpOJito9qafxKZvC2szPllwLafO05IlgJC4qgPKLxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843185; c=relaxed/simple;
	bh=YTilCDnY7md8stSUobr/74gGwJP21g/iu4mTuQp1Qk4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JgDktKIDn0OwJ5xaVvuEkuQSP4g9u9s75C0U9sClAR0ZmKkJ3vArKM7mdsURQDqwn8CWFjzbgvt7dutDM8M670kT8NuRctQntTiw5STJyh2RnbjlpPFtDSE1M3SOSmDpGE5bp5pFGTz1i/XAiYzDyT8UKGZGorvPK8yyr5f2B6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4530ea23ce6so1039136b6e.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 02:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764843183; x=1765447983;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrWtb3AGiUZFdOqAGPsVDdYoxkQ82A3K4ITqkGXEKTY=;
        b=j39mk0mzCfiIHRdS8KFIS1AS6HAS4OShdnQtl9q98EHffEh27JOW3ce6odoqCS1Mp3
         evumU9RB3McQsIvkd3drJr0HOrZdY1qvvZcfkQ7uhfkzPWS3ouNNJGYCYjMYfPTOZwWc
         hrwxbcVUwppjd3xt/+qmQ5polI5U+Qtm68MTRjYydgOQd5G9n002FGZ5YckNnxDcX8UT
         0Wg0LRjL/dK7UR3P1HDh94XEbk5dknDCO6Fowph4NhPJw573R4VuEkr+wrEYnbZhw13M
         AkpNXvx7rImCWoN1RFkXiSyYUeM5jNN57coJhU9+1H0CUmf+DFaTPH1IHHnJQB20EX/Q
         4RRg==
X-Forwarded-Encrypted: i=1; AJvYcCUP3d/nysHtsqJ5Q1/236nGcH7fWOJOfRHxaKkRhz2iYgSZjiZTT1XMfQpkSbBdzc9gySGNPTcySiTMfRGS@vger.kernel.org
X-Gm-Message-State: AOJu0YyEN1aGvkom9nKBcssfUlNS9ppT5pS9pT/Ffjw7zvNcbhwmGpQN
	b3eCvSSa8NZRAK1c+ULlKVMih0V665DmqyEVV3kJtJVX8qvsScDpmMvh2IW/T7yFjRPkAFOhMBJ
	xrTsguVkUardMUHFeTgESnEqiRvhKqCDOROdqTlmcjeW14ia6ERXzdaB7Tjk=
X-Google-Smtp-Source: AGHT+IE55KuGOJpck6ZHJ825oET39Lm4BcByQ1rdlEJTt3MmNSRTu73d2PjEjaaZr+4hSLnK9Y3KlPspZPpPKmbsnuMF474UEM2n
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:80b1:b0:441:8f74:fc4 with SMTP id
 5614622812f47-45379efb59bmr1220034b6e.65.1764843182874; Thu, 04 Dec 2025
 02:13:02 -0800 (PST)
Date: Thu, 04 Dec 2025 02:13:02 -0800
In-Reply-To: <27ec3nl274o3u3rx6gu6vqaqtwmmflgb45wflfyy3ihqs5w4fc@pdvkacnfnhrw>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69315eae.a70a0220.d98e3.01cd.GAE@google.com>
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
From: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	mjguzik@gmail.com, ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

SYZFAIL: failed to recv rpc

SYZFAIL: failed to recv rpc


Warning: Permanently added '10.128.0.177' (ED25519) to the list of known ho=
sts.
2025/12/04 10:11:47 parsed 1 programs
[   78.910789][ T5830] cgroup: Unknown subsys name 'net'
[   79.061524][ T5830] cgroup: Unknown subsys name 'cpuset'
[   79.071037][ T5830] cgroup: Unknown subsys name 'rlimit'
Setting up swapspace version 1, size =3D 127995904 bytes
[   80.470098][ T5830] Adding 124996k swap on ./swap-file.  Priority:0 exte=
nts:1 across:124996k=20
[   83.462586][ T5842] soft_limit_in_bytes is deprecated and will be remove=
d. Please report your usecase to linux-mm@kvack.org if you depend on this f=
unctionality.
[   83.768296][ T1303] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   83.776268][ T1303] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   84.018160][   T36] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   84.026332][   T36] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   84.079691][ T5149] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   84.089721][ T5149] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   84.097886][ T5149] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   84.120020][ T5149] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   84.128054][ T5149] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   86.764273][ T5914] chnl_net:caif_netlink_parms(): no params data found
[   86.952176][   T10] cfg80211: failed to load regulatory.db
[   86.970822][ T5914] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   86.987663][ T5914] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   86.995387][ T5914] bridge_slave_0: entered allmulticast mode
[   87.004680][ T5914] bridge_slave_0: entered promiscuous mode
[   87.019597][ T5914] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   87.038879][ T5914] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   87.046589][ T5914] bridge_slave_1: entered allmulticast mode
[   87.055691][ T5914] bridge_slave_1: entered promiscuous mode
[   87.132629][ T5914] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   87.165237][ T5914] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   87.263236][ T5914] team0: Port device team_slave_0 added
[   87.273397][ T5914] team0: Port device team_slave_1 added
[   87.303206][ T5914] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   87.311015][ T5914] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   87.339107][ T5914] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   87.352524][ T5914] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   87.360592][ T5914] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   87.387771][ T5914] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   87.429283][ T5914] hsr_slave_0: entered promiscuous mode
[   87.436383][ T5914] hsr_slave_1: entered promiscuous mode
[   87.589866][ T5914] netdevsim netdevsim2 netdevsim0: renamed from eth0
[   87.602532][ T5914] netdevsim netdevsim2 netdevsim1: renamed from eth1
[   87.612793][ T5914] netdevsim netdevsim2 netdevsim2: renamed from eth2
[   87.624712][ T5914] netdevsim netdevsim2 netdevsim3: renamed from eth3
[   87.702119][ T5914] 8021q: adding VLAN 0 to HW filter on device bond0
[   87.727060][ T5914] 8021q: adding VLAN 0 to HW filter on device team0
[   87.742924][ T3460] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   87.750338][ T3460] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   87.767840][   T13] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   87.775679][   T13] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   87.951069][ T5914] 8021q: adding VLAN 0 to HW filter on device batadv0
[   87.997784][ T5914] veth0_vlan: entered promiscuous mode
[   88.011677][ T5914] veth1_vlan: entered promiscuous mode
[   88.040488][ T5914] veth0_macvtap: entered promiscuous mode
[   88.050521][ T5914] veth1_macvtap: entered promiscuous mode
[   88.070672][ T5914] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   88.086679][ T5914] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   88.102451][ T1303] netdevsim netdevsim2 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   88.112929][ T1303] netdevsim netdevsim2 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   88.125269][ T1303] netdevsim netdevsim2 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   88.138936][ T1303] netdevsim netdevsim2 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
2025/12/04 10:11:58 executed programs: 0
[   88.265933][ T5149] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   88.275000][ T5149] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   88.283928][ T5149] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   88.294110][ T5149] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   88.303601][ T5149] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   88.516655][ T5945] chnl_net:caif_netlink_parms(): no params data found
[   88.589071][ T5945] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   88.597183][ T5945] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   88.605206][ T5945] bridge_slave_0: entered allmulticast mode
[   88.613430][ T5945] bridge_slave_0: entered promiscuous mode
[   88.621792][ T5945] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   88.629190][ T5945] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   88.636388][ T5945] bridge_slave_1: entered allmulticast mode
[   88.644502][ T5945] bridge_slave_1: entered promiscuous mode
[   88.679834][ T5945] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   88.693258][ T5945] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   88.729876][ T5945] team0: Port device team_slave_0 added
[   88.739741][ T5945] team0: Port device team_slave_1 added
[   88.770447][ T5945] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   88.778982][ T5945] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   88.806119][ T5945] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   88.819400][ T5945] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   88.826898][ T5945] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   88.854775][ T5945] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   88.906117][ T5945] hsr_slave_0: entered promiscuous mode
[   88.913653][ T5945] hsr_slave_1: entered promiscuous mode
[   88.920136][ T5945] debugfs: 'hsr0' already exists in 'hsr'
[   88.926073][ T5945] Cannot create hsr debugfs directory
[   89.100742][ T5945] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   89.113003][ T5945] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   89.123282][ T5945] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   89.134611][ T5945] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   89.164880][ T5945] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   89.172220][ T5945] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   89.180595][ T5945] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   89.188151][ T5945] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   89.201467][   T13] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   89.210194][   T13] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   89.271133][ T5945] 8021q: adding VLAN 0 to HW filter on device bond0
[   89.292385][ T5945] 8021q: adding VLAN 0 to HW filter on device team0
[   89.304472][   T13] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   89.311731][   T13] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   89.328520][ T1303] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   89.336026][ T1303] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   89.510299][ T5945] 8021q: adding VLAN 0 to HW filter on device batadv0
[   89.555268][ T5945] veth0_vlan: entered promiscuous mode
[   89.567506][ T5945] veth1_vlan: entered promiscuous mode
[   89.602029][ T5945] veth0_macvtap: entered promiscuous mode
[   89.611643][ T5945] veth1_macvtap: entered promiscuous mode
[   89.630992][ T5945] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   89.645744][ T5945] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   89.661459][   T13] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   89.675047][   T13] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   89.685863][   T13] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   89.695952][   T13] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   89.763899][ T3460] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   89.773242][ T3460] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   89.806188][   T13] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   89.814827][   T13] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
SYZFAIL: failed to recv rpc
[   90.239026][   T13] netdevsim netdevsim2 netdevsim3 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0


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
 -ffile-prefix-map=3D/tmp/go-build2089224975=3D/tmp/go-build -gno-record-gc=
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
/usr/bin/ld: /tmp/cc9mWJPn.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null



Tested on:

commit:         bc04acf4 Add linux-next specific files for 20251204
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da94030c847137a1=
8
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd222f4b7129379c3d=
5bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1731d01a5800=
00


