Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9561376385A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjGZOHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjGZOHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:01 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8F9270C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:06:52 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140649euoutp02a8f0b4c04120b8de15e51f8d560e703d~1cAbPPSBJ1520515205euoutp02a
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:06:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230726140649euoutp02a8f0b4c04120b8de15e51f8d560e703d~1cAbPPSBJ1520515205euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380409;
        bh=DSy3B8hklTXE+LzMzZYpY0McWPjbA036RjQyYAWKZEA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=nsq/H8B7r+0XxM0CiT4wLDDRbU1fwMILr9yHhSzvZaYGlTqZXmM8rvJ64jiUPLUS/
         qNKC5W7SGzauQFZsdjsolAcYa+K+aQNuo6LT6n4haaHXFTKy1RoMFUDVfJzpOpzvca
         II19AZK9nzvglln+Zgqx0GXVY364hPYeUVNFRo4I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230726140649eucas1p1ce6717395e82b63328ca8e2236203a92~1cAa3UItT2041620416eucas1p1i;
        Wed, 26 Jul 2023 14:06:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D1.66.42423.97821C46; Wed, 26
        Jul 2023 15:06:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230726140648eucas1p29a92c80fb28550e2087cd0ae190d29bd~1cAah_83g3021730217eucas1p2N;
        Wed, 26 Jul 2023 14:06:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230726140648eusmtrp16096fb743412d9b5a3b7eea05a113c41~1cAahYkr62391823918eusmtrp1Q;
        Wed, 26 Jul 2023 14:06:48 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-50-64c12879951c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5B.B7.10549.87821C46; Wed, 26
        Jul 2023 15:06:48 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140648eusmtip25b6540a66ec0ab11193938907c9bba42~1cAaU0Xsb2113521135eusmtip28;
        Wed, 26 Jul 2023 14:06:48 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     willy@infradead.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/14] sysctl: Add a size argument to register functions in
 sysctl
Date:   Wed, 26 Jul 2023 16:06:20 +0200
Message-Id: <20230726140635.2059334-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7qVGgdTDP685bFYuv8ho8X/BfkW
        Z7pzLfbsPclicXnXHDaLGxOeMlr8/gFkLdvp58DhMbvhIovHgk2lHptXaHncem3rsWlVJ5tH
        35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZcx48IS54Gt6xdVdp5kaGD86dTFyckgImEj8Ofme
        vYuRi0NIYAWjxMdVJ1kgnC+MEl3fDrBCOJ8ZJS5NfsMM03LpSBMbRGI5o8SrTbuZIJyXjBIr
        Jn1nBKliE9CROP/mDlAHB4eIQKzE4ikpIGFmgemMEkvmyIDYwgIhEr9ffWIHsVkEVCW+3etg
        ArF5BWwl5q79wAixTF6i7fp0Roi4oMTJmU9YIObISzRvnc0MsldC4AiHxJL+v+wQDS4SG24f
        gLpUWOLV8S1QcRmJ05N7WCAaJjNK7P/3gR3CWc0osazxKxNElbVEy5Un7CBXMwtoSqzfpQ8R
        dpRYeeoYK0hYQoBP4sZbQYgj+CQmbZvODBHmlehoE4KoVpHoWzqFBcKWkrh+eScbhO0hsWXb
        PhaQciFgkDQ945vAqDALyWezkHw2C+GEBYzMqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3
        MQKTz+l/xz/tYJz76qPeIUYmDsZDjBIczEoivIYx+1KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1ME0MWClclNB8/evaZXNtYkq4fBvOV2Xq1X5Q0KyX
        NwyYx3OFM6w9If9vrVZ9pdLKqZftmRNjeNw/zpqwzy/oxNq9nLHtb6+Vv2efl3hCINe5ctu1
        PfyZCk5SEs+NJPpSPj2NSU0zs8yRuzrV9O6eE/znG4UbK91CbRZ8N1NJ0l47rVdko4NeZJVW
        rsWPnVZ3XghevFl5ZgvnjG4Daa+SC2+eclz1q2OZdC5j5U7dLRm3vintbstWPah48WiqZdy5
        pTdT7UxfNP2vjvlyfMJO3/Lf/A6hsXP5HRzkf+qq6U978/nM123ByxtaT3r/qtSqqtq85i/z
        6kOGn8sO69UG5Ltuulc8IfRsSPfcIz8llViKMxINtZiLihMBt32h5q0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e/4Pd0KjYMpBj07jC2W7n/IaPF/Qb7F
        me5ciz17T7JYXN41h83ixoSnjBa/fwBZy3b6OXB4zG64yOKxYFOpx+YVWh63Xtt6bFrVyebR
        t2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
        qUX6dgl6GTMePGEu+JpecXXXaaYGxo9OXYycHBICJhKXjjSxdTFycQgJLGWUuPmhib2LkQMo
        ISXxfRknRI2wxJ9rXVA1zxklTr99xA6SYBPQkTj/5g4ziC0iEC8x8/F9JpAiZoHZjBKrTx4C
        SwgLBEk8629gA7FZBFQlvt3rYAKxeQVsJeau/cAIsUFeou36dEaQxcwCmhLrd+lDlAhKnJz5
        hAXEZgYqad46m3kCI/8shKpZSKpmIalawMi8ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBG
        th37uXkH47xXH/UOMTJxMB5ilOBgVhLhNYzZlyLEm5JYWZValB9fVJqTWnyI0RTo6onMUqLJ
        +cAozSuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYDL85q0ao37C
        e+0KFt/GbeFXFHdYlE67+ovXQFRAb/+0ReaLpss/3rZXpkHkcpv4db1D/FeOn3V4a8v44uhU
        s+hMxUUsoelqqTr+Mze9lpf9kf3rNWdmeMRqgZ47Sd+6bI2mSZ6bspbXbP9zi27Z6iOGzmas
        V458ybt5+vj6n29/98tUxeit/6OdcDJoxfV9t84mL/kksOjbZ+l1Hz8FbUkMq8mq4CyeU2rV
        bFvLcTCg8MLto3cvz8q+dSb1cv+P8r43jlcfMNteDDp+fRGHrYeDh+zKNrdDgb+45tYwr9UN
        P5+20UX0ddGve+e3vXWwkOn4+33mq3e6T42P8+h1WOXbBOpeLrFmzDkbsUn1cpYSS3FGoqEW
        c1FxIgBRDVpOGgMAAA==
