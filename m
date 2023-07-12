Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B57508E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 14:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjGLM4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 08:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjGLM4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:56:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75151173B;
        Wed, 12 Jul 2023 05:56:50 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CCqls1015912;
        Wed, 12 Jul 2023 12:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=DM/+bB1GI+w8sbgcaGTj8NxYs1rqWPKdOCH7h7tAdIo=;
 b=g1g0qgYYWFBC65sFjn+7gX8CLn9MVITi7fhPiRh/PSebXXipBlXrE/TL4m6TbqJKdKvH
 0KLmMi8vyP7I3319wMJBva1a9Fjat+r3MQH91TpFebbC+8CN9Y5ZjOTeMOBrgM1FHy+i
 nqqGANA6KjOPSgA1w4xfsZUU+U/aqoboGUb4wYu6QuETUhuC3b6LamdO1UTCyo9RkYv6
 iXYMEboB/ylgfcQbfIe2IEcEMAsoXNC8Bocv13DSDpXuZGa8cVphPdGQOPa/7SfrK7H+
 xu5DJ50g2YwegcaqSa0COUpLVVaLn8xJFsSDmm6XURXZT/jRbZ0VOoNV/mzL6BRhOnRH pA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsvjbr2yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 12:56:42 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36C8V7gi022696;
        Wed, 12 Jul 2023 12:56:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rpy2e9wts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 12:56:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36CCuaIV17171110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 12:56:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73DA22004B;
        Wed, 12 Jul 2023 12:56:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C31620043;
        Wed, 12 Jul 2023 12:56:36 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Jul 2023 12:56:36 +0000 (GMT)
Date:   Wed, 12 Jul 2023 14:56:34 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 16/92] s390: convert to ctime accessor functions
Message-ID: <ZK6jApBgBnDk14cj@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-14-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-14-jlayton@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7G4j4JOmKqSKxejA7tF4iKaz0fhE4HzW
X-Proofpoint-ORIG-GUID: 7G4j4JOmKqSKxejA7tF4iKaz0fhE4HzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 clxscore=1011 spamscore=0 suspectscore=0
 mlxlogscore=542 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 05, 2023 at 03:00:41PM -0400, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  arch/s390/hypfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index ee919bfc8186..5feef8da406b 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -53,7 +53,7 @@ static void hypfs_update_update(struct super_block *sb)
>  	struct inode *inode = d_inode(sb_info->update_file);
>  
>  	sb_info->last_update = ktime_get_seconds();
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  }
>  
>  /* directory tree removal functions */
> @@ -101,7 +101,7 @@ static struct inode *hypfs_make_inode(struct super_block *sb, umode_t mode)
>  		ret->i_mode = mode;
>  		ret->i_uid = hypfs_info->uid;
>  		ret->i_gid = hypfs_info->gid;
> -		ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
> +		ret->i_atime = ret->i_mtime = inode_set_ctime_current(ret);
>  		if (S_ISDIR(mode))
>  			set_nlink(ret, 2);
>  	}

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
