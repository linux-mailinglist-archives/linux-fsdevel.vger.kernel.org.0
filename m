Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569C13C18B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 05:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390950AbfFKD0T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 23:26:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37150 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390856AbfFKD0T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 23:26:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B3JYbq122570;
        Tue, 11 Jun 2019 03:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=+KMHTpIPHehmYr7PrnoKeQGFw46qVIvlu8jfHMIONJs=;
 b=lTw3n6sfAuJxerQIcWvvAzMYQN+AqtCPDfst2dOgTcdT2K7l70GXNYMqGHsNnCdk6wWJ
 c7B8KxtKCiw/HIyg0TzHinvugM77U16TWDIV4RUqydwstE2v/O6WmbklmNTHt9ONL6Hf
 8nix+RvdOj4fFnrZWzqEqBGocz0+c/cYECmtDtfNx42zPkkJePXJWXe7Hh7CPw4YOW9s
 4yqshFav8Do/yNkdOJCBXL2mI4X3yT493ZlzXH1rdALCUQWxVW53N8gWI7PU+/0hSDva
 e/vYpQcoD4tQPYop3LFIttJa/6DA6+oherOHnagItEI4/fDKCBn6gnQuy8H0a/HVH5Zq ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2t02hejhjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 03:26:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B3Q8lN021788;
        Tue, 11 Jun 2019 03:26:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t0p9r2a63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 03:26:08 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5B3Q4J4008815;
        Tue, 11 Jun 2019 03:26:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 20:26:04 -0700
Date:   Mon, 10 Jun 2019 20:26:03 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/8] mm/fs: don't allow writes to immutable files
Message-ID: <20190611032603.GB1872258@magnolia>
References: <155552786671.20411.6442426840435740050.stgit@magnolia>
 <155552787330.20411.11893581890744963309.stgit@magnolia>
 <20190610015145.GB3266@mit.edu>
 <20190610044144.GA1872750@magnolia>
 <20190610131417.GD15963@mit.edu>
 <20190610160934.GH1871505@magnolia>
 <20190610204154.GA5466@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610204154.GA5466@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110021
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110021
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 11, 2019 at 04:41:54PM -0400, Theodore Ts'o wrote:
> On Mon, Jun 10, 2019 at 09:09:34AM -0700, Darrick J. Wong wrote:
> > > I was planning on only taking 8/8 through the ext4 tree.  I also added
> > > a patch which filtered writes, truncates, and page_mkwrites (but not
> > > mmap) for immutable files at the ext4 level.
> > 
> > *Oh*.  I saw your reply attached to the 1/8 patch and thought that was
> > the one you were taking.  I was sort of surprised, tbh. :)
> 
> Sorry, my bad.  I mis-replied to the wrong e-mail message  :-)
> 
> > > I *could* take this patch through the mm/fs tree, but I wasn't sure
> > > what your plans were for the rest of the patch series, and it seemed
> > > like it hadn't gotten much review/attention from other fs or mm folks
> > > (well, I guess Brian Foster weighed in).
> > 
> > > What do you think?
> > 
> > Not sure.  The comments attached to the LWN story were sort of nasty,
> > and now that a couple of people said "Oh, well, Debian documented the
> > inconsistent behavior so just let it be" I haven't felt like
> > resurrecting the series for 5.3.
> 
> Ah, I had missed the LWN article.   <Looks>
> 
> Yeah, it's the same set of issues that we had discussed when this
> first came up.  We can go round and round on this one; It's true that
> root can now cause random programs which have a file mmap'ed for
> writing to seg fault, but root has a million ways of killing and
> otherwise harming running application programs, and it's unlikely
> files get marked for immutable all that often.  We just have to pick
> one way of doing things, and let it be same across all the file
> systems.
> 
> My understanding was that XFS had chosen to make the inode immutable
> as soon as the flag is set (as opposed to forbidding new fd's to be
> opened which were writeable), and I was OK moving ext4 to that common
> interpretation of the immmutable bit, even though it would be a change
> to ext4.

<nod> It started as "just do this to xfs" and has now become a vfs level
change...

> And then when I saw that Amir had included a patch that would cause
> test failures unless that patch series was applied, it seemed that we
> had all thought that the change was a done deal.  Perhaps we should
> have had a more explicit discussion when the test was sent for review,
> but I had assumed it was exclusively a copy_file_range set of tests,
> so I didn't realize it was going to cause ext4 failures.

And here we see the inconsistent behavior causing developer confusion. :)

I think Amir's c_f_r tests just check the existing behavior (of just
c_f_r) that you can't (most of the time) copy into a file that you
opened for write but that the administrator has since marked immutable.

/That/ behavior in turn came from the original implementation that would
try reflink which would fail on the immutable destination check and then
fail the whole call ... I think?

--D

>      	    	       	   	 - Ted
