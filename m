Return-Path: <linux-fsdevel+bounces-21943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1470790FB8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 05:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4AA283BD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 03:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5391F1EA8F;
	Thu, 20 Jun 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZUxBfA6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F421B5A4
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853067; cv=none; b=eyf4I4Kor6lsMcGmwSLnkv/YyZC6ZhWW4K+drQfssssloctMgHgPMcqDycuJ1Tjet0lbXnADVzg0qOWeDCTxR0vMBhe3WlrnyNdTR+7mqb7YZ1dUaO0zl8pUu7o6FqW+PMdas28Y5h8UMRBfHN5ao5Wb24GRhoUT56ogVh3Y/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853067; c=relaxed/simple;
	bh=5p2AxTpd6a7PLUWBmgpHc9QVaSepe1mn04sFi4sCfs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUtaIrz7MA4NvnESFa9DiOqlvJu4huiPzRMLDYnHZEKe/FB6nTE2WZqLB99Kfz1MK6fvShQYy523xKLydNyTq+6IOj8Qc6FA6ih4/rbFZYG6CdcPhVypRjkKDgWJM3j5qyNZvmox3NDwMu7T+ALVs/QpyatSxpa7QVISaOY9HRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZUxBfA6y; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-120-239.bstnma.fios.verizon.net [173.48.120.239])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45K3AiwE018591
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 23:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718853047; bh=g7jNV9Cch3yWVsexAfH6zCU1DoH+Ax54DSdo/kLyfxE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ZUxBfA6y2N9fJZUSjlXGc3tKi4ncCs1jrgYZtLm39X37cEjMuFB8C98+lXHZbzIW9
	 aJPv+0pYur2YYLa22Cf2Bwiz0rF71Sz6173g7mPjjbjTJ2b9aRs06Wak6dIcpvzT6C
	 6QFdxKUJ0CUKqjCUEEtTZ0RhUdWwJeG0ivhHhAZENIR/WXADkJQpJIzfpeSWr/xq+u
	 NGMmqJN5IHLZFhm9tjCD/p4DEQM3JeBmDAZjo72nLaJutjo24TsBnfXMW6YM7BLUwU
	 UYwExbBJHn8DiPzF66WSh+ydqlcepuBXlUTXsFpbWuIGMjrgjAM3mmz3rQcXZeUUwZ
	 SoGOa63BCdKbg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 43DE615C0579; Wed, 19 Jun 2024 23:10:44 -0400 (EDT)
Date: Wed, 19 Jun 2024 23:10:44 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+ee72b9a7aad1e5a77c5c@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ext4: fix deadlock in ext4_xattr_inode_iget
Message-ID: <20240620031044.GB1553731@mit.edu>
References: <000000000000163e1406152c6877@google.com>
 <tencent_9E9EB81B474B0E1B23256EBA05BB79332408@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_9E9EB81B474B0E1B23256EBA05BB79332408@qq.com>

On Thu, Apr 04, 2024 at 09:54:02AM +0800, Edward Adam Davis wrote:
> According to mark inode dirty context, it does not need to be protected by lock
> i_data_sem, and if it is protected by i_data_sem, a deadlock will occur.

The i_data_sem lock is not to protect mark_inode_dirty_context, but to
avoid races with the writeback code, which you can see right before
you added the down_write() line.

More detail about why it is necessary can be found in commit
90e775b71ac4 ("ext4: fix lost truncate due to race with writeback"):

    The following race can lead to a loss of i_disksize update from truncate
    thus resulting in a wrong inode size if the inode size isn't updated
    again before inode is reclaimed:
    
    ext4_setattr()                          mpage_map_and_submit_extent()
      EXT4_I(inode)->i_disksize = attr->ia_size;
      ...                                     ...
                                              disksize = ((loff_t)mpd->first_page) << PAGE_CACHE_SHIFT
                                              /* False because i_size isn't
                                               * updated yet */
                                              if (disksize > i_size_read(inode))
                                              /* True, because i_disksize is
                                               * already truncated */
                                              if (disksize > EXT4_I(inode)->i_disksize)
                                                /* Overwrite i_disksize
                                                 * update from truncate */
                                                ext4_update_i_disksize()
      i_size_write(inode, attr->ia_size);
    
    For other places updating i_disksize such race cannot happen because
    i_mutex prevents these races. Writeback is the only place where we do
    not hold i_mutex and we cannot grab it there because of lock ordering.
    
    We fix the race by doing both i_disksize and i_size update in truncate
    Atomically under i_data_sem and in mpage_map_and_submit_extent() we move
    the check against i_size under i_data_sem as well.

So your proposed fix would introduce a regression by re-enabling the
bug which is fixed by commit 90e775b71ac4.

In any case, as Andreas has pointed out, this is a false positive; the
supposed deadlock involves an ea_inode in stack trace #0, whereas the
stack trace #1 involves a write to a data inode.  Andreas has
suggested fixing this by annotating the lock appropriately.  This case
is not going to happen in real production systems today, since
triggering it requires using the debugging mount option
debug_want_extra_isize.

So while it would be good to avoid the false positive lockdep warning,
fixing this is a lower priority bug --- it certainly isn't security
issue that syzbot developers like to point at when talking about the
"Linux security disaster".  It isn't even a real production level bug!

Cheers,

      	       		  	     - Ted

