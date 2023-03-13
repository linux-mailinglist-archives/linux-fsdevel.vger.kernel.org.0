Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63436B7896
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 14:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjCMNNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 09:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjCMNNh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:13:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022078A50;
        Mon, 13 Mar 2023 06:13:34 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DCqKH0032618;
        Mon, 13 Mar 2023 13:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Z6c8czDRDXgZsRSOblHEeb0yKGSpJxQjXaWCL6Vfv+Y=;
 b=eFTeyYmlLDlPgk4CXjnXrTmXNrG7moZDpO3st6Z4FD/9/bwZwtHlCRV2rJCReTEmoywR
 iSs8mROz8VsW2U3799wdITEQYQA8ziwqE90EvLXqRmo/2buVUWOpsi9LWIPhssNMNvzv
 +CXopoPyMe70c3vZCld6GHZZqyqRIdT5nMOQmmfY2yS06Gfjb6zAOd2oHC5lwgkAcf4w
 R6DZDM4JEY7jdSkMDH/ocbDFhjZPBXNWRhBcWC9HMwNVZTvIToITivjiLJOldGAA8XQb
 PBtLnIF8jUY+XRiPusQpUnmKY7OF/vgi6SwFz3sRBH20x4khIIGDv4HgoKJTfWsfYFt2 fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p93k2pcjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 13:13:18 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32DCXbZv014441;
        Mon, 13 Mar 2023 13:13:18 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p93k2pchd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 13:13:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32D2fdtF028633;
        Mon, 13 Mar 2023 13:13:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96kd70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 13:13:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32DDDCk430540170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 13:13:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1774A20040;
        Mon, 13 Mar 2023 13:13:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F9CE2004B;
        Mon, 13 Mar 2023 13:13:11 +0000 (GMT)
Received: from localhost (unknown [9.171.94.54])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Mar 2023 13:13:11 +0000 (GMT)
Date:   Mon, 13 Mar 2023 14:13:09 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, sudipm.mukherjee@gmail.com,
        ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] s390: simplify dynamic sysctl registration for
 appldata_register_ops
Message-ID: <your-ad-here.call-01678713189-ext-6022@work.hours>
References: <20230310234525.3986352-1-mcgrof@kernel.org>
 <20230310234525.3986352-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310234525.3986352-7-mcgrof@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f3O5qYrIdmMrOFJsZlZhauzbbIhotcZ_
X-Proofpoint-GUID: fhDbawH6TznfU3UDeaB02Csjum17WPqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 03:45:25PM -0800, Luis Chamberlain wrote:
> The routine appldata_register_ops() allocates a sysctl table
> with 4 entries. The firsts one,   ops->ctl_table[0] is the parent directory
> with an empty entry following it, ops->ctl_table[1]. The next entry is
> for the the ops->name and that is ops->ctl_table[2]. It needs an empty

for the ops->name

> entry following that, and that is ops->ctl_table[3]. And so hence the
> kcalloc(4, sizeof(struct ctl_table), GFP_KERNEL).
> 
> We can simplify this considerably since sysctl_register("foo", table)
> can create the parent directory for us if it does not exist. So we
> can just remove the first two entries and move back the ops->name to
> the first entry, and just use kcalloc(2, ...).
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  arch/s390/appldata/appldata_base.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
> index c593f2228083..a60c1e093039 100644
> --- a/arch/s390/appldata/appldata_base.c
> +++ b/arch/s390/appldata/appldata_base.c
> @@ -351,7 +351,8 @@ int appldata_register_ops(struct appldata_ops *ops)
>  	if (ops->size > APPLDATA_MAX_REC_SIZE)
>  		return -EINVAL;
>  
> -	ops->ctl_table = kcalloc(4, sizeof(struct ctl_table), GFP_KERNEL);
> +	/* The last entry must be an empty one */
> +	ops->ctl_table = kcalloc(2, sizeof(struct ctl_table), GFP_KERNEL);
>  	if (!ops->ctl_table)
>  		return -ENOMEM;
>  
> @@ -359,17 +360,12 @@ int appldata_register_ops(struct appldata_ops *ops)
>  	list_add(&ops->list, &appldata_ops_list);
>  	mutex_unlock(&appldata_ops_mutex);
>  
> -	ops->ctl_table[0].procname = appldata_proc_name;
> -	ops->ctl_table[0].maxlen   = 0;
> -	ops->ctl_table[0].mode     = S_IRUGO | S_IXUGO;
> -	ops->ctl_table[0].child    = &ops->ctl_table[2];
> +	ops->ctl_table[0].procname = ops->name;
> +	ops->ctl_table[0].mode     = S_IRUGO | S_IWUSR;
> +	ops->ctl_table[0].proc_handler = appldata_generic_handler;
> +	ops->ctl_table[0].data = ops;
>  
> -	ops->ctl_table[2].procname = ops->name;
> -	ops->ctl_table[2].mode     = S_IRUGO | S_IWUSR;
> -	ops->ctl_table[2].proc_handler = appldata_generic_handler;
> -	ops->ctl_table[2].data = ops;
> -
> -	ops->sysctl_header = register_sysctl_table(ops->ctl_table);
> +	ops->sysctl_header = register_sysctl(appldata_proc_name, ops->ctl_table);
>  	if (!ops->sysctl_header)
>  		goto out;
>  	return 0;
> -- 
> 2.39.1

I'll take it with the commit message change mentioned above and the following fixup,
which addresses the obvious problem found during testing:
---
diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index a60c1e093039..f462d60679d7 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -281,7 +281,7 @@ appldata_generic_handler(struct ctl_table *ctl, int write,
        mutex_lock(&appldata_ops_mutex);
        list_for_each(lh, &appldata_ops_list) {
                tmp_ops = list_entry(lh, struct appldata_ops, list);
-               if (&tmp_ops->ctl_table[2] == ctl) {
+               if (&tmp_ops->ctl_table[0] == ctl) {
                        found = 1;
                }
        }
--
