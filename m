Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700D43043A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 17:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391043AbhAZQTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 11:19:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:35982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392835AbhAZQTL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:19:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2EEAFACF5;
        Tue, 26 Jan 2021 16:18:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A22FF1E0879; Tue, 26 Jan 2021 17:18:29 +0100 (CET)
Date:   Tue, 26 Jan 2021 17:18:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Sascha Hauer <s.hauer@pengutronix.de>,
        linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20210126161829.GG10966@quack2.suse.cz>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
 <20210122151536.7982-2-s.hauer@pengutronix.de>
 <20210122171658.GA237653@infradead.org>
 <20210125083854.GB31738@pengutronix.de>
 <20210125154507.GH1175@quack2.suse.cz>
 <20210125204249.GA1103662@infradead.org>
 <20210126131752.GB10966@quack2.suse.cz>
 <20210126133406.GA1346375@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126133406.GA1346375@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-01-21 13:34:06, Christoph Hellwig wrote:
> On Tue, Jan 26, 2021 at 02:17:52PM +0100, Jan Kara wrote:
> > Well, I don't think that "wait until unfrozen" is that strange e.g. for
> > Q_SETQUOTA - it behaves like setxattr() or any other filesystem
> > modification operation. And IMO it is desirable that filesystem freezing is
> > transparent for operations like these. For stuff like Q_QUOTAON, I agree
> > that returning EBUSY makes sense but then I'm not convinced it's really
> > simpler or more useful behavior...
> 
> If we want it to behave like other syscalls we'll just need to throw in
> a mnt_want_write/mnt_drop_write pair.  Than it behaves exactly like other
> syscalls.

Right, we could do that. I'd just note that the "wait until unfrozen" and
holding of sb->s_umount semaphore is equivalent to
mnt_want_write/mnt_drop_write pair. But I agree
mnt_want_write/mnt_drop_write is easier to understand and there's no reason
not to use it. So I'm for that simplification in the new syscall.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
