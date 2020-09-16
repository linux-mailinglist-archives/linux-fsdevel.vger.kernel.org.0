Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F066226BB35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 06:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIPEBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 00:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgIPEBU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 00:01:20 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9941121D1B;
        Wed, 16 Sep 2020 04:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600228879;
        bh=X8wXCrHwg8qTRjJeeDa4WPSRGx8yGWNAx7/mtcme7zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WB3ZVtqPk5D/h4gKkIuCLaImnHFkzEIZCcdhD+x0br2wD9fjD/lGleHExEs5uQk/i
         tEpB19F5wN5+ASIBZiwgBMw/VtpmaFp7ORjR7QeX5S+9bzHBRzD6OV7z9Rzii4iicb
         YKSVSWa3xJcbqul4YbKbB8Gaz2EIXuZW/03MoOv4=
Date:   Tue, 15 Sep 2020 21:01:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.com>
Cc:     reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+187510916eb6a14598f7@syzkaller.appspotmail.com
Subject: Re: [PATCH] reiserfs: only call unlock_new_inode() if I_NEW
Message-ID: <20200916040118.GB825@sol.localdomain>
References: <20200628070057.820213-1-ebiggers@kernel.org>
 <20200727165215.GI1138@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727165215.GI1138@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 09:52:15AM -0700, Eric Biggers wrote:
> On Sun, Jun 28, 2020 at 12:00:57AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > unlock_new_inode() is only meant to be called after a new inode has
> > already been inserted into the hash table.  But reiserfs_new_inode() can
> > call it even before it has inserted the inode, triggering the WARNING in
> > unlock_new_inode().  Fix this by only calling unlock_new_inode() if the
> > inode has the I_NEW flag set, indicating that it's in the table.
> > 
> > This addresses the syzbot report "WARNING in unlock_new_inode"
> > (https://syzkaller.appspot.com/bug?extid=187510916eb6a14598f7).
> > 
> > Reported-by: syzbot+187510916eb6a14598f7@syzkaller.appspotmail.com
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Anyone interested in taking this patch?

Jan, you seem to be taking some reiserfs patches... Any interest in taking this
one?

- Eric
