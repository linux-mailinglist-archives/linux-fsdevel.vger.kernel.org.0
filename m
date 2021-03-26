Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3079834A43A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 10:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCZJWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhCZJVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:21:48 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7011CC0613AA
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Mar 2021 02:21:47 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q26so4547139qkm.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Mar 2021 02:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5R/OsCrfOhAkAC9wHW67hb0GX0UwxDY8KZQaXm/H/U=;
        b=fH/Vq3g7AGLmH/wsL403Ckzl2fdiB7paMjQhOn9sEbOa+qDcHlBmJLzKEYIvZz8lCY
         VHC/38UKBxaVgYJf6Ftir0gSMJEb40+7F4gHwxyo/WYxGCgUhELyQFb63jUxdJTrdmId
         +Lgu9mZ4E9qFucVl1A+kxja7QRwjGDq74pCef0YtzlwXVsFVepfEXhEXjJgLQW9QDm8l
         4SkwISmQy2yXENMOFENIP+OiI86qjVEGqJL4kYo/YKUO2ltuFLtb+O3ETjqcRqQPgjZv
         udbluclz8ZAWMauVV2O+x96Yj6twNTwiVNx/27nLVJuNq3LXMYtCp+XNNikZcjuJ2//o
         940Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5R/OsCrfOhAkAC9wHW67hb0GX0UwxDY8KZQaXm/H/U=;
        b=HCiz2R9sFYy3hBGOxpAmEmTPqoRnOpsAIIysjK8O5ByXY4vY2rRPSW+oW0QJbdiUvz
         Pqv8ftDYwVLGEK5WQ18R6MnnEvt11DSU5wZB5dbMYdYiy+DuQ0SbZ1iL4/+j9so4hmDe
         BczxlZnvpkRkaNoyEeogkMmdUaHSzzYBpwQrhcU7x+vbmy9RiyyQyREZiEd5OGh1NTun
         +TFWu9w92TfBL/IDAGX5aBqtKJiasYqMWtLC6kkLUdymaGkyfvHkkjcJ8KLgr/yVFFtp
         B7eCoImaRm+wOWwziLQyQ89k3ylmQtM0vIntrLFwFPU8bmQ+jtXRTTkcDxvHpUqc59IK
         vHcw==
X-Gm-Message-State: AOAM531oKssqRhfLduozZMq0BtVnowshI8TXxpoR9N5Tuu0zlbwLlEmP
        HPtLnmw/HfhBqDDfY4gCk8Wskz5f/oFAzecnivpFtA==
X-Google-Smtp-Source: ABdhPJzjnqGNKANGVaP/JQ6glc7MmANjyI/EW1dVvA9e6eyoLY/xXzHwL6rs2XrrIa7OLZ2S07vNQIOXQOzCySKrlt8=
X-Received: by 2002:ae9:e513:: with SMTP id w19mr12656866qkf.231.1616750506171;
 Fri, 26 Mar 2021 02:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069c40405be6bdad4@google.com> <CACT4Y+baP24jKmj-trhF8bG_d_zkz8jN7L1kYBnUR=EAY6hOaA@mail.gmail.com>
 <20210326091207.5si6knxs7tn6rmod@wittgenstein>
In-Reply-To: <20210326091207.5si6knxs7tn6rmod@wittgenstein>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 26 Mar 2021 10:21:34 +0100
Message-ID: <CACT4Y+atQdf_fe3BPFRGVCzT1Ba3V_XjAo6XsRciL8nwt4wasw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in filp_close (2)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     syzbot <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 26, 2021 at 10:12 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Fri, Mar 26, 2021 at 09:02:08AM +0100, Dmitry Vyukov wrote:
> > On Fri, Mar 26, 2021 at 8:55 AM syzbot
> > <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    5ee96fa9 Merge tag 'irq-urgent-2021-03-21' of git://git.ke..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17fb84bed00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=6abda3336c698a07
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=283ce5a46486d6acdbaf
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com
> >
> > I was able to reproduce this with the following C program:
> > https://gist.githubusercontent.com/dvyukov/00fb7aae489f22c60b4e64b45ef14d60/raw/cb368ca523d01986c2917f4414add0893b8f4243/gistfile1.txt
> >
> > +Christian
> > The repro also contains close_range as the previous similar crash:
> > https://syzkaller.appspot.com/bug?id=1bef50bdd9622a1969608d1090b2b4a588d0c6ac
> > I don't know if it's related or not in this case, but looks suspicious.
>
> Hm, I fail to reproduce this with your repro. Do you need to have it run
> for a long time?
> One thing that strucky my eye is that binfmt_misc gets setup which made
> me go huh and I see commit
>
> commit e7850f4d844e0acfac7e570af611d89deade3146
> Author: Lior Ribak <liorribak@gmail.com>
> Date:   Fri Mar 12 21:07:41 2021 -0800
>
>     binfmt_misc: fix possible deadlock in bm_register_write
>
> which uses filp_close() after having called open_exec() on the
> interpreter which makes me wonder why this doesn't have to use fput()
> like in all other codepaths for binfmnt_*.
>
> Can you revert this commit and see if you can reproduce this issue.
> Maybe this is a complete red herring but worth a try.


