Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE51195596
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 11:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgC0KrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 06:47:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43248 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgC0KrB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:47:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02RAipEu110793;
        Fri, 27 Mar 2020 10:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=wCNEdmm970c9ohe5wSF1kEgXI3G+JCq5rKsy4xABqeI=;
 b=ez6hm1hBU7A7HPlFjWuFzeOjehM/4JmeSn98TLQ+ro/+EaWhU2WZUAxWMsdqFwVGZ2HX
 dWPGHWZqus7ybjxL0N72DWEQtxZ3dSR/UpaLLAKmqA8YF5BLuzphDOtgm+uhKZhaBxu/
 N6R+Wo+EONNzysgbMef7w9cg3XQu9pmxujpzc9FUivX32r0CpMVKVq/aYdv3di9Q02Wi
 YxvyvPjBc0Xw0tl4HvADF9u39TXs4fPHe0x/rQ1/EtOn1cY8jnvBkYzbOGBwQHqPmasT
 aeev5zT9S6Bci/q1Nf5oM9mF+GW/+cSYZuVBXyOJ2zSsYhiNUtSi6I4K2iZ2TEYYP+Dx tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ywavmmqa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 10:46:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02RAfi89004657;
        Fri, 27 Mar 2020 10:46:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3003gnqhqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 10:46:46 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02RAkh3F026047;
        Fri, 27 Mar 2020 10:46:43 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Mar 2020 03:46:43 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/2] mm: Use clear_bit_unlock_is_negative_byte for
 PageWriteback
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200326124443.GG22483@bombadil.infradead.org>
Date:   Fri, 27 Mar 2020 04:46:42 -0600
Cc:     Jan Kara <jack@suse.cz>, linux-mm <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CF691FE6-389A-44D5-ABD7-6D8F1E6D9C83@oracle.com>
References: <20200326122429.20710-1-willy@infradead.org>
 <20200326122429.20710-3-willy@infradead.org>
 <20200326124047.GA13756@quack2.suse.cz>
 <20200326124443.GG22483@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=769 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=823 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270098
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I like it explicit in the code before __clear_page_writeback() is called,
and given it's the only caller I think it adds clarity to have it in
end_page_writeback() - but either approach is fine with me.

For the series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Mar 26, 2020, at 6:44 AM, Matthew Wilcox <willy@infradead.org> wrote:
> 
> On Thu, Mar 26, 2020 at 01:40:47PM +0100, Jan Kara wrote:
>> On Thu 26-03-20 05:24:29, Matthew Wilcox wrote:
>>> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>>> 
>>> By moving PG_writeback down into the low bits of the page flags, we can
>>> use clear_bit_unlock_is_negative_byte() for writeback as well as the
>>> lock bit.  wake_up_page() then has no more callers.  Given the other
>>> code being executed between the clear and the test, this is not going
>>> to be as dramatic a win as it was for PageLocked, but symmetry between
>>> the two is nice and lets us remove some code.
>>> 
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> 
>> The patch looks good to me. Just one nit:
>> 
>>> +	VM_BUG_ON_PAGE(!PageWriteback(page), page);
>>> +	if (__clear_page_writeback(page))
>>> +		wake_up_page_bit(page, PG_writeback);
>> 
>> Since __clear_page_writeback() isn't really prepared for PageWriteback()
>> not being set, can we move the VM_BUG_ON_PAGE() there? Otherwise feel free
>> to add:
>> 
>> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Thanks!  I put it there to be parallel to the PageLocked equivalent:
> 
> void unlock_page(struct page *page)
> {
>        BUILD_BUG_ON(PG_waiters != 7);
>        BUILD_BUG_ON(PG_locked > 7);
>        page = compound_head(page);
>        VM_BUG_ON_PAGE(!PageLocked(page), page);
>        if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
>                wake_up_page_bit(page, PG_locked);
> }
> 
> but one could equally well argue it should be in __clear_page_writeback
> instead.
> 

