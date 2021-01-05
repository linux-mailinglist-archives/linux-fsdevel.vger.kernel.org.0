Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A800F2EAC44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 14:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbhAENrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 08:47:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:44022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730266AbhAENrM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:47:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 070CFAE61;
        Tue,  5 Jan 2021 13:46:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D249A1E07FD; Tue,  5 Jan 2021 14:46:30 +0100 (CET)
Date:   Tue, 5 Jan 2021 14:46:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, yangerkun@huawei.com,
        yi.zhang@huawei.com, linfeilong@huawei.com
Subject: Re: [RFC PATCH RESEND] fs: fix a hungtask problem when
 freeze/unfreeze fs
Message-ID: <20210105134630.GB15080@quack2.suse.cz>
References: <20201226095641.17290-1-luoshijie1@huawei.com>
 <20201226155500.GB3579531@ZenIV.linux.org.uk>
 <870c4a20-ac5e-c755-fe8c-e1a192bffb29@huawei.com>
 <20210104160457.GG4018@quack2.suse.cz>
 <b0187d7d-cd4f-0cda-ea32-8c05b7e9b592@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0187d7d-cd4f-0cda-ea32-8c05b7e9b592@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 05-01-21 10:48:48, Shijie Luo wrote:
> Hi!
> 
> On 2021/1/5 0:04, Jan Kara wrote:
> > > Consuming the reference here because we won't "set frozen =
> > > SB_FREEZE_COMPLETE" in thaw_super_locked() now.
> > > 
> > > If don't do that, we never have a chance to consume it, thaw_super_locked()
> > > will directly return "-EINVAL". But I do
> > > 
> > > agree that it's not a good idea to return 0. How about returning "-EINVAL or
> > > -ENOTSUPP" ?
> > > 
> > > And, If we keep "frozen = SB_FREEZE_COMPLETE" in freeze_super() here, it
> > > will cause another problem, thaw_super_locked()
> > > 
> > > will always release rwsems in my logic, but freeze_super() won't acquire the
> > > rwsems when filesystem is read-only.
> > I was thinking about this for a while. I think the best solution would be
> > to track whether the fs was read only (and thus frozen without locking
> > percpu semaphores) at the time of freezing. I'm attaching that patch. Does
> > it fix your problem?
> > 
> > 									Honza
> 
> I tested your patch, and it can indeed fix this deadlock problem.

Thanks for testing! I've sent the patch to Al for inclusion.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