This program reproduces the crash for me almost immediately. Are you
sure you used the right commit/config?

I tried to revert the commit, but it still crashed:

    Revert "binfmt_misc: pass binfmt_misc flags to the interpreter"
    This reverts commit 2347961b11d4079deace3c81dceed460c08a8fc1.

root@syzkaller:~# ./a.out
[   52.774025][ T8417] cgroup: Unknown subsys name 'cpuset'
[   52.774025][ T8419] cgroup: Unknown subsys name 'cpuset'
[   52.774102][ T8420] cgroup: Unknown subsys name 'cpuset'
[   52.779016][ T8418] cgroup: Unknown subsys name 'cpuset'
[   53.884323][ T8417] IPVS: ftp: loaded support on port[0] = 21
[   53.886698][ T8418] IPVS: ftp: loaded support on port[0] = 21
[   53.902865][ T8420] IPVS: ftp: loaded support on port[0] = 21
[   53.903916][ T8419] IPVS: ftp: loaded support on port[0] = 21
[   53.988507][ T8420] chnl_net:caif_netlink_parms(): no params data found
[   54.047612][ T8417] chnl_net:caif_netlink_parms(): no params data found
[   54.083928][ T8420] bridge0: port 1(bridge_slave_0) entered blocking state
[   54.085630][ T8420] bridge0: port 1(bridge_slave_0) entered disabled state
[   54.087502][ T8420] device bridge_slave_0 entered promiscuous mode
[   54.092748][ T8420] bridge0: port 2(bridge_slave_1) entered blocking state
[   54.094368][ T8420] bridge0: port 2(bridge_slave_1) entered disabled state
[   54.096169][ T8420] device bridge_slave_1 entered promiscuous mode
[   54.147535][ T8418] chnl_net:caif_netlink_parms(): no params data found

[   54.196200][ T8420] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[   54.204123][ T8417] bridge0: port 1(bridge_slave_0) entered blocking state
[   54.205410][ T8417] bridge0: port 1(bridge_slave_0) entered disabled state
[   54.207145][ T8417] device bridge_slave_0 entered promiscuous mode
[   54.210785][ T8417] bridge0: port 2(bridge_slave_1) entered blocking state
[   54.211923][ T8417] bridge0: port 2(bridge_slave_1) entered disabled state
[   54.213488][ T8417] device bridge_slave_1 entered promiscuous mode
[   54.216445][ T8420] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[   54.224477][ T8419] chnl_net:caif_netlink_parms(): no params data found
[   54.239118][ T8417] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[   54.256575][ T8417] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[   54.260275][ T8420] team0: Port device team_slave_0 added
[   54.279533][ T8420] team0: Port device team_slave_1 added
[   54.292773][ T8418] bridge0: port 1(bridge_slave_0) entered blocking state
[   54.322675][ T8418] bridge0: port 1(bridge_slave_0) entered disabled state
[   54.351991][ T8418] device bridge_slave_0 entered promiscuous mode

