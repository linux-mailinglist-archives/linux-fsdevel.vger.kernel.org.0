Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43BD91500B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 04:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBCDUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Feb 2020 22:20:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38494 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgBCDUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Feb 2020 22:20:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so7026106pgm.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Feb 2020 19:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Za5Sr8YzwMTkDYP6x/gVgtusvcyP37eHqgzHf18f+NM=;
        b=tpip8nRwJ4mmGSf1Kzj97uoTolWxd0lpFk32P8C2T7TsVXT5I2iCbK0LyzrgTm3j0M
         vFllRrMUj7O1AtcG0A1jPyTOUxIqCg4jcJ8VQZvInE0Ahm2578JLSeK4oM6gbRL02yH6
         mGmQUHTFZ/jMYC/UTPRerDd7IolJzR61nPFjFxJRl+lsLFTh2abdUTPGN6vu7QyJztAI
         BxNJ8L9Tf3IE/GNBcFUj9HlUyzd/pZxgrAbAx86h1oiI967CbL5WrxQfJlxxEXAl8Whd
         R+x4JzJUu5hKzPdkHZ4B0Ry9lOsBgZ/BM4hFIE44RJp59w+Qdba4RIgN394+JLFONKRC
         QFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Za5Sr8YzwMTkDYP6x/gVgtusvcyP37eHqgzHf18f+NM=;
        b=VVzAUBbfNp6jZg3PDxuY9qHVUKXlV84p3V5m1kPMXCM5qVnqWm+hEMGkeWkj/fZTDj
         +ucLxIhz5I+JovqO2B1HBuntXHmAqq7tfH9aJzEv9jveAv55p0N7F+JenU1F70oD5yeD
         Aw1GeQWcW9dnZWz1O3ACuPCEFU2vb1vugPSfh9DBHBy0ih2IvgLeMxAFAq9tZU8/I4Nr
         oNoZw/utalX45qohs4Jv3oK1Le/43cNelfZN1XuAUCbEQJkll/XPXONcjAHoqR7MehOd
         1MhDG7BXseWYMw/O0pC0c2RcWiCbnO8ABXhmdotQdJWVe7eJZzsta08Ib6dfsV43y0n8
         3TLw==
X-Gm-Message-State: APjAAAVaxaKV83A7A8aJrhEjRd5smyrgeXG6JUDDyZhgiX5xydjAwftq
        ddfZWWja73roDkdcarrlkN8=
X-Google-Smtp-Source: APXvYqzRDkZlDccuvljSVGl3/k3E+kojcy7lqZPa1HIxcvfHlFhEcf0D9AuwnM5M2p5zABlcCT8sTA==
X-Received: by 2002:a63:f744:: with SMTP id f4mr10621024pgk.345.1580700015244;
        Sun, 02 Feb 2020 19:20:15 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id o1sm8847459pfg.60.2020.02.02.19.20.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 02 Feb 2020 19:20:14 -0800 (PST)
Date:   Mon, 3 Feb 2020 11:20:12 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fuse: fix inode rwsem regression
Message-ID: <20200203032012.GA11846@cqw-OptiPlex-7050>
References: <1580536171-27838-1-git-send-email-qiwuchen55@gmail.com>
 <668fc86f-4214-f315-9b41-40368ba91022@fastmail.fm>
 <20200202020817.GA14887@cqw-OptiPlex-7050>
 <aafd8abf-832b-6348-7b74-4d65451a1eb6@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aafd8abf-832b-6348-7b74-4d65451a1eb6@fastmail.fm>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 02, 2020 at 10:18:58PM +0100, Bernd Schubert wrote:
> 
> 
> On 2/2/20 3:08 AM, chenqiwu wrote:
> > On Sun, Feb 02, 2020 at 12:09:50AM +0100, Bernd Schubert wrote:
> >>
> >>
> >> On 2/1/20 6:49 AM, qiwuchen55@gmail.com wrote:
> >>> From: chenqiwu <chenqiwu@xiaomi.com>
> >>>
> >>> Apparently our current rwsem code doesn't like doing the trylock, then
> >>> lock for real scheme.  So change our direct write method to just do the
> >>> trylock for the RWF_NOWAIT case.
> >>> This seems to fix AIM7 regression in some scalable filesystems upto ~25%
> >>> in some cases. Claimed in commit 942491c9e6d6 ("xfs: fix AIM7 regression")
> >>>
> >>> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> >>> ---
> >>>  fs/fuse/file.c | 8 +++++++-
> >>>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >>> index ce71538..ac16994 100644
> >>> --- a/fs/fuse/file.c
> >>> +++ b/fs/fuse/file.c
> >>> @@ -1529,7 +1529,13 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >>>  	ssize_t res;
> >>>  
> >>>  	/* Don't allow parallel writes to the same file */
> >>> -	inode_lock(inode);
> >>> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> >>> +		if (!inode_trylock(inode))
> >>> +			return -EAGAIN;
> >>> +	} else {
> >>> +		inode_lock(inode);
> >>> +	}
> >>> +
> >>>  	res = generic_write_checks(iocb, from);
> >>>  	if (res > 0) {
> >>>  		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
> >>>
> >>
> >>
> >> I would actually like to ask if we can do something about this lock
> >> altogether. Replace it with a range lock?  This very lock badly hurts
> >> fuse shared file performance and maybe I miss something, but it should
> >> be needed only for writes/reads going into the same file?
> >>
> > I think replacing the internal inode rwsem with a range lock maybe not
> > a good idea, because it may cause potential block for different writes/reads
> > routes when this range lock is owned by someone. Using internal inode rwsem
> > can avoid this range racy.
> > 
> 
> So your 2nd patch changes to rw-locks and should solve low read
> direct-io performance, but single shared file writes is still an issue.
> For network file systems it also common to globally enforce fuse
> direct-io to reduce/avoid cache coherency issues - the application
> typically doesn't ask for that on its own. And that is where this lock
> is badly hurting.  Hmm, maybe we should differentiate between
> fuse-internal direct-io and application direct-io requests here? Or we
> need a range lock,that supports shared readers (I haven't looked at any
> of the proposed range lock patches yet (non has landed yet, right?).
>
There is a recent fix for ext4 and we can evaluate and apply it to fuse
filesytem for solving low dio-write performance.
aa9714d0e(ext4: Start with shared i_rwsem in case of DIO instead of exclusive)

Thanks!
Qiwu
