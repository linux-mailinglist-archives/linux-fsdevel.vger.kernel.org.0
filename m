Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860867BA093
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbjJEOiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbjJEOfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:35:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562633790D;
        Thu,  5 Oct 2023 06:58:54 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395D7At8014585;
        Thu, 5 Oct 2023 13:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3ex7mhh2wNwC1ElK8hxF+83j+vTpDKL0Hxu33BudBd8=;
 b=MWciXcw9Mk5LbHWdbl1mR3kLIsj5/hHig5wyk5zJzaPcyw7X+i2ZrMCzDiHl0OFoxORW
 N/HA45jFni71aaWEKoDfa+ky44f4UPOq4vNLWOI3h2oeiU25jQXx7Eh+YlbTWqUoJB6x
 U3zKDhjTeuTcJDHReE/xu+H6u3RvZwvWygyUlAyyMDMNVj2Q4PZgDSi26zihSsPXtBGq
 PzJu1rK3PXs6OnNI03sHPROY8c0fFbYSV8ThON3eYtdBGbwWxwpwVG7ricpuJTre3UaT
 F5aGZsK2AvIS91P5kBlHERUSb9+G0sYAlHuKNYujuC+RII8rw2/UfLgiIRuDpOe4ji5S NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thwrdrbbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 13:14:06 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395D785C014528;
        Thu, 5 Oct 2023 13:10:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thwrdr93w-62
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 13:10:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 395ACNA9010931;
        Thu, 5 Oct 2023 11:47:08 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf0q2angr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 11:47:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 395Bl7mJ262752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Oct 2023 11:47:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BE9B5805A;
        Thu,  5 Oct 2023 11:47:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BC8358052;
        Thu,  5 Oct 2023 11:47:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.90.188])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  5 Oct 2023 11:47:06 +0000 (GMT)
Message-ID: <25f6950a67be079e32ad5b4139b1e89e367a91ba.camel@linux.ibm.com>
Subject: Re: [syzbot] [integrity] [overlayfs] possible deadlock in
 mnt_want_write (2)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzbot@syzkalhler.appspotmail.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Date:   Thu, 05 Oct 2023 07:47:06 -0400
In-Reply-To: <CAOQ4uxjw_XztGxrhR9LWtz_SszdURkM+Add2q8A9BAt0z901kA@mail.gmail.com>
References: <CAOQ4uxhbNyDzf0_fFh1Yy5Kz2Coz=gTrfOtsmteE0=ncibBnpw@mail.gmail.com>
         <0000000000001081fc0606f52ed9@google.com>
         <CAOQ4uxjw_XztGxrhR9LWtz_SszdURkM+Add2q8A9BAt0z901kA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mBwZEAiNtaVL6b8uRu3IAIxO_elfKi-K
X-Proofpoint-ORIG-GUID: Moy2T3K-Oh6VNFoTbGhz-ZhtPfbNOcl5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_08,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=711 adultscore=0 clxscore=1011 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310050103
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-10-05 at 13:26 +0300, Amir Goldstein wrote:
> On Thu, Oct 5, 2023 at 12:59 PM syzbot
> <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot tried to test the proposed patch but the build/boot failed:
> 
> My mistake. Please try again:
> 
> #syz test: https://github.com/amir73il/linux ima-ovl-fix

Thanks, Amir.   "mutext_init(&iint->mutex); moved, but the status
initialization lines 161-166 were dropped.   They're needed by IMA-
appraisal for signature verification.

        iint->ima_file_status = INTEGRITY_UNKNOWN;
	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
	iint->ima_read_status = INTEGRITY_UNKNOWN;
	iint->ima_creds_status = INTEGRITY_UNKNOWN;
	iint->evm_status = INTEGRITY_UNKNOWN;

