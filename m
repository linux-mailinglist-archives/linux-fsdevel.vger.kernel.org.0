Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E172CC3DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 18:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389095AbgLBRa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 12:30:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387594AbgLBRa6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:30:58 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B2GWT3S000638;
        Wed, 2 Dec 2020 12:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=kXWZTM+5Rdhk2yAKdGsncWEQ/xu/UQKUEALcFsB9wXY=;
 b=HnC0sOQfTUFNIV0AVir4iU3d8COtHbYS/r4Lt5ux4NyH40NIF8LeGvFmg3igUOMWffFg
 08ZjGI8hPB450KhrQRnfqqCJM68udsvkvXA7h9MH1cI1d6qJygywDvezOdjjddaDOzF9
 KHwqaQmQCJPPEONoGlAfaI36YQCQ+VNFdVaWBvTKGiIWk30D+FGl+IQ7axKYqr4pgcyQ
 oNvAYhlw8Atp7DF2LdwNeOZFjZn7buHBFsb6SM9tgzYRB4hfWTQo+isPlxccpOYY/D8v
 TIy4DqQIREHP37ultboUhzsMQKx0GiL7IkuPjuvRC0scGxZw7Fuk8tLfd95axaOYYTk0 BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3568cwffcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 12:30:11 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B2HJSpv001429;
        Wed, 2 Dec 2020 12:30:11 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3568cwffbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 12:30:11 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B2HN98h008516;
        Wed, 2 Dec 2020 17:30:09 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 353e686j9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 17:30:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B2HRbkw61997566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 17:27:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12800A4064;
        Wed,  2 Dec 2020 17:27:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86441A4054;
        Wed,  2 Dec 2020 17:27:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.92.233])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Dec 2020 17:27:35 +0000 (GMT)
Message-ID: <74ccede608479a55df4a7c9b446f840aedf8bd68.camel@linux.ibm.com>
Subject: Re: [PATCH v3 02/11] evm: Load EVM key in ima_load_x509() to avoid
 appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        silviu.vlasceanu@huawei.com
Date:   Wed, 02 Dec 2020 12:27:34 -0500
In-Reply-To: <20201111092302.1589-3-roberto.sassu@huawei.com>
References: <20201111092302.1589-1-roberto.sassu@huawei.com>
         <20201111092302.1589-3-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_08:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020096
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-11-11 at 10:22 +0100, Roberto Sassu wrote:
> Public keys do not need to be appraised by IMA as the restriction on the
> IMA/EVM keyrings ensures that a key can be loaded only if it is signed with
> a key in the primary or secondary keyring.

Let's clean this up a bit.
- The public builtin keys ...
- IMA/EVM trusted keyrings ...
- on the builtin or secondary keyrings

> However, when evm_load_x509() is called, appraisal is already enabled and
> a valid IMA signature must be added to the EVM key to pass verification.
> 
> Since the restriction is applied on both IMA and EVM keyrings, it is safe

and update:
- IMA and EVM trusted keyrings 

> to disable appraisal also when the EVM key is loaded. This patch calls
> evm_load_x509() inside ima_load_x509() if CONFIG_IMA_LOAD_X509 is defined.

, which crosses the normal IMA and EVM boundary,

thanks,

Mimi

