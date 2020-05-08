Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C041CB564
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 19:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgEHRIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 13:08:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726750AbgEHRIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 13:08:23 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048H1aow181718;
        Fri, 8 May 2020 13:08:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30vtw0tstj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 13:08:11 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048H2GHA183411;
        Fri, 8 May 2020 13:08:11 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30vtw0tssw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 13:08:11 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048H4s14002508;
        Fri, 8 May 2020 17:08:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 30s0g5dn2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 17:08:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 048H87PH8847814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 17:08:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37D1EA405C;
        Fri,  8 May 2020 17:08:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3B4FA4065;
        Fri,  8 May 2020 17:08:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.139.55])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 May 2020 17:08:05 +0000 (GMT)
Message-ID: <1588957684.5146.70.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "david.safford@gmail.com" <david.safford@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jmorris@namei.org" <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Fri, 08 May 2020 13:08:04 -0400
In-Reply-To: <84e6acad739a415aa3e2457b5c37979f@huawei.com>
References: <20200429073935.11913-1-roberto.sassu@huawei.com>
         <1588794293.4624.21.camel@linux.ibm.com>
         <1588799408.4624.28.camel@linux.ibm.com>
         <ab879f9e66874736a40e9c566cadc272@huawei.com>
         <1588864628.5685.78.camel@linux.ibm.com>
         <750ab4e0990f47e4aea10d0e580b1074@huawei.com>
         <1588884313.5685.110.camel@linux.ibm.com>
         <84e6acad739a415aa3e2457b5c37979f@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_15:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-05-08 at 10:20 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > On Thu, 2020-05-07 at 16:47 +0000, Roberto Sassu wrote:

<snip>

> > > > the file metadata to the file data.  The IMA and EVM policies really
> > > > need to be in sync.
> > >
> > > It would be nice, but at the moment EVM considers also files that are
> > > not selected by the IMA policy. An example of why this is a problem is
> > > the audit service that fails to start when it tries to adjust the permissions
> > > of the log files. Those files don't have security.evm because they are
> > > not appraised by IMA, but EVM denies the operation.
> > 
> > No, this is a timing issue as to whether or not the builtin policy or
> > a custom policy has been loaded.  A custom policy could exclude the
> > log files based on LSM labels, but they are included in the builtin
> > policy.
> 
> Yes, I was referring to a custom policy. In this case, EVM will not adapt
> to the custom policy but still verifies all files. If access control is done
> exclusively by IMA at the time evm_verifyxattr() is called, we wouldn't
> need to add security.evm to all files.

Roberto, EVM is only triggered by IMA, unless you've modified the
kernel to do otherwise.

I'm not interested in a complicated solution, just one that addresses
the new EVM immutable and portable signature.  It might require EVM
HMAC, IMA differentiating between a new file and an existing file, or
it might require writing the new EVM signature last, after all the
other xattrs or metadata are updated.  Please nothing that changes
existing expectations.

Mimi