[   54.383614][ T8418] bridge0: port 2(bridge_slave_1) entered blocking state
[   54.415226][ T8418] bridge0: port 2(bridge_slave_1) entered disabled state
[   54.447532][ T8418] device bridge_slave_1 entered promiscuous mode
[   54.488335][ T8417] team0: Port device team_slave_0 added
[   54.503504][ T8420] batman_adv: batadv0: Adding interface: batadv_slave_0
[   54.504623][ T8420] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over th.
[   54.508710][ T8420] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[   54.512314][ T8417] team0: Port device team_slave_1 added
[   54.514066][ T8420] batman_adv: batadv0: Adding interface: batadv_slave_1
[   54.515198][ T8420] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over th.
[   54.519650][ T8420] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[   54.540431][ T8418] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[   54.542677][ T8419] bridge0: port 1(bridge_slave_0) entered blocking state
[   54.544534][ T8419] bridge0: port 1(bridge_slave_0) entered disabled state
[   54.546775][ T8419] device bridge_slave_0 entered promiscuous mode
[   54.552027][ T8419] bridge0: port 2(bridge_slave_1) entered blocking state
[   54.553578][ T8419] bridge0: port 2(bridge_slave_1) entered disabled state
[   54.555492][ T8419] device bridge_slave_1 entered promiscuous mode
[   54.567672][ T8418] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[   54.573989][ T8417] batman_adv: batadv0: Adding interface: batadv_slave_0
[   54.575868][ T8417] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over th.
[   54.582147][ T8417] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[   54.596432][ T8420] device hsr_slave_0 entered promiscuous mode
[   54.598893][ T8420] device hsr_slave_1 entered promiscuous mode
[   54.607754][ T8417] batman_adv: batadv0: Adding interface: batadv_slave_1
[   54.609041][ T8417] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over th.
[   54.619663][ T8417] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[   54.624989][ T8419] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[   54.629738][ T8418] team0: Port device team_slave_0 added
[   54.636611][ T8418] team0: Port device team_slave_1 added
[   54.638642][ T8419] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[   54.668637][ T8418] batman_adv: batadv0: Adding interface: batadv_slave_0
[   54.669792][ T8418] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over th.
[   54.673749][ T8418] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[   54.680397][ T8419] team0: Port device team_slave_0 added
[   54.684125][ T8417] device hsr_slave_0 entered promiscuous mode
[   54.686156][ T8417] device hsr_slave_1 entered promiscuous mode
[   54.687835][ T8417] debugfs: Directory 'hsr0' with parent 'hsr'
already present!
[   54.689864][ T8417] Cannot create hsr debugfs directory
[   54.691469][ T8418] batman_adv: batadv0: Adding interface: batadv_slave_1
[   54.692806][ T8418] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over th.
[   54.697723][ T8418] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[   54.705348][ T8419] team0: Port device team_slave_1 added
[   54.727458][ T8418] device hsr_slave_0 entered promiscuous mode
[   54.728810][ T8418] device hsr_slave_1 entered promiscuous mode
[   54.730089][ T8418] debugfs: Directory 'hsr0' with parent 'hsr'
already present!
[   54.731279][ T8418] Cannot create hsr debugfs directory
[   54.748153][ T8419] batman_adv: batadv0: Adding interface: batadv_slave_0
[   54.749632][ T8419] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over th.
[   54.755030][ T8419] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[   54.768306][ T8419] batman_adv: batadv0: Adding interface: batadv_slave_1
[   54.769982][ T8419] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over th.
[   54.774855][ T8419] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[   54.829550][ T8419] device hsr_slave_0 entered promiscuous mode
[   54.831300][ T8419] device hsr_slave_1 entered promiscuous mode
[   54.832906][ T8419] debugfs: Directory 'hsr0' with parent 'hsr'
already present!
[   54.834451][ T8419] Cannot create hsr debugfs directory
[   54.887137][ T8420] netdevsim netdevsim3 netdevsim0: renamed from eth0
[   54.891644][ T8420] netdevsim netdevsim3 netdevsim1: renamed from eth1
[   54.900135][ T8420] netdevsim netdevsim3 netdevsim2: renamed from eth2
[   54.904165][ T8420] netdevsim netdevsim3 netdevsim3: renamed from eth3
[   54.925803][ T8417] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   54.930799][ T8417] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   54.933594][ T8417] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   54.938436][ T8417] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   54.941530][ T8420] bridge0: port 2(bridge_slave_1) entered blocking state
[   54.942785][ T8420] bridge0: port 2(bridge_slave_1) entered forwarding state
[   54.944287][ T8420] bridge0: port 1(bridge_slave_0) entered blocking state
[   54.945415][ T8420] bridge0: port 1(bridge_slave_0) entered forwarding state
[   54.962977][ T8418] netdevsim netdevsim2 netdevsim0: renamed from eth0
[   54.965605][ T8418] netdevsim netdevsim2 netdevsim1: renamed from eth1
[   54.968715][ T8418] netdevsim netdevsim2 netdevsim2: renamed from eth2
[   54.971746][ T8418] netdevsim netdevsim2 netdevsim3: renamed from eth3
[   54.994089][ T8417] bridge0: port 2(bridge_slave_1) entered blocking state
[   54.995230][ T8417] bridge0: port 2(bridge_slave_1) entered forwarding state
[   54.996440][ T8417] bridge0: port 1(bridge_slave_0) entered blocking state
[   54.997554][ T8417] bridge0: port 1(bridge_slave_0) entered forwarding state
[   55.006265][ T8419] netdevsim netdevsim1 netdevsim0: renamed from eth0
[   55.015556][ T8419] netdevsim netdevsim1 netdevsim1: renamed from eth1
[   55.019751][ T8419] netdevsim netdevsim1 netdevsim2: renamed from eth2
[   55.024621][ T8418] bridge0: port 2(bridge_slave_1) entered blocking state
[   55.026236][ T8418] bridge0: port 2(bridge_slave_1) entered forwarding state
[   55.027997][ T8418] bridge0: port 1(bridge_slave_0) entered blocking state
[   55.029650][ T8418] bridge0: port 1(bridge_slave_0) entered forwarding state
[   55.033870][ T8419] netdevsim netdevsim1 netdevsim3: renamed from eth3
[   55.045317][ T5237] bridge0: port 1(bridge_slave_0) entered disabled state
[   55.047268][ T5237] bridge0: port 2(bridge_slave_1) entered disabled state
[   55.049895][ T5237] bridge0: port 1(bridge_slave_0) entered disabled state
[   55.051483][ T5237] bridge0: port 2(bridge_slave_1) entered disabled state
[   55.054479][ T5237] bridge0: port 1(bridge_slave_0) entered disabled state
[   55.056295][ T5237] bridge0: port 2(bridge_slave_1) entered disabled state
[   55.082924][ T8420] 8021q: adding VLAN 0 to HW filter on device bond0
[   55.102238][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
[   55.104738][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[   55.108466][ T8420] 8021q: adding VLAN 0 to HW filter on device team0
[   55.122029][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge:
link becomes ready
[   55.123807][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0:
link becomes ready
[   55.125417][   T12] bridge0: port 1(bridge_slave_0) entered blocking state
[   55.126654][   T12] bridge0: port 1(bridge_slave_0) entered forwarding state
[   55.129601][ T8417] 8021q: adding VLAN 0 to HW filter on device bond0
[   55.139730][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge:
link becomes ready
[   55.141602][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1:
link becomes ready
[   55.143115][   T12] bridge0: port 2(bridge_slave_1) entered blocking state
[   55.144228][   T12] bridge0: port 2(bridge_slave_1) entered forwarding state
[   55.153194][ T3916] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond:
link becomes ready
[   55.159570][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
[   55.162235][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[   55.166161][ T3916] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bond:
link becomes ready
[   55.175784][ T8417] 8021q: adding VLAN 0 to HW filter on device team0
[   55.178483][ T8418] 8021q: adding VLAN 0 to HW filter on device bond0
[   55.182508][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team:
link becomes ready
[   55.184444][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0:
link becomes ready
[   55.189340][ T3916] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
[   55.191123][ T3916] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge:
link becomes ready
[   55.192865][ T3916] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0:
link becomes ready
[   55.194478][ T3916] bridge0: port 1(bridge_slave_0) entered blocking state
[   55.195650][ T3916] bridge0: port 1(bridge_slave_0) entered forwarding state
[   55.207785][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge:
link becomes ready
[   55.209481][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1:
link becomes ready
[   55.211025][ T8427] bridge0: port 2(bridge_slave_1) entered blocking state
[   55.212131][ T8427] bridge0: port 2(bridge_slave_1) entered forwarding state
[   55.213461][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team:
link becomes ready
[   55.215100][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1:
link becomes ready
[   55.216730][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
[   55.218215][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[   55.227631][ T8460] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_hsr:
link becomes ready
[   55.230092][ T8460] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0:
link becomes ready
[   55.231894][ T8460] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond:
link becomes ready
[   55.235044][ T8418] 8021q: adding VLAN 0 to HW filter on device team0
[   55.237516][ T8460] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_hsr:
link becomes ready
[   55.239461][ T8460] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1:
link becomes ready
[   55.247613][ T8420] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
[   55.251109][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bond:
link becomes ready
[   55.253309][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team:
link becomes ready
[   55.255350][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0:
link becomes ready
[   55.264928][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
[   55.266460][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge:
link becomes ready
[   55.267980][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0:
link becomes ready
[   55.269494][ T4945] bridge0: port 1(bridge_slave_0) entered blocking state
[   55.270603][ T4945] bridge0: port 1(bridge_slave_0) entered forwarding state
[   55.271971][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team:
link becomes ready
[   55.273575][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1:
link becomes ready
[   55.279757][ T3916] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge:
link becomes ready
[   55.282041][ T3916] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1:
link becomes ready
[   55.284040][ T3916] bridge0: port 2(bridge_slave_1) entered blocking state
[   55.285560][ T3916] bridge0: port 2(bridge_slave_1) entered forwarding state
[   55.297126][ T8417] hsr0: Slave A (hsr_slave_0) is not up; please
bring it up to get a fully working HSR network
[   55.298778][ T8417] hsr0: Slave B (hsr_slave_1) is not up; please
bring it up to get a fully working HSR network
[   55.303433][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond:
link becomes ready
[   55.305692][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_hsr:
link becomes ready
[   55.307922][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0:
link becomes ready
[   55.311494][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_hsr:
link becomes ready
[   55.313580][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1:
link becomes ready
[   55.315713][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
[   55.322963][ T8419] 8021q: adding VLAN 0 to HW filter on device bond0
[   55.325385][ T3916] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bond:
link becomes ready
[   55.349443][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes ready
[   55.350706][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes ready
[   55.351959][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
[   55.353372][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[   55.354769][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team:
link becomes ready
[   55.356388][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0:
link becomes ready
[   55.357942][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes ready
[   55.359611][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes ready
[   55.360815][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team:
link becomes ready
[   55.362478][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1:
link becomes ready
[   55.364023][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0:
link becomes ready
[   55.370049][ T8417] 8021q: adding VLAN 0 to HW filter on device batadv0
[   55.371639][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
[   55.373247][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1:
link becomes ready
[   55.376112][ T8419] 8021q: adding VLAN 0 to HW filter on device team0
[   55.381526][ T8418] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
[   55.383755][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge:
link becomes ready
[   55.385310][ T4945] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0:
link becomes ready
[   55.386752][ T4945] bridge0: port 1(bridge_slave_0) entered blocking state
[   55.387865][ T4945] bridge0: port 1(bridge_slave_0) entered forwarding state
[   55.390813][ T8420] 8021q: adding VLAN 0 to HW filter on device batadv0
[   55.396284][ T8458] IPv6: ADDRCONF(NETDEV_CHANGE): bridge0: link
becomes ready
[   55.397725][ T8458] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge:
link becomes ready
[   55.399586][ T8458] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1:
link becomes ready
[   55.401069][ T8458] bridge0: port 2(bridge_slave_1) entered blocking state
[   55.402284][ T8458] bridge0: port 2(bridge_slave_1) entered forwarding state
[   55.417004][ T8458] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond:
link becomes ready
[   55.424546][ T3916] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi:
link becomes ready
[   55.426557][ T3916] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bond:
link becomes ready
[   55.435722][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team:
link becomes ready
[   55.437382][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0:
link becomes ready
[   55.438957][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_virt_wifi:
link becomes ready
[   55.441726][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi:
link becomes ready
[   55.443386][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes ready
[   55.444587][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes ready
[   55.445831][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
[   55.458379][ T8418] 8021q: adding VLAN 0 to HW filter on device batadv0
[   55.464070][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link
becomes ready
[   55.465632][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes ready
[   55.467014][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes ready
[   55.468484][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team:
link becomes ready
[   55.471113][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1:
link becomes ready
[   55.472680][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0:
link becomes ready
[   55.478542][ T8417] device veth0_vlan entered promiscuous mode
[   55.486649][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_vlan: link
becomes ready
[   55.488193][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link
becomes ready
[   55.490207][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes ready
[   55.491622][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes ready
[   55.498241][ T8457] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1:
link becomes ready
[   55.500145][ T8420] device veth0_vlan entered promiscuous mode
[   55.502453][ T8419] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
[   55.505635][ T8417] device veth1_vlan entered promiscuous mode
[   55.513802][ T8420] device veth1_vlan entered promiscuous mode
[   55.528752][   T47] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link
becomes ready
[   55.530814][   T47] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link
becomes ready
[   55.532748][   T47] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link
becomes ready
[   55.534307][   T47] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link
becomes ready
[   55.536368][   T47] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes ready
[   55.537604][   T47] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes ready
[   55.543990][ T8460] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap:
link becomes ready
[   55.545601][ T8460] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi:
link becomes ready
[   55.557011][ T8419] 8021q: adding VLAN 0 to HW filter on device batadv0
[   55.559703][ T8417] device veth0_macvtap entered promiscuous mode
[   55.568438][ T8417] device veth1_macvtap entered promiscuous mode
[   55.576974][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link
becomes ready
[   55.578675][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes ready
[   55.580454][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes ready
[   55.581893][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link
becomes ready
[   55.585857][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap:
link becomes ready
[   55.590147][ T8418] device veth0_vlan entered promiscuous mode
[   55.593438][ T8420] device veth0_macvtap entered promiscuous mode
[   55.596388][ T8417] batman_adv: batadv0: Interface activated: batadv_slave_0
[   55.599685][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link
becomes ready
[   55.601259][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_0:
link becomes ready
[   55.602892][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv:
link becomes ready
[   55.606834][ T8420] device veth1_macvtap entered promiscuous mode
[   55.609803][ T8417] batman_adv: batadv0: Interface activated: batadv_slave_1
[   55.613750][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_1:
link becomes ready
[   55.615316][ T8427] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv:
link becomes ready
[   55.618276][ T8418] device veth1_vlan entered promiscuous mode
[   55.621546][ T8417] netdevsim netdevsim0 netdevsim0: set [1, 0]
type 2 family 0 port 6081 - 0
[   55.623016][ T8417] netdevsim netdevsim0 netdevsim1: set [1, 0]
type 2 family 0 port 6081 - 0
[   55.624411][ T8417] netdevsim netdevsim0 netdevsim2: set [1, 0]
type 2 family 0 port 6081 - 0
[   55.625764][ T8417] netdevsim netdevsim0 netdevsim3: set [1, 0]
type 2 family 0 port 6081 - 0
[   55.633979][ T8457] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link
becomes ready
[   55.635485][ T8457] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link
becomes ready
[   55.637046][ T8457] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi:
link becomes ready
[   55.647653][ T8420] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3d) already exists on: batadv_slave_0
[   55.650656][ T8420] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[   55.653585][ T8420] batman_adv: batadv0: Interface activated: batadv_slave_0
[   55.661918][ T8458] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_0:
link becomes ready
[   55.663516][ T8458] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv:
link becomes ready
[   55.669589][ T8420] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_1
[   55.671380][ T8420] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[   55.673566][ T8420] batman_adv: batadv0: Interface activated: batadv_slave_1
[   55.676293][   T47] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link
becomes ready
[   55.678269][   T47] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_1:
link becomes ready
[   55.681491][   T47] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv:
link becomes ready
[   55.683507][   T47] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes ready
[   55.685073][   T47] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes ready
[   55.693628][ T8419] device veth0_vlan entered promiscuous mode
[   55.695711][ T8420] netdevsim netdevsim3 netdevsim0: set [1, 0]
type 2 family 0 port 6081 - 0
[   55.697187][ T8420] netdevsim netdevsim3 netdevsim1: set [1, 0]
type 2 family 0 port 6081 - 0
[   55.698641][ T8420] netdevsim netdevsim3 netdevsim2: set [1, 0]
type 2 family 0 port 6081 - 0
[   55.701227][ T8420] netdevsim netdevsim3 netdevsim3: set [1, 0]
type 2 family 0 port 6081 - 0
[   55.712126][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap:
link becomes ready
[   55.723666][ T8418] device veth0_macvtap entered promiscuous mode
[   55.732979][ T8418] device veth1_macvtap entered promiscuous mode
[   55.743076][ T8419] device veth1_vlan entered promiscuous mode
[   55.764965][ T3092] wlan0: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[   55.766588][ T3092] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:50
[   55.773260][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link
becomes ready
[   55.775027][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link
becomes ready
[   55.776594][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link
becomes ready
[   55.778171][   T12] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   55.787908][ T3093] wlan0: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[   55.787950][ T8418] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3d) already exists on: batadv_slave_0
[   55.789768][ T8418] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[   55.791403][ T3093] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:50
[   55.792640][ T8418] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3d) already exists on: batadv_slave_0
[   55.795462][ T8418] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[   55.797603][ T8418] batman_adv: batadv0: Interface activated: batadv_slave_0
[   55.798845][ T8457] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   55.800562][ T8457] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_0:
link becomes ready
[   55.802140][ T8457] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv:
link becomes ready
[   55.824228][ T3092] wlan1: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[   55.824417][ T8418] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_1
[   55.825590][ T3092] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
[   55.827225][ T8418] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[   55.827232][ T8418] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_1
[   55.832197][ T8418] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[   55.834287][ T8418] batman_adv: batadv0: Interface activated: batadv_slave_1
[   55.836978][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes ready
[   55.838488][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_1:
link becomes ready
[   55.848341][ T8462] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv:
link becomes ready
[   55.853941][ T3093] wlan1: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[   55.855398][ T3093] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
[   55.857652][ T8418] netdevsim netdevsim2 netdevsim0: set [1, 0]
type 2 family 0 port 6081 - 0
[   55.859775][ T8418] netdevsim netdevsim2 netdevsim1: set [1, 0]
type 2 family 0 port 6081 - 0
[   55.861661][ T8418] netdevsim netdevsim2 netdevsim2: set [1, 0]
type 2 family 0 port 6081 - 0
[   55.863521][ T8418] netdevsim netdevsim2 netdevsim3: set [1, 0]
type 2 family 0 port 6081 - 0
[   55.866508][ T8457] IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes ready
[   55.876206][ T8463] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap:
link becomes ready
[   55.881066][ T8419] device veth0_macvtap entered promiscuous mode
[   55.881542][ T8417] cgroup: cgroup: disabling cgroup2 socket
matching due to net_prio or net_cls activation
[   55.893570][ T8419] device veth1_macvtap entered promiscuous mode
[   55.911291][ T8419] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3d) already exists on: batadv_slave_0
[   55.912945][ T8419] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[   55.914468][ T8419] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3d) already exists on: batadv_slave_0
[   55.916157][ T8419] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[   55.917673][ T8419] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3d) already exists on: batadv_slave_0
[   55.919741][   T48] Bluetooth: hci0: command 0x0409 tx timeout
[   55.920927][ T8419] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[   55.923609][ T8419] batman_adv: batadv0: Interface activated: batadv_slave_0
[   55.929424][ T8457] Bluetooth: hci3: command 0x0409 tx timeout
[   55.930423][ T8457] Bluetooth: hci2: command 0x0409 tx timeout
[   55.931353][ T8458] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv:
link becomes ready
[   55.933012][ T8457] Bluetooth: hci1: command 0x0409 tx timeout
[   55.934563][ T8458] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link
becomes ready
[   55.937382][ T8465]
==================================================================
[   55.937545][ T8468] general protection fault, probably for
non-canonical address 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN
[   55.938204][ T8419] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_1
[   55.938215][ T8419] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[   55.938220][ T8419] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_1
[   55.938227][ T8419] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[   55.938232][ T8419] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_1
[   55.938239][ T8419] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[   55.938755][ T8419] batman_adv: batadv0: Interface activated: batadv_slave_1
[   55.938769][ T8465] BUG: KASAN: null-ptr-deref in filp_close+0x22/0x170
[   55.940640][ T8468] KASAN: null-ptr-deref in range
[0x0000000000000070-0x0000000000000077]
[   55.941689][ T8418] ieee80211 phy8: Selected rate control algorithm
'minstrel_ht'
[   55.942228][ T8465] Read of size 8 at addr 0000000000000077 by task
a.out/8465
[   55.943745][ T8468] CPU: 0 PID: 8468 Comm: a.out Not tainted 5.12.0-rc2+ #111
[   55.945341][ T8465]
[   55.945348][ T8465] CPU: 1 PID: 8465 Comm: a.out Not tainted 5.12.0-rc2+ #111
[   55.946919][ T8468] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS rel-1.13.0-44-g88ab0c15525c-prebuilt.qemu.org 04/01/2014
[   55.948513][ T8465] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS rel-1.13.0-44-g88ab0c15525c-prebuilt.qemu.org 04/01/2014
[   55.950035][ T8468] RIP: 0010:filp_close+0x33/0x170
[   55.951141][ T8465] Call Trace:
[   55.951146][ T8465]  dump_stack+0x141/0x1d7
[   55.952193][ T8468] Code: 89 fd 4c 8d 6d 78 53 e8 6b 8d b5 ff be 08
00 00 00 4c 89 ef e8 8e d8 f6 ff 4c 89 ea 48 b8 00 00 00 00 00 fc ff
df 48 c1 ea 03 <80> 3c 02 005
[   55.953483][ T8465]  ? filp_close+0x22/0x170
[   55.954674][ T8468] RSP: 0018:ffffc900018c7ad8 EFLAGS: 00010203
[   55.955806][ T8465]  kasan_report.cold+0x5f/0xd8
[   55.957002][ T8468]
[   55.957005][ T8468] RAX: dffffc0000000000 RBX: ffffffffffffffff
RCX: ffffffff81bbb852
[   55.957361][ T8465]  ? filp_close+0x22/0x170
[   55.958497][ T8468] RDX: 000000000000000e RSI: 0000000000000008
RDI: 0000000000000077
[   55.960331][ T8465]  kasan_check_range+0x13d/0x180
[   55.962185][ T8468] RBP: ffffffffffffffff R08: 0000000000000000
R09: 000000000000007f
[   55.962943][ T8465]  filp_close+0x22/0x170
[   55.963438][ T8468] R10: ffffed1020c94914 R11: 0000000000000000
R12: ffff8881064a4780
[   55.964083][ T8465]  put_files_struct+0x1d0/0x350
[   55.967078][ T8468] R13: 0000000000000077 R14: ffff8881064a4780
R15: ffff8881064a48a0
[   55.967742][ T8465]  exit_files+0x7e/0xa0
[   55.968652][ T8468] FS:  0000000000000000(0000)
GS:ffff888159e00000(0000) knlGS:0000000000000000
[   55.969361][ T8465]  do_exit+0xba9/0x2a40
[   55.969718][ T8468] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.970913][ T8465]  ? queued_spin_lock_slowpath+0xcc/0x940
[   55.971589][ T8468] CR2: 00000000004a2638 CR3: 0000000117245000
CR4: 0000000000750ef0
[   55.972810][ T8465]  ? find_held_lock+0x2d/0x110
[   55.973564][ T8468] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[   55.974777][ T8465]  ? mm_update_next_owner+0x7a0/0x7a0
[   55.975431][ T8468] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[   55.976738][ T8465]  ? get_signal+0x37b/0x2490
[   55.977487][ T8468] PKRU: 55555554
[   55.977492][ T8468] Call Trace:
[   55.978686][ T8465]  ? lock_downgrade+0x6e0/0x6e0
[   55.979316][ T8468]  put_files_struct+0x1d0/0x350
[   55.980664][ T8465]  ? do_raw_spin_lock+0x1d8/0x260
[   55.981302][ T8468]  exit_files+0x7e/0xa0
[   55.982305][ T8465]  do_group_exit+0x125/0x310
[   55.983180][ T8468]  do_exit+0xba9/0x2a40
[   55.984390][ T8465]  get_signal+0x468/0x2490
[   55.985114][ T8468]  ? find_held_lock+0x2d/0x110
[   55.986389][ T8465]  ? futex_exit_release+0x220/0x220
[   55.987213][ T8468]  ? mm_update_next_owner+0x7a0/0x7a0
[   55.988421][ T8465]  arch_do_signal_or_restart+0x2a8/0x1eb0
[   55.989124][ T8468]  ? get_signal+0x37b/0x2490
[   55.989662][ T8465]  ? debug_object_init_on_stack+0x20/0x20
[   55.990163][ T8468]  ? lock_downgrade+0x6e0/0x6e0
[   55.990902][ T8465]  ? clone_private_mount+0x140/0x140
[   55.991645][ T8468]  ? do_raw_spin_lock+0x121/0x260
[   55.992426][ T8465]  ? copy_siginfo_to_user32+0xa0/0xa0
[   55.993058][ T8468]  do_group_exit+0x125/0x310
[   55.993757][ T8465]  ? __do_sys_futex+0x2a2/0x470
[   55.994392][ T8468]  get_signal+0x468/0x2490
[   55.995065][ T8465]  ? __do_sys_futex+0x2ab/0x470
[   55.995793][ T8468]  ? futex_exit_release+0x220/0x220
[   55.996692][ T8465]  ? do_futex+0x1710/0x1710
[   55.997515][ T8468]  arch_do_signal_or_restart+0x2a8/0x1eb0
[   55.998378][ T8465]  exit_to_user_mode_prepare+0x148/0x250
[   55.999079][ T8468]  ? lock_downgrade+0x6e0/0x6e0
[   55.999944][ T8465]  syscall_exit_to_user_mode+0x19/0x50
[   56.000683][ T8468]  ? do_raw_spin_lock+0x121/0x260
[   56.001481][ T8465]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   56.002245][ T8468]  ? __sanitizer_cov_trace_const_cmp1+0x22/0x80
[   56.003065][ T8465] RIP: 0033:0x4576d9
[   56.003764][ T8468]  ? put_files_struct+0x33/0x350
[   56.004497][ T8465] Code: Unable to access opcode bytes at RIP 0x4576af.
[   56.005169][ T8468]  ? copy_siginfo_to_user32+0xa0/0xa0
[   56.005907][ T8465] RSP: 002b:00007fab4413c1e8 EFLAGS: 00000246
[   56.006817][ T8468]  ? __do_sys_futex+0x2a2/0x470
[   56.007499][ T8465]  ORIG_RAX: 00000000000000ca
[   56.007505][ T8465] RAX: fffffffffffffe00 RBX: 0000000000000000
RCX: 00000000004576d9
[   56.008368][ T8468]  ? __do_sys_futex+0x2ab/0x470
[   56.009225][ T8465] RDX: 0000000000000000 RSI: 0000000000000080
RDI: 00000000004dd3a8
[   56.009962][ T8468]  ? do_futex+0x1710/0x1710
[   56.010791][ T8465] RBP: 00007fab4413c200 R08: 0000000100000001
R09: 0000000100000001
[   56.011557][ T8468]  exit_to_user_mode_prepare+0x148/0x250
[   56.012450][ T8465] R10: 0000000000000000 R11: 0000000000000246
R12: 00007ffe0c4cd91e
[   56.013399][ T8468]  syscall_exit_to_user_mode+0x19/0x50
[   56.013989][ T8465] R13: 00007ffe0c4cd91f R14: 00007fab4413c300
R15: 0000000000022000
[   56.014748][ T8468]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   56.015786][ T8465]
==================================================================
[   56.016697][ T8468] RIP: 0033:0x4576d9
[   56.023878][ T8465] Kernel panic - not syncing: panic_on_warn set ...
[   56.024082][ T8468] Code: Unable to access opcode bytes at RIP 0x4576af.
[   56.024088][ T8468] RSP: 002b:00007fab4411b1e8 EFLAGS: 00000246
ORIG_RAX: 00000000000000ca
[   56.034295][ T8468] RAX: fffffffffffffe00 RBX: 0000000000000000
RCX: 00000000004576d9
[   56.035533][ T8468] RDX: 0000000000000000 RSI: 0000000000000080
RDI: 00000000004dd3b8
[   56.036797][ T8468] RBP: 00007fab4411b200 R08: 0000000000000000
R09: 0000000000000000
[   56.038006][ T8468] R10: 0000000000000000 R11: 0000000000000246
R12: 00007ffe0c4cd91e
[   56.039221][ T8468] R13: 00007ffe0c4cd91f R14: 00007fab4411b300
R15: 0000000000022000
[   56.040433][ T8468] Modules linked in:
[   56.041067][ T8465] Kernel Offset: disabled
[   56.041718][ T8465] Rebooting in 86400 seconds..
