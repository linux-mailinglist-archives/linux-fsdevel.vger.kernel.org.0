Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEF378C74C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 16:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbjH2OUq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 10:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbjH2OUl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:20:41 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0255A110
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 07:20:36 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bf60f85d78so54207935ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 07:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693318835; x=1693923635;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykd8ZepMHXlJ1kVPrunVW+kI5L9fdPJ3pk7TpFfXR7w=;
        b=hBJoSX4+e07WgZDlDizUZ4mIxVU19pB2owtnbor5duVZNFyN/8zQF/fAuS+6dQ5xyt
         XZ8HVJpu9CVmAzxujWhtOpiKR59Pvhp0ZIEnU5+2K8FqeAZyFn+C7Ty0mFuWbM1nsh/t
         9t2uH8SvLrDniy23XcGNGMPY7pMOj9fg2bzh4FhQJXFXJkni2panPpvLnVnPi69ArWs8
         pK0fWIC9juBlhPkF0RecbYvgIgR2a7+iomwdkZ4S4IGi2NxkitGcUqLQ1WvpEjy9VwNh
         ZOChXVK4Y0E61zdCIZraoUM313pfuJqlBwHrHUubR1m7UP/tYdGcHCAuEfmhNrayYAnu
         A7VA==
X-Gm-Message-State: AOJu0Ywskn5dVOex8IIbqiov4NaGrOHEoR+8UrTOYyZ2Kfl8MCk17ZBv
        mgIx5d0sCwBysBP2YAZzldeZopDTUBoNhdzHZKWmBHpDx6tV
X-Google-Smtp-Source: AGHT+IEQjSQw6eu8AqMUUCtDkVsW3fm4mKH99fkoAgybc2Wi0R4Xt0V23AOHb+BjTJfDjOqbDSu3Yox/o4i9wRnFOlVUehshmikM
MIME-Version: 1.0
X-Received: by 2002:a17:902:dacd:b0:1bc:1866:fd0f with SMTP id
 q13-20020a170902dacd00b001bc1866fd0fmr9934596plx.9.1693318835565; Tue, 29 Aug
 2023 07:20:35 -0700 (PDT)
Date:   Tue, 29 Aug 2023 07:20:35 -0700
In-Reply-To: <834085d4-8a3c-43aa-a0ba-22207b70c1cf@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af7d47060410833a@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: use-after-free Read in btrfs_test_super
From:   syzbot <syzbot+65bb53688b6052f09c28@syzkaller.appspotmail.com>
To:     clm@fb.com, code@siddh.me, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

