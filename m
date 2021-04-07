Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F933356DA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 15:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbhDGNoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 09:44:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236584AbhDGNoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:44:04 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137DXNF7150093;
        Wed, 7 Apr 2021 09:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=ut34vTc6pDXsycRccgnTEyFOYJEGJnIMiBKnzo/o+K4=;
 b=N4oe9t7MN4uSn/z10cv4wBQFnTmfUyITLJTKWCHqm2Exard1eZ4O+B5Y79K2tpBAcU8+
 ZyRgxqTupJmNqNHe4rCdqgrMqJwHwyPgVmLMkHR2OmzBJoNJJiPtjtPXtId8ECbS78dA
 c7JTH7PQ/3h3tRbPnJUfCDNezvT7N1cWfET/Cfy5MdXTumbulokBlWPKLrnwFY27mLSc
 NjUlYG88Y33O5x0Gx3vZCIvaEL5NEtZYjd+cWGRb6r+hIKyaYXU2CqVBfDnqZIIdnuxf
 1C5iz0F9VdLclHnAXjowVvY9r1Kgav3mlOKtbJs1Eqt6Bs2gkYglmIC650CkebFGkjF3 FQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37rwf0gs9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 09:43:50 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 137DhTpK014113;
        Wed, 7 Apr 2021 13:43:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 37rvbw0dkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 13:43:48 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 137Dhkh123790020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 13:43:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 486735204F;
        Wed,  7 Apr 2021 13:43:46 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.44.82])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 175D65204E;
        Wed,  7 Apr 2021 13:43:44 +0000 (GMT)
Date:   Wed, 7 Apr 2021 19:13:42 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <20210407134342.GA1386511@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20210405054848.GA1077931@in.ibm.com>
 <YG2diKMPNSK2cMyG@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG2diKMPNSK2cMyG@dhcp22.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eic6vawrVTddkbSgnSTIykSKr_OQiEmN
X-Proofpoint-ORIG-GUID: eic6vawrVTddkbSgnSTIykSKr_OQiEmN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-07_08:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=918 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070094
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:54:48PM +0200, Michal Hocko wrote:
> On Mon 05-04-21 11:18:48, Bharata B Rao wrote:
> > Hi,
> > 
> > When running 10000 (more-or-less-empty-)containers on a bare-metal Power9
> > server(160 CPUs, 2 NUMA nodes, 256G memory), it is seen that memory
> > consumption increases quite a lot (around 172G) when the containers are
> > running. Most of it comes from slab (149G) and within slab, the majority of
> > it comes from kmalloc-32 cache (102G)
> 
> Is this 10k cgroups a testing enviroment or does anybody really use that
> in production? I would be really curious to hear how that behaves when
> those containers are not idle. E.g. global memory reclaim iterating over
> 10k memcgs will likely be very visible. I do remember playing with
> similar setups few years back and the overhead was very high.

This 10k containers is only a test scenario that we are looking at.

Regards,
Bharata.
