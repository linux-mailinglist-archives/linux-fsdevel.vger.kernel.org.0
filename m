Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CD51F6006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 04:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgFKCca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 22:32:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45282 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFKCca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 22:32:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05B2Qq9q109046;
        Thu, 11 Jun 2020 02:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qc8BycOlCegbte15aqZApUOZGLL/Tup1u+/vFyN0fDo=;
 b=BDjWJwDVluFs0GG2Ro66mcEX1oEcwzzGp0TV7tQggvcbV0BhIjQSOgB4qFwwgqawa/Gh
 i2tH/o4lHFJGGulWqGG5MTB6pAzOjwQ4qs+rxmetxVgJIG/9dOJ0Dw+tY+XDBXY6xiIi
 7rMjEWJBrzdHzSteYr1h/P0OdLld1AvdNewA7jc4PHXQvjo6XlbwHTrAGtui4LLUQM1y
 L6rAPuS3zUX/Myt9/XoLbdRh0Vx6wuowNoYFHVDSifX+aMLgwjRjUJMSCQ1H1QW7yp1j
 ofTe1I9ZH8wxnEdHitvyKgsvQHw2t/A4jx8mu+Y3RhLEBZT1Y3g6JgsF8gLqeqGx8B/8 eQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31jepny8u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jun 2020 02:32:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05B2McGn133486;
        Thu, 11 Jun 2020 02:32:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31gn2ara1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 02:32:06 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05B2Vxb9010697;
        Thu, 11 Jun 2020 02:31:59 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jun 2020 19:31:59 -0700
Subject: Re: [PATCH v2] ovl: provide real_file() and overlayfs
 get_unmapped_area()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Colin Walters <walters@verbum.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
References: <4ebd0429-f715-d523-4c09-43fa2c3bc338@oracle.com>
 <202005281652.QNakLkW3%lkp@intel.com>
 <365d83b8-3af7-2113-3a20-2aed51d9de91@oracle.com>
 <CAJfpegtz=tzndsF=_1tYHewGwEgvqEOA_4zj8HCAqyFdKe6mag@mail.gmail.com>
 <ffc00a9e-5c2f-0c3e-aa1e-9836b98f7b54@oracle.com>
 <20200611003726.GY23230@ZenIV.linux.org.uk>
 <20200611013616.GM19604@bombadil.infradead.org>
 <20200611021710.GA23230@ZenIV.linux.org.uk>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1bfea970-00f5-502c-3ced-4ebe7fd3eef1@oracle.com>
Date:   Wed, 10 Jun 2020 19:31:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611021710.GA23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006110017
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/20 7:17 PM, Al Viro wrote:
> On Wed, Jun 10, 2020 at 06:36:16PM -0700, Matthew Wilcox wrote:
> 
>> 	while (file->f_mode & FMODE_OVL_UPPER)
>> 		file = file->private_data;
>> 	return file;
>>
>> Or are you proposing that overlayfs copy FMODE_HUGEPAGES from the
>> underlying fs to the overlaying fs?
> 
> The latter - that way nobody outside of overlayfs needs to know what
> its ->private_data points to, for one thing.  And it's cheaper that
> way, obviously.
> 

Thanks Al and Matthew!

I knew adding a file op for this was overkill and was looking for other
suggestions.
-- 
Mike Kravetz
