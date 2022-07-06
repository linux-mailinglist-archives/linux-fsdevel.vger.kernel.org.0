Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C55356953F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 00:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiGFWYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 18:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiGFWYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:24:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B772AE21;
        Wed,  6 Jul 2022 15:24:42 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266LVUS3028569;
        Wed, 6 Jul 2022 22:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=F22vL1+5zsau5Vgjd7MmaM1vXo7+Zz3f/wM7XhhKd6c=;
 b=pC3mI7Xh3kdusXzPklz6t1ERL4zskFdqN8XyKYog1arE5r+JGDm7p/4hr/zw3gaG8NYY
 NHptSpjQpy6e41lPW5IRDTG2YytQzH/2FjymRj8O8bF6ZZvgaginmbYxm796P4BdhHGU
 NyuBW2LHmUDOWt9V6FwhJMyXkbG/h0wd5atnZVznRHRsFoyTOdoam5hSXKOsB5I7Ee9u
 blnyHMLSqQcn1rnGssbfs/ZVIZGcYLca/cAqQq7UBySJX0TEjOxZjbyNpu5kxX+irl3Z
 EgThFGZUz/NIsth/y5L2sj3dIL1f0yDSwyp5c/w9SROjgqhqYHpoMoxg9fUQuXkHgTkL ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5g39vhtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 22:24:39 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 266MFcFk027819;
        Wed, 6 Jul 2022 22:24:38 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5g39vhsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 22:24:38 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 266MM9iD001881;
        Wed, 6 Jul 2022 22:24:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3h4v4jsnvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 22:24:36 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 266MOYlB21692744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jul 2022 22:24:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DDBB11C04C;
        Wed,  6 Jul 2022 22:24:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C859111C04A;
        Wed,  6 Jul 2022 22:24:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.26.108])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Jul 2022 22:24:31 +0000 (GMT)
Message-ID: <d262e97cea0b9c32065ee8e02354a0aa0134c8ab.camel@linux.ibm.com>
Subject: Re: [syzbot] possible deadlock in mnt_want_write (2)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+b42fe626038981fb7bfa@syzkalhler.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 06 Jul 2022 18:24:30 -0400
In-Reply-To: <20220706121038.2045-1-hdanton@sina.com>
References: <000000000000466f0d05e2d5d1d1@google.com>
         <20220706121038.2045-1-hdanton@sina.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vCVT9Ma_lepHnNYECMUdcbyAA1tib5nH
X-Proofpoint-GUID: QlBo5NoRdChiUREP_Mp9wQWZ9xlRLJNy
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207060083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Hillf,g

On Wed, 2022-07-06 at 20:10 +0800, Hillf Danton wrote:
> On Tue, 05 Jul 2022 08:53:15 -0400 Mimi Zohar wrote:
> > 
> > Thank you for the reproducer.  This seems to be a similar false
> > positive as was discussed:
> > https://lore.kernel.org/linux-unionfs/000000000000c5b77105b4c3546e@google.com/
> > 
> > thanks,
> > 
> 
> Hi Mimi
> 
> Please pick up the patch attached if it makes sense to you.

The patch itself looks good, but missing from the patch description is
an indication that the lockdep warning is a false positive.  Perhaps
add a "Suggested-by" line crediting Amir.   I'd appreciate your posting
the patch on the mailing list.

thanks!

Mimi

> From: Hillf Danton <hdanton@sina.com>
> Subject: [PATCH] integrity: lockdep annotate of iint->mutex
> 
> This fixes a reported lockdep splat
> 
>         CPU0                    CPU1
>         ----                    ----
> 	lock(&iint->mutex);
> 				lock(sb_writers#4);
> 				lock(&iint->mutex);
> 	lock(sb_writers#4);
>  
> 	*** DEADLOCK ***
> 
> using the method in 4eae06de482b annotating OVL_I(inode)->lock.
> 
> Links: https://lore.kernel.org/linux-unionfs/CAOQ4uxjk4XYuwz5HCmN-Ge=Ld=tM1f7ZxVrd5U1AC2Wisc9MTA@mail.gmail.com/
> Reported-and-tested-by: syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> 
> --- a/security/integrity/iint.c 
> +++ b/security/integrity/iint.c 
> @@ -85,6 +85,17 @@ static void iint_free(struct integrity_i
>  	kmem_cache_free(iint_cache, iint);
>  }
>  
> +static void iint_annotate_mutex_key(struct integrity_iint_cache *iint, struct inode *inode)
> +{
> +#ifdef CONFIG_LOCKDEP
> +	static struct lock_class_key iint_mutex_key[FILESYSTEM_MAX_STACK_DEPTH];
> +
> +	int depth = inode->i_sb->s_stack_depth;
> +
> +	lockdep_set_class(&iint->mutex, &iint_mutex_key[depth]);
> +#endif
> +}
> +
>  /**
>   * integrity_inode_get - find or allocate an iint associated with an inode
>   * @inode: pointer to the inode
> @@ -114,6 +125,8 @@ struct integrity_iint_cache *integrity_i
>  	if (!iint)
>  		return NULL;
>  
> +	iint_annotate_mutex_key(iint, inode);
> +
>  	write_lock(&integrity_iint_lock);
>  
>  	p = &integrity_iint_tree.rb_node;
> --


