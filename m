Return-Path: <linux-fsdevel+bounces-69108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D51C6F44E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 129FE4F2F15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258EC25C804;
	Wed, 19 Nov 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnO+Cv2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F92571DE;
	Wed, 19 Nov 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561799; cv=none; b=eN80mcFWLebWYiUKENsTqLwdnAYkU1NTp71TXnyPpPYyausu7wXmBTdsKIINZsgaSjOV5GAeS+GyawEyhIpfWtca6QtlqRDxrG21h6BU15q5wUdo7Jfdjd0AcniQzSjD2c9jDlIMlG93KHITpuaqTp5/P2drD/UMGur63WZ3QAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561799; c=relaxed/simple;
	bh=vqC0PBJSFIKjl7Sy4G1VkEpMmGgtRSuM1mdcJchDjHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdbu5LPu7v67p1cWxxn6kqFrEAEHTVVjeV6tZUCfnEgcNNqBY7AommL38OBNkvolzXXXyaaeXWGRn43uhyZICnSycbXhgDX2KezgJRo0CqtxCm59I4n3+TqBGKPmfZsCZwrGmNzTP3y33jOLt/GXKvAAlYz7KWFlmnx4u+Vwly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnO+Cv2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC819C19425;
	Wed, 19 Nov 2025 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763561799;
	bh=vqC0PBJSFIKjl7Sy4G1VkEpMmGgtRSuM1mdcJchDjHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnO+Cv2kDekzZvcDru+Y5h8MACX5rU5Z/8zejy1U+f7W0OHxpS5VRmp/H6wiLHVpF
	 +5561Rj1lt45IasajB3sXmKuInA1xkCpafdXCis0IwvkAajQH3t/0fs2CEcwUhWvyl
	 g76zG99isBY1T/+FvlocYL94fOQLNuUOJadPMyK+D+nIpWoS+zp7ZTWkAE9ZHYePcZ
	 kqz6a8Ni0km552o5k7GADLl7f0zNxUvt6z+qDCqf/1N1c9P+pzifeOBoSR4C44wm3T
	 sZnilI1PjfV1HooG4l+jVdHV0kDocnf9NhQWB9ygooiBWB3cPqihILgsakyTHNsnbG
	 8TZ/Zh1MeCM7Q==
Date: Wed, 19 Nov 2025 15:16:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mehdi.benhadjkhelifa@gmail.com, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] memory leak in hfs_init_fs_context
Message-ID: <20251119-klebrig-mutwillig-3bd6043f1270@brauner>
References: <20251119-leitmotiv-freifahrt-c706880c1f0b@brauner>
 <691dd074.a70a0220.2ea503.001a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <691dd074.a70a0220.2ea503.001a.GAE@google.com>

