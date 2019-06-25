Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D28654CE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 12:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfFYK6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 06:58:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34410 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfFYK6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w1VYtukMDFjClOBWrgBSEg29TnKHWzUm3jllxU3LtVU=; b=rtyLtNjDw4p6TnPt3CncrQp7X
        Yig8xdu1UY0SGixxHVqiAUm4+cZrSK5chsUKK9EMREb+mlNfL9i+ASyJtGUl9lbRpApvZxGV6jgM8
        CvJ01GtDiZvoVuwXj6AwcDh4cc8+cSuWzIQrsaZNRIdKkaxStTj45iVZnU96w90FX3npVKivwPQEp
        LBlgmJK0t12LzaGtFfBZ3+6X6fbsF6fndebssjuzYDk0YQqRc2Eg5hv1jmmklxbKVcTpnNb2++kCp
        EUgN7ABdtwwvX787EWwMu7qEOjjyXSgk6EygJw0HsQtj3+auaeg9xRyyL026ARdwIQi/Ag6aNi+qj
        l/lkg6fsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hfj8f-0000HH-M9; Tue, 25 Jun 2019 10:57:25 +0000
Date:   Tue, 25 Jun 2019 03:57:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        shaggy@kernel.org, ard.biesheuvel@linaro.org, josef@toxicpanda.com,
        clm@fb.com, adilger.kernel@dilger.ca, jk@ozlabs.org, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, viro@zeniv.linux.org.uk,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-efi@vger.kernel.org, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] vfs: create a generic checking function for
 FS_IOC_FSSETXATTR
Message-ID: <20190625105725.GB26085@infradead.org>
References: <156116136742.1664814.17093419199766834123.stgit@magnolia>
 <156116138952.1664814.16552129914959122837.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156116138952.1664814.16552129914959122837.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 21, 2019 at 04:56:29PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Create a generic checking function for the incoming FS_IOC_FSSETXATTR
> fsxattr values so that we can standardize some of the implementation
> behaviors.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/btrfs/ioctl.c   |   21 +++++++++-------
>  fs/ext4/ioctl.c    |   27 ++++++++++++++------
>  fs/f2fs/file.c     |   26 ++++++++++++++-----
>  fs/inode.c         |   17 +++++++++++++
>  fs/xfs/xfs_ioctl.c |   70 ++++++++++++++++++++++++++++++----------------------
>  include/linux/fs.h |    3 ++
>  6 files changed, 111 insertions(+), 53 deletions(-)
> 
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index f408aa93b0cf..7ddda5b4b6a6 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -366,6 +366,13 @@ static int check_xflags(unsigned int flags)
>  	return 0;
>  }
>  
> +static void __btrfs_ioctl_fsgetxattr(struct btrfs_inode *binode,
> +				     struct fsxattr *fa)
> +{
> +	memset(fa, 0, sizeof(*fa));
> +	fa->fsx_xflags = btrfs_inode_flags_to_xflags(binode->flags);

Is there really much of a point in this helper? Epeciall as
the zeroing could easily be done in the variable declaration
line using

	struct fsxattr fa = { };

> +	memset(fa, 0, sizeof(struct fsxattr));
> +	fa->fsx_xflags = ext4_iflags_to_xflags(ei->i_flags & EXT4_FL_USER_VISIBLE);

Overly lone line.

> +	if (ext4_has_feature_project(inode->i_sb)) {
> +		fa->fsx_projid = (__u32)from_kprojid(&init_user_ns,
> +				ei->i_projid);

The cast here looks bogus.  Same comment for f2fs.
