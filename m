Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A97476D69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 10:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbhLPJ3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 04:29:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53552 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232923AbhLPJ3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:29:06 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG876Fr012421;
        Thu, 16 Dec 2021 09:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=4UYqN4pVlQMbSDiJg/IcU0Peamsj4/1Hc55y6tyNRUk=;
 b=JpVkLelbdqeo4XrxSRBdsTACL2/X62VFBupg0qN4nfZgD0p/YTUPRCP/jyCbfOMLO0ZS
 iJPDbOZ2PYdV767s1WCMGPK/0E0Q+N4LftHOA8qUiYngb6LRVuoYk8k9MHWVfjHuThIg
 M8/cDTuC9Df1YfqjaPMmoDmEIZ9HUMaxfSuTO1E3pTpWy1P/NKEzbleOw0BIhSzSf5Lo
 xEt+SYKl1AdkCslwl7sgeORp535WQpzqChOS6OIw5OGjBu4pqLGQ6DJdYloPKTw5fTUd
 vASlvdeJFZFfrbZbMMmH26wdy3Zc6Wquqm6+/31Tic9ZPftFdpmu+/wFp7OGaaCtkBBS lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyq8un6vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 09:28:45 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG8oMW5004562;
        Thu, 16 Dec 2021 09:28:44 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyq8un6ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 09:28:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG9RcLR023271;
        Thu, 16 Dec 2021 09:28:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3cy7qw550c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 09:28:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG9Scjt46596358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 09:28:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6F21AE04D;
        Thu, 16 Dec 2021 09:28:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26A1FAE045;
        Thu, 16 Dec 2021 09:28:38 +0000 (GMT)
Received: from osiris (unknown [9.145.8.245])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Dec 2021 09:28:38 +0000 (GMT)
Date:   Thu, 16 Dec 2021 10:28:36 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 1/3] vmcore: Convert copy_oldmem_page() to take an
 iov_iter
Message-ID: <YbsGxJRo1153aykr@osiris>
References: <20211213000636.2932569-1-willy@infradead.org>
 <20211213000636.2932569-2-willy@infradead.org>
 <20211213075725.GA20986@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213075725.GA20986@lst.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2tBGfTBNsLkquTgKNYuLjZSJgkpEalRA
X-Proofpoint-GUID: E9Y1WVUVnHyD8lhRcrpVPe9dEdVog6Br
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_03,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 mlxlogscore=687 phishscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112160051
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 08:57:25AM +0100, Christoph Hellwig wrote:
> On Mon, Dec 13, 2021 at 12:06:34AM +0000, Matthew Wilcox (Oracle) wrote:
> > Instead of passing in a 'buf' and 'userbuf' argument, pass in an iov_iter.
> > s390 needs more work to pass the iov_iter down further, or refactor,
> > but I'd be more comfortable if someone who can test on s390 did that work.
> > 
> > It's more convenient to convert the whole of read_from_oldmem() to
> > take an iov_iter at the same time, so rename it to read_from_oldmem_iter()
> > and add a temporary read_from_oldmem() wrapper that creates an iov_iter.
> 
> This looks pretty reasonable.  s390 could use some love from people that
> know the code, and yes, the kerneldoc comments should go away.

Sure, we will take care of this. Added to ToDo list.
