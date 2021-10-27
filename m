Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8718D43C87B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 13:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbhJ0LZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 07:25:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42786 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbhJ0LZK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 07:25:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CE3071FD3B;
        Wed, 27 Oct 2021 11:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635333763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xeo4tWojXaRyeV9lNeOTLkKRkzGCZZeeM1nu6FtoDMo=;
        b=GQH+bPd8mvMYWZUyrwYSJCHciPFVXkGCAGocBuVci9kLQ6yVUawaBnorhWIKXTbrr49QBn
        xgq+dy8+SSVpp/14yOxXg8ZDU7PsxvKw+e1Ci3nOP16ZGS8OxQycO40Me/EI2UfKfV2bkp
        BdzhAs7xpVlqH0mdHR7AgnWdTEwyDqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635333763;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xeo4tWojXaRyeV9lNeOTLkKRkzGCZZeeM1nu6FtoDMo=;
        b=+mPJrTFfhPKbdqDrBGxBaIrno+dpiT8rN3/njrhK85pDR05IwGconbjzv8lVhYuXteIWjd
        RBcFjYwA3Y1XASAA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id B63A3A3B83;
        Wed, 27 Oct 2021 11:22:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 917271F2C66; Wed, 27 Oct 2021 13:22:43 +0200 (CEST)
Date:   Wed, 27 Oct 2021 13:22:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v9 00/31] file system-wide error monitoring
Message-ID: <20211027112243.GE28650@quack2.suse.cz>
References: <20211025192746.66445-1-krisman@collabora.com>
 <CAOQ4uxhth8NP4hS53rhLppK9_8ET41yrAx5d98s1uhSqrSzVHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhth8NP4hS53rhLppK9_8ET41yrAx5d98s1uhSqrSzVHg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-10-21 12:12:38, Amir Goldstein wrote:
> On Mon, Oct 25, 2021 at 10:27 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Hi,
> >
> > This is the 9th version of this patch series.  Thank you, Amir, Jan and
> > Ted, for the feedback in the previous versions.
> >
> > The main difference in this version is that the pool is no longer
> > resizeable nor limited in number of marks, even though we only
> > pre-allocate 32 slots.  In addition, ext4 was modified to always return
> > non-zero errno, and the documentation was fixed accordingly (No longer
> > suggests we return EXT4_ERR* values.
> >
> > I also droped the Reviewed-by tags from the ext4 patch, due to the
> > changes above.
> >
> > Please let me know what you think.
> >
> 
> All good on my end.
> I've made a couple of minor comments that
> could be addressed on commit if no other issues are found.

All good on my end as well. I've applied all the minor updates, tested the
result and pushed it out to fsnotify branch of my tree. WRT to your new
FS_ERROR LTP tests, I've noticed that the testcases 1 and 3 from test
fanotify20 fail for me. After a bit of debugging this seems to be a bug in
ext4 where it calls ext4_abort() with EXT4_ERR_ESHUTDOWN instead of plain
ESHUTDOWN. Not sure if you have that fixed or how come the tests passed for
you. After fixing that ext4 bug everything passes for me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
