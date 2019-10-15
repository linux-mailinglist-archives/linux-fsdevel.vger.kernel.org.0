Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6F7D8484
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 01:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfJOXhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 19:37:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50968 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfJOXhL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 19:37:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FNXj1H177247;
        Tue, 15 Oct 2019 23:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=l6qEvTX6M+mfKCgCoH/LOx2QgImZNw52hr41fUw2/tU=;
 b=RVMdWhEGnH5CJpUeEBFLrKsasMS84UOfDzPqriI7qyRWMkdWU8TzVA4mRzSWxNdFmWjp
 sdu32BsBSrM5aI3gRyXSxdoAG8pCrF7SNH50hXd+MGa45WVvAAHEBc1MrpO7qhoybVOy
 LcCWeMDU6z8a4gwYiCFJyyzODDhh/k7gXa1qqTyWKcsCTRWxdcyMEcQlo//6A+NrdQkH
 uQm/UqDV5FenZenhJoRSBC0pDCCCVbXfFB/h2HDjeS1aJSzraQ6t6X3W6cRz8Tql7Vrn
 eihs8qa2Y1IF+FhIwRnXS3JhoO66vtmIITP8gkm0Pc1o4f8xjLuG0M83ak0WFrmVK/7X GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vk68ukb4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 23:37:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FNWwCl041669;
        Tue, 15 Oct 2019 23:37:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vn8ep8pam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 23:37:03 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9FNb1jB002134;
        Tue, 15 Oct 2019 23:37:02 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 23:37:01 +0000
Subject: Re: [PATCH] hugetlbfs: add O_TMPFILE support
To:     Michal Hocko <mhocko@kernel.org>, Piotr Sarna <p.sarna@tlen.pl>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
References: <22c29acf9c51dae17802e1b05c9e5e4051448c5c.1571129593.git.p.sarna@tlen.pl>
 <20191015105055.GA24932@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <766b4370-ba71-85a2-5a57-ca9ed7dc7870@oracle.com>
Date:   Tue, 15 Oct 2019 16:37:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191015105055.GA24932@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150200
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150200
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/15/19 3:50 AM, Michal Hocko wrote:
> On Tue 15-10-19 11:01:12, Piotr Sarna wrote:
>> With hugetlbfs, a common pattern for mapping anonymous huge pages
>> is to create a temporary file first.
> 
> Really? I though that this is normally done by shmget(SHM_HUGETLB) or
> mmap(MAP_HUGETLB). Or maybe I misunderstood your definition on anonymous
> huge pages.
> 
>> Currently libraries like
>> libhugetlbfs and seastar create these with a standard mkstemp+unlink
>> trick,

I would guess that much of libhugetlbfs was writen before MAP_HUGETLB
was implemented.  So, that is why it does not make (more) use of that
option.

The implementation looks to be straight forward.  However, I really do
not want to add more functionality to hugetlbfs unless there is specific
use case that needs it.
-- 
Mike Kravetz
