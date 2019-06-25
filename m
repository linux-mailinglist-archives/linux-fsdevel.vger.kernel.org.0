Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2938755264
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbfFYOp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 10:45:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34390 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730905AbfFYOp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:45:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PEdTRU167344;
        Tue, 25 Jun 2019 14:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=0EUuG3LGzOAP6D3wSMZeh8KZEo6tiXD6ZqjeYMFA07M=;
 b=dr5KWuEr9Y2rQYE6U73yHbzuosJaxne8Vv9WTN3EmUtptHxUk4jCAePfKSZX/EGU9mao
 sVtLUi6cleNPuOkokte7LWCpcaGsMIHNAyytf4eCjSdgyymo9LX5Zj/YYLg8x2jyOaW7
 +JU/4JyztHLU9VSvsr6Yndi6JvJ1KpWDFMNcl6CXoOQvOQErpxKHLRuWo8kZEHw/aJxR
 pOkz1dNOk1YhXhK+ob1aJhkmRrveuv9MNk1LyCrRQID/WCDjH32mqqKliFdUR/xObqHl
 h/zF9FPU8R0dHMUQoBDBaQWLBs4et5FNVTvun5Se4plrv3q/YvZgMNaXDYcgztS+Kgqk 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t9brt4vc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 14:45:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PEhOVf030853;
        Tue, 25 Jun 2019 14:45:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tat7c9aer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 14:45:17 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5PEjFHc026039;
        Tue, 25 Jun 2019 14:45:15 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 07:45:15 -0700
Date:   Tue, 25 Jun 2019 07:45:13 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] xfs: refactor the ioend merging code
Message-ID: <20190625144513.GB5379@magnolia>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-10-hch@lst.de>
 <e42c54c4-4c64-8185-8ac3-cca38ad8e8a4@suse.com>
 <20190625101445.GK1462@lst.de>
 <387a9e4b-6a15-5b08-6878-53ed5cfb9bb0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <387a9e4b-6a15-5b08-6878-53ed5cfb9bb0@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906250114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250114
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 03:42:20PM +0300, Nikolay Borisov wrote:
> 
> 
> On 25.06.19 г. 13:14 ч., Christoph Hellwig wrote:
> > On Mon, Jun 24, 2019 at 07:06:22PM +0300, Nikolay Borisov wrote:
> >>> +{
> >>> +	struct list_head	tmp;
> >>> +
> >>> +	list_replace_init(&ioend->io_list, &tmp);
> >>> +	xfs_destroy_ioend(ioend, error);
> >>> +	while ((ioend = list_pop(&tmp, struct xfs_ioend, io_list)))
> >>> +		xfs_destroy_ioend(ioend, error);
> >>
> >> nit: I'd prefer if the list_pop patch is right before this one since
> >> this is the first user of it.
> > 
> > I try to keep generic infrastructure first instead of interveawing
> > it with subystem-specific patches.
> > 
> >> Additionally, I don't think list_pop is
> >> really a net-negative win 
> > 
> > What is a "net-negative win" ?
> 
> What I meant was 'net-positive win', in terms of making the code more
> readable or optimised.
> 
> > 
> >> in comparison to list_for_each_entry_safe
> >> here. In fact this "delete the list" would seems more idiomatic if
> >> implemented via list_for_each_entry_safe
> > 
> > I disagree.  The for_each loops require an additional next iterator,
> > and also don't clearly express what is going on, but require additional
> > spotting of the list_del.
> 
> That is of course your opinion. At the very least we can agree to disagree.
> 
> What I'm worried about, though, is now you've essentially introduced a
> new idiom to dispose of lists, which is used only in your code. If it
> doesn't become more widespread and gradually start replacing current
> list_for_each_entry_safe usage then you would have increased the public
> list interface to cater for one specific use case, just because it seems
> more natural to you. I guess only time will show whether it makes sense
> to have list_pop_entry

I for one would love to replace all the opencoded "walk a list and drop
each entry before we move on" code in fs/xfs/scrub/ with list_pop_entry.
Quickly scanning fs/xfs/, there seem to be a couple dozen places where
we could probably do that too.

--D
