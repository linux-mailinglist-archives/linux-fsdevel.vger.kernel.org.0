Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B74612E54
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 14:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfECMrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 08:47:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727992AbfECMre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 08:47:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x43CWLXs071356
        for <linux-fsdevel@vger.kernel.org>; Fri, 3 May 2019 08:47:32 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s8m6cmkb8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2019 08:47:32 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 3 May 2019 13:47:30 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 May 2019 13:47:27 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x43ClQi429098078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 May 2019 12:47:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C94D642059;
        Fri,  3 May 2019 12:47:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEB5C42047;
        Fri,  3 May 2019 12:47:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.126])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 May 2019 12:47:25 +0000 (GMT)
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided
 hashes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Matthew Garrett <mjg59@google.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Date:   Fri, 03 May 2019 08:47:14 -0400
In-Reply-To: <8e806482-2f55-8c9e-ab95-a3ba4c728535@huawei.com>
References: <20190226215034.68772-1-matthewgarrett@google.com>
         <1551923650.31706.258.camel@linux.ibm.com>
         <CACdnJuv+d2qEc+vQosmDOzdu57Jjpjq9-CZEy8epz0ob5mptsA@mail.gmail.com>
         <1551991690.31706.416.camel@linux.ibm.com>
         <CACdnJuvkA6M_fu3+BARH2AMHksTXbvWmRyK9ZaxcH-xZMq4G2g@mail.gmail.com>
         <CACdnJuv2zV1OnbVaHqkB2UU=dAEzzffajAFg_xsgXRMvuZ5fTw@mail.gmail.com>
         <1554416328.24612.11.camel@HansenPartnership.com>
         <CACdnJutZzJu7FxcLWasyvx9BLQJeGrA=7WA389JL8ixFJ6Skrg@mail.gmail.com>
         <1554417315.24612.15.camel@HansenPartnership.com>
         <CACdnJuutKe+i8KLUmPWjbFOWfrO2FzYVPjYZGgEatFmZWkw=UA@mail.gmail.com>
         <1554431217.24612.37.camel@HansenPartnership.com>
         <CACdnJut_vN9pJXq-j9fEO1CFZ-Aq83cO2LiFmep=Fn9_NOKhWQ@mail.gmail.com>
         <CACdnJusKM74vZ=zg+0fe50gNRVaDPCdw9mfbbq45yTqnZfZX5w@mail.gmail.com>
         <1556828700.4134.128.camel@linux.ibm.com>
         <CACdnJutAw02Hq=NDeHoSsZAh2D95EBag_U8GYoSfNJ7eM61OxQ@mail.gmail.com>
         <1556838167.7067.9.camel@linux.ibm.com>
         <6fc66a58-2d34-e8cc-ee01-ec04c85196eb@huawei.com>
         <8e806482-2f55-8c9e-ab95-a3ba4c728535@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050312-0008-0000-0000-000002E2E8A1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050312-0009-0000-0000-0000224F5A97
Message-Id: <1556887634.4754.28.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=757 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905030079
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-05-03 at 10:17 +0200, Roberto Sassu wrote:
> On 5/3/2019 8:51 AM, Roberto Sassu wrote:
> > On 5/3/2019 1:02 AM, Mimi Zohar wrote:

> >> Perhaps instead of making the template format dynamic based on fields,
> >> as I suggested above, define a per policy rule template format option.
> > 
> > This should not be too complicated. The template to use will be returned
> > by ima_get_action() to process_measurement().
> 
> Some time ago I made some patches:
> 
> https://sourceforge.net/p/linux-ima/mailman/message/31655784/

Thank you for the reference!  In addition to Matthew's VFS hash use
case, Thiago's appended signature support would benefit from a per
policy rule template.  Do you want, and have time, to add this
support?

Mimi

