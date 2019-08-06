Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1488F83445
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 16:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbfHFOsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 10:48:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53330 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730289AbfHFOsX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:48:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76EjVm7030504;
        Tue, 6 Aug 2019 14:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=wyNpU9d1Jq9VYKzI7mIJU4vjLwl+NJ2F9Pqgwn7ZZL4=;
 b=0Vb4B+qe3IEiY3zgUeRDvej52vMsgkbtDlqzSg2wrT+rqNc8OXQ1shhpu3LcL6wuZ7yg
 9FU7b/0eBO6vD+GQz4gFDusqnmxarAEwttRSuIf0LxnQSs5CkQcd/bx8pToOx+is+/yP
 ukgDFkNjttnkaa24z/6h0O9hqdvUAjG4SFKVOlPzS7L6nUhOhO5kr9J8Sz1HnG//QDoW
 TZm7Nr2xDLyrvh+eh9vozou3qSlXoyylbFN2o/kRi0FdpXV1GsoKvPIzH1z4aHULxGqI
 WLusdOBHPLszG2dYC+zDnNTDfFGfqfG0IcshdEh5bgjktc623tumfhiaGY6ji1Lvil4O tQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u527ppk9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 14:48:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76EjAqL127917;
        Tue, 6 Aug 2019 14:48:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2u7666n5w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 14:48:08 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x76Em43q027066;
        Tue, 6 Aug 2019 14:48:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Aug 2019 07:48:03 -0700
Date:   Tue, 6 Aug 2019 07:48:00 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        adilger@dilger.ca, jaegeuk@kernel.org, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <20190806144800.GN7138@magnolia>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-5-cmaiolino@redhat.com>
 <20190731231217.GV1561054@magnolia>
 <20190802091937.kwutqtwt64q5hzkz@pegasus.maiolino.io>
 <20190802151400.GG7138@magnolia>
 <20190805102729.ooda6sg65j65ojd4@pegasus.maiolino.io>
 <20190805151258.GD7129@magnolia>
 <20190806053840.GH13409@lst.de>
 <20190806120723.eb72ykmukgjejiku@pegasus.maiolino.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806120723.eb72ykmukgjejiku@pegasus.maiolino.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908060148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908060148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:07:24PM +0200, Carlos Maiolino wrote:
> On Tue, Aug 06, 2019 at 07:38:40AM +0200, Christoph Hellwig wrote:
> > On Mon, Aug 05, 2019 at 08:12:58AM -0700, Darrick J. Wong wrote:
> > > > returned. And IIRC, iomap is the only interface now that cares about issuing a
> > > > warning.
> > > >
> > > > I think the *best* we could do here, is to make the new bmap() to issue the same
> > > > kind of WARN() iomap does, but we can't really change the end result.
> > > 
> > > I'd rather we break legacy code than corrupt filesystems.
> > 
> 
> Yes, I have the same feeling, but this patchset does not have the goal to fix
> the broken api.
> 
> > This particular patch should keep existing behavior as is, as the intent
> > is to not change functionality.  Throwing in another patch to have saner
> > error behavior now that we have a saner in-kernel interface that cleary
> > documents what it is breaking and why on the other hand sounds like a
> > very good idea.
> 
> I totally agree here, and to be honest, I think such change should be in a
> different patchset rather than a new patch in this series. I can do it for sure,
> but this discussion IMHO should be done not only here in linux-fsdevel, but also
> in linux-api, which well, I don't think cc'ing this whole patchset there will do
> any good other than keep the change discussion more complicated than it should
> be. I'd rather finish the design and implementation of this patchset, and I'll
> follow-up it, once it's all set, with a new patch to change the truncation
> behavior, it will make the discussion way easier than mixing up subjects. What
> you guys think?

I probably would've fixed the truncation behavior in the old code and
based the fiemap-fibmap conversion on that so that anyone who wants to
backport the behavior change to an old kernel has an easier time of it.

But afterwards probably works just as well since I don't feel like tying
ourselves in more knots over an old interface. ;)

--D

> Cheers
> 
> 
> -- 
> Carlos
