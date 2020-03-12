Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E47618273A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 04:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387745AbgCLDA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 23:00:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37176 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbgCLDA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 23:00:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02C2xLP7175694;
        Thu, 12 Mar 2020 03:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Qo/MY1wia4ChrahGN998AHrVHZxgV5G79qHPQfknXEE=;
 b=upJxzfwZ0MvxTTGNmjZzcj2xWiYLF/vQCjx9sW0pIebH103o6ghhWrKm0de2cyNMkqlj
 qQlIbNE2HJKH+nkuRN22bYXoyOeWnNi27y3Obp1t8sTgA1gjmqo/r68aqW49SWXqsioT
 qYxrT3o3q2HGD6gJVuW3XAM4DRuqX5OdyOKdgEjGM3MQC6iAgjkY99G2fY5WNY0urmgq
 0DS/CBfH81dBRFPxzj53nFzg0bzQlLSW3PTHT3JagGqvMkU+3T0qUVWM+Cf+yhzBCcSv
 8H3o5CBNfwHub1ILPe5qAlR5QZ1mu4Wt4AEMv4w1m8BFrNBNWK6Ya1Ms0U7fVVTzLRWf /A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2yp7hmbek7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 03:00:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02C2wfD3017433;
        Thu, 12 Mar 2020 03:00:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2yp8q1thc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 03:00:15 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02C30CLw018920;
        Thu, 12 Mar 2020 03:00:12 GMT
Received: from localhost (/10.159.134.61) by default (Oracle Beehive Gateway
 v4.0) with ESMTP ; Wed, 11 Mar 2020 20:00:11 -0700
USER-AGENT: Mutt/1.9.4 (2018-02-28)
MIME-Version: 1.0
Message-ID: <20200312030009.GJ8045@magnolia>
Date:   Wed, 11 Mar 2020 20:00:09 -0700 (PDT)
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ira Weiny <ira.weiny@intel.com>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
References: <20200227052442.22524-1-ira.weiny@intel.com>
 <20200305155144.GA5598@lst.de>
 <20200309170437.GA271052@iweiny-DESK2.sc.intel.com>
 <20200311033614.GQ1752567@magnolia>
 <20200311063942.GE10776@dread.disaster.area> <20200311064412.GA11819@lst.de>
 <20200312004932.GH10776@dread.disaster.area>
In-Reply-To: <20200312004932.GH10776@dread.disaster.area>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120013
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 11:49:32AM +1100, Dave Chinner wrote:
> On Wed, Mar 11, 2020 at 07:44:12AM +0100, Christoph Hellwig wrote:
> > On Wed, Mar 11, 2020 at 05:39:42PM +1100, Dave Chinner wrote:
> > > IOWs, the dax_associate_page() related functionality probably needs
> > > to be a filesystem callout - part of the aops vector, I think, so
> > > that device dax can still use it. That way XFS can go it's own way,
> > > while ext4 and device dax can continue to use the existing mechanism
> > > mechanisn that is currently implemented....
> > 
> > s/XFS/XFS with rmap/, as most XFS file systems currently don't have
> > that enabled we'll also need to keep the legacy path around.
> 
> Sure, that's trivially easy to handle in the XFS code once the
> callouts are in place.
> 
> But, quite frankly, we can enforce rmap to be enabled 
> enabled because nobody is using a reflink enabled FS w/ DAX right
> now. Everyone will have to mkfs their filesystems anyway to enable
> reflink+dax, so we simply don't allow reflink+dax to be enabled
> unless rmap is also enabled. Simple, easy, trivial.

Heh, this reminds me that I need to get that rmap performance analysis
report out to the list... it does have a fairly substantial performance
impact (in its current not-terribly-optimized state) but otoh enables
self-repair.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
