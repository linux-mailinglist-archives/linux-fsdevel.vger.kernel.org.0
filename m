Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0826E233632
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 18:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgG3QAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 12:00:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41320 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3QAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:00:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFvHn4041953;
        Thu, 30 Jul 2020 16:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Qc8yTS3/0uqmBgDDziPyn/x72XbIBs2YRTJ1co+pfuQ=;
 b=vTt+f3pkLBuNfIO582kSbvGeBWJpW/dSw+mleXLSPBeQQGFFDXCbzReXezY/2Ph3JTWt
 Gw1cTpot8k1gTQAmj/49tSfNtJcOVg3fRaeVrMLE9nCaZd9MXM2HBSzSKU9zFFyF+vAx
 kmFZtp10+5NNfiE2ETSILcnrXZ1KSakXeKTdS1Tp3+soLiiu1h0l2bEM0FCXZiqI5INS
 rDA9vpad91EK8H5wn9FtBaMRfJ2jP9Q0tNQYeHKLGMEWk5KHPXUgELn8RzweKuqjTW7r
 6n6u6gjSZ2AKn+/E85SxbN3fCBzm1TnWcDIBUUHbOUN9CxNcGF2n/PUOsWkdupZXXhHa cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32hu1jmk99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 16:00:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFrVRG009502;
        Thu, 30 Jul 2020 15:59:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32hu5wxtw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 15:59:59 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFxlZu022011;
        Thu, 30 Jul 2020 15:59:48 GMT
Received: from [10.39.200.60] (/10.39.200.60)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jul 2020 08:59:47 -0700
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     Matthew Wilcox <willy@infradead.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        gerg@linux-m68k.org, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
Date:   Thu, 30 Jul 2020 11:59:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730152250.GG23808@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300112
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/30/2020 11:22 AM, Matthew Wilcox wrote:
> On Mon, Jul 27, 2020 at 10:11:22AM -0700, Anthony Yznaga wrote:
>> This patchset adds support for preserving an anonymous memory range across
>> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
>> sharing memory in this manner, as opposed to re-attaching to a named shared
>> memory segment, is to ensure it is mapped at the same virtual address in
>> the new process as it was in the old one.  An intended use for this is to
>> preserve guest memory for guests using vfio while qemu exec's an updated
>> version of itself.  By ensuring the memory is preserved at a fixed address,
>> vfio mappings and their associated kernel data structures can remain valid.
>> In addition, for the qemu use case, qemu instances that back guest RAM with
>> anonymous memory can be updated.
> 
> I just realised that something else I'm working on might be a suitable
> alternative to this.  Apologies for not realising it sooner.
> 
> http://www.wil.cx/~willy/linux/sileby.html
> 
> To use this, you'd mshare() the anonymous memory range, essentially
> detaching the VMA from the current process's mm_struct and reparenting
> it to this new mm_struct, which has an fd referencing it.
> 
> Then you call exec(), and the exec'ed task gets to call mmap() on that
> new fd to attach the memory range to its own address space.
> 
> Presto!

To be suitable for the qemu use case, we need a guarantee that the same VA range
is available in the new process, with nothing else mapped there.  From your spec,
it sounds like the new process could do a series of unrelated mmap's which could
overlap the desired va range before the silby mmap(fd) is performed??

Also, we need to support updating legacy processes that already created anon segments.
We inject code that calls MADV_DOEXEC for such segments.

- Steve
