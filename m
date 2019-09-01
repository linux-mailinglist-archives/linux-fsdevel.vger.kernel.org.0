Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94328A4C72
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 00:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfIAWMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 18:12:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54240 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbfIAWMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 18:12:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x81MBuee196148;
        Sun, 1 Sep 2019 22:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=SMZ7kBtjRpfMdbM6ZyF2aXvSW5Zkg/0feBi5AFHROE8=;
 b=S4KfFrmUQheeYW2CWFHc/dV21cSrUCqS52SB8ugd/qNlnVFaua6fvWwHqSRHHBFnSJMJ
 6rliME1TaLFL5MFZdhN47blT3VOh1BAirDMBiL3OCWy3zA6MD4N+S4WVHnhCQ/CdJS85
 m4Wz0R9n47xqtksy+9pb9wVLCnCRjo0nD5SEFA4Dv7jzXJgYOvYM0jHgZ5go0FGTZfck
 5E15CuHbnhxtQ8fyjneXEklTxABtdOMadvvtCvVhvzSRTBv2eDzV66lcS2iZ64ufN9Ok
 SlZ1tmyANUn2VQ5n2ZQqvGJBdmiq4SLdvzIJNZC1I9vNkoibN/AIMOuw6+6JnVHUm4rN Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2urpj4803k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Sep 2019 22:12:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x81KhABO064623;
        Sun, 1 Sep 2019 20:44:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2uqg827jvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Sep 2019 20:44:05 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x81Khw8b007806;
        Sun, 1 Sep 2019 20:43:58 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Sep 2019 13:43:58 -0700
Date:   Sun, 1 Sep 2019 13:44:00 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien.LeMoal@wdc.com, agruenba@redhat.com
Subject: Re: [PATCH v4 0/6] iomap: lift the xfs writepage code into iomap
Message-ID: <20190901204400.GQ5354@magnolia>
References: <156444945993.2682261.3926017251626679029.stgit@magnolia>
 <20190816065229.GA28744@infradead.org>
 <20190817014633.GE752159@magnolia>
 <20190901073440.GB13954@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901073440.GB13954@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909010238
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909010254
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 12:34:40AM -0700, Christoph Hellwig wrote:
> On Fri, Aug 16, 2019 at 06:46:33PM -0700, Darrick J. Wong wrote:
> > On Thu, Aug 15, 2019 at 11:52:29PM -0700, Christoph Hellwig wrote:
> > > Darrick,
> > > 
> > > are you going to queue this up?
> > 
> > Yes, I'll go promote the iomap writeback branch to iomap-for-next.  I
> > haven't 100% convinced myself that it's a good idea to hook up xfs to it
> > yet, if nothing else because of all the other problems I've had getting
> > 5.3 testing to run to completion reliably...
> 
> So what is the current status?  We are going to get an -rc8 to give
> you some more time, and I'd really hate to miss the second merge window
> for the change, espececially as things tend to get out of sync, and I
> have various bits touching the code planned for the 5.5 merge window.

Heh, I had assumed today was going to be 5.3 final and that would be
that for 5.4.  However, if the 5.4 merge window isn't going to close
until Sept. 29 then there's still time for more soaking.

Would you mind rebasing the remaining patches against iomap-for-next and
sending that out?  I'll try to get to it before I go on vacation 6 - 15
Sept.

Admittedly I think the controversial questions are still "How much
writeback code are we outsourcing to iomap anyway?" and "Do we want to
do the added stress of keeping that going without breaking everyone
else"?  IOWs, more philosophical than just the mechanics of porting code
around.

I still want a CONFIG_IOMAP_DEBUG which turns on stricter checking of
the iomap(s) that ->begin_iomap pass to the actor, if you have the time;
I for one am starting to forget exactly what are the valid combinations
of iomap flag inputs that ->begin_iomap has to handle for a given actor
and what are the valid imaps for each actor that it can pass back.  :)

--D
