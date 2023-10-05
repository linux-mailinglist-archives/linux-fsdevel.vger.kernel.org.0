Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338EE7BA071
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbjJEOgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbjJEOej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:34:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D16527A;
        Thu,  5 Oct 2023 06:52:38 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395DQhjE031548;
        Thu, 5 Oct 2023 13:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=R/QTM1fzVv6cm+wswFVzDr/m9+FgX0LQuY8/jeKmhko=;
 b=cuCVAU6kZBORw4kNzQM8QhKATzaQYQx9sq9VyXtyAcbUjSJlu2csv9UKwRsMdWToW/kZ
 0C0RhlLfSx4clzeAM9kri0/U0zoNlTG8RblVDlrVkUr8EElTobyZsMXrLACmhgSCyeNj
 mwc7IV+kj/e+X5u63Eo6l2E8JPclAG8R1FP1Mai2lrKjyos0n24UwIr+NGmFo5l/dmCQ
 dGyPtibDLCjR17Zb0bp+IBJPg1LpSIU+tL/CMmv8D5xPmvorNRdNYuKpBMJSXVYh1+lJ
 yx7r7YcPGH6+f/EQTT0ey3+nrJjVS9Dgplu6YZos1rGIOPl3jrrD8md/aNUQm4O8WJSh nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thq9k02u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 13:41:49 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395DR6nD000477;
        Thu, 5 Oct 2023 13:36:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thq9jywwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 13:36:47 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 395BKrDl017644;
        Thu, 5 Oct 2023 13:35:43 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tey0nuqkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 13:35:43 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 395DZgnd64356738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Oct 2023 13:35:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F204A58051;
        Thu,  5 Oct 2023 13:35:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CBCF5805C;
        Thu,  5 Oct 2023 13:35:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.90.188])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  5 Oct 2023 13:35:41 +0000 (GMT)
Message-ID: <97be76d94fdacf369a324b6122d5f5bc19a3838c.camel@linux.ibm.com>
Subject: Re: [syzbot] [integrity] [overlayfs] possible deadlock in
 mnt_want_write (2)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzbot@syzkalhler.appspotmail.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Date:   Thu, 05 Oct 2023 09:35:40 -0400
In-Reply-To: <CAOQ4uxgfJ4owqzh99t65MyT5A99BbwkLQ-sHumCUWyqSw-Rd5g@mail.gmail.com>
References: <CAOQ4uxhbNyDzf0_fFh1Yy5Kz2Coz=gTrfOtsmteE0=ncibBnpw@mail.gmail.com>
         <0000000000001081fc0606f52ed9@google.com>
         <CAOQ4uxjw_XztGxrhR9LWtz_SszdURkM+Add2q8A9BAt0z901kA@mail.gmail.com>
         <25f6950a67be079e32ad5b4139b1e89e367a91ba.camel@linux.ibm.com>
         <CAOQ4uxgfJ4owqzh99t65MyT5A99BbwkLQ-sHumCUWyqSw-Rd5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SRYz0AUECWsolMMPvJe_2XVNQ0vgpjPQ
X-Proofpoint-ORIG-GUID: 2cgjxh7a4g6A1IxuXODZIVABZC_A6upp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_08,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=642 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050107
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-10-05 at 16:22 +0300, Amir Goldstein wrote:
> On Thu, Oct 5, 2023 at 4:14 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Thu, 2023-10-05 at 13:26 +0300, Amir Goldstein wrote:
> > > On Thu, Oct 5, 2023 at 12:59 PM syzbot
> > > <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot tried to test the proposed patch but the build/boot failed:
> > >
> > > My mistake. Please try again:
> > >
> > > #syz test: https://github.com/amir73il/linux ima-ovl-fix
> >
> > Thanks, Amir.   "mutext_init(&iint->mutex); moved, but the status
> > initialization lines 161-166 were dropped.   They're needed by IMA-
> > appraisal for signature verification.
> >
> >         iint->ima_file_status = INTEGRITY_UNKNOWN;
> >         iint->ima_mmap_status = INTEGRITY_UNKNOWN;
> >         iint->ima_bprm_status = INTEGRITY_UNKNOWN;
> >         iint->ima_read_status = INTEGRITY_UNKNOWN;
> >         iint->ima_creds_status = INTEGRITY_UNKNOWN;
> >         iint->evm_status = INTEGRITY_UNKNOWN;
> >
> 
> They are dropped from iint_init_once()
> They are not needed there because there are now set
> in every iint allocation in iint_init_always()
> instead of being set in iint_free()

I was only looking at the patch and noticed the removal.  Thanks, this
looks good.

Mimi

