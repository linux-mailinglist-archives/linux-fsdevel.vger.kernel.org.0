Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45550B12E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 18:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfILQoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 12:44:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60538 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfILQoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 12:44:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8CGhdQh088519;
        Thu, 12 Sep 2019 16:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=EB/p5338NYK4pzHsk6TBuBlAMNpbEMjQOcbfPa1pTQQ=;
 b=jCafRrJiLWmf9PMwQwF3AQ5GwyOUrMFaTKoak7fyLTjhfpvBEwfryr6f+qpkTtAycMnC
 Ek8O93/PErFd/DhTtMsYJAHFpYqkZRMNVmZa+VqbYyc8455i4rkK6JpQUIMAUJIa1LHF
 DIRRwdujfsNWYrvn9nm0oLWu+LciByGLAyv3yyMki3b96p8VADNpao/k/LFCmxf8wQOE
 cQSXRqJz307e+aoHlIVVeY6AFM62+dwjstXLL9T8DNsn6NIAguH29YeTouKFvcbHQMnD
 ydn/mkbe6plveb4unWpgJOXqELB4KUg+ltQeThuC9RXEIH1NZ73dXIaJLz9IefNnT1e1 iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2uw1jyhnvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 16:43:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8CGhe1s010201;
        Thu, 12 Sep 2019 16:43:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2uyrdgkbaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 16:43:48 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8CGhSW9018583;
        Thu, 12 Sep 2019 16:43:28 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Sep 2019 09:43:28 -0700
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
References: <20190911150537.19527-1-longman@redhat.com>
 <20190911150537.19527-6-longman@redhat.com>
 <ae7edcb8-74e5-037c-17e7-01b3cf9320af@oracle.com>
 <b7d7d109-03cf-d750-3a56-a95837998372@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <87ac9e4f-9301-9eb7-e68b-a877e7cf0384@oracle.com>
Date:   Thu, 12 Sep 2019 09:43:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b7d7d109-03cf-d750-3a56-a95837998372@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9378 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=664
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909120174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9378 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=710 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909120174
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/12/19 2:06 AM, Waiman Long wrote:
> If we can take the rwsem in read mode, that should solve the problem
> AFAICS. As I don't have a full understanding of the history of that
> code, I didn't try to do that in my patch.

Do you still have access to an environment that creates the long stalls?
If so, can you try the simple change of taking the semaphore in read mode
in huge_pmd_share.

-- 
Mike Kravetz