lizing XFRM netlink socket
[   14.885795][    T1] IPsec XFRM device driver
[   14.890969][    T1] NET: Registered PF_INET6 protocol family
[   14.911523][    T1] Segment Routing with IPv6
[   14.916046][    T1] RPL Segment Routing with IPv6
[   14.921986][    T1] In-situ OAM (IOAM) with IPv6
[   14.927746][    T1] mip6: Mobile IPv6
[   14.935984][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   14.952403][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   14.962840][    T1] NET: Registered PF_PACKET protocol family
[   14.969252][    T1] NET: Registered PF_KEY protocol family
[   14.975567][    T1] Bridge firewalling registered
[   14.981435][    T1] NET: Registered PF_X25 protocol family
[   14.988218][    T1] X25: Linux Version 0.2
[   15.043994][    T1] NET: Registered PF_NETROM protocol family
[   15.108172][    T1] NET: Registered PF_ROSE protocol family
[   15.114262][    T1] NET: Registered PF_AX25 protocol family
[   15.121387][    T1] can: controller area network core
[   15.129393][    T1] NET: Registered PF_CAN protocol family
[   15.135214][    T1] can: raw protocol
[   15.139548][    T1] can: broadcast manager protocol
[   15.144606][    T1] can: netlink gateway - max_hops=1
[   15.150115][    T1] can: SAE J1939
[   15.153780][    T1] can: isotp protocol (max_pdu_size 8300)
[   15.160013][    T1] Bluetooth: RFCOMM TTY layer initialized
[   15.165751][    T1] Bluetooth: RFCOMM socket layer initialized
[   15.172172][    T1] Bluetooth: RFCOMM ver 1.11
[   15.176941][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   15.183185][    T1] Bluetooth: BNEP filters: protocol multicast
[   15.189439][    T1] Bluetooth: BNEP socket layer initialized
[   15.195253][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   15.201168][    T1] Bluetooth: CMTP socket layer initialized
[   15.207046][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   15.213833][    T1] Bluetooth: HIDP socket layer initialized
[   15.223950][    T1] NET: Registered PF_RXRPC protocol family
[   15.229815][    T1] Key type rxrpc registered
[   15.234782][    T1] Key type rxrpc_s registered
[   15.240340][    T1] NET: Registered PF_KCM protocol family
[   15.247032][    T1] lec:lane_module_init: lec.c: initialized
[   15.253055][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   15.259251][    T1] l2tp_core: L2TP core driver, V2.0
[   15.264492][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   15.270428][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   15.277183][    T1] l2tp_netlink: L2TP netlink interface
[   15.282901][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   15.291834][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[   15.299851][    T1] NET: Registered PF_PHONET protocol family
[   15.306144][    T1] 8021q: 802.1Q VLAN Support v1.8
[   15.329922][    T1] DCCP: Activated CCID 2 (TCP-like)
[   15.335982][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   15.343079][    T1] DCCP is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
[   15.354425][    T1] sctp: Hash tables configured (bind 32/56)
[   15.361984][    T1] NET: Registered PF_RDS protocol family
[   15.368589][    T1] Registered RDS/infiniband transport
[   15.375224][    T1] Registered RDS/tcp transport
[   15.380063][    T1] tipc: Activated (version 2.0.0)
[   15.385926][    T1] NET: Registered PF_TIPC protocol family
[   15.392806][    T1] tipc: Started in single node mode
[   15.399102][    T1] NET: Registered PF_SMC protocol family
[   15.405230][    T1] 9pnet: Installing 9P2000 support
[   15.411417][    T1] NET: Registered PF_CAIF protocol family
[   15.423944][    T1] NET: Registered PF_IEEE802154 protocol family
[   15.430606][    T1] Key type dns_resolver registered
[   15.435802][    T1] Key type ceph registered
[   15.440780][    T1] libceph: loaded (mon/osd proto 15/24)
[   15.448554][    T1] batman_adv: B.A.T.M.A.N. advanced 2023.1 (compatibility version 15) loaded
[   15.458226][    T1] openvswitch: Open vSwitch switching datapath
[   15.468028][    T1] NET: Registered PF_VSOCK protocol family
[   15.474126][    T1] mpls_gso: MPLS GSO support
[   15.497716][    T1] IPI shorthand broadcast: enabled
[   15.502975][    T1] AVX2 version of gcm_enc/dec engaged.
[   15.508805][    T1] AES CTR mode by8 optimization enabled
[   17.223182][    T1] sched_clock: Marking stable (17180029827, 36587317)->(17221731302, -5114158)
[   17.243650][    T1] registered taskstats version 1
[   17.262388][    T1] Loading compiled-in X.509 certificates
[   17.273486][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: aa11228529d7ecff43d292c244cd4c0215eb484b'
[   17.286758][    T1] zswap: loaded using pool lzo/zbud
[   17.439896][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[   19.204518][    T1] Key type .fscrypt registered
[   19.209480][    T1] Key type fscrypt-provisioning registered
[   19.220257][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   19.239869][    T1] Btrfs loaded, assert=on, ref-verify=on, zoned=yes, fsverity=yes
[   19.248647][    T1] Key type big_key registered
[   19.255671][    T1] Key type encrypted registered
[   19.260647][    T1] AppArmor: AppArmor sha1 policy hashing enabled
[   19.267301][    T1] ima: No TPM chip found, activating TPM-bypass!
[   19.273634][    T1] Loading compiled-in module X.509 certificates
[   19.284091][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: aa11228529d7ecff43d292c244cd4c0215eb484b'
[   19.295158][    T1] ima: Allocated hash algorithm: sha256
[   19.300987][    T1] ima: No architecture policies found
[   19.306858][    T1] evm: Initialising EVM extended attributes:
[   19.312841][    T1] evm: security.selinux (disabled)
[   19.317980][    T1] evm: security.SMACK64 (disabled)
[   19.323076][    T1] evm: security.SMACK64EXEC (disabled)
[   19.329157][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   19.335024][    T1] evm: security.SMACK64MMAP (disabled)
[   19.340477][    T1] evm: security.apparmor
[   19.344692][    T1] evm: security.ima
[   19.348592][    T1] evm: security.capability
[   19.353504][    T1] evm: HMAC attrs: 0x1
[   19.359430][    T1] PM:   Magic number: 3:294:183
[   19.364856][    T1] tty ttyr9: hash matches
[   19.371437][    T1] printk: console [netcon0] enabled
[   19.376734][    T1] netconsole: network logging started
[   19.382571][    T1] gtp: GTP module loaded (pdp ctx size 104 bytes)
[   19.390465][    T1] rdma_rxe: loaded
[   19.394775][    T1] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   19.405588][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   19.413593][    T7] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   19.419610][    T1] clk: Disabling unused clocks
[   19.423838][    T7] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[   19.429868][    T1] ALSA device list:
[   19.442565][    T1]   #0: Dummy 1
[   19.446585][    T1]   #1: Loopback 1
[   19.450479][    T1]   #2: Virtual MIDI Card 1
[   19.459241][    T1] md: Waiting for all devices to be available before autodetect
[   19.467371][    T1] md: If you don't use raid, use raid=noautodetect
[   19.473915][    T1] md: Autodetecting RAID arrays.
[   19.480271][    T1] md: autorun ...
[   19.483987][    T1] md: ... autorun DONE.
[   19.533391][    T1] /dev/root: Can't open blockdev
[   19.538686][    T1] VFS: Cannot open root device "/dev/sda1" or unknown-block(8,1): error -6
[   19.547577][    T1] Please append a correct "root=" boot option; here are the available partitions:
[   19.556790][    T1] 0100            4096 ram0 
[   19.556809][    T1]  (driver?)
[   19.565429][    T1] 0101            4096 ram1 
[   19.565445][    T1]  (driver?)
[   19.573450][    T1] 0102            4096 ram2 
[   19.573466][    T1]  (driver?)
[   19.581675][    T1] 0103            4096 ram3 
[   19.581693][    T1]  (driver?)
[   19.589670][    T1] 0104            4096 ram4 
[   19.589685][    T1]  (driver?)
[   19.597776][    T1] 0105            4096 ram5 
[   19.597800][    T1]  (driver?)
[   19.606208][    T1] 0106            4096 ram6 
[   19.606226][    T1]  (driver?)
[   19.614272][    T1] 0107            4096 ram7 
[   19.614290][    T1]  (driver?)
[   19.622759][    T1] 0108            4096 ram8 
[   19.622776][    T1]  (driver?)
[   19.631267][    T1] 0109            4096 ram9 
[   19.631284][    T1]  (driver?)
[   19.639190][    T1] 010a            4096 ram10 
[   19.639205][    T1]  (driver?)
[   19.647168][    T1] 010b            4096 ram11 
[   19.647182][    T1]  (driver?)
[   19.655150][    T1] 010c            4096 ram12 
[   19.655163][    T1]  (driver?)
[   19.663673][    T1] 010d            4096 ram13 
[   19.663693][    T1]  (driver?)
[   19.671911][    T1] 010e            4096 ram14 
[   19.671932][    T1]  (driver?)
[   19.680112][    T1] 010f            4096 ram15 
[   19.680130][    T1]  (driver?)
[   19.688831][    T1] fa00       262144000 nullb0 
[   19.688845][    T1]  (driver?)
[   19.696919][    T1] 1f00             128 mtdblock0 
[   19.696933][    T1]  (driver?)
[   19.705681][    T1] 0800         2097152 sda 
[   19.705697][    T1]  driver: sd
[   19.713493][    T1]   0801         1048576 sda1 00000000-01
[   19.713508][    T1] 
[   19.721644][    T1] List of all bdev filesystems:
[   19.726478][    T1]  reiserfs
[   19.726486][    T1]  ext3
[   19.729712][    T1]  ext2
[   19.732551][    T1]  ext4
[   19.735324][    T1]  cramfs
[   19.738114][    T1]  squashfs
[   19.741050][    T1]  minix
[   19.744150][    T1]  vfat
[   19.747003][    T1]  msdos
[   19.749924][    T1]  exfat
[   19.753045][    T1]  bfs
[   19.755989][    T1]  iso9660
[   19.758690][    T1]  hfsplus
[   19.761707][    T1]  hfs
[   19.764723][    T1]  vxfs
[   19.767580][    T1]  sysv
[   19.770336][    T1]  v7
[   19.773259][    T1]  hpfs
[   19.775830][    T1]  ntfs
[   19.778604][    T1]  ntfs3
[   19.781355][    T1]  ufs
[   19.784189][    T1]  efs
[   19.786986][    T1]  affs
[   19.789679][    T1]  romfs
[   19.792422][    T1]  qnx4
[   19.795339][    T1]  qnx6
[   19.798305][    T1]  adfs
[   19.801089][    T1]  fuseblk
[   19.803927][    T1]  udf
[   19.807090][    T1]  omfs
[   19.809934][    T1]  jfs
[   19.812694][    T1]  xfs
[   19.815354][    T1]  nilfs2
[   19.818113][    T1]  befs
[   19.821138][    T1]  ocfs2
[   19.823984][    T1]  gfs2
[   19.826975][    T1]  gfs2meta
[   19.829746][    T1]  f2fs
[   19.832868][    T1]  erofs
[   19.835653][    T1]  zonefs
[   19.838706][    T1]  btrfs
[   19.842173][    T1] 
[   19.847649][    T1] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,1)
[   19.856898][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc2-syzkaller-00053-ga91589157e45 #0
[   19.866691][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
[   19.877007][    T1] Call Trace:
[   19.880297][    T1]  <TASK>
[   19.883405][    T1]  dump_stack_lvl+0xd9/0x1b0
[   19.888194][    T1]  panic+0x6a4/0x750
[   19.892084][    T1]  ? panic_smp_self_stop+0xa0/0xa0
[   19.897218][    T1]  ? do_raw_spin_unlock+0x173/0x230
[   19.902634][    T1]  mount_root_generic+0x2ac/0x460
[   19.907783][    T1]  ? init_rootfs+0x60/0x60
[   19.912208][    T1]  ? kmem_cache_alloc+0x34e/0x3b0
[   19.917279][    T1]  ? getname_kernel+0x21c/0x360
[   19.924262][    T1]  mount_root+0x241/0x480
[   19.928705][    T1]  ? kmem_cache_alloc+0x34e/0x3b0
[   19.934024][    T1]  ? driver_sysfs_add+0x2c0/0x2c0
[   19.939210][    T1]  ? mount_root_generic+0x460/0x460
[   19.944596][    T1]  ? md_compat_ioctl+0x70/0x70
[   19.949385][    T1]  ? getname_kernel+0x21c/0x360
[   19.954279][    T1]  prepare_namespace+0xe3/0x3a0
[   19.959143][    T1]  ? mount_root+0x480/0x480
[   19.963907][    T1]  ? fput+0x30/0x1a0
[   19.967874][    T1]  kernel_init_freeable+0x6fe/0x8f0
[   19.973102][    T1]  ? rest_init+0x2b0/0x2b0
[   19.977548][    T1]  kernel_init+0x1c/0x2a0
[   19.982056][    T1]  ? rest_init+0x2b0/0x2b0
[   19.986469][    T1]  ret_from_fork+0x2c/0x70
[   19.991232][    T1]  ? rest_init+0x2b0/0x2b0
[   19.995991][    T1]  ret_from_fork_asm+0x11/0x20
[   20.000926][    T1] RIP: 0000:0x0
[   20.004380][    T1] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   20.011757][    T1] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
[   20.020479][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   20.028796][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   20.037185][    T1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   20.045430][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   20.053602][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   20.062538][    T1]  </TASK>
[   20.066456][    T1] Kernel Offset: disabled
[   20.070903][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.20.1"
GCCGO="gccgo"
GOAMD64="v1"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mod"
GOWORK=""
CGO_CFLAGS="-O2 -g"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-O2 -g"
CGO_FFLAGS="-O2 -g"
CGO_LDFLAGS="-O2 -g"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build2408059581=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 03d9c195d
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=03d9c195daed8fca30b642783f35657aa7e32209 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230825-085153'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=03d9c195daed8fca30b642783f35657aa7e32209 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230825-085153'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=03d9c195daed8fca30b642783f35657aa7e32209 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230825-085153'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"03d9c195daed8fca30b642783f35657aa7e32209\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=110016cba80000


Tested on:

commit:         a9158915 mtd: key superblock by device number
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.super
kernel config:  https://syzkaller.appspot.com/x/.config?x=508c762d5be0ada8
dashboard link: https://syzkaller.appspot.com/bug?extid=65bb53688b6052f09c28
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
