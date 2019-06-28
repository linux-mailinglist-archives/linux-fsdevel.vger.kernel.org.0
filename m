Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1E5591FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 05:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfF1Dd0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 23:33:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46780 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF1Dd0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:33:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S3TSew007988;
        Fri, 28 Jun 2019 03:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=XNssvwhy0FbfTsDRiG4Jc4n0gxEcgk+h9kgGBaf6yys=;
 b=B612IMjsJyLVvw8Qo/0g+i+P65yj4D6xHhdGChgwKNAAs37fSaG+C8zwmv8q3ZYuyzJf
 TQ8degHnK0z8iQxvVPJqeO5/NL+HUsZsCJRZuWGIZF2g9GGezRqpN/ctLgPNVS3rAS02
 8wfH2XhIknCVjBZn9/gwxz0Dgb/4g74fKSj2M2jHm1Ks1NQFJQx605urvkrYO8KkAoAD
 +2EHyi2fh5pYjh46ZuFbfuNkh8JNiH+wGBDfvD24fliuVqs6pQpibiDO3wXk5LyNBiJT
 9R3R9DoRL87ZupAoACpRmIp1QzcGCOAu28BqVIygTFUNiRYWX9S/lH24IVKA4kcvRxyh Xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t9cyqu92g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 03:33:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S3VaJo143693;
        Fri, 28 Jun 2019 03:33:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2t9acdk8w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 03:33:04 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5S3X4O7003148;
        Fri, 28 Jun 2019 03:33:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 20:33:03 -0700
Date:   Thu, 27 Jun 2019 20:33:03 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] xfs: allow merging ioends over append boundaries
Message-ID: <20190628033303.GA1404256@magnolia>
References: <20190627104836.25446-1-hch@lst.de>
 <20190627104836.25446-8-hch@lst.de>
 <20190627182309.GP5171@magnolia>
 <20190627214304.GB30113@42.do-not-panic.com>
 <20190628025204.GI30864@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628025204.GI30864@dhcp-12-102.nay.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=977
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280033
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:52:04AM +0800, Zorro Lang wrote:
> On Thu, Jun 27, 2019 at 09:43:04PM +0000, Luis Chamberlain wrote:
> > On Thu, Jun 27, 2019 at 11:23:09AM -0700, Darrick J. Wong wrote:
> > > On Thu, Jun 27, 2019 at 12:48:30PM +0200, Christoph Hellwig wrote:
> > > > There is no real problem merging ioends that go beyond i_size into an
> > > > ioend that doesn't.  We just need to move the append transaction to the
> > > > base ioend.  Also use the opportunity to use a real error code instead
> > > > of the magic 1 to cancel the transactions, and write a comment
> > > > explaining the scheme.
> > > > 
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > Reading through this patch, I have a feeling it fixes the crash that
> > > Zorro has been seeing occasionally with generic/475...
> > > 
> > > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > Zorro, can you confirm? If so it would be great to also refer to
> > the respective bugzilla entry #203947 [0].
> 
> Sure, I'll give it a test. But it's so hard to reproduce, I need long enough
> time to prove "the panic's gone".
> 
> BTW, should I only merge this single patch to test, or merge your whole patchset
> with 13 patches?

Just this one patch.

--D

> Thanks,
> Zorro
> 
> > 
> > [0] https://bugzilla.kernel.org/show_bug.cgi?id=203947
> > 
> >   Luis
