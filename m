Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271322CEE98
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 14:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgLDNF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 08:05:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726432AbgLDNF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:05:56 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B4D3EZx056402;
        Fri, 4 Dec 2020 08:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jctQgMWgSlsHPOjsDmaUeXfSF+9Z30/WArFoiAk/M3o=;
 b=GrZPzRTenWKY3N4pDjkeB3jRv/wXCs4bTLDjRFU9/A0SD0vPZNyo2GJKCHkiF1oUTMen
 mMZsHF8jM7yqoh0RymQRoA41x5zkS/K4foDqbCk9HEuME9ClGd/hcoMYcF30ICEfm3ej
 hM7YKz0ek1ZGoZqMZdQWjyOgl82bXTsXlCSIvea538e6kdjuIWg9VtO8C5oRAtzdHh32
 Us391JD8M9SNhmOVsBKMnWRaHJ5mKiE4/nHbqUCfGwEWFxSlnD3ANU5kDG65R2PReUxy
 Rz0P+FCH0S66XgfCGJW6MOg3oWgxs+IdA0j9YCm15JPCrJ5E1nyx+QRzgebodFUufASZ 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 357m7hjj7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 08:05:05 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B4D3d2Q058711;
        Fri, 4 Dec 2020 08:05:05 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 357m7hjj4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 08:05:05 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B4CmvoA000390;
        Fri, 4 Dec 2020 13:05:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 354fpdd1m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 13:05:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B4D50Av52298134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Dec 2020 13:05:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6547DA4054;
        Fri,  4 Dec 2020 13:05:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55E3BA4064;
        Fri,  4 Dec 2020 13:04:58 +0000 (GMT)
Received: from sig-9-65-202-27.ibm.com (unknown [9.65.202.27])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Dec 2020 13:04:57 +0000 (GMT)
Message-ID: <0eec775cf5c44f646defe33aec5f241a06844d3a.camel@linux.ibm.com>
Subject: Re: [PATCH v3 06/11] evm: Ignore INTEGRITY_NOLABEL if no HMAC key
 is loaded
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "mjg59@google.com" <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Fri, 04 Dec 2020 08:04:57 -0500
In-Reply-To: <3c628dc54804469597a72d03c33e8315@huawei.com>
References: <20201111092302.1589-1-roberto.sassu@huawei.com>
         <20201111092302.1589-7-roberto.sassu@huawei.com>
         <b9f1a31e9b2dfb7a7167574a39652932263488e8.camel@linux.ibm.com>
         <3c628dc54804469597a72d03c33e8315@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_04:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=3 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040075
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-12-04 at 08:05 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Thursday, December 3, 2020 9:43 PM
> > Hi Roberto,
> > 
> > On Wed, 2020-11-11 at 10:22 +0100, Roberto Sassu wrote:
> > > When a file is being created, LSMs can set the initial label with the
> > > inode_init_security hook. If no HMAC key is loaded, the new file will have
> > > LSM xattrs but not the HMAC.
> > >
> > > Unfortunately, EVM will deny any further metadata operation on new
> > files,
> > > as evm_protect_xattr() will always return the INTEGRITY_NOLABEL error.
> > This
> > > would limit the usability of EVM when only a public key is loaded, as
> > > commands such as cp or tar with the option to preserve xattrs won't work.
> > >
> > > Ignoring this error won't be an issue if no HMAC key is loaded, as the
> > > inode is locked until the post hook, and EVM won't calculate the HMAC on
> > > metadata that wasn't previously verified. Thus this patch checks if an
> > > HMAC key is loaded and if not, ignores INTEGRITY_NOLABEL.
> > 
> > I'm not sure what problem this patch is trying to solve.
> > evm_protect_xattr() is only called by evm_inode_setxattr() and
> > evm_inode_removexattr(), which first checks whether
> > EVM_ALLOW_METADATA_WRITES is enabled.
> 
> The idea is to also support EVM verification when only a public key
> is loaded. An advantage to do that is that for example we can prevent
> accidental metadata changes when the signature is portable.

Right, there are a couple of  scenarios.  Let's be more specific as to
which scenario this patch is addressing.

- a public key is loaded and EVM_ALLOW_METADATA_WRITES is enabled,
- a public key is loaded and EVM_ALLOW_METADATA_WRITES is disabled,
- an HMAC key is loaded

For the first and last case, this patch shouldn't be necessary.  Only
the second case, with EVM_ALLOW_METADATA_WRITES disabled, probably does
not work.  I would claim that is working as designed.

thanks,

Mimi

