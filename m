Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CC838E2B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 10:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhEXIuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 04:50:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:33584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232623AbhEXIum (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 04:50:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621846152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jpE9YGrCjrEpHsW3uIKMlS6XsBu4wdObU8VGSrpMBhU=;
        b=TQSoNE8TH8Qw/0nXV4p4prxRuZHyAGLtNsnT71NNZvBuaWH1gbkvAxRXfDZgQA8sIbDwma
        5gMLetD5QwQVxTGM2c7fk/d+RT5EF66jMlM8U4RxKXXYtVeZzdFGJ6Zcji4MFCaQgiWwIX
        DNVbY0eJfqLQwXRIWG6U1KWtOzPfoKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621846152;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jpE9YGrCjrEpHsW3uIKMlS6XsBu4wdObU8VGSrpMBhU=;
        b=9CU/XjoMjdxhBrK3qpgq8XzBbWs1+NP4iDMf3mat82Qp4+bb6af3LxjTm6UrVH0MarzXe2
        XdS5UarcZ3H309CA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B955EABB1;
        Mon, 24 May 2021 08:49:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7E08C1F2CA2; Mon, 24 May 2021 10:49:12 +0200 (CEST)
Date:   Mon, 24 May 2021 10:49:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 0/2] quota: Add mountpath based quota support
Message-ID: <20210524084912.GC32705@quack2.suse.cz>
References: <20210304123541.30749-1-s.hauer@pengutronix.de>
 <20210316112916.GA23532@quack2.suse.cz>
 <20210512110149.GA31495@quack2.suse.cz>
 <20210512150346.GQ19819@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512150346.GQ19819@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 12-05-21 17:03:46, Sascha Hauer wrote:
> On Wed, May 12, 2021 at 01:01:49PM +0200, Jan Kara wrote:
> > Added a few more CCs.
> > 
> > On Tue 16-03-21 12:29:16, Jan Kara wrote:
> > > On Thu 04-03-21 13:35:38, Sascha Hauer wrote:
> > > > Current quotactl syscall uses a path to a block device to specify the
> > > > filesystem to work on which makes it unsuitable for filesystems that
> > > > do not have a block device. This series adds a new syscall quotactl_path()
> > > > which replaces the path to the block device with a mountpath, but otherwise
> > > > behaves like original quotactl.
> > > > 
> > > > This is done to add quota support to UBIFS. UBIFS quota support has been
> > > > posted several times with different approaches to put the mountpath into
> > > > the existing quotactl() syscall until it has been suggested to make it a
> > > > new syscall instead, so here it is.
> > > > 
> > > > I'm not posting the full UBIFS quota series here as it remains unchanged
> > > > and I'd like to get feedback to the new syscall first. For those interested
> > > > the most recent series can be found here: https://lwn.net/Articles/810463/
> > > 
> > > Thanks. I've merged the two patches into my tree and will push them to
> > > Linus for the next merge window.
> > 
> > So there are some people at LWN whining that quotactl_path() has no dirfd
> > and flags arguments for specifying the target. Somewhat late in the game
> > but since there's no major release with the syscall and no userspace using
> > it, I think we could still change that. What do you think? What they
> > suggest does make some sense. But then, rather then supporting API for
> > million-and-one ways in which I may wish to lookup a fs object, won't it be
> > better to just pass 'fd' in the new syscall (it may well be just O_PATH fd
> > AFAICT) and be done with that?
> 
> This sounds like a much cleaner interface to me. If we agree on this I
> wouldn't mind spinning this patch for another few rounds.

So the syscall is currently disabled in Linus' tree. Will you send a patch
for new fd-based quotactl variant?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
