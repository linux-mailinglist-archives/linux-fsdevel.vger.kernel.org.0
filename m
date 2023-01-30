Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14647680B94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 12:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbjA3LFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 06:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbjA3LEy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:04:54 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62959CA18
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 03:04:18 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UAT89s018611;
        Mon, 30 Jan 2023 11:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=jeb7QWeBepJL9ZapzbeROcrKlwVo4gdD3ekHCiMD/zo=;
 b=BVYZyNfvzNHCKq8oQeB7zpbT5eeYH/5GZsvvTIF37aZHt6ATqrGpaVp94/UUQt0WFt/8
 brLXxKhtqJf+PfEvfAnk4ff7ynvVV1b0Lx92xMz9Kxg6bwlTUx3MXHeJQhe9TYwFR0n6
 QlzP7IPZCfjl/2Uggc5cVWDK7DFHxWdWwiil0BOi1joiFzamc/rTug5nKuhx77hNQ5gp
 DOnmGd18UWXV0tfqwgSwRCZ1RmXIv+n14Ei+goxGu09vKw9ZUZeHB8ALLvOIdIHxRbeH
 h624zlXO2ybICiUk7A2Z+JRTmj+E85oFPYy31gewQkfkjiZX6k6qVqi6xbdlxxLPlKm3 2A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nec6cgrp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 11:04:05 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30T8B1LZ016468;
        Mon, 30 Jan 2023 11:04:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3ncvt7hh3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 11:04:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UB414M51577180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 11:04:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 598762004B;
        Mon, 30 Jan 2023 11:04:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 339BA20040;
        Mon, 30 Jan 2023 11:04:01 +0000 (GMT)
Received: from localhost (unknown [9.171.84.174])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 11:04:01 +0000 (GMT)
From:   Alexander Egorenkov <Alexander.Egorenkov@ibm.com>
To:     willy@infradead.org
Cc:     akpm@linux-foundation.org, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mpage: Convert __mpage_writepage() to use a folio
 more fully
In-Reply-To: <20230126201255.1681189-3-willy@infradead.org>
In-Reply-To: 
Date:   Mon, 30 Jan 2023 12:04:00 +0100
Message-ID: <878rhk707z.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fe0j-r8KUss-8L4481DpZi9zH1dgrc6Z
X-Proofpoint-GUID: fe0j-r8KUss-8L4481DpZi9zH1dgrc6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_10,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=478 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1011 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

after this change we see a WARNING on s390 linux-next with LTP tests (write=
v03).

RELEASE: 6.2.0-20230129.rc5.git1.e2f86c02fdc9.300.fc37.s390x+next

  [ 5577.900868] BTRFS: device fsid 4127fc5b-a6b3-44ff-927d-7bfc5163686e de=
vid 1 transid 6 /dev/loop0 scanned by mkfs.btrfs (2502327)
  [ 5577.901186] BTRFS info (device loop0): using crc32c (crc32c-vx) checks=
um algorithm
  [ 5577.901192] BTRFS info (device loop0): using free space tree
  [ 5577.901847] BTRFS info (device loop0): enabling ssd optimizations
  [ 5577.901850] BTRFS info (device loop0): auto enabling async discard
  [ 5577.901895] BTRFS info (device loop0): checking UUID tree
  [ 5620.655695] ------------[ cut here ]------------
  [ 5620.655702] WARNING: CPU: 6 PID: 2404385 at fs/mpage.c:570 __mpage_wri=
tepage+0x79c/0x7b0
  [ 5620.655711] Modules linked in: xt_state(E) quota_v2(E) quota_tree(E) t=
un(E) nls_utf8(E) overlay(E) nls_iso8859_1(E) nls_cp437(E) ntfs(E) exfat(E)=
 vfat(E) fat(E) loop(E) sctp(E) ip6_udp_tunnel(E) udp_tunnel(E) kunit(E) af=
