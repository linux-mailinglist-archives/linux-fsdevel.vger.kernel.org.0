Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49AC7BF020
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 03:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379344AbjJJBO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 21:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379287AbjJJBO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:14:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F50B9D;
        Mon,  9 Oct 2023 18:14:25 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39A16ApM012966;
        Tue, 10 Oct 2023 01:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=OWNx4Dc16p2VrNqth4UHuwuTAqcH/+k7eoc5opXOse8=;
 b=p3CQvMUR2m5vm70icim/T9NexzE2tPzXtLPyA3Na6oXL7RQtRuLVyok4zPmiXjWzFpJN
 c71ydsKC6duhIhDeteHYnw9mcAbYW/aPLR2fjJdJFZAVrsvwHtaPxgi1uSouxsGiqdt+
 n1Pbd+fJmE8Xv/x+S9hvsf0iz6n+/RTDtGemgTSyFjgPH48s5djKC9Ac/5JMyWf2AyzT
 5pFu2lfv3GFvmpib3srj9c3AICgCzT44mxR9uDW0uXl2nXcHFAXC4ESrZTYiIqG/N+dn
 z1oaS+f7u0BUJGCwwu0yoaKsOfuiWFX/nKbUYjQNlovev26JmuRDsJACAbgYIaJRTooH LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmvf1gpbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 01:14:08 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39A1CJAw006277;
        Tue, 10 Oct 2023 01:14:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmvf1gp8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 01:14:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 399NNuP0000693;
        Tue, 10 Oct 2023 01:14:04 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5kct8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 01:14:03 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39A1E3tp42729816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 01:14:03 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EB1258059;
        Tue, 10 Oct 2023 01:14:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9504C58063;
        Tue, 10 Oct 2023 01:14:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.60.67])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Oct 2023 01:14:02 +0000 (GMT)
Message-ID: <8e1fd27440e08741db52dbe7a55552552c78316b.camel@linux.ibm.com>
Subject: Re: [PATCH] fs: Pass AT_GETATTR_NOSEC flag to getattr interface
 function
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>,
        syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>
Date:   Mon, 09 Oct 2023 21:14:02 -0400
In-Reply-To: <20231003-bespielbar-tarnt-c61162656db5@brauner>
References: <20231002125733.1251467-1-stefanb@linux.vnet.ibm.com>
         <CAOQ4uxiuQxTDqn4F62ueGf_9f4KC4p7xqRZdwPvL8rEYrCOWbg@mail.gmail.com>
         <20231003-bespielbar-tarnt-c61162656db5@brauner>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1yiI-AWQMuJudohy-q7YX2HlXuaDbcol
X-Proofpoint-ORIG-GUID: k889ZtI7slsu4wSAFluAHoNfPZBpPUNp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_01,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=976 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310100007
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-10-03 at 15:38 +0200, Christian Brauner wrote:
> On Mon, Oct 02, 2023 at 04:22:25PM +0300, Amir Goldstein wrote:
> > On Mon, Oct 2, 2023 at 3:57 PM Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> > >
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > >
> > > When vfs_getattr_nosec() calls a filesystem's getattr interface function
> > > then the 'nosec' should propagate into this function so that
> > > vfs_getattr_nosec() can again be called from the filesystem's gettattr
> > > rather than vfs_getattr(). The latter would add unnecessary security
> > > checks that the initial vfs_getattr_nosec() call wanted to avoid.
> > > Therefore, introduce the getattr flag GETATTR_NOSEC and allow to pass
> > > with the new getattr_flags parameter to the getattr interface function.
> > > In overlayfs and ecryptfs use this flag to determine which one of the
> > > two functions to call.
> > >
> > > In a recent code change introduced to IMA vfs_getattr_nosec() ended up
> > > calling vfs_getattr() in overlayfs, which in turn called
> > > security_inode_getattr() on an exiting process that did not have
> > > current->fs set anymore, which then caused a kernel NULL pointer
> > > dereference. With this change the call to security_inode_getattr() can
> > > be avoided, thus avoiding the NULL pointer dereference.
> > >
> > > Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
> > > Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > Cc: Tyler Hicks <code@tyhicks.com>
> > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > Suggested-by: Christian Brauner <brauner@kernel.org>
> > > Co-developed-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > ---
> > 
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > 
> > Now let's see what vfs maintainers think about this...
> 
> Seems fine overall. We kind of need to propagate the knowledge through
> the layers. But I don't like that we need something like it...

So at this point there are two options.  Either revert commit
db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version") or
this patch to fix it.  Christian, what do you prefer?

Mimi

