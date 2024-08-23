Return-Path: <linux-fsdevel+bounces-26881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7D295C7DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 10:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C83289683
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7BF1422CA;
	Fri, 23 Aug 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCSZGEWQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79513B2A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400993; cv=none; b=riKyLFPQX7WLoUi4EITRbnri4O9673eGUPUJ3Gu5bAqU8mlcsx5OFUmULZEKjXeR+NTODMfuG1pSyPcIRGr9lEnIGFhiPIyOzAcY9WWWhidkuXZeMyvw9K8uBXeLR4eFHNQNCHOgJjsaNG9NO23TMhgT3NvFEnZdqK83+2/FNvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400993; c=relaxed/simple;
	bh=NvoktKRp8l2IwTNc1dikxznUe8KSIKaFfDUKpL1nWrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCMBjT18ZbwukA2NkiA/0nrWcTK7YIshJYbnB0fsItqknlPQJObkk1yjaVEytcstYVkjmHvNCwFANwkYRB1NjbEGX+7Gboyz7knuIGCH1HRwsGKOQvJf1ixzF/Sidu4psqMG7ce0i+p9o/IxFidCNynizcPsvzehG5046WZmV/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCSZGEWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C43AC32786;
	Fri, 23 Aug 2024 08:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724400993;
	bh=NvoktKRp8l2IwTNc1dikxznUe8KSIKaFfDUKpL1nWrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCSZGEWQzjcD9gxiORtkcqD0mp9xmM4B9xjy9eHQDysurCf7Y4zeyIwfAOgV5ziw+
	 HsWjlB/7kAxps/SMuc1FDapV4E3CFLmHsAp75MoDiM4HnGo89F4nfi1cVSa3VVbc6T
	 PYZqvQBh9EHer4UMLz20hqTqeTUQ4uAZg+io/WgPpl1xgSSaW8br3nBBD5fsYsLiQ6
	 /LLJGMjiOf4RT8thyiUgN8eCvvWL8MgBGkLJc8dvJpyx1yxHpoG/kU7MrCWqcUYo3K
	 h6a0xLkaGC4BHFnSCHbSRCIqBNdui5s5nQr/vyCJHvCxrZJ6x9Hc6/QUuwFAjbUOeK
	 WZ2IC606EcjFA==
Date: Fri, 23 Aug 2024 10:16:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: switch f_iocb_flags and f_version
Message-ID: <20240823-luftdicht-berappen-d69a2166a0db@brauner>
References: <20240822-mutig-kurznachrichten-68d154f25f41@brauner>
 <19488597-8585-4875-8fa5-732f5cd9f2ee@kernel.dk>
 <20240822-soviel-rohmaterial-210aef53569b@brauner>
 <47187d8f-483b-45e6-a2be-ea7826bebb62@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dkh3nrolmgchewwv"
Content-Disposition: inline
In-Reply-To: <47187d8f-483b-45e6-a2be-ea7826bebb62@kernel.dk>


--dkh3nrolmgchewwv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Aug 22, 2024 at 10:17:37AM GMT, Jens Axboe wrote:
> On 8/22/24 9:10 AM, Christian Brauner wrote:
> >> Do we want to add a comment to this effect? I know it's obvious from
> >> sharing with f_task_work, but...
> > 
> > I'll add one.
> 
> Sounds good. You can add my:
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> 
> as well, forgot to mention that in the original reply.

I think we can deliver 192 bytes aka 3 cachelines.
Afaict we can move struct file_ra_state into the union instead of
f_version. See the appended patch I'm testing now. If that works then
we're down by 40 bytes this cycle.

--dkh3nrolmgchewwv
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fs-switch-f_iocb_flags-and-f_ra.patch"

From 51d5327717b370041733af2f3c6ea3cd75d793e2 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 22 Aug 2024 16:14:46 +0200
Subject: [PATCH] fs: switch f_iocb_flags and f_ra

Now that we shrank struct file by 24 bytes we still have a 4 byte hole.
If we move struct file_ra_state into the union and f_iocb_flags out of
the union we close that whole and bring down struct file to 192 bytes.
Which means struct file is 3 cachelines and we managed to shrink it by
40 bytes this cycle.

I've tried to audit all codepaths that use f_ra and none of them seem to
rely on it in file->f_op->release() and never have since commit
1da177e4c3f4 ("Linux-2.6.12-rc2").

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7eb4f706d59f..6c19f87ea615 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -998,9 +998,9 @@ struct file {
 		struct callback_head 	f_task_work;
 		/* fput() must use workqueue (most kernel threads). */
 		struct llist_node	f_llist;
-		unsigned int 		f_iocb_flags;
+		/* Invalid after last fput(). */
+		struct file_ra_state	f_ra;
 	};
-
 	/*
 	 * Protects f_ep, f_flags.
 	 * Must not be taken from IRQ context.
@@ -1011,9 +1011,9 @@ struct file {
 	struct mutex		f_pos_lock;
 	loff_t			f_pos;
 	unsigned int		f_flags;
+	unsigned int 		f_iocb_flags;
 	struct fown_struct	*f_owner;
 	const struct cred	*f_cred;
-	struct file_ra_state	f_ra;
 	struct path		f_path;
 	struct inode		*f_inode;	/* cached value */
 	const struct file_operations	*f_op;
-- 
2.43.0


--dkh3nrolmgchewwv--