On Wed, Nov 19, 2025 at 06:13:08AM -0800, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> pc
> 
> SYZFAIL: failed to recv rpc
> fd=3 want=4 recv=0 n=0 (errno 9: Bad file descriptor)
> 
> 
> Warning: Permanently added '10.128.10.29' (ED25519) to the list of known hosts.
> 2025/11/19 14:11:52 parsed 1 programs
> [   42.022753][ T5811] cgroup: Unknown subsys name 'net'
> [   42.175712][ T5811] cgroup: Unknown subsys name 'cpuset'
> [   42.182256][ T5811] cgroup: Unknown subsys name 'rlimit'
> Setting up swapspace version 1, size = 127995904 bytes
> [   50.184013][ T5811] Adding 124996k swap on ./swap-file.  Priority:0 extents:1 across:124996k 
> [   51.419720][ T5824] soft_limit_in_bytes is deprecated and will be removed. Please report your usecase to linux-mm@kvack.org if you depend on this functionality.
> [   51.816926][   T58] wlan0: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
> [   51.825249][   T58] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:50
> [   51.836771][   T31] wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
> [   51.844633][   T31] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
> [   51.992800][ T5887] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > 1
> [   52.000051][ T5887] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > 9
> [   52.007203][ T5887] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > 9
> [   52.014500][ T5887] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > 4
> [   52.021816][ T5887] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
> [   52.104921][ T5895] chnl_net:caif_netlink_parms(): no params data found
> [   52.123774][ T5895] bridge0: port 1(bridge_slave_0) entered blocking state
> [   52.130962][ T5895] bridge0: port 1(bridge_slave_0) entered disabled state
> [   52.138313][ T5895] bridge_slave_0: entered allmulticast mode
> [   52.144523][ T5895] bridge_slave_0: entered promiscuous mode
> [   52.151904][ T5895] bridge0: port 2(bridge_slave_1) entered blocking state
> [   52.159070][ T5895] bridge0: port 2(bridge_slave_1) entered disabled state
> [   52.166257][ T5895] bridge_slave_1: entered allmulticast mode
> [   52.172607][ T5895] bridge_slave_1: entered promiscuous mode
> [   52.184675][ T5895] bond0: (slave bond_slave_0): Enslaving as an active interface with an up link
> [   52.194790][ T5895] bond0: (slave bond_slave_1): Enslaving as an active interface with an up link
> [   52.210335][ T5895] team0: Port device team_slave_0 added
> [   52.216530][ T5895] team0: Port device team_slave_1 added
> [   52.226332][ T5895] batman_adv: batadv0: Adding interface: batadv_slave_0
> [   52.233294][ T5895] batman_adv: batadv0: The MTU of interface batadv_slave_0 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1532 would solve the problem.
> [   52.259593][ T5895] batman_adv: batadv0: Not using interface batadv_slave_0 (retrying later): interface not active
> [   52.270857][ T5895] batman_adv: batadv0: Adding interface: batadv_slave_1
> [   52.277950][ T5895] batman_adv: batadv0: The MTU of interface batadv_slave_1 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1532 would solve the problem.
> [   52.304091][ T5895] batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
> [   52.330778][ T5895] hsr_slave_0: entered promiscuous mode
> [   52.337739][ T5895] hsr_slave_1: entered promiscuous mode
> [   52.365548][ T5895] netdevsim netdevsim0 netdevsim0: renamed from eth0
> [   52.373816][ T5895] netdevsim netdevsim0 netdevsim1: renamed from eth1
> [   52.382570][ T5895] netdevsim netdevsim0 netdevsim2: renamed from eth2
> [   52.390442][ T5895] netdevsim netdevsim0 netdevsim3: renamed from eth3
> [   52.402050][ T5895] bridge0: port 2(bridge_slave_1) entered blocking state
> [   52.409208][ T5895] bridge0: port 2(bridge_slave_1) entered forwarding state
> [   52.416560][ T5895] bridge0: port 1(bridge_slave_0) entered blocking state
> [   52.424189][ T5895] bridge0: port 1(bridge_slave_0) entered forwarding state
> [   52.442787][ T5895] 8021q: adding VLAN 0 to HW filter on device bond0
> [   52.452023][   T31] bridge0: port 1(bridge_slave_0) entered disabled state
> [   52.461111][   T31] bridge0: port 2(bridge_slave_1) entered disabled state
> [   52.470558][ T5895] 8021q: adding VLAN 0 to HW filter on device team0
> [   52.479109][   T31] bridge0: port 1(bridge_slave_0) entered blocking state
> [   52.486350][   T31] bridge0: port 1(bridge_slave_0) entered forwarding state
> [   52.496004][ T2979] bridge0: port 2(bridge_slave_1) entered blocking state
> [   52.503421][ T2979] bridge0: port 2(bridge_slave_1) entered forwarding state
> [   52.520122][ T5895] hsr0: Slave A (hsr_slave_0) is not up; please bring it up to get a fully working HSR network
> [   52.531213][ T5895] hsr0: Slave B (hsr_slave_1) is not up; please bring it up to get a fully working HSR network
> [   52.567709][ T5895] 8021q: adding VLAN 0 to HW filter on device batadv0
> [   52.582539][ T5895] veth0_vlan: entered promiscuous mode
> [   52.589714][ T5895] veth1_vlan: entered promiscuous mode
> [   52.600093][ T5895] veth0_macvtap: entered promiscuous mode
> [   52.606771][ T5895] veth1_macvtap: entered promiscuous mode
> [   52.615855][ T5895] batman_adv: batadv0: Interface activated: batadv_slave_0
> [   52.625167][ T5895] batman_adv: batadv0: Interface activated: batadv_slave_1
> [   52.634137][   T58] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 family 0 port 6081 - 0
> [   52.642907][   T58] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
> [   52.652172][   T58] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
> [   52.661018][   T58] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
> [   52.696362][   T35] netdevsim netdevsim0 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
> [   52.736176][   T35] netdevsim netdevsim0 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
> [   52.776000][   T35] netdevsim netdevsim0 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
> 2025/11/19 14:12:05 executed programs: 0
> [   52.826029][   T35] netdevsim netdevsim0 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
> [   55.913007][   T35] bridge_slave_1: left allmulticast mode
> [   55.924242][   T35] bridge_slave_1: left promiscuous mode
> [   55.930898][   T35] bridge0: port 2(bridge_slave_1) entered disabled state
> [   55.939182][   T35] bridge_slave_0: left allmulticast mode
> [   55.945141][   T35] bridge_slave_0: left promiscuous mode
> [   55.951004][   T35] bridge0: port 1(bridge_slave_0) entered disabled state
> [   56.026188][   T35] bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
> [   56.036592][   T35] bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
> [   56.046139][   T35] bond0 (unregistering): Released all slaves
> [   56.106597][   T35] hsr_slave_0: left promiscuous mode
> [   56.112214][   T35] hsr_slave_1: left promiscuous mode
> [   56.118098][   T35] batman_adv: batadv0: Interface deactivated: batadv_slave_0
> [   56.126443][   T35] batman_adv: batadv0: Removing interface: batadv_slave_0
> [   56.133898][   T35] batman_adv: batadv0: Interface deactivated: batadv_slave_1
> [   56.141694][   T35] batman_adv: batadv0: Removing interface: batadv_slave_1
> [   56.150927][   T35] veth1_macvtap: left promiscuous mode
> [   56.157067][   T35] veth0_macvtap: left promiscuous mode
> [   56.163187][   T35] veth1_vlan: left promiscuous mode
> [   56.168965][   T35] veth0_vlan: left promiscuous mode
> [   56.196836][   T35] team0 (unregistering): Port device team_slave_1 removed
> [   56.205815][   T35] team0 (unregistering): Port device team_slave_0 removed
> [   58.084150][ T5133] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > 1
> [   58.091289][ T5133] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > 9
> [   58.098477][ T5133] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > 9
> [   58.105739][ T5133] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > 4
> [   58.112872][ T5133] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
> [   58.147089][ T5988] chnl_net:caif_netlink_parms(): no params data found
> [   58.166338][ T5988] bridge0: port 1(bridge_slave_0) entered blocking state
> [   58.173578][ T5988] bridge0: port 1(bridge_slave_0) entered disabled state
> [   58.180784][ T5988] bridge_slave_0: entered allmulticast mode
> [   58.187051][ T5988] bridge_slave_0: entered promiscuous mode
> [   58.193583][ T5988] bridge0: port 2(bridge_slave_1) entered blocking state
> [   58.200740][ T5988] bridge0: port 2(bridge_slave_1) entered disabled state
> [   58.207833][ T5988] bridge_slave_1: entered allmulticast mode
> [   58.214030][ T5988] bridge_slave_1: entered promiscuous mode
> [   58.225238][ T5988] bond0: (slave bond_slave_0): Enslaving as an active interface with an up link
> [   58.235910][ T5988] bond0: (slave bond_slave_1): Enslaving as an active interface with an up link
> [   58.251413][ T5988] team0: Port device team_slave_0 added
> [   58.257776][ T5988] team0: Port device team_slave_1 added
> [   58.267463][ T5988] batman_adv: batadv0: Adding interface: batadv_slave_0
> [   58.274482][ T5988] batman_adv: batadv0: The MTU of interface batadv_slave_0 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1532 would solve the problem.
> [   58.300974][ T5988] batman_adv: batadv0: Not using interface batadv_slave_0 (retrying later): interface not active
> [   58.311990][ T5988] batman_adv: batadv0: Adding interface: batadv_slave_1
> [   58.318969][ T5988] batman_adv: batadv0: The MTU of interface batadv_slave_1 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1532 would solve the problem.
> [   58.344994][ T5988] batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
> [   58.362193][ T5988] hsr_slave_0: entered promiscuous mode
> [   58.368062][ T5988] hsr_slave_1: entered promiscuous mode
> [   58.548290][ T5988] netdevsim netdevsim0 netdevsim0: renamed from eth0
> [   58.556831][ T5988] netdevsim netdevsim0 netdevsim1: renamed from eth1
> [   58.564665][ T5988] netdevsim netdevsim0 netdevsim2: renamed from eth2
> [   58.572522][ T5988] netdevsim netdevsim0 netdevsim3: renamed from eth3
> [   58.586118][ T5988] bridge0: port 2(bridge_slave_1) entered blocking state
> [   58.593280][ T5988] bridge0: port 2(bridge_slave_1) entered forwarding state
> [   58.600654][ T5988] bridge0: port 1(bridge_slave_0) entered blocking state
> [   58.607726][ T5988] bridge0: port 1(bridge_slave_0) entered forwarding state
> [   58.630191][ T5988] 8021q: adding VLAN 0 to HW filter on device bond0
> [   58.640402][   T58] bridge0: port 1(bridge_slave_0) entered disabled state
> [   58.649632][   T58] bridge0: port 2(bridge_slave_1) entered disabled state
> [   58.659837][ T5988] 8021q: adding VLAN 0 to HW filter on device team0
> [   58.669532][   T58] bridge0: port 1(bridge_slave_0) entered blocking state
> [   58.676712][   T58] bridge0: port 1(bridge_slave_0) entered forwarding state
> [   58.686492][   T35] bridge0: port 2(bridge_slave_1) entered blocking state
> [   58.693655][   T35] bridge0: port 2(bridge_slave_1) entered forwarding state
> [   58.709390][ T5988] hsr0: Slave A (hsr_slave_0) is not up; please bring it up to get a fully working HSR network
> [   58.720129][ T5988] hsr0: Slave B (hsr_slave_1) is not up; please bring it up to get a fully working HSR network
> [   58.769091][ T5988] 8021q: adding VLAN 0 to HW filter on device batadv0
> [   58.787789][ T5988] veth0_vlan: entered promiscuous mode
> [   58.795800][ T5988] veth1_vlan: entered promiscuous mode
> [   58.808550][ T5988] veth0_macvtap: entered promiscuous mode
> [   58.816434][ T5988] veth1_macvtap: entered promiscuous mode
> [   58.826869][ T5988] batman_adv: batadv0: Interface activated: batadv_slave_0
> [   58.837590][ T5988] batman_adv: batadv0: Interface activated: batadv_slave_1
> [   58.847552][ T2979] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 family 0 port 6081 - 0
> [   58.862969][ T2979] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
> [   58.881016][ T2979] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
> [   58.894676][   T35] wlan0: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
> [   58.903471][   T35] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:50
> SYZFAIL: failed to recv rpc
> fd=3 want=4 recv=0 n=0 (errno 9: Bad file descriptor)
> [   58.917260][   T31] wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
> [   58.925507][ T2979] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
> [   58.934333][   T31] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
> 
> 
> syzkaller build log:
> go env (err=<nil>)
> AR='ar'
> CC='gcc'
> CGO_CFLAGS='-O2 -g'
> CGO_CPPFLAGS=''
> CGO_CXXFLAGS='-O2 -g'
> CGO_ENABLED='1'
> CGO_FFLAGS='-O2 -g'
> CGO_LDFLAGS='-O2 -g'
> CXX='g++'
> GCCGO='gccgo'
> GO111MODULE='auto'
> GOAMD64='v1'
> GOARCH='amd64'
> GOAUTH='netrc'
> GOBIN=''
> GOCACHE='/syzkaller/.cache/go-build'
> GOCACHEPROG=''
> GODEBUG=''
> GOENV='/syzkaller/.config/go/env'
> GOEXE=''
> GOEXPERIMENT=''
> GOFIPS140='off'
> GOFLAGS=''
> GOGCCFLAGS='-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -ffile-prefix-map=/tmp/go-build3582148735=/tmp/go-build -gno-record-gcc-switches'
> GOHOSTARCH='amd64'
> GOHOSTOS='linux'
> GOINSECURE=''
> GOMOD='/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod'
> GOMODCACHE='/syzkaller/jobs-2/linux/gopath/pkg/mod'
> GONOPROXY=''
> GONOSUMDB=''
> GOOS='linux'
> GOPATH='/syzkaller/jobs-2/linux/gopath'
> GOPRIVATE=''
> GOPROXY='https://proxy.golang.org,direct'
> GOROOT='/usr/local/go'
> GOSUMDB='sum.golang.org'
> GOTELEMETRY='local'
> GOTELEMETRYDIR='/syzkaller/.config/go/telemetry'
> GOTMPDIR=''
> GOTOOLCHAIN='auto'
> GOTOOLDIR='/usr/local/go/pkg/tool/linux_amd64'
> GOVCS=''
> GOVERSION='go1.24.4'
> GOWORK=''
> PKG_CONFIG='pkg-config'
> 
> git status (err=<nil>)
> HEAD detached at 4e1406b4d
> nothing to commit, working tree clean
> 
> 
> tput: No value for $TERM and no -T specified
> tput: No value for $TERM and no -T specified
> Makefile:31: run command via tools/syz-env for best compatibility, see:
> Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
> go list -f '{{.Stale}}' -ldflags="-s -w -X github.com/google/syzkaller/prog.GitRevision=4e1406b4defac0e2a9d9424c70706f79a7750cf3 -X github.com/google/syzkaller/prog.gitRevisionDate=20251106-151142"  ./sys/syz-sysgen | grep -q false || go install -ldflags="-s -w -X github.com/google/syzkaller/prog.GitRevision=4e1406b4defac0e2a9d9424c70706f79a7750cf3 -X github.com/google/syzkaller/prog.gitRevisionDate=20251106-151142"  ./sys/syz-sysgen
> make .descriptions
> tput: No value for $TERM and no -T specified
> tput: No value for $TERM and no -T specified
> Makefile:31: run command via tools/syz-env for best compatibility, see:
> Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
> bin/syz-sysgen
> touch .descriptions
> GOOS=linux GOARCH=amd64 go build -ldflags="-s -w -X github.com/google/syzkaller/prog.GitRevision=4e1406b4defac0e2a9d9424c70706f79a7750cf3 -X github.com/google/syzkaller/prog.gitRevisionDate=20251106-151142"  -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
> mkdir -p ./bin/linux_amd64
> g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
> 	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -std=c++17 -I. -Iexecutor/_include   -DGOOS_linux=1 -DGOARCH_amd64=1 \
> 	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"4e1406b4defac0e2a9d9424c70706f79a7750cf3\"
> /usr/bin/ld: /tmp/ccMkllK7.o: in function `Connection::Connect(char const*, char const*)':
> executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEPKcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
> ./tools/check-syzos.sh 2>/dev/null
> 
> 
> Error text is too large and was truncated, full error text is at:
> https://syzkaller.appspot.com/x/error.txt?x=10715332580000
> 
> 
> Tested on:
> 
> commit:         058747ce hfs: ensure sb->s_fs_info is always cleaned up
> git tree:       https://github.com/brauner/linux.git work.hfs.fixes
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f30cc590c4f6da44
> dashboard link: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Note: no patches were applied.

Groan, unrelated error.
What do I do? Just restart?

#syz test https://github.com/brauner/linux.git work.hfs.fixes


