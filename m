Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9025D2F1FD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 20:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391135AbhAKTvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 14:51:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388625AbhAKTvJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:51:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0614B22BEF;
        Mon, 11 Jan 2021 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610394629;
        bh=TKB/HnyGkf9UFm9NR/3BttEtk/tszaUH5WZ2/H0H1lU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4gqn+mXwYxCAS6/xTYdzruo7QoknLSjAmGIppZ+evtXmbHvhh0iA5LTXjTPiaPFS
         usyjcJJU6it4DZACHXghcAR4uGoUK4KGA8f6tvgGgHAbfqaVH+0Dzcl5GLCgVItq39
         oplzpqms5sfjB8gtZb/clVe1D+93CqcZwbLH3iT2/ZbJbauAtNiAAeY5WH89Eo1SlP
         T6eZ3vyGEU9JiMVr59ZzArKNKHNuJgNm3X/VKbSeJlTOxlX3qwejyUOJ2JSynJQ1il
         8WPYmluN055p6mj+TjN1avqozbCl1YGDv894Ylp3KtTK6Br83jCBWoGMDPxpxG9+Zd
         htCAc3VlPQinw==
Date:   Mon, 11 Jan 2021 11:50:27 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 04/12] fat: only specify I_DIRTY_TIME when needed in
 fat_update_time()
Message-ID: <X/ysA8PuJ/+JXQYL@sol.localdomain>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-5-ebiggers@kernel.org>
 <20210111105201.GB2502@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111105201.GB2502@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:52:01AM +0100, Christoph Hellwig wrote:
> On Fri, Jan 08, 2021 at 11:58:55PM -0800, Eric Biggers wrote:
> > +	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> > +		dirty_flags |= I_DIRTY_SYNC;
> 
> fat does not support i_version updates, so this bit can be skipped.

Is that really the case?  Any filesystem (including fat) can be mounted with
"iversion", which causes SB_I_VERSION to be set.

A lot of filesystems (including fat) don't store i_version to disk, but it looks
like it will still get updated in-memory.  Could anything be relying on that?

- Eric