_packet_diag(E) unix_diag(E) mptcp_diag(E) xfrm_user(E) xfrm_algo(E) crypto=
_user(E) tcp_diag(E) inet_diag(E) netlink_diag(E) algif_hash(E) af_alg(E) d=
m_service_time(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E=
) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_=
ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defra=
g_ipv4(E) ip_set(E) nf_tables(E) nfnetlink(E) sunrpc(E) zfcp(E) scsi_transp=
ort_fc(E) s390_trng(E) vfio_ccw(E) mdev(E) vfio_iommu_type1(E) vfio(E) sch_=
fq_codel(E) ip6_tables(E) ip_tables(E) x_tables(E) configfs(E) ghash_s390(E=
) prng(E) chacha_s390(E) libchacha(E) aes_s390(E) des_s390(E) libdes(E) sha=
3_512_s390(E) sha3_256_s390(E) sha512_s390(E) sha256_s390(E) sha1_s390(E) s=
ha_common(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E)
  [ 5620.655763]  pkey(E) zcrypt(E) rng_core(E) dm_multipath(E) autofs4(E)
  [ 5620.655778] Unloaded tainted modules: init_module(OE):3 finit_module(O=
E):3 dummy_del_mod_dep(OE):1 dummy_del_mod(OE):2 test_unwind(E):1 test_modu=
les(E):1 test_kprobes_s390(E):1 test_kprobes(E):1 klp_tc_17_livepatch(OEK):=
1 klp_tc_16_livepatch(OEK):1 klp_tc_15_livepatch(OEK):1 klp_tc_14_livepatch=
(OEK):1 klp_tc_13_livepatch(OEK):1 klp_tc_12_livepatch(OEK):1 klp_tc_11_liv=
epatch(OEK):1 klp_test_support_mod(OE):8 klp_tc_10_livepatch(OEK):1 klp_tc_=
8_5_livepatch(OEK):1 klp_tc_8_4_livepatch(OEK):1 klp_tc_8_3_livepatch(OEK):=
1 klp_tc_8_2_livepatch(OEK):1 klp_tc_8_1_livepatch(OEK):1 klp_tc_6_livepatc=
h(OEK):1 klp_tc_5_1_livepatch(OEK):1 klp_tc_5_2_livepatch(OEK):1 klp_tc_5_3=
_livepatch(OEK):1 klp_tc_5_4_livepatch(OEK):1 klp_tc_5_5_livepatch(OEK):1 k=
lp_tc_5_6_livepatch(OEK):1 klp_tc_5_7_livepatch(OEK):1 klp_tc_5_8_livepatch=
(OEK):1 klp_tc_5_9_livepatch(OEK):1 klp_tc_5_10_livepatch(OEK):1 klp_tc_5_1=
1_livepatch(OEK):1 klp_tc_5_12_livepatch(OEK):1 klp_tc_5_13_livepatch(OEK):=
1 klp_tc_5_14_livepatch(OEK):1 klp_tc_5_15_livepatch(OEK):1
  [ 5620.655806]  klp_tc_3_livepatch(OEK):1 [last unloaded: init_module(OE)]
  [ 5620.655815] CPU: 6 PID: 2404385 Comm: kworker/u128:8 Tainted: G       =
    OE K  N 6.2.0-20230129.rc5.git1.e2f86c02fdc9.300.fc37.s390x+next #1
  [ 5620.655818] Hardware name: IBM 3931 A01 704 (z/VM 7.3.0)
  [ 5620.655820] Workqueue: writeback wb_workfn (flush-7:0)
  [ 5620.655861] Krnl PSW : 0704c00180000000 0000000077704118 (__mpage_writ=
epage+0x7a0/0x7b0)
  [ 5620.655866]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 P=
M:0 RI:0 EA:3
  [ 5620.655869] Krnl GPRS: 0000000000000000 0000000000001000 0000000000000=
000 0000000000000000
  [ 5620.655872]            0000038000000001 00000001ce688000 0000000000000=
000 0000037200000009
  [ 5620.655874]            00000380004cb970 0000000000000000 0000038000000=
001 0000037203a01d80
  [ 5620.655877]            00000000855f2100 0000000000000000 0000000000000=
000 00000380004cb660
  [ 5620.655885] Krnl Code: 000000007770410c: a7181000          lhi     %r1=
,4096
                            0000000077704110: a7f4fe34          brc     15,=
0000000077703d78
                           #0000000077704114: af000000          mc      0,0
                           >0000000077704118: a7f4fccc          brc     15,=
0000000077703ab0
                            000000007770411c: af000000          mc      0,0
                            0000000077704120: d70010001000      xc      0(1=
,%r1),0(%r1)
                            0000000077704126: 0707              bcr     0,%=
r7
                            0000000077704128: c00400497b2c      brcl    0,0=
