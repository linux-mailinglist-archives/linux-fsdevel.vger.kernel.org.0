Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A79B060D39
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 23:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfGEVnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 17:43:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59946 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfGEVnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 17:43:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x65LdCZ4047322;
        Fri, 5 Jul 2019 21:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=N0Xj0V7McXFWZJIEb4PS0gMpz9E6oJverdvCiNgsT24=;
 b=1fHUiSCgQ3/Oo4+qpeQZhYdPyQESNPPEJgin9+woFwEllfl3Y8W2NiWeY8CRSH7GDhjR
 9FMmzL4Tnwxxt7WYreRInEZBUqf28NtDmK6HinaBkuJcqSKrHud/Hk8xqKJhryFu93as
 xOR6YmYnsOJcHpUoUGbxmmhYWykth6++sioTy3U9HzVveds09MKxOi0sLqdtlh8Lftba
 9UXVZ3sh0AwvC6h6RWzR1kin015MUAKl+fRZZv94LR5K5AVOIlLMX5BLAgUc+caDuVw/
 rqQfHYbkBmp0FirdYxDi7Dgasgwbu6YoADadt+yQ4f9l6wQEe5R1/O6kSov6S5zfouz2 qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2te5tc4mb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jul 2019 21:43:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x65LbRX8036346;
        Fri, 5 Jul 2019 21:41:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2th5qmxfqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jul 2019 21:41:02 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x65LexAA014956;
        Fri, 5 Jul 2019 21:40:59 GMT
Received: from localhost (/10.159.235.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jul 2019 14:40:59 -0700
Date:   Fri, 5 Jul 2019 14:40:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Subject: Re: Question about ext4 testing: need to produce a high depth extent
 tree to verify mapping code
Message-ID: <20190705214058.GD5161@magnolia>
References: <1562021070.2762.36.camel@HansenPartnership.com>
 <20190702002355.GB3315@mit.edu>
 <1562028814.2762.50.camel@HansenPartnership.com>
 <20190702173301.GA3032@mit.edu>
 <1562095894.3321.52.camel@HansenPartnership.com>
 <20190702203937.GG3032@mit.edu>
 <1562343948.2953.8.camel@HansenPartnership.com>
 <20190705173905.GA32320@bombadil.infradead.org>
 <1562352542.2953.10.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562352542.2953.10.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9309 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907050274
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9309 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907050274
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 05, 2019 at 11:49:02AM -0700, James Bottomley wrote:
> On Fri, 2019-07-05 at 10:39 -0700, Matthew Wilcox wrote:
> > On Fri, Jul 05, 2019 at 09:25:48AM -0700, James Bottomley wrote:
> > > Now the problem: I'd like to do some testing with high depth extent
> > > trees to make sure I got this right, but the files we load at boot
> > > are ~20MB in size and I'm having a hard time fragmenting the
> > > filesystem enough to produce a reasonable extent (I've basically
> > > only got to a two level tree with two entries at the top).  Is
> > > there an easy way of producing a high depth extent tree for a 20MB
> > > file?
> > 
> > Create a series of 4kB files numbered sequentially, each 4kB in size
> > until you fill the partition.  Delete the even numbered ones.  Create
> > a 20MB file.
> 
> Well, I know *how* to do it ... I was just hoping, in the interests of
> creative laziness, that someone else had produced a script for this
> before I had to ... particularly one which leaves more randomized gaps.

If you don't care about the contents of the file you could just build
src/punch-alternating.c from xfstests and use it to turn your 20M file
into holy cheese.

(Granted if you actually need 5,120 extents then you probably ought to
make it a 40M file and /then/ run it through the cheese grater....)

--D

> James
> 
