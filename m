Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C7C10D899
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 17:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfK2QgB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 11:36:01 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:44102 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfK2QgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 11:36:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A3CB6607BDB2;
        Fri, 29 Nov 2019 17:35:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kOcQPONK-3hk; Fri, 29 Nov 2019 17:35:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D5E1B6083139;
        Fri, 29 Nov 2019 17:35:53 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Au7ORLC9cK4z; Fri, 29 Nov 2019 17:35:53 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8329F607BDB2;
        Fri, 29 Nov 2019 17:35:53 +0100 (CET)
Date:   Fri, 29 Nov 2019 17:35:53 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Darrick <darrick.wong@oracle.com>,
        torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>, tytso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <51833696.101442.1575045353332.JavaMail.zimbra@nod.at>
In-Reply-To: <20191129142045.7215-1-agruenba@redhat.com>
References: <20191129142045.7215-1-agruenba@redhat.com>
Subject: Re: [PATCH v2] fs: Fix page_mkwrite off-by-one errors
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix page_mkwrite off-by-one errors
Thread-Index: OwUcLuBZ37Awg+4d3rXFBEMLhx0YIg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Andreas Gruenbacher" <agruenba@redhat.com>
> An: "Christoph Hellwig" <hch@infradead.org>, "Darrick" <darrick.wong@oracle.com>
> CC: "Andreas Gruenbacher" <agruenba@redhat.com>, "torvalds" <torvalds@linux-foundation.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "Jeff Layton" <jlayton@kernel.org>, "Sage Weil"
> <sage@redhat.com>, "Ilya Dryomov" <idryomov@gmail.com>, "tytso" <tytso@mit.edu>, "Andreas Dilger"
> <adilger.kernel@dilger.ca>, "Jaegeuk Kim" <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>, linux-xfs@vger.kernel.org,
> "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "richard" <richard@nod.at>, "Artem Bityutskiy" <dedekind1@gmail.com>,
> "Adrian Hunter" <adrian.hunter@intel.com>, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
> linux-f2fs-devel@lists.sourceforge.net, "linux-mtd" <linux-mtd@lists.infradead.org>, "Chris Mason" <clm@fb.com>, "Josef
> Bacik" <josef@toxicpanda.com>, "David Sterba" <dsterba@suse.com>, "linux-btrfs" <linux-btrfs@vger.kernel.org>
> Gesendet: Freitag, 29. November 2019 15:20:45
> Betreff: [PATCH v2] fs: Fix page_mkwrite off-by-one errors

> The check in block_page_mkwrite meant to determine whether an offset is
> within the inode size is off by one.  This bug has spread to
> iomap_page_mkwrite and to several filesystems (ubifs, ext4, f2fs, ceph).
> To fix that, introduce a new page_mkwrite_check_truncate helper that
> checks for truncate and computes the bytes in the page up to EOF, and
> use that helper in the above mentioned filesystems and in btrfs.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Thank you for fixing UBIFS!

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
