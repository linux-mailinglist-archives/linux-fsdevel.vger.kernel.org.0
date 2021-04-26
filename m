Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D4836BA46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 21:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbhDZTuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 15:50:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241599AbhDZTt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:49:56 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QJXFdx027490;
        Mon, 26 Apr 2021 15:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=8WSSTzuvgLaURdE1p1L5vyYkPe9dTOjBzC3nWcMEwQY=;
 b=GlQx2frkiPEidfCtkuKENdMc4T+tNxUi3L41siXpc6RCesQEudWlFOFzcYJ1FfI6RwyP
 AsPbLVgqIIYZgw2yLFcvwgLIImzky8ReGYy25+U55ifFkBxvS5cj+GEGSqGbiOSWVYZr
 eigzPHZ/komq82zL+7MxkDv2YSEKJP16BlGp1WI0Y1Bh/hbBFClB0fqONmBhGQzEn1jV
 mhUUaqpnpjz8/Ib9SIgFhIXIWMvunshgnfBYc5rcxZtUBiywqRD575PHXeinj46NCbyD
 l3d/TeUHs01ksGzYoexWIUNu1b6LwkI0BHWHa/hpb13F5M4rd0Xh3Mt/FGsqulcqACSO 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3863ga8uys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 15:49:10 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13QJYrwr032068;
        Mon, 26 Apr 2021 15:49:09 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3863ga8uy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 15:49:09 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QJdE36016671;
        Mon, 26 Apr 2021 19:49:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 384ay8gy3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 19:49:07 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13QJn3JD31850770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 19:49:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E41CD11C04A;
        Mon, 26 Apr 2021 19:49:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF9F511C04C;
        Mon, 26 Apr 2021 19:49:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.108.190])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Apr 2021 19:49:01 +0000 (GMT)
Message-ID: <93858a47a29831ca782c8388faaa43c8ffc3f5cd.camel@linux.ibm.com>
Subject: Re: [PATCH v4 04/11] ima: Move ima_reset_appraise_flags() call to
 post hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 26 Apr 2021 15:49:00 -0400
In-Reply-To: <c3bb1069-c732-d3cf-0dde-7a83b3f31871@schaufler-ca.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
         <20210305151923.29039-5-roberto.sassu@huawei.com>
         <c3bb1069-c732-d3cf-0dde-7a83b3f31871@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FPIXXxQwnVCZrvQJS0SCoiLk7bRqhY7t
X-Proofpoint-GUID: yfo_0uQLuRgWncnvpCP6T1bVMTkYon1J
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_09:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=984
 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260150
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-03-05 at 09:30 -0800, Casey Schaufler wrote:
> On 3/5/2021 7:19 AM, Roberto Sassu wrote:
> > ima_inode_setxattr() and ima_inode_removexattr() hooks are called before an
> > operation is performed. Thus, ima_reset_appraise_flags() should not be
> > called there, as flags might be unnecessarily reset if the operation is
> > denied.
> >
> > This patch introduces the post hooks ima_inode_post_setxattr() and
> > ima_inode_post_removexattr(), and adds the call to
> > ima_reset_appraise_flags() in the new functions.
> 
> I don't see anything wrong with this patch in light of the way
> IMA and EVM have been treated to date.
> 
> However ...
> 
> The special casing of IMA and EVM in security.c is getting out of
> hand, and appears to be unnecessary. By my count there are 9 IMA
> hooks and 5 EVM hooks that have been hard coded. Adding this IMA
> hook makes 10. It would be really easy to register IMA and EVM as
> security modules. That would remove the dependency they currently
> have on security sub-system approval for changes like this one.
> I know there has been resistance to "IMA as an LSM" in the past,
> but it's pretty hard to see how it wouldn't be a win.

Somehow I missed the new "lsm=" boot command line option, which
dynamically allows enabling/disabling LSMs, being upstreamed.  This
would be one of the reasons for not making IMA/EVM full LSMs.

Both IMA and EVM file data/metadata is persistent across boots.  If
either one or the other is not enabled the file data hash or file
metadata HMAC will not properly be updated, potentially preventing the
system from booting when re-enabled.  Re-enabling IMA and EVM would
require "fixing" the mutable file data hash and HMAC, without any
knowledge of what the "fixed" values should be.  Dave Safford referred
to this as "blessing" the newly calculated values.

Mimi

