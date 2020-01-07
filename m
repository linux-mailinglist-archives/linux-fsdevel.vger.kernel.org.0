Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65BF6132DB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgAGR5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:57:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45982 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgAGR5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:57:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007HsIHw164148;
        Tue, 7 Jan 2020 17:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=vN4COk+F1rQWgOObms3RGk7Ng89H9X3BD3nxkfpZrkM=;
 b=COPRY0QwTekreHAGtRm5x8ml2QnodRwUpU7vocNaqBk2V3oM6SftcxHkGwxtKdJ86+W2
 TAxMyNDBkfPr31DZgvhfq9oVLvqiZkbtcRWBecTmxx/IaiJqm0HOEBem6tbr2v3tSFHx
 UmXPikTxgNEmEUpgA6qitao7V94dRtIvkw6Be+Ulh2/KfKN9Oxy2SrmeCCjSLZ1SarXB
 yXg98Cwa+u7osuq5YlTTeYU6J9cQdvrM/sHhAgOHdjR4jeS7Y1SNF+jX4Es3H9FZm9rp
 vyXM7NJxgFQrLqDBmyeQi9xUJGPltDRNhRrzwjgJyXvP1MG704z0OpalgP6g3LkREeZA FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xakbqq37x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 17:57:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007HrxIs016970;
        Tue, 7 Jan 2020 17:57:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xcpan14ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 17:57:41 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 007Hve9U008691;
        Tue, 7 Jan 2020 17:57:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 09:57:40 -0800
Date:   Tue, 7 Jan 2020 09:57:39 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/2] fs: allow deduplication of eof block into the end of
 the destination file
Message-ID: <20200107175739.GC472651@magnolia>
References: <20191216182656.15624-1-fdmanana@kernel.org>
 <20191216182656.15624-2-fdmanana@kernel.org>
 <CAL3q7H5+CMRkJ9yAa2AeB0aKtA=b_yW2g9JSQwCOhOtLNrH1iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5+CMRkJ9yAa2AeB0aKtA=b_yW2g9JSQwCOhOtLNrH1iQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070141
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 04:23:15PM +0000, Filipe Manana wrote:
> On Mon, Dec 16, 2019 at 6:28 PM <fdmanana@kernel.org> wrote:
> >
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > We always round down, to a multiple of the filesystem's block size, the
> > length to deduplicate at generic_remap_check_len().  However this is only
> > needed if an attempt to deduplicate the last block into the middle of the
> > destination file is requested, since that leads into a corruption if the
> > length of the source file is not block size aligned.  When an attempt to
> > deduplicate the last block into the end of the destination file is
> > requested, we should allow it because it is safe to do it - there's no
> > stale data exposure and we are prepared to compare the data ranges for
> > a length not aligned to the block (or page) size - in fact we even do
> > the data compare before adjusting the deduplication length.
> >
> > After btrfs was updated to use the generic helpers from VFS (by commit
> > 34a28e3d77535e ("Btrfs: use generic_remap_file_range_prep() for cloning
> > and deduplication")) we started to have user reports of deduplication
> > not reflinking the last block anymore, and whence users getting lower
> > deduplication scores.  The main use case is deduplication of entire
> > files that have a size not aligned to the block size of the filesystem.
> >
> > We already allow cloning the last block to the end (and beyond) of the
> > destination file, so allow for deduplication as well.
> >
> > Link: https://lore.kernel.org/linux-btrfs/2019-1576167349.500456@svIo.N5dq.dFFD/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> Darrick, Al, any feedback?

Is there a fstest to check for correct operation of dedupe at or beyond
source and destfile EOF?  Particularly if one range is /not/ at EOF?
And that an mmap read of the EOF block will see zeroes past EOF before
and after the dedupe operation?

If I fallocate a 16k file, write 'X' into the first 5000 bytes,
write 'X' into the first 66,440 bytes (60k + 5000) of a second file, and
then try to dedupe (first file, 0-8k) with (second file, 60k-68k),
should that work?

I'm convinced that we could support dedupe to EOF when the ranges of the
two files both end at the respective file's EOF, but it's the weirder
corner cases that I worry about...

--D

> Thanks.
> 
> > ---
> >  fs/read_write.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index 5bbf587f5bc1..7458fccc59e1 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -1777,10 +1777,9 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
> >   * else.  Assume that the offsets have already been checked for block
> >   * alignment.
> >   *
> > - * For deduplication we always scale down to the previous block because we
> > - * can't meaningfully compare post-EOF contents.
> > - *
> > - * For clone we only link a partial EOF block above the destination file's EOF.
> > + * For clone we only link a partial EOF block above or at the destination file's
> > + * EOF.  For deduplication we accept a partial EOF block only if it ends at the
> > + * destination file's EOF (can not link it into the middle of a file).
> >   *
> >   * Shorten the request if possible.
> >   */
> > @@ -1796,8 +1795,7 @@ static int generic_remap_check_len(struct inode *inode_in,
> >         if ((*len & blkmask) == 0)
> >                 return 0;
> >
> > -       if ((remap_flags & REMAP_FILE_DEDUP) ||
> > -           pos_out + *len < i_size_read(inode_out))
> > +       if (pos_out + *len < i_size_read(inode_out))
> >                 new_len &= ~blkmask;
> >
> >         if (new_len == *len)
> > --
> > 2.11.0
> >
