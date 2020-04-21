Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043891B2FA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 20:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDUS5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 14:57:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57398 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDUS5N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:57:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LIv2kU001553;
        Tue, 21 Apr 2020 18:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=WOyKZjY+eI2YMOo8cv9qPTAY/ZyP/gYFXzlUCbXYSH8=;
 b=a4cWUdIFlDDioH4LRw2Vi4Qbh7qzccfCV+4M+GbiqNrek4Jx2nJhf5c/txZJAMPoArlt
 Vdkb3z3Lpf0vIZ8BR2DKJ1Lq2wtzAG5I0dBF9S4oAV6wqCfuXKaOt4WcScK6fZc288QY
 ThWuE7MiWl/N6RLQZ0/NaNkowmnpway4Q13X7lLYayOpbnIRHtYCpgDSOejchH+bLkYD
 xU9G6aS2uh7qmQqVElTWgsHdBRsxo92TRUd+emoLLnzkdHvjpHfxKWwVRJriMAtf3iTE
 PHoJHxEV2iXs8dglRwaHE0nwAI3J9aN+/sPcy/1H8ADEst/KRKPSAfoyKJxK4LjqUk7n CQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30ft6n6r5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 18:57:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LIrQUF119834;
        Tue, 21 Apr 2020 18:57:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30gb90rnff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 18:57:02 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03LIuxPi029627;
        Tue, 21 Apr 2020 18:56:59 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Apr 2020 11:56:59 -0700
Date:   Tue, 21 Apr 2020 11:56:57 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 3/8] fs/ext4: Disallow encryption if inode is DAX
Message-ID: <20200421185657.GK6749@magnolia>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-4-ira.weiny@intel.com>
 <20200415160307.GJ90651@mit.edu>
 <20200415195433.GC2305801@iweiny-DESK2.sc.intel.com>
 <20200421184143.GA3004764@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421184143.GA3004764@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210141
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:41:43AM -0700, Ira Weiny wrote:
> On Wed, Apr 15, 2020 at 12:54:34PM -0700, 'Ira Weiny' wrote:
> > On Wed, Apr 15, 2020 at 12:03:07PM -0400, Theodore Y. Ts'o wrote:
> > > On Mon, Apr 13, 2020 at 09:00:25PM -0700, ira.weiny@intel.com wrote:
>  
> [snip]
> 
> > > 
> > > Also note that encrypted files are read/write so we must never allow
> > > the combination of ENCRPYT_FL and DAX_FL.  So that may be something
> > > where we should teach __ext4_iget() to check for this, and declare the
> > > file system as corrupted if it sees this combination.
> > 
> > ok...
> 
> After thinking about this...
> 
> Do we really want to declare the FS corrupted?

Seeing as we're defining the dax inode flag to be advisory (since its
value is ignored if the fs isn't on pmem, or the administrator overrode
with dax=never mount option), I don't see why that's filesystem
corruption.

I can see a case for returning errors if you're trying to change ENCRYPT
or VERITY on a file that's has S_DAX set.  We can't encrypt or set
verity data for a file that could be changed behind our backs, so the
kernel cannot satisfy /that/ request.

As for changing FS_DAX_FL on an encrypted/verity'd file, the API says
that it might not have an immedate effect on S_DAX and that programs
have to check S_DAX after changing FS_DAX_FL.  It'll never result in
S_DAX being set, but the current spec never guarantees that. ;)

(If FS_DAX_FL were *mandatory* then yes that would be corruption.)

--D

> If so, I think we need to return errors when such a configuration is attempted.
> If in the future we have an encrypted mode which can co-exist with DAX (such as
> Dan mentioned) we can change this.
> 
> FWIW I think we should return errors when such a configuration is attempted but
> _not_ declare the FS corrupted.  That allows users to enable this configuration
> later if we can figure out how to support it.
> 
> > 
> > > (For VERITY_FL
> > > && DAX_FL that is a combo that we might want to support in the future,
> > > so that's probably a case where arguably, we should just ignore the
> > > DAX_FL for now.)
> > 
> > ok...
> 
> I think this should work the same.
> 
> It looks like VERITY_FL and ENCRYPT_FL are _not_ user modifiable?  Is that
> correct?
> 
> You said that ENCRPYT_FL is set from the parent directory?  But I'm not seeing
> where that occurs?
> 
> Similarly I don't see where VERITY_FL is being set either?  :-/
> 
> I think to make this work correctly we should restrict setting those flags if
> DAX_FL is set and vice versa.  But I'm not finding where to do that.  :-/
> 
> Ira
> 
> > 
> > Ira
> > 
