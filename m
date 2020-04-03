Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E3C19DAD4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 18:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404011AbgDCQGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 12:06:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32922 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403971AbgDCQGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:06:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033FmlXx060862;
        Fri, 3 Apr 2020 16:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=UhdHklRomxNbebWWRjDfKWX0dV8tBeR4UT0S2HC9XPI=;
 b=eYWuFB7Md4C6e/b6A31sehx/Iwdjh0AK9osSQuJ3MegOVfOo36LgqkJSHvOY2zBI0OJI
 4fXdc0YAdZu+Hp4q/Mda0F9aLyNcMpOx/3NybkyCv7GdDFWxpqCWabbmw2SlRAEzkcCo
 Wqq9ZH/qS+Koxsntmhk7zosLU0Ti5za6qU6I/FRYx7RKMyadAuCXm33nLZ7gUyGYBP+Z
 dGO3ZtkbfIg1xpk7vizt8349nyzuRhFm+yR5shUwlHiZpHDAAFCugzbJpjXtV/Uj2UX3
 yMPoIgkxybmEHctR/n5o/YRTf0JHdVfk4MopREB56/UtKZ2at8bxwJmN+HrtslrIykzq EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 303aqj2dqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 16:05:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033FmEWr175392;
        Fri, 3 Apr 2020 16:05:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 302ga53hav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 16:05:48 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033G5jXv019624;
        Fri, 3 Apr 2020 16:05:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 09:05:45 -0700
Date:   Fri, 3 Apr 2020 09:05:44 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
Message-ID: <20200403160544.GO80283@magnolia>
References: <20200311033614.GQ1752567@magnolia>
 <20200311062952.GA11519@lst.de>
 <CAPcyv4h9Xg61jk=Uq17xC6AGj9yOSAJnCaTzHcfBZwOVdRF9dw@mail.gmail.com>
 <20200316095224.GF12783@quack2.suse.cz>
 <20200316095509.GA13788@lst.de>
 <20200401040021.GC56958@magnolia>
 <20200401102511.GC19466@quack2.suse.cz>
 <20200402085327.GA19109@lst.de>
 <20200402205518.GF3952565@iweiny-DESK2.sc.intel.com>
 <20200403072731.GA24176@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403072731.GA24176@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=935 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030136
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:27:31AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 02, 2020 at 01:55:19PM -0700, Ira Weiny wrote:
> > > I'd just return an error for that case, don't play silly games like
> > > evicting the inode.
> > 
> > I think I agree with Christoph here.  But I want to clarify.  I was heading in
> > a direction of failing the ioctl completely.  But we could have the flag change
> > with an appropriate error which could let the user know the change has been
> > delayed.
> > 
> > But I don't immediately see what error code is appropriate for such an
> > indication.  Candidates I can envision:
> > 
> > EAGAIN
> > ERESTART
> > EUSERS
> > EINPROGRESS
> > 
> > None are perfect but I'm leaning toward EINPROGRESS.
> 
> I really, really dislike that idea.  The whole point of not forcing
> evictions is to make it clear - no this inode is "busy" you can't
> do that.  A reasonably smart application can try to evict itself.
> 
> But returning an error and doing a lazy change anyway is straight from
> the playbook for arcane and confusing API designs.

Agreed.  That's why I wrote that applications can set FS_XFLAG_DAX and
then query statx for STATX_ATTR_DAX to find out if it actually took
effect, and that if applications require it immediately they can either
create a file in a FS_XFLAG_DAX directory, or the admin can mount with
dax=always.  No magic return values required or desired anywhere.

I don't know what "try to evict the inode" magic means, but I'm fairly
sure I don't want to. ;)

--D
