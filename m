Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D55522F5D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgG0QwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbgG0QwR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:52:17 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 138AF20719;
        Mon, 27 Jul 2020 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595868737;
        bh=Rd0yXJxM1FZV2AkKPP2w284CplJp2APSP/Ajct3yKQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6Ei18zs+qrut1A39M6wgC5rrS5mOrbqutkkGin1Snx5fZdNkwTDur3EaWxhm97jn
         n0RtL8vd3MAwWfTuY0qCdOWljf9ED3bvuVB8/tLl5UZD8NOqbBInhlSQHd/ss2H5oq
         jrvY7WxeP0D27Bo7cD2y6Q0TeTB12MvB2LilSQZM=
Date:   Mon, 27 Jul 2020 09:52:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        syzbot+187510916eb6a14598f7@syzkaller.appspotmail.com
Subject: Re: [PATCH] reiserfs: only call unlock_new_inode() if I_NEW
Message-ID: <20200727165215.GI1138@sol.localdomain>
References: <20200628070057.820213-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628070057.820213-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 28, 2020 at 12:00:57AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> unlock_new_inode() is only meant to be called after a new inode has
> already been inserted into the hash table.  But reiserfs_new_inode() can
> call it even before it has inserted the inode, triggering the WARNING in
> unlock_new_inode().  Fix this by only calling unlock_new_inode() if the
> inode has the I_NEW flag set, indicating that it's in the table.
> 
> This addresses the syzbot report "WARNING in unlock_new_inode"
> (https://syzkaller.appspot.com/bug?extid=187510916eb6a14598f7).
> 
> Reported-by: syzbot+187510916eb6a14598f7@syzkaller.appspotmail.com
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Anyone interested in taking this patch?

- Eric
