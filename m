Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175E02CDFDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 21:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgLCUn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 15:43:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgLCUn7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 15:43:59 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B3KdYgE140764;
        Thu, 3 Dec 2020 15:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xdxiKiKIqcjET4+9fMusWkPkzX/cFh6Jey/xlFUt0Ko=;
 b=tPY+g20s0ly84EtVX1PWEPYqvpfxCR0OvwACGwBmqt8WSAloANHHX0leeMr7/j/xKlnD
 wv5YYKFTL7oS9tD9i6o93f1I89tggTY4xENlokmBpUvBUTx4MYWQO9HccGo/nyapJYVm
 1ukfkCPlep+PJj4tVuAyC+13mFI8B6Fo2PO6tBZokaXaJ4KKXyH13LBYCqzX2yV2NLpu
 f+FcsxvqSF+AxYH5YZuy7oHMybsupwpW0+ejw3PrDxi9ISPvaPzNZM1S/vt478jF6QWe
 0x0OGG5ALocHyBNn+QLkXycZZtDHCG2AdfgEVN5UIg4VSaK+KLy7mPywexpyRyRNTJsG YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 357734g6mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 15:43:14 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B3KdqJu141331;
        Thu, 3 Dec 2020 15:43:09 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 357734g6m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 15:43:08 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B3Kg4Rd011961;
        Thu, 3 Dec 2020 20:43:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3573v9r52b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 20:43:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B3Kh44s51052944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Dec 2020 20:43:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 752E9AE051;
        Thu,  3 Dec 2020 20:43:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9FDCAE04D;
        Thu,  3 Dec 2020 20:43:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.43.205])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Dec 2020 20:43:02 +0000 (GMT)
Message-ID: <e2579b090abb447aa4b0773ba6c91df0f6e84eb6.camel@linux.ibm.com>
Subject: Re: [PATCH v3 04/11] ima: Move ima_reset_appraise_flags() call to
 post hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "mjg59@google.com" <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Thu, 03 Dec 2020 15:43:01 -0500
In-Reply-To: <a401e63a91114daba2037e2b0083101f@huawei.com>
References: <20201111092302.1589-1-roberto.sassu@huawei.com>
         <20201111092302.1589-5-roberto.sassu@huawei.com>
         <a401e63a91114daba2037e2b0083101f@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_12:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030120
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-12-02 at 11:56 +0000, Roberto Sassu wrote:
> > From: Roberto Sassu
> > Sent: Wednesday, November 11, 2020 10:23 AM
> > ima_inode_setxattr() and ima_inode_removexattr() hooks are called
> > before an
> > operation is performed. Thus, ima_reset_appraise_flags() should not be
> > called there, as flags might be unnecessarily reset if the operation is
> > denied.
> > 
> > This patch introduces the post hooks ima_inode_post_setxattr() and
> > ima_inode_post_removexattr(), removes ima_inode_removexattr() and
> > adds the
> > call to ima_reset_appraise_flags() in the new functions.
> 
> Removing ima_inode_removexattr() is not correct. We should still prevent
> that security.ima is removed when CAP_SYS_ADMIN is not set. I will fix
> this in the next version.

Ok.  So this patch will define the post hooks and defer
ima_reset_appraise_flags() to them, leaving the original hooks intact.

Mimi

