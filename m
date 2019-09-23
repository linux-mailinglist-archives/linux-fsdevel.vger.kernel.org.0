Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1D6BBABF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 19:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440238AbfIWRwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 13:52:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49870 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440205AbfIWRwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:52:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8NHdF1v048664;
        Mon, 23 Sep 2019 17:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=QmIc8SyP7RM5Do/QTI4knkOCWuEHdj+zEMy3rAkq2Hc=;
 b=GoJc40BHF6cojzLJ68q2+dWjy7haKJEAQNHgz+VZBKkwbhfh23GgssQoi7Hm9TO0h03e
 7OeEEY09l9G5bk2inPJ21guyqka9goM9IyOQ7xyThsddSGnrSrg9sKsfKXAl9WgnRh54
 zRU2qH7XPqes1WXn9kSrxofHIY3YxGMe+KSf6+/UM+L5MOed813s4f4dJkMAwIYbC8GZ
 ABZ1c/AgnuKBpRWCniRACcUBJwVI1Kkaj8kFrsrBY7FNnSC2wReeSdrypPwQYqcTPGh4
 d0U5kFEloCKG174QEYKVaCFMAAs5bTgK6brWk/dQJqiWIIyNFMLJAbSkC4xbm8j+V3b9 Yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2v5btprmrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 17:52:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8NHctLO179108;
        Mon, 23 Sep 2019 17:52:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2v6yvpu82k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 17:52:00 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8NHpmAQ017226;
        Mon, 23 Sep 2019 17:51:48 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Sep 2019 10:51:48 -0700
Date:   Mon, 23 Sep 2019 10:51:46 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     dsterba@suse.cz, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-btrfs@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Message-ID: <20190923175146.GT2229799@magnolia>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
 <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz>
 <20190923171710.GN2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923171710.GN2751@twin.jikos.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909230157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909230157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 23, 2019 at 07:17:10PM +0200, David Sterba wrote:
> On Mon, Sep 23, 2019 at 06:36:32PM +0200, Vlastimil Babka wrote:
> > So if anyone thinks this is a good idea, please express it (preferably
> > in a formal way such as Acked-by), otherwise it seems the patch will be
> > dropped (due to a private NACK, apparently).

Oh, I didn't realize  ^^^^^^^^^^^^ that *some* of us are allowed the
privilege of gutting a patch via private NAK without any of that open
development discussion incovenience. <grumble>

As far as XFS is concerned I merged Dave's series that checks the
alignment of io memory allocations and falls back to vmalloc if the
alignment won't work, because I got tired of scrolling past the endless
discussion and bug reports and inaction spanning months.

Now this private NAK stuff helps me feel vindicated for merging it
despite my misgivings because now I can declare that "XFS will just work
around all the stupid broken sh*t it finds in the rest of the kernel".

--D

> As a user of the allocator interface in filesystem, I'd like to see a
> more generic way to address the alignment guarantees so we don't have to
> apply workarounds like 3acd48507dc43eeeb each time we find that we
> missed something. (Where 'missed' might be another sort of weird memory
> corruption hard to trigger.)
> 
> The workaround got applied because I was not sure about the timeframe of
> merge of this patch, also to remove pressure for merge in case there are
> more private acks and nacks to be sent. In the end I'd be fine with
> reverting the workaround in order to use the generic code again.
> 
> Thanks.
