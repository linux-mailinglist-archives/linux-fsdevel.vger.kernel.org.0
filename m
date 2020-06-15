Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A4D1F9ECC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 19:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbgFORsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 13:48:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40150 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFORsk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:48:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05FHleik178201;
        Mon, 15 Jun 2020 17:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8/GvKgnXyWMqWG4x04LszNrZLOvvW4SLPdr9wifArpI=;
 b=UYLm0d99pVRGz58KNwBO6kwXK5xvC7/oZKu4Ga8N5ovM+yKoJI6S4MLKgsLioIDG3Rux
 ITwnG65Lcm5yJFg41TeTO1K2KPd6gVj1LZb2U/J7woNHPDDKC6ZZgFpkyhhdEyIZKAMv
 kFAq14NhDnxrYVPlR9K9byaU9OgQW/wjkPAI3EsfwnLq/YEkXrVpxg8Mzi1oSaLjjIoB
 TVH7BlYsVio9DWXVtbqBrI/Z9Jf8nd+XlAaNGc/4Ds4FyfnPiiDDTys0qI/e3qo/2XiF
 zOsUCAdorEVKgQRIwNVEmepbX390xaexjxcqcbvPn1jbEDh4OIXpzh4bXv9nCdfqMcAA kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31p6s229je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Jun 2020 17:48:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05FHm5YV147592;
        Mon, 15 Jun 2020 17:48:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31p6s5sj6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jun 2020 17:48:17 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05FHmDcM028323;
        Mon, 15 Jun 2020 17:48:13 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jun 2020 10:48:13 -0700
Subject: Re: [PATCH v4 1/2] hugetlb: use f_mode & FMODE_HUGETLBFS to identify
 hugetlbfs files
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <20200612004644.255692-1-mike.kravetz@oracle.com>
 <20200612015842.GC23230@ZenIV.linux.org.uk>
 <b1756da5-4e91-298f-32f1-e5642a680cbf@oracle.com>
 <CAOQ4uxg=o2SVbfUiz0nOg-XHG8irvAsnXzFWjExjubk2v_6c_A@mail.gmail.com>
 <CAJfpegv28Z2aECcb+Yfqum54zfwV=k1G1n_o3o6O-QTWOy3T4Q@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <33cbc2b6-a37a-8bd1-d896-f4318a61b8ca@oracle.com>
Date:   Mon, 15 Jun 2020 10:48:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegv28Z2aECcb+Yfqum54zfwV=k1G1n_o3o6O-QTWOy3T4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=919 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006150132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=933 priorityscore=1501 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 cotscore=-2147483648 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006150132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/15/20 1:24 AM, Miklos Szeredi wrote:
> On Sat, Jun 13, 2020 at 8:53 AM Amir Goldstein <amir73il@gmail.com> wrote:
> 
>>> I also looked at normal filesystem lower and hugetlbfs upper.  Yes, overlayfs
>>> allows this.  This is somewhat 'interesting' as write() is not supported in
>>> hugetlbfs.  Writing to files in the overlay actually ended up writing to
>>> files in the lower filesystem.  That seems wrong, but overlayfs is new to me.
> 
> Yes, this very definitely should not happen.
> 
>> I am not sure how that happened, but I think that ovl_open_realfile()
>> needs to fixup f_mode flags FMODE_CAN_WRITE | FMODE_CAN_READ
>> after open_with_fake_path().
> 
> Okay, but how did the write actually get to the lower layer?
> 
> I failed to reproduce this.  Mike, how did you trigger this?

My apologies!!!

I reviewed my testing and found that it was incorrectly writing to the
lower filesystem.  Writing to any file in the union will fail.
-- 
Mike Kravetz
