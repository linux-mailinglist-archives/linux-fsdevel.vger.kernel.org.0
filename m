Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C041E0811
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbgEYHbn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 03:31:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:59820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388947AbgEYHbn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 03:31:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0A307B084;
        Mon, 25 May 2020 07:31:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9515D1E1270; Mon, 25 May 2020 09:31:40 +0200 (CEST)
Date:   Mon, 25 May 2020 09:31:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Martijn Coenen <maco@android.com>
Cc:     Jan Kara <jack@suse.cz>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, miklos@szeredi.hu, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Subject: Re: Writeback bug causing writeback stalls
Message-ID: <20200525073140.GI14199@quack2.suse.cz>
References: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
 <20200522144100.GE14199@quack2.suse.cz>
 <CAB0TPYF+Nqd63Xf_JkuepSJV7CzndBw6_MUqcnjusy4ztX24hQ@mail.gmail.com>
 <20200522153615.GF14199@quack2.suse.cz>
 <CAB0TPYGJ6WkaKLoqQhsxa2FQ4s-jYKkDe1BDJ89CE_QUM_aBVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYGJ6WkaKLoqQhsxa2FQ4s-jYKkDe1BDJ89CE_QUM_aBVw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 23-05-20 10:15:20, Martijn Coenen wrote:
> Jaegeuk wondered whether callers of write_inode_now() should hold
> i_rwsem, and whether that would also prevent this problem. Some
> existing callers of write_inode_now() do, eg ntfs and hfs:
> 
> hfs_file_fsync()
>     inode_lock(inode);
> 
>     /* sync the inode to buffers */
>     ret = write_inode_now(inode, 0);
> 
> but there are also some that don't (eg fat, fuse, orangefs).

Well, most importantly filesystems like ext4, xfs, btrfs don't hold i_rwsem
when writing back inode and that's deliberate because of performance. We
don't want to block writes (or event reads in case of XFS) for the inode
during writeback.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
