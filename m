Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6D269B450
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 22:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBQVAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 16:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBQVAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:00:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207953B659;
        Fri, 17 Feb 2023 13:00:01 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HKZUqW011132;
        Fri, 17 Feb 2023 20:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=mtvBsyU8XADwYu46GeHqCJKq8+Z8yzmqh+fK44bsmJ4=;
 b=iDN6Gu+1byNFsr89/OoD4JaYI/nbJ/3rR5OvO2j5FvvarY/Q6K+TIN+UqK4afyJ/Dj5g
 WznF4i7pg7kTcgBlIYej5+QmCAEQVWie4hYsRZ2p5jsG+4nqRo69j3H1zmublZkVN109
 i+lhY2PYON/DhtwjexY0AZoqxbcNRz6QDwsKMklZtVroQWuXqK/SQsc8aKuJS50nFlZh
 IS11bcZZVQ8FsTh9xGe0B+leCEJuhHGko/+YqcHnMDoUyCj4laIj6u07n1CZiFjEByOw
 sXpq4GjdnhN49Pq3Gz98FlHF+jwiXYwh+I6PbGCShAid8lNosBMlPSTG5rHv7xdK5x8p 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ntdj0d258-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 20:59:40 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31HKboPR017510;
        Fri, 17 Feb 2023 20:59:39 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ntdj0d24a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 20:59:39 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31HBbN5V017648;
        Fri, 17 Feb 2023 20:59:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6rf59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 20:59:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HKxXoV49873182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 20:59:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 728132004E;
        Fri, 17 Feb 2023 20:59:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E6182004B;
        Fri, 17 Feb 2023 20:59:33 +0000 (GMT)
Received: from localhost (unknown [9.179.0.31])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 20:59:33 +0000 (GMT)
From:   egorenar@linux.ibm.com
To:     egorenar@linux.ibm.com
Cc:     axboe@kernel.dk, david@redhat.com, dhowells@redhat.com,
        hch@infradead.org, hch@lst.de, hdanton@sina.com, jack@suse.cz,
        jgg@nvidia.com, jhubbard@nvidia.com, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        logang@deltatee.com, viro@zeniv.linux.org.uk, willy@infradead.org
Cc:     mhartmay@linux.ibm.com
Subject: Re: [PATCH v14 08/17] splice: Do splice read from a file without
 using ITER_PIPE
In-Reply-To: <87a61ckowk.fsf@oc8242746057.ibm.com>
In-Reply-To: 
Date:   Fri, 17 Feb 2023 21:59:33 +0100
Message-ID: <877cwgknyi.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U28IYZLbSCFId4W3_J-x4CaJaQmE4pcB
X-Proofpoint-GUID: MXb_ez_tu3zfuqMxToO4sKFkRJsrzLb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_14,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=915
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170180
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Forgot to mention another related problem we had recently.

We have seen LTP test suite failing in 'sendfile09' test case on 2023-02-15:

 [ 5157.233192] CPU: 0 PID: 2435571 Comm: sendfile09 Tainted: G           OE K  N 6.2.0-20230214.rc8.git112.3ebb0ac55efa.300.fc37.s390x+next #1
 [ 5157.233197] Hardware name: IBM 8561 T01 701 (z/VM 7.3.0)
 [ 5157.233199] Krnl PSW : 0704d00180000000 0000000000000002 (0x2)
 [ 5157.233207]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
 [ 5157.233210] Krnl GPRS: 0000000000000008 0000000000000000 00000000893d1800 00000372088bd040
 [ 5157.233213]            00000372088bd040 000000018c836000 0000000000000000 0000038000a4bb80
 [ 5157.233215]            00000372088bd040 0000000000000000 00000000893d1800 00000372088bd040
 [ 5157.233218]            0000000081182100 00000000893d1800 000000001f691596 0000038000a4b9b0
 [ 5157.233222] Krnl Code:#0000000000000000: 0000       illegal 
              >0000000000000002: 0000        illegal 
               0000000000000004: 0000       illegal 
               0000000000000006: 0000       illegal 
               0000000000000008: 0000       illegal 
               000000000000000a: 0000       illegal 
               000000000000000c: 0000       illegal 
               000000000000000e: 0000       illegal 
 [ 5157.233281] Call Trace:
 [ 5157.233284]  [<0000000000000002>] 0x2 
 [ 5157.233288]  [<000000001f694e26>] filemap_get_pages+0x276/0x3b0 
 [ 5157.233296]  [<000000001f7c7256>] generic_file_buffered_splice_read.constprop.0+0xd6/0x370 
 [ 5157.233301]  [<000000001f7c6aa0>] do_splice_to+0x98/0xc8 
 [ 5157.233304]  [<000000001f7c6eee>] splice_direct_to_actor+0xb6/0x270 
 [ 5157.233306]  [<000000001f7c714a>] do_splice_direct+0xa2/0xd8 
 [ 5157.233309]  [<000000001f77c79c>] do_sendfile+0x39c/0x4e8 
 [ 5157.233314]  [<000000001f77ca00>] __do_sys_sendfile64+0x68/0xc0 
 [ 5157.233317]  [<00000000200b4bb4>] __do_syscall+0x1d4/0x200 
 [ 5157.233322]  [<00000000200c42f2>] system_call+0x82/0xb0 
 [ 5157.233328] Last Breaking-Event-Address:
 [ 5157.233329]  [<000000001f691594>] filemap_read_folio+0x3c/0xd0
 [ 5157.233338] Kernel panic - not syncing: Fatal exception: panic_on_oops

But it was apparently fixed on the next day.

Regards
Alex
