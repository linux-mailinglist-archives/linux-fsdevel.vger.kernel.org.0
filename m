Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28534230612
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 11:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgG1JEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 05:04:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:32778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgG1JEi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:04:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C63AB5AC;
        Tue, 28 Jul 2020 09:04:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0F4D71E12C7; Tue, 28 Jul 2020 11:04:36 +0200 (CEST)
Date:   Tue, 28 Jul 2020 11:04:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fanotify: compare fsid when merging name event
Message-ID: <20200728090436.GC2318@quack2.suse.cz>
References: <20200728065108.26332-1-amir73il@gmail.com>
 <20200728074229.GA2318@quack2.suse.cz>
 <CAOQ4uxg+R0wGq6O_qCw2EmzgJbNjbTP_6V0sVoxvXf1O=SOdFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg+R0wGq6O_qCw2EmzgJbNjbTP_6V0sVoxvXf1O=SOdFA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 28-07-20 11:06:25, Amir Goldstein wrote:
> On Tue, Jul 28, 2020 at 10:42 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 28-07-20 09:51:08, Amir Goldstein wrote:
> > > This was missed when splitting name event from fid event
> > >
> > > Fixes: cacfb956d46e ("fanotify: record name info for FAN_DIR_MODIFY event")
> > > Cc: <stable@vger.kernel.org> # v5.7+
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > OK, but given we never enabled FAN_DIR_MODIFY in 5.7, this is just a dead
> > code there, isn't it? So it should be enough to fix this for the series
> > that's currently queued?
> 
> Doh! you are right.
> So you can just work it into the series and remove the explicit stable tag.
> If we leave the Fixes tag, stable bots will probably pick this up, but OTOH,
> there is no harm in applying the patch to stable kernel, so whatever.

Attached is what I have pushed to my tree.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--h31gzZEtNLTqOjlF
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-fanotify-compare-fsid-when-merging-name-event.patch"

From 8aed8cebdd973e95d20743e00e35467c7b467d0d Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 28 Jul 2020 10:58:07 +0200
Subject: [PATCH] fanotify: compare fsid when merging name event

When merging name events, fsids of the two involved events have to
match. Otherwise we could merge events from two different filesystems
and thus effectively loose the second event.

Backporting note: Although the commit cacfb956d46e introducing this bug
was merged for 5.7, the relevant code didn't get used in the end until
7e8283af6ede ("fanotify: report parent fid + name + child fid") which
will be merged with this patch. So there's no need for backporting this.

Fixes: cacfb956d46e ("fanotify: record name info for FAN_DIR_MODIFY event")
Reported-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fanotify/fanotify.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index bd9e88e889ea..c942910a8649 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -82,6 +82,9 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
 	if (!info1->dir_fh_totlen)
 		return false;
 
+	if (!fanotify_fsid_equal(&fne1->fsid, &fne2->fsid))
+		return false;
+
 	return fanotify_info_equal(info1, info2);
 }
 
-- 
2.16.4


--h31gzZEtNLTqOjlF--
