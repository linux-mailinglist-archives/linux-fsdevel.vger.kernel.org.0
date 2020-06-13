Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3FB1F84D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 21:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgFMTMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 15:12:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40766 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgFMTMa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 15:12:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05DJ2t70125135;
        Sat, 13 Jun 2020 19:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Pz4pQAMmCUEhD7BU5fQaqlQilXqbia6a1vauOMeTvug=;
 b=BFWO/pxMrO/SthKxw/aSGmMo2aomTQ2LlV+h7SIs6nU8HnZd0tgn/bcxDRv5CHECnbmG
 z/wL8iOMsOLk3HI3JavktCKU2pLcbnPV+JDBv/tvVhH8md2g/Qtvgz/CRnWbVvmAvOrk
 WKwhzETJwfRbdQHe/Sb1wxAxt4xPyr3Yg4gJaCF36aWoyPVlMk+VrqJq8Zs7Dt5Ui+NN
 onopUefBs+Lp4hcBoMkNsGPXV4Vb8p8YwiH/tzst4ZXqwL6hKVbPGWr/k22tUi8Vy+R2
 +NxuW6v7nA94aFQ1gNu2CwccPvTvMS5mmEwQ+3XaUAysufdy9OfkdaZjK+YCZtEp69ma ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31mp7r1ty1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 Jun 2020 19:12:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05DJ8E4C064116;
        Sat, 13 Jun 2020 19:12:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31mpm137mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Jun 2020 19:12:12 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05DJC5rL015195;
        Sat, 13 Jun 2020 19:12:07 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 13 Jun 2020 19:12:05 +0000
Subject: Re: [PATCH v4 1/2] hugetlb: use f_mode & FMODE_HUGETLBFS to identify
 hugetlbfs files
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <20200612004644.255692-1-mike.kravetz@oracle.com>
 <20200612015842.GC23230@ZenIV.linux.org.uk>
 <b1756da5-4e91-298f-32f1-e5642a680cbf@oracle.com>
 <CAOQ4uxg=o2SVbfUiz0nOg-XHG8irvAsnXzFWjExjubk2v_6c_A@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6e8924b0-bfc4-eaf5-1775-54f506cdf623@oracle.com>
Date:   Sat, 13 Jun 2020 12:12:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxg=o2SVbfUiz0nOg-XHG8irvAsnXzFWjExjubk2v_6c_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9651 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006130171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9651 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 clxscore=1011
 cotscore=-2147483648 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006130170
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/12/20 11:53 PM, Amir Goldstein wrote:
>>> Incidentally, can a hugetlbfs be a lower layer, while the upper one
>>> is a normal filesystem?  What should happen on copyup?
>>
>> Yes, that seems to work as expected.  When accessed for write the hugetlb
>> file is copied to the normal filesystem.
>>
>> The BUG found by syzbot actually has a single hugetlbfs as both lower and
>> upper.  With the BUG 'fixed', I am not exactly sure what the expected
>> behavior is in this case.  I may be wrong, but I would expect any operations
>> that can be performed on a stand alone hugetlbfs to also be performed on
>> the overlay.  However, mmap() still fails.  I will look into it.
>>
>> I also looked at normal filesystem lower and hugetlbfs upper.  Yes, overlayfs
>> allows this.  This is somewhat 'interesting' as write() is not supported in
>> hugetlbfs.  Writing to files in the overlay actually ended up writing to
>> files in the lower filesystem.  That seems wrong, but overlayfs is new to me.
>>
> 
> I am not sure how that happened, but I think that ovl_open_realfile()
> needs to fixup f_mode flags FMODE_CAN_WRITE | FMODE_CAN_READ
> after open_with_fake_path().
> 
>> Earlier in the discussion of these issues, Colin Walters asked "Is there any
>> actual valid use case for mounting an overlayfs on top of hugetlbfs?"  I can
>> not think of one.  Perhaps we should consider limiting the ways in which
>> hugetlbfs can be used in overlayfs?  Preventing it from being an upper
>> filesystem might be a good start?  Or, do people think making hugetlbfs and
>> overlayfs play nice together is useful?
> 
> If people think that making hugetlbfs and overlayfs play nice together maybe
> they should work on this problem. It doesn't look like either
> hugetlbfs developers
> nor overlayfs developers care much about the combination.

Thanks Amir,

As a hugetlbfs developer, I do not know of a use case for interoperability
with overlayfs.  So yes, I am not too interested in making them work well
together.  However, if there was an actual use case I would be more than
happy to consider doing the work.  Just hate to put effort into fixing up
two 'special' filesystems for functionality that may not be used.

I can't speak for overlayfs developers.

> Your concern, I assume, is fixing the syzbot issue.

That is the primary concern.  We should not BUG!  After fixing that up, Al
asked how these things worked together.  I honestly did not look at
interoperability before that.  I am not sure if anyone has done that in the
past.

> I agree with Colin's remark about adding limitations, but it would be a shame
> if overlay had to special case hugetlbfs. It would have been better if we could
> find a property of hugetlbfs that makes it inapplicable for overlayfs
> upper/lower
> or stacking fs in general.
> 
> The simplest thing for you to do in order to shush syzbot is what procfs does:
>         /*
>          * procfs isn't actually a stacking filesystem; however, there is
>          * too much magic going on inside it to permit stacking things on
>          * top of it
>          */
>         s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
> 
> Currently, the only in-tree stacking fs are overlayfs and ecryptfs, but there
> are some out of tree implementations as well (shiftfs).
> So you may only take that option if you do not care about the combination
> of hugetlbfs with any of the above.
> 
> overlayfs support of mmap is not as good as one might hope.
> overlayfs.rst says:
> "If a file residing on a lower layer is opened for read-only and then
>  memory mapped with MAP_SHARED, then subsequent changes to
>  the file are not reflected in the memory mapping."
> 
> So if I were you, I wouldn't go trying to fix overlayfs-huguetlb interop...

Thanks again,

I'll look at something as simple as s_stack_depth.
-- 
Mike Kravetz
