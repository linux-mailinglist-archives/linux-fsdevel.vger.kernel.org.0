Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A92B7FD51
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395153AbfHBPQX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 11:16:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60870 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729945AbfHBPQW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:16:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72F9HO6158546;
        Fri, 2 Aug 2019 15:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=FSshj20Yv9Pi9pVWxgDmQ12FjvpA1rN9rhtAHZlgXDg=;
 b=vQ1ISrWL6AYPveo+gouT8E5L8tww+UhL4JLDQPiS7tg0spYAO50fsbk92wJAJxXp/1mh
 K3HEF7NsRyHOsclF91EVBfxgrtdCF3rz+QtZmZDfrt2LT7dP/qlCGCTEJ/2un+eCE1Rc
 xyDHTVTXsbaFsuQIUx8JLKqL2nSs3xjrK28LxL8nTRP+ydrKMIkz+VEVSgeoSsp0KGJ7
 GGWI7F5glRhz5N2JkOTtA4sMbz+sjK0M1PmXXvbJng5H8KlBqsdZyD4t2v6NUIXxjErt
 YTdiranSbpkWwGNeO3XxAstMxylG2nfUSKTxZyfYxWiaV6X63GL7Rp78hs7/1VtcX7Q4 Lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u0f8rjtde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 15:16:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72F7VaT054455;
        Fri, 2 Aug 2019 15:14:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2u349f359p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 15:14:05 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x72FE2di029795;
        Fri, 2 Aug 2019 15:14:03 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Aug 2019 08:14:02 -0700
Date:   Fri, 2 Aug 2019 08:14:00 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <20190802151400.GG7138@magnolia>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-5-cmaiolino@redhat.com>
 <20190731231217.GV1561054@magnolia>
 <20190802091937.kwutqtwt64q5hzkz@pegasus.maiolino.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802091937.kwutqtwt64q5hzkz@pegasus.maiolino.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=884
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908020156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=929 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908020156
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:19:39AM +0200, Carlos Maiolino wrote:
> Hi Darrick.
> 
> > > +		return error;
> > > +
> > > +	block = ur_block;
> > > +	error = bmap(inode, &block);
> > > +
> > > +	if (error)
> > > +		ur_block = 0;
> > > +	else
> > > +		ur_block = block;
> > 
> > What happens if ur_block > INT_MAX?  Shouldn't we return zero (i.e.
> > error) instead of truncating the value?  Maybe the code does this
> > somewhere else?  Here seemed like the obvious place for an overflow
> > check as we go from sector_t to int.
> > 
> 
> The behavior should still be the same. It will get truncated, unfortunately. I
> don't think we can actually change this behavior and return zero instead of
> truncating it.

But that's even worse, because the programs that rely on FIBMAP will now
receive *incorrect* results that may point at a different file and
definitely do not point at the correct file block.

Note also that the iomap (and therefore xfs) implementation WARNs on
integer overflow and returns 0 (error) to prevent an incorrect access.

--D

> > --D
> > 
> > > +
> > > +	error = put_user(ur_block, p);
> > > +
> > > +	return error;
> > >  }
> > >  
> > >  /**
> > > -- 
> > > 2.20.1
> > > 
> 
> -- 
> Carlos