X-CMS-MailID: 20230726140648eucas1p29a92c80fb28550e2087cd0ae190d29bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140648eucas1p29a92c80fb28550e2087cd0ae190d29bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140648eucas1p29a92c80fb28550e2087cd0ae190d29bd
References: <CGME20230726140648eucas1p29a92c80fb28550e2087cd0ae190d29bd@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

What?
These commits set things up so we can start removing the sentinel elements.
They modify sysctl and net_sysctl internals so that registering a ctl_table
that contains a sentinel gives the same result as passing a table_size
calculated from the ctl_table array without a sentinel. We accomplish this by
introducing a table_size argument in the same place where procname is checked
for NULL. The idea is for it to keep stopping when it hits ->procname == NULL,
while the sentinel is still present. And when the sentinel is removed, it will
stop on the table_size (thx to jani.nikula@linux.intel.com for the discussion
that led to this). This allows us to remove sentinels from one (or several)
files at a time.

These commits are part of a bigger set containing the removal of ctl_table sentinel
(https://github.com/Joelgranados/linux/tree/tag/sysctl_remove_empty_elem_V1).
The idea is to make the review process easier by chunking the 65+ commits into
manageable pieces. Even though I had already sent a V1 with the full set, I'll
restart the count as this is the first version of this chunk.

My idea is to send out one chunk at a time so it can be reviewed separately
from the others without the noise from parallel related sets. After this first
chunk will come 6 that remove the sentinel element from "arch/*, drivers/*,
fs/*, kernel/*, net/* and miscellaneous. And then a final one that removes the
->procname == NULL check other miscellaneous details. You can see all commits here
(https://github.com/Joelgranados/linux/tree/tag/sysctl_remove_empty_elem_V1).

Commits in this chunk:
* Preparation commits:
    start : sysctl: Prefer ctl_table_header in proc_sysct
    end   : sysctl: Add size argument to init_header
  These are preparation commits that make sure that we have the
  ctl_table_header where we need the array size.

* Add size to __register_sysctl_table, __register_sysctl_init and register_sysctl
    start : sysctl: Add a size arg to __register_sysctl_table
    end   : sysctl: Add size arg to __register_sysctl_init
  Here we replace the existing register functions with macros that add the
  ARRAY_SIZE automatically. Unfortunately these macros cannot be used for the
  register calls that pass a pointer; in this situation we add register
  functions with an table_size argument (thx to greg@kroah.com for bringing
  this to my attention)

* Add size to register_net_sysctl
    start : sysctl: Add size to register_net_sysctl function
    end   : sysctl: SIZE_MAX->ARRAY_SIZE in register_net_sysctl
  register_net_sysctl is an indirection function to the sysctl registrations
  and needed a several commits to add table_size to all its callers. We
  temporarily use SIZE_MAX to avoid compiler warnings while we change to
  register_net_sysctl to register_net_sysctl_sz; we remove it with the
  penultimate patch of this set. Finally, we make sure to adjust the calculated
  size every time there is a check for unprivileged users.

* Add size as additional stopping criteria
    commit : sysctl: Use size as stopping criteria for list macro
  We add table_size check in the main macro within proc_sysctl.c. This commit
  allows the removal of the sentinel element by chunks.

Why?
This is part of the push to trim down kernel/sysctl.c by moving the large array
that was causing merge conflicts. Most of the work is already done and what is
left is to remove the now unneeded empty last (sentinel) element in the
ctl_table arrays and plumb everything within the sysctl infrastructure so it
understands sizes instead of sentinels.

Here are some related threads to give more context:
* This is a patch set that replaces register_sysctl_table with register_sysctl
  https://lore.kernel.org/all/20230302204612.782387-1-mcgrof@kernel.org/
* Patch set to deprecate register_sysctl_paths()
  https://lore.kernel.org/all/20230302202826.776286-1-mcgrof@kernel.org/
* Here there is an explicit expectation for the removal of the sentinel element.
  https://lore.kernel.org/all/20230321130908.6972-1-frank.li@vivo.com
* The "ARRAY_SIZE" approach was mentioned (proposed?) in this thread
  https://lore.kernel.org/all/20220220060626.15885-1-tangmeng@uniontech.com

Testing:
* Ran sysctl selftests (./tools/testing/selftests/sysctl/sysctl.sh)
* Successfully ran this through 0-day

Misc:
A consequence of eventually removing all the sentinels (64 bytes per sentinel)
is the bytes we save. Here I include numbers for when all sentinels are removed
to contextualize this chunk
  * bloat-o-meter:
    The "yesall" configuration results save 9158 bytes (you can see the output here
    https://lore.kernel.org/all/20230621091000.424843-1-j.granados@samsung.com/.
    The "tiny" configuration + CONFIG_SYSCTL save 1215 bytes (you can see the
    output here [2])
  * memory usage:
    As we no longer need the sentinel element within proc_sysctl.c, we save some
    bytes in main memory as well. In my testing kernel I measured a difference of
    6720 bytes. I include the way to measure this in [1]

Comments/feedback greatly appreciated

Best
Joel

[1]
To measure the in memory savings apply this patch on top of
https://github.com/Joelgranados/linux/tree/tag/sysctl_remove_empty_elem_V1
"
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 5f413bfd6271..9aa8374c0ef1 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -975,6 +975,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
        table[0].procname = new_name;
        table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
        init_header(&new->header, set->dir.header.root, set, node, table, 1);
+       printk("%ld sysctl saved mem kzalloc \n", sizeof(struct ctl_table));

        return new;
 }
@@ -1202,6 +1203,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
                    head->ctl_table_size);
        links->nreg = head->ctl_table_size;

+       printk("%ld sysctl saved mem kzalloc \n", sizeof(struct ctl_table));
        return links;
 }

"
and then run the following bash script in the kernel:

accum=0
for n in $(dmesg | grep kzalloc | awk '{print $3}') ; do
    echo $n
    accum=$(calc "$accum + $n")
done
echo $accum

[2]
bloat-o-meter with "tiny" config:
add/remove: 0/2 grow/shrink: 33/24 up/down: 470/-1685 (-1215)
Function                                     old     new   delta
insert_header                                831     966    +135
__register_sysctl_table                      971    1092    +121
get_links                                    177     226     +49
put_links                                    167     186     +19
erase_header                                  55      66     +11
sysctl_init_bases                             59      69     +10
setup_sysctl_set                              65      73      +8
utsname_sysctl_init                           26      31      +5
sld_mitigate_sysctl_init                      33      38      +5
setup_userns_sysctls                         158     163      +5
sched_rt_sysctl_init                          33      38      +5
sched_fair_sysctl_init                        33      38      +5
sched_dl_sysctl_init                          33      38      +5
random_sysctls_init                           33      38      +5
page_writeback_init                          122     127      +5
oom_init                                      73      78      +5
kernel_panic_sysctls_init                     33      38      +5
kernel_exit_sysctls_init                      33      38      +5
init_umh_sysctls                              33      38      +5
init_signal_sysctls                           33      38      +5
init_pipe_fs                                  94      99      +5
init_fs_sysctls                               33      38      +5
init_fs_stat_sysctls                          33      38      +5
init_fs_namespace_sysctls                     33      38      +5
init_fs_namei_sysctls                         33      38      +5
init_fs_inode_sysctls                         33      38      +5
init_fs_exec_sysctls                          33      38      +5
init_fs_dcache_sysctls                        33      38      +5
register_sysctl                               22      25      +3
__register_sysctl_init                         9      12      +3
user_namespace_sysctl_init                   149     151      +2
sched_core_sysctl_init                        38      40      +2
register_sysctl_mount_point                   13      15      +2
vm_table                                    1344    1280     -64
vm_page_writeback_sysctls                    512     448     -64
vm_oom_kill_table                            256     192     -64
uts_kern_table                               448     384     -64
usermodehelper_table                         192     128     -64
user_table                                   576     512     -64
sld_sysctls                                  128      64     -64
signal_debug_table                           128      64     -64
sched_rt_sysctls                             256     192     -64
sched_fair_sysctls                           128      64     -64
sched_dl_sysctls                             192     128     -64
sched_core_sysctls                            64       -     -64
root_table                                   128      64     -64
random_table                                 448     384     -64
namei_sysctls                                320     256     -64
kern_table                                  1792    1728     -64
kern_panic_table                             128      64     -64
kern_exit_table                              128      64     -64
inodes_sysctls                               192     128     -64
fs_stat_sysctls                              256     192     -64
fs_shared_sysctls                            192     128     -64
fs_pipe_sysctls                              256     192     -64
fs_namespace_sysctls                         128      64     -64
fs_exec_sysctls                              128      64     -64
fs_dcache_sysctls                            128      64     -64
init_header                                   85       -     -85
Total: Before=1877669, After=1876454, chg -0.06%

base:  fdf0eaf11452

Joel Granados (14):
  sysctl: Prefer ctl_table_header in proc_sysctl
  sysctl: Use ctl_table_header in list_for_each_table_entry
  sysctl: Add ctl_table_size to ctl_table_header
  sysctl: Add size argument to init_header
  sysctl: Add a size arg to __register_sysctl_table
  sysctl: Add size to register_sysctl
  sysctl: Add size arg to __register_sysctl_init
  sysctl: Add size to register_net_sysctl function
  ax.25: Update to register_net_sysctl_sz
  netfilter: Update to register_net_sysctl_sz
  networking: Update to register_net_sysctl_sz
  vrf: Update to register_net_sysctl_sz
  sysctl: SIZE_MAX->ARRAY_SIZE in register_net_sysctl
  sysctl: Use size as stopping criteria for list macro

 arch/arm64/kernel/armv8_deprecated.c    |  2 +-
 arch/s390/appldata/appldata_base.c      |  2 +-
 drivers/net/vrf.c                       |  3 +-
 fs/proc/proc_sysctl.c                   | 88 ++++++++++++-------------
 include/linux/sysctl.h                  | 31 +++++++--
 include/net/ipv6.h                      |  2 +
 include/net/net_namespace.h             | 10 +--
 ipc/ipc_sysctl.c                        |  4 +-
 ipc/mq_sysctl.c                         |  4 +-
 kernel/ucount.c                         |  5 +-
 net/ax25/sysctl_net_ax25.c              |  3 +-
 net/bridge/br_netfilter_hooks.c         |  3 +-
 net/core/neighbour.c                    |  8 ++-
 net/core/sysctl_net_core.c              |  3 +-
 net/ieee802154/6lowpan/reassembly.c     |  8 ++-
 net/ipv4/devinet.c                      |  3 +-
 net/ipv4/ip_fragment.c                  |  3 +-
 net/ipv4/route.c                        |  8 ++-
 net/ipv4/sysctl_net_ipv4.c              |  3 +-
 net/ipv4/xfrm4_policy.c                 |  3 +-
 net/ipv6/addrconf.c                     |  3 +-
 net/ipv6/icmp.c                         |  5 ++
 net/ipv6/netfilter/nf_conntrack_reasm.c |  3 +-
 net/ipv6/reassembly.c                   |  3 +-
 net/ipv6/route.c                        | 13 ++--
 net/ipv6/sysctl_net_ipv6.c              | 16 +++--
 net/ipv6/xfrm6_policy.c                 |  3 +-
 net/mpls/af_mpls.c                      | 72 ++++++++++----------
 net/mptcp/ctrl.c                        |  3 +-
 net/netfilter/ipvs/ip_vs_ctl.c          |  8 ++-
 net/netfilter/ipvs/ip_vs_lblc.c         | 10 ++-
 net/netfilter/ipvs/ip_vs_lblcr.c        | 10 ++-
 net/netfilter/nf_conntrack_standalone.c |  4 +-
 net/netfilter/nf_log.c                  |  7 +-
 net/rds/tcp.c                           |  3 +-
 net/sctp/sysctl.c                       |  4 +-
 net/smc/smc_sysctl.c                    |  3 +-
 net/sysctl_net.c                        | 26 +++++---
 net/unix/sysctl_net_unix.c              |  3 +-
 net/xfrm/xfrm_sysctl.c                  |  8 ++-
 40 files changed, 254 insertions(+), 149 deletions(-)

-- 
2.30.2

