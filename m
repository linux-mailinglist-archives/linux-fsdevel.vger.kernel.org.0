Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0271D8C5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 02:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgESAfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 20:35:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51546 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgESAfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 20:35:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04J0X3bX123418;
        Tue, 19 May 2020 00:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kYKRRz4oXs0Dp0x61TphU78tz9P7emd0AKAWTPvVFBc=;
 b=T+CFtZwCa5QEAu0UGGQjljFzy6LKg21NfsGPu5THWOWyHzKlHFCqMx1PtPw+/8tzCyeH
 3Z9T/+2Qwc7wX/l9Ip063Fesbu25W7RvwEK2xoW7Te34qeGTfWKHysNZdK3L0LlDWUBy
 xHTAlwnJToGptVAnNBOHGg/gtsM+SymFahON2x2ShQvxbhhWmj6j9AyR7FLg5bE95+BQ
 4EFafPtbtYc1u2HzAybMjBtUuETGgX4euGVvtdIDaIiNO3r+eVpAZ0ds3Y2yafpvGVwx
 9bzdFym1MeUfoqomea4V4NxQDStBbZ41fAoph1YXvnIBMCYjGYT4bhmXKseCyzYmZw1C dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3127kr25xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 00:35:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04J0YL69088110;
        Tue, 19 May 2020 00:35:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 312t3wqw27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 00:35:14 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04J0ZC5B023317;
        Tue, 19 May 2020 00:35:12 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 May 2020 17:35:11 -0700
Subject: Re: kernel BUG at mm/hugetlb.c:LINE!
To:     Colin Walters <walters@verbum.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <000000000000b4684e05a2968ca6@google.com>
 <aa7812b8-60ae-8578-40db-e71ad766b4d3@oracle.com>
 <CAJfpegtVca6H1JPW00OF-7sCwpomMCo=A2qr5K=9uGKEGjEp3w@mail.gmail.com>
 <bb232cfa-5965-42d0-88cf-46d13f7ebda3@www.fastmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9a56a79a-88ed-9ff4-115e-ec169cba5c0b@oracle.com>
Date:   Mon, 18 May 2020 17:35:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bb232cfa-5965-42d0-88cf-46d13f7ebda3@www.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190003
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/18/20 4:41 PM, Colin Walters wrote:
> 
> On Tue, May 12, 2020, at 11:04 AM, Miklos Szeredi wrote:
> 
>>> However, in this syzbot test case the 'file' is in an overlayfs filesystem
>>> created as follows:
>>>
>>> mkdir("./file0", 000)                   = 0
>>> mount(NULL, "./file0", "hugetlbfs", MS_MANDLOCK|MS_POSIXACL, NULL) = 0
>>> chdir("./file0")                        = 0
>>> mkdir("./file1", 000)                   = 0
>>> mkdir("./bus", 000)                     = 0
>>> mkdir("./file0", 000)                   = 0
>>> mount("\177ELF\2\1\1", "./bus", "overlay", 0, "lowerdir=./bus,workdir=./file1,u"...) = 0
> 
> Is there any actual valid use case for mounting an overlayfs on top of hugetlbfs?  I can't think of one.  Why isn't the response to this to instead only allow mounting overlayfs on top of basically a set of whitelisted filesystems?
> 

I can not think of a use case.  I'll let Miklos comment on adding whitelist
capability to overlayfs.

IMO - This BUG/report revealed two issues.  First is the BUG by mmap'ing
a hugetlbfs file on overlayfs.  The other is that core mmap code will skip
any filesystem specific get_unmapped area routine if on a union/overlay.
My patch fixes both, but if we go with a whitelist approach and don't allow
hugetlbfs I think we still need to address the filesystem specific
get_unmapped area issue.  That is easy enough to do by adding a routine to
overlayfs which calls the routine for the underlying fs.

-- 
Mike Kravetz
