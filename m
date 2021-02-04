Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B136030F380
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 13:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhBDMyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 07:54:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:55886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235605AbhBDMye (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:54:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91FF0AC43;
        Thu,  4 Feb 2021 12:53:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 001931E1518; Thu,  4 Feb 2021 13:53:50 +0100 (CET)
Date:   Thu, 4 Feb 2021 13:53:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Sascha Hauer <s.hauer@pengutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] quota: Add mountpath based quota support
Message-ID: <20210204125350.GD20183@quack2.suse.cz>
References: <20210128141713.25223-1-s.hauer@pengutronix.de>
 <20210128141713.25223-2-s.hauer@pengutronix.de>
 <20210128143552.GA2042235@infradead.org>
 <20210202180241.GE17147@quack2.suse.cz>
 <20210204073414.GA126863@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204073414.GA126863@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 04-02-21 07:34:14, Christoph Hellwig wrote:
> On Tue, Feb 02, 2021 at 07:02:41PM +0100, Jan Kara wrote:
> > Hum, let me think out loud. The path we pass to Q_QUOTAON is a path to
> > quota file - unless the filesystem stores quota in hidden files in which
> > case this argument is just ignored. You're right we could require that
> > specifically for Q_QUOTAON, the mountpoint path would actually need to
> > point to the quota file if it is relevant, otherwise anywhere in the
> > appropriate filesystem. We don't allow quota file to reside on a different
> > filesystem (for a past decade or so) so it should work fine.
> > 
> > So the only problem I have is whether requiring the mountpoint argument to
> > point quota file for Q_QUOTAON isn't going to be somewhat confusing to
> > users. At the very least it would require some careful explanation in the
> > manpage to explain the difference between quotactl_path() and quotactl()
> > in this regard. But is saving the second path for Q_QUOTAON really worth the
> > bother?
> 
> I find the doubled path argument a really horrible API, so I'd pretty
> strongly prefer to avoid that.

Honestly, I don't understand why is it so horrible. The paths point to
different things... The first path identifies the filesystem to operate on,
the second path identifies the file which contains quota accounting data.
In the ancient times, the file with quota accounting data could even be
stored on a different filesystem (these were still times when filesystem
metadata journalling was a new thing - like late 90's).  But later I just
disallowed that because it was not very useful (and luckily even used) and
just complicated matters.
 
Anyway, back to 2021 :). What I find somewhat confusing about a single path
for Q_QUOTAON is that for any other quotactl, any path on the filesystem is
fine. Similarly if quota data is stored in the hidden file, any path on the
filesystem is fine. It is only for Q_QUOTAON on a filesystem where quota
data is stored in a normal file, where we suddently require that the path
has to point to it.

Now quota data stored in a normal file is a setup we try to deprecate
anyway so another option is to just leave quotactl_path() only for those
setups where quota metadata is managed by the filesystem so we don't need
to pass quota files to Q_QUOTAON?

> > > Given how cheap quotactl_cmd_onoff and quotactl_cmd_write are we
> > > could probably simplify this down do:
> > > 
> > > 	if (quotactl_cmd_write(cmd)) {
> > 
> > This needs to be (quotactl_cmd_write(cmd) || quotactl_cmd_onoff(cmd)).
> > Otherwise I agree what you suggest is somewhat more readable given how
> > small the function is.
> 
> The way I read quotactl_cmd_write, it only special cases a few commands
> and returns 0 there, so we should not need the extra quotactl_cmd_onoff
> call, as all those commands are not explicitly listed.

Right, sorry, I was mistaken.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
