Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 074A310297D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 17:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfKSQfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 11:35:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56726 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfKSQfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:35:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJGTNLM102172;
        Tue, 19 Nov 2019 16:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=vizkMgmMDESpjnFcq/Am7MA+/C9xfAoNWHo2ZfgU82I=;
 b=UcEI7LqKHXXXo9aGSr+lQIPXbdgZ3oZjg/udlKPsH2VtH+C15AyuO+PFZicHsiLt/k6j
 d/HTRtDNjxXWJS5eUYe2LqdITMGplRB1ewL2nJSz9bwwGRi7Sk3x7YWDdKyVW5haIFjt
 xjXfonFvcZcpUrIkEWOI6ju6HlUGnzQGIhnVAVC8+qyuDZkxeWzJGjlyWHFnMLCTJ7Og
 ULXJvBTU5wJTls4dyFUXW7Mlz26Xb31+MT2LWK7qLqCynExtFvhIBaeIL00s200UeP93
 0MBj5qOlbs+DMshppu4O1fFjDbV2iOe2PnN+oRPamuPzcHUg5mJCcFgL/5PowoSS2FQP Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wa92pr2xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 16:34:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJGSBI9016064;
        Tue, 19 Nov 2019 16:34:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wcem9w4q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 16:34:57 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJGYuNb007637;
        Tue, 19 Nov 2019 16:34:56 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 08:34:55 -0800
Date:   Tue, 19 Nov 2019 08:34:54 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>
Subject: Re: Splice & iomap dio problems
Message-ID: <20191119163454.GS6235@magnolia>
References: <20191113180032.GB12013@quack2.suse.cz>
 <20191113184403.GM6235@magnolia>
 <20191119163214.GC2440@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119163214.GC2440@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190146
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 19, 2019 at 05:32:14PM +0100, Jan Kara wrote:
> On Wed 13-11-19 10:44:03, Darrick J. Wong wrote:
> > On Wed, Nov 13, 2019 at 07:00:32PM +0100, Jan Kara wrote:
> > > Hello,
> > > 
> > > I've spent today tracking down the syzkaller report of a WARN_ON hit in
> > > iov_iter_pipe() [1]. The immediate problem is that syzkaller reproducer
> > > (calling sendfile(2) from different threads at the same time a file to the
> > > same file in rather evil way) results in splice code leaking pipe pages
> > > (nrbufs doesn't return to 0 after read+write in the splice) and eventually
> > > we run out of pipe pages and hit the warning in iov_iter_pipe(). The
> > > problem is not specific to ext4, I can see in my tracing that when the
> > > underlying filesystem is XFS, we can leak the pipe pages in the same way
> > > (but for XFS somehow the problem doesn't happen as often).  Rather the
> > > problem seems to be in how iomap direct IO code, pipe iter code, and splice
> > > code interact.
> > > 
> > > So the problematic situation is when we do direct IO read into pipe pages
> > > and the read hits EOF which is not on page boundary. Say the file has 4608
> > > (4096+512) bytes, block size == page size == 4096. What happens is that iomap
> > > code maps the extent, gets that the extent size is 8192 (mapping ignores
> > 
> > I wonder, would this work properly if the read side returns a 4608-byte
> > mapping instead of an 8192-byte mapping?  It doesn't make a lot of sense
> > (to me, anyway) for a read mapping to go beyond EOF.
> 
> The slight concern I have with this is that that would change e.g. the
> behavior of IOMAP_REPORT. We could specialcase IOMAP_REPORT but then it
> gets kind of ugly. And it seems kind of fuzzy when do we truncate the
> extent with i_size and when not... Generally i_size is kind of a side-band
> thing for block mapping operations so if we could leave it out of
> ->iomap_begin I'd find that nicer.

<nod>

> > > i_size). Then we call iomap_dio_bio_actor(), which creates its private
> > > iter, truncates it to 8192, and calls bio_iov_iter_get_pages(). That
> > > eventually results in preparing two pipe buffers with length 4096 to accept
> > > the read. Then read completes, in iomap_dio_complete() we truncate the return
> > > value from 8192 (which was the real amount of IO we performed) to 4608. Now
> > > this amount (4608) gets passed through splice code to
> > > iter_file_splice_write(), we write out that amount, but then when cleaning
> > > up pipe buffers, the last pipe buffer has still 3584 unused so we leave
> > > the pipe buffer allocated and effectively leak it.
> > > 
> > > Now I was also investigating why the old direct IO code doesn't leak pipe
> > > buffers like this and the trick is done by the iov_iter_revert() call
> > > generic_file_read_iter(). This results in setting iter position right to
> > > the position where direct IO read reported it ended (4608) and truncating
> > > pipe buffers after this point. So splice code then sees the second pipe
> > > buffer has length only 512 which matches the amount it was asked to write
> > > and so the pipe buffer gets freed after the write in
> > > iter_file_splice_write().
> > > 
> > > The question is how to best fix this. The quick fix is to add
> > > iov_iter_revert() call to iomap_dio_rw() so that in case of sync IO (we
> > > always do only sync IO to pipes), we properly set iter position in case of
> > > short read / write. But it looks somewhat hacky to me and this whole
> > > interaction of iter and pipes looks fragile to me.
> > > 
> > > Another option I can see is to truncate the iter to min(i_size-pos, length) in
> > > iomap_dio_bio_actor() which *should* do the trick AFAICT. But I'm not sure
> > > if it won't break something else.
> > 
> > Do the truncation in ->iomap_begin on the read side, as I suggested above?
> 
> Yes, that would be equivalent for this case.
> 
> > > Any other ideas?
> > > 
> > > As a side note the logic copying iter in iomap_dio_bio_actor() looks
> > > suspicious. We copy 'dio->submit.iter' to 'iter' but then in the loop we call
> > > iov_iter_advance() on dio->submit.iter. So if bio_iov_iter_get_pages()
> > > didn't return enough pages and we loop again, 'iter' will have stale
> > > contents and things go sideways from there? What am I missing? And why do
> > > we do that strange copying of iter instead of using iov_iter_truncate() and
> > > iov_iter_reexpand() on the 'dio->submit.iter' directly?
> > 
> > I'm similarly puzzled; I would've thought that we'd need to advance the
> > private @iter too.  Or just truncate and reexpand the dio->submit.iter
> > and not have the private one.
> > 
> > With any luck hch will have some ideas? :/
> 
> Christoph seems to be busy with something else. So I'll just write patches,
> run them through fstests and see if something blows up.

Heheh.  Ok, sounds good!

--D

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
