Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F948201FDF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 04:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbgFTCor (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 22:44:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43536 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732033AbgFTCoq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:44:46 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05K2VrJP081877;
        Fri, 19 Jun 2020 22:44:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rund6c5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 22:44:33 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05K2a9Sp097377;
        Fri, 19 Jun 2020 22:44:33 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rund6c5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 22:44:33 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05K2ZEpQ009419;
        Sat, 20 Jun 2020 02:44:32 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 31q6c6g01k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Jun 2020 02:44:32 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05K2iS1q29688088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Jun 2020 02:44:29 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0640136053;
        Sat, 20 Jun 2020 02:44:30 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 096B7136051;
        Sat, 20 Jun 2020 02:44:29 +0000 (GMT)
Received: from [9.163.11.155] (unknown [9.163.11.155])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 20 Jun 2020 02:44:29 +0000 (GMT)
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
To:     Tejun Heo <tj@kernel.org>
Cc:     Ian Kent <raven@themaw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20200619153833.GA5749@mtj.thefacebook.com>
 <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
 <20200619222356.GA13061@mtj.duckdns.org>
From:   Rick Lindsley <ricklind@linux.vnet.ibm.com>
Message-ID: <fa22c563-73b7-5e45-2120-71108ca8d1a0@linux.vnet.ibm.com>
Date:   Fri, 19 Jun 2020 19:44:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619222356.GA13061@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006200012
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/19/20 3:23 PM, Tejun Heo wrote:

> Spending 5 minutes during boot creating sysfs objects doesn't seem like a
> particularly good solution and I don't know whether anyone else would
> experience similar issues. Again, not necessarily against improving the
> scalability of kernfs code but the use case seems a bit out there.

Creating sysfs objects is not a new "solution".  We already do it, and it can take over an hour on a machine with 64TB of memory.  We're not *adding* this ... we're *improving* something that has been around for a long time.

>> They are used for hotplugging and partitioning memory. The size of the
>> segments (and thus the number of them) is dictated by the underlying
>> hardware.
> 
> This sounds so bad. There gotta be a better interface for that, right?

Again; this is not new.  Easily changing the state of devices by writing new values into kernfs is one of the reasons kernfs exists.

     echo 0 > /sys/devices//system/memory/memory10374/online

and boom - you've taken memory chunk 10374 offline.

These changes are not just a whim.  I used lockstat to measure contention during boot.  The addition of 250,000 "devices" in parallel created tremendous contention on the kernfs_mutex and, it appears, on one of the directories within it where memory nodes are created.  Using a mutex means that the details of that mutex must bounce around all the cpus ... did I mention 1500+ cpus?  A whole lot of thrash ...

These patches turn that mutex into a rw semaphore, and any thread checking for the mere existence of something can get by with a read lock. lockstat showed that about 90% of the mutex contentions were in a read path and only 10% in a write path.  Switching to a rw semaphore meant that 90% of the time there was no waiting and the thread proceeded with its caches intact.  Total time spent waiting on either read or write decreased by 75%, and should scale much better with subsequent hardware upgrades.

With contention on this particular data structure reduced, we saw thrash on related control structures decrease markedly too.  The contention for the lockref taken in dput dropped 66% and, likely due to reduced thrash, the time used waiting for that structure dropped 99%.

Rick