000000078033780
  [ 5620.655905] Call Trace:
  [ 5620.655907]  [<0000000077704118>] __mpage_writepage+0x7a0/0x7b0
  [ 5620.655911]  [<00000000775c9df0>] write_cache_pages+0x1b0/0x418
  [ 5620.655916]  [<0000000077703824>] mpage_writepages+0x64/0xb0
  [ 5620.655918]  [<00000000775cb416>] do_writepages+0x66/0x1d0
  [ 5620.655921]  [<00000000776ee14c>] __writeback_single_inode+0x4c/0x410
  [ 5620.655925]  [<00000000776eea2a>] writeback_sb_inodes+0x232/0x5a0
  [ 5620.655928]  [<00000000776eedf2>] __writeback_inodes_wb+0x5a/0x138
  [ 5620.655931]  [<00000000776ef140>] wb_writeback+0x270/0x3a0
  [ 5620.655934]  [<00000000776f04e0>] wb_workfn+0x370/0x5b8
  [ 5620.655936]  [<00000000773daab8>] process_one_work+0x200/0x458
  [ 5620.655940]  [<00000000773db246>] worker_thread+0x66/0x490
  [ 5620.655942]  [<00000000773e4098>] kthread+0x108/0x110
  [ 5620.655944]  [<000000007736736c>] __ret_from_fork+0x3c/0x58
  [ 5620.655947]  [<0000000077fecb6a>] ret_from_fork+0xa/0x40
  [ 5620.655952] Last Breaking-Event-Address:
  [ 5620.655953]  [<0000000077703d2e>] __mpage_writepage+0x3b6/0x7b0
  [ 5620.655956] Kernel panic - not syncing: kernel: panic_on_warn set ...
  [ 5620.655958] CPU: 6 PID: 2404385 Comm: kworker/u128:8 Tainted: G       =
    OE K  N 6.2.0-20230129.rc5.git1.e2f86c02fdc9.300.fc37.s390x+next #1
  [ 5620.655961] Hardware name: IBM 3931 A01 704 (z/VM 7.3.0)
  [ 5620.655962] Workqueue: writeback wb_workfn (flush-7:0)
  [ 5620.655965] Call Trace:
  [ 5620.655966]  [<0000000077fdd01a>] dump_stack_lvl+0x62/0x80
  [ 5620.655970]  [<0000000077fcb658>] panic+0x118/0x300
  [ 5620.655973]  [<00000000773b5d80>] check_panic_on_warn+0x70/0x88
  [ 5620.655977]  [<00000000773b6028>] __warn+0x108/0x150
  [ 5620.655979]  [<0000000077fa06da>] report_bug+0xba/0x140
  [ 5620.655983]  [<00000000773651a4>] monitor_event_exception+0x44/0x80
  [ 5620.655985]  [<0000000077fdd218>] __do_pgm_check+0xf0/0x1b0
  [ 5620.655988]  [<0000000077feccbc>] pgm_check_handler+0x11c/0x170
  [ 5620.655991]  [<0000000077704118>] __mpage_writepage+0x7a0/0x7b0
  [ 5620.655993]  [<00000000775c9df0>] write_cache_pages+0x1b0/0x418
  [ 5620.655995]  [<0000000077703824>] mpage_writepages+0x64/0xb0
  [ 5620.655998]  [<00000000775cb416>] do_writepages+0x66/0x1d0
  [ 5620.656000]  [<00000000776ee14c>] __writeback_single_inode+0x4c/0x410
  [ 5620.656003]  [<00000000776eea2a>] writeback_sb_inodes+0x232/0x5a0
  [ 5620.656006]  [<00000000776eedf2>] __writeback_inodes_wb+0x5a/0x138
  [ 5620.656010]  [<00000000776ef140>] wb_writeback+0x270/0x3a0
  [ 5620.656012]  [<00000000776f04e0>] wb_workfn+0x370/0x5b8
  [ 5620.656014]  [<00000000773daab8>] process_one_work+0x200/0x458
  [ 5620.656016]  [<00000000773db246>] worker_thread+0x66/0x490
  [ 5620.656019]  [<00000000773e4098>] kthread+0x108/0x110
  [ 5620.656020]  [<000000007736736c>] __ret_from_fork+0x3c/0x58
  [ 5620.656023]  [<0000000077fecb6a>] ret_from_fork+0xa/0x40
  crash> q

Regards
Alex
