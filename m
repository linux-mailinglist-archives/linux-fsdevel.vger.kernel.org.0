Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487386B0D66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 16:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjCHPwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 10:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCHPwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:52:34 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B17811665;
        Wed,  8 Mar 2023 07:52:33 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328EA4kw021368;
        Wed, 8 Mar 2023 15:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jHt3Yt1N+jjYFR2SJ074JKx0EsmJ3Y2vMpruhc7Uzkg=;
 b=KJYOtmt80MhhPhe5cDCSOvnAT/wDtRAgtqFFrcOeorT05ErOcz6+/YZRS/1mr33vxs8M
 aiarpNMbYGgxBm3Q4IqgAgOrAbWZQWNexN7XRCRvh1Mkn2T7b3SX+itMxYGAD00P0kV4
 gdxnX7mVCqfsUX93c3uJMA+Eo0hbSxOufEJ+cseJtmxyyjP6lkMxa8o2qFRslFqvGhBU
 oz7tcFEeH5eKHgfHKIlXhjCVr0Rxr/ZG9/gd0YNxGkZBrf8kAmHRXtvoUCEwDtRg1YhH
 /GfSAqnSntWPtkNUTwyC/lFhX1NM+plBVIGhRseYf9PCfe4bWaYlOEfZYsh8mNFbbo2d ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6suk614u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:52:12 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328DKYnw011694;
        Wed, 8 Mar 2023 15:52:11 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6suk614f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:52:11 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 328EbNRd009868;
        Wed, 8 Mar 2023 15:52:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3p6g1gkw94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:52:11 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 328Fq9mA60162324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Mar 2023 15:52:09 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A052458063;
        Wed,  8 Mar 2023 15:52:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B3C558052;
        Wed,  8 Mar 2023 15:52:08 +0000 (GMT)
Received: from sig-9-77-134-135.ibm.com (unknown [9.77.134.135])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Mar 2023 15:52:07 +0000 (GMT)
Message-ID: <b8acdcc49b33b738bebc0921f7688782489b52bd.camel@linux.ibm.com>
Subject: Re: [PATCH 23/28] security: Introduce LSM_ORDER_LAST
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, dmitry.kasatkin@gmail.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        jarkko@kernel.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 08 Mar 2023 10:52:06 -0500
In-Reply-To: <384be560fdc4c37f056acc655de68372049560c7.camel@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303182602.1088032-1-roberto.sassu@huaweicloud.com>
         <a0320926ebfe732dabc4e53c3a35ede450c75474.camel@linux.ibm.com>
         <ee5d9eb3addb9d408408fd748d52686bd9b85e24.camel@huaweicloud.com>
         <1d02222998cf465fa7080ffb910bcf5815b7f857.camel@linux.ibm.com>
         <384be560fdc4c37f056acc655de68372049560c7.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wpGU8fROSMOcJ8mWxKHMrk_Bn0V7bQpt
X-Proofpoint-ORIG-GUID: vKUIsgEdfDTBLkM-2Swi-Cxep995t66S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080132
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-03-08 at 15:35 +0100, Roberto Sassu wrote:
> On Wed, 2023-03-08 at 09:00 -0500, Mimi Zohar wrote:
> > On Wed, 2023-03-08 at 14:26 +0100, Roberto Sassu wrote:
> > > On Wed, 2023-03-08 at 08:13 -0500, Mimi Zohar wrote:
> > > > Hi Roberto,
> > > > 
> > > > On Fri, 2023-03-03 at 19:25 +0100, Roberto Sassu wrote:
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > 
> > > > > Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs willing to be
> > > > > the last, e.g. the 'integrity' LSM, without changing the kernel command
> > > > > line or configuration.
> > > > 
> > > > Please reframe this as a bug fix for 79f7865d844c ("LSM: Introduce
> > > > "lsm=" for boottime LSM selection") and upstream it first, with
> > > > 'integrity' as the last LSM.   The original bug fix commit 92063f3ca73a
> > > > ("integrity: double check iint_cache was initialized") could then be
> > > > removed.
> > > 
> > > Ok, I should complete the patch by checking the cache initialization in
> > > iint.c.
> > > 
> > > > > As for LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled and put
> > > > > at the end of the LSM list in no particular order.
> > > > 
> > > > ^Similar to LSM_ORDER_FIRST ...
> > > > 
> > > > And remove "in no particular order".
> > > 
> > > The reason for this is that I originally thought that the relative
> > > order of LSMs specified in the kernel configuration or the command line
> > > was respected (if more than one LSM specifies LSM_ORDER_LAST). In fact
> > > not. To do this, we would have to parse the LSM string again, as it is
> > > done for LSM_ORDER_MUTABLE LSMs.
> > 
> > IMA and EVM are only configurable if 'integrity' is enabled.  Similar
> > to how LSM_ORDER_FIRST is reserved for capabilities, LSM_ORDER_LAST
> > should be reserved for integrity (LSMs), if it is configured, for the
> > reason as described in the "[PATCH 24/28] ima: Move to LSM
> > infrastructure" patch description.
> 
> Yes, it is just that nothing prevents to have multiple LSMs with order
> LSM_ORDER_LAST. I guess we will enforce that it is only one by
> reviewing the code.

At least add a comment, like the existing one for LSM_ORDER_FIRST.

> > > >  enum lsm_order {
> > > > >  	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
> > > > >  	LSM_ORDER_MUTABLE = 0,
> > > > > +	LSM_ORDER_LAST = 1,
> > > > >  };

-- 
thanks,

Mimi

