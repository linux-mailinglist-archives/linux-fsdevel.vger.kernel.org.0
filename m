Return-Path: <linux-fsdevel+bounces-29146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 679F8976644
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F237DB22C94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 10:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6487019C54B;
	Thu, 12 Sep 2024 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjKKWRsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA813C809
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135381; cv=none; b=fUC//5GYLC+ihQyGKW9RXOatmBpZj8HrrToKPuRF65NFaCWXPRXOwyvw86A1bQAk7kAkFrE7ECs2++YCHRPUbC44BPoKkbZ/ECwa/dSjbvQUrCf1e4rPzGRjONl+lLKpPSjA/mA6cgDqBluP6Yu5ur6kwfjY4rhKQjP3v+p6dbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135381; c=relaxed/simple;
	bh=DH74NqsLwXcYgpdc9ZxHdfBNxVq/m/ifXeMpKqe7SWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSSw8TzConDwLJ30RqTUrZgzkxDudRKmg7RsbZPcBns43Xn5LXTBCIZ+nLHmbH2fOOOzfDWVtTVqIPg8jfi4ajzGfVGZRm24/TJiG0v2CZxzCKQHD92LyoHdfmr5B6dTRO2vgJFid6EgGDWzECisPQYWPAV05dN33gOBx9o7W9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjKKWRsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4475DC4CEC3;
	Thu, 12 Sep 2024 10:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726135381;
	bh=DH74NqsLwXcYgpdc9ZxHdfBNxVq/m/ifXeMpKqe7SWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjKKWRsl3FTj8ltKoz3PADGaFb+wngUO/UzFQf0tfJQ4y3uF5axxrds7loUSMusgK
	 U/hWSxWc15pJXha8FQ5GjXEc7VATcRq1/6dEwg8oZN8l55s36OO07kYDakgyWVEwda
	 UunJZvuJwOV371dqPh/TE6abw4DGQDiNCVwsvWUJpASA31/uL9V6qLYHoIv4lV9ZTI
	 ask+beK1tFxIVJFdqPILwr323hRVJ+vrRvPtBCzRSJQyBBRdS27kBQXhMG6J0BIU+K
	 RLjEx+fGP07sc60XtVm8Hyu5dnp3wv1OijaN70OXt7jKlpQ840NAHsLJ28Q9plSELd
	 jejbpvWKLxCdw==
Date: Thu, 12 Sep 2024 12:02:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 12/20] input: remove f_version abuse
Message-ID: <20240912-zeche-entkommen-1ae27588d0de@brauner>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-12-6d3e4816aa7b@kernel.org>
 <ZuJXYNeTGrnRpPHk@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ijrkgxanuoezdhlk"
Content-Disposition: inline
In-Reply-To: <ZuJXYNeTGrnRpPHk@ly-workstation>


--ijrkgxanuoezdhlk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Sep 12, 2024 at 10:52:16AM GMT, Lai, Yi wrote:
> Hi Christian Brauner,
> 
> Greetings!
> 
> I used Syzkaller and found that there is BUG: unable to handle kernel paging request in input_proc_devices_poll in next-20240909.
> 
> After bisection and the first bad commit is:
> "
> 7c3d158418c2 input: remove f_version abuse
> "
> 
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/240911_155303_input_proc_devices_poll
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/blob/main/240911_155303_input_proc_devices_poll/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/blob/main/240911_155303_input_proc_devices_poll/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/blob/main/240911_155303_input_proc_devices_poll/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/blob/main/240911_155303_input_proc_devices_poll/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/blob/main/240911_155303_input_proc_devices_poll/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/main/240911_155303_input_proc_devices_poll/bzImage_100cc857359b5d731407d1038f7e76cd0e871d94
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/240911_155303_input_proc_devices_poll/100cc857359b5d731407d1038f7e76cd0e871d94_dmesg.log

Thanks for all the info. I see what the issue is and pushed a fix out.

--ijrkgxanuoezdhlk
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-input-remove-f_version-abuse.patch"

From 7a7ce8b3ba66754f5d275a71630b4ee8b507d266 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:53 +0200
Subject: [PATCH] input: remove f_version abuse

f_version is removed from struct file. Make input stop abusing f_version
for stashing information for poll. Move the input state counter into
input_seq_state and allocate it via seq_private_open() and free via
seq_release_private().

Link: https://lore.kernel.org/r/20240830-vfs-file-f_version-v1-12-6d3e4816aa7b@kernel.org
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/input/input.c | 47 ++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 54c57b267b25..19ea1888da9f 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1079,33 +1079,31 @@ static inline void input_wakeup_procfs_readers(void)
 	wake_up(&input_devices_poll_wait);
 }
 
+struct input_seq_state {
+	unsigned short pos;
+	bool mutex_acquired;
+	int input_devices_state;
+};
+
 static __poll_t input_proc_devices_poll(struct file *file, poll_table *wait)
 {
+	struct seq_file *seq = file->private_data;
+	struct input_seq_state *state = seq->private;
+
 	poll_wait(file, &input_devices_poll_wait, wait);
-	if (file->f_version != input_devices_state) {
-		file->f_version = input_devices_state;
+	if (state->input_devices_state != input_devices_state) {
+		state->input_devices_state = input_devices_state;
 		return EPOLLIN | EPOLLRDNORM;
 	}
 
 	return 0;
 }
 
-union input_seq_state {
-	struct {
-		unsigned short pos;
-		bool mutex_acquired;
-	};
-	void *p;
-};
-
 static void *input_devices_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	union input_seq_state *state = (union input_seq_state *)&seq->private;
+	struct input_seq_state *state = seq->private;
 	int error;
 
-	/* We need to fit into seq->private pointer */
-	BUILD_BUG_ON(sizeof(union input_seq_state) != sizeof(seq->private));
-
 	error = mutex_lock_interruptible(&input_mutex);
 	if (error) {
 		state->mutex_acquired = false;
@@ -1124,7 +1122,7 @@ static void *input_devices_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 
 static void input_seq_stop(struct seq_file *seq, void *v)
 {
-	union input_seq_state *state = (union input_seq_state *)&seq->private;
+	struct input_seq_state *state = seq->private;
 
 	if (state->mutex_acquired)
 		mutex_unlock(&input_mutex);
@@ -1210,7 +1208,8 @@ static const struct seq_operations input_devices_seq_ops = {
 
 static int input_proc_devices_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &input_devices_seq_ops);
+	return seq_open_private(file, &input_devices_seq_ops,
+				sizeof(struct input_seq_state));
 }
 
 static const struct proc_ops input_devices_proc_ops = {
@@ -1218,17 +1217,14 @@ static const struct proc_ops input_devices_proc_ops = {
 	.proc_poll	= input_proc_devices_poll,
 	.proc_read	= seq_read,
 	.proc_lseek	= seq_lseek,
-	.proc_release	= seq_release,
+	.proc_release	= seq_release_private,
 };
 
 static void *input_handlers_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	union input_seq_state *state = (union input_seq_state *)&seq->private;
+	struct input_seq_state *state = seq->private;
 	int error;
 
-	/* We need to fit into seq->private pointer */
-	BUILD_BUG_ON(sizeof(union input_seq_state) != sizeof(seq->private));
-
 	error = mutex_lock_interruptible(&input_mutex);
 	if (error) {
 		state->mutex_acquired = false;
@@ -1243,7 +1239,7 @@ static void *input_handlers_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *input_handlers_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	union input_seq_state *state = (union input_seq_state *)&seq->private;
+	struct input_seq_state *state = seq->private;
 
 	state->pos = *pos + 1;
 	return seq_list_next(v, &input_handler_list, pos);
@@ -1252,7 +1248,7 @@ static void *input_handlers_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 static int input_handlers_seq_show(struct seq_file *seq, void *v)
 {
 	struct input_handler *handler = container_of(v, struct input_handler, node);
-	union input_seq_state *state = (union input_seq_state *)&seq->private;
+	struct input_seq_state *state = seq->private;
 
 	seq_printf(seq, "N: Number=%u Name=%s", state->pos, handler->name);
 	if (handler->filter)
@@ -1273,14 +1269,15 @@ static const struct seq_operations input_handlers_seq_ops = {
 
 static int input_proc_handlers_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &input_handlers_seq_ops);
+	return seq_open_private(file, &input_handlers_seq_ops,
+				sizeof(struct input_seq_state));
 }
 
 static const struct proc_ops input_handlers_proc_ops = {
 	.proc_open	= input_proc_handlers_open,
 	.proc_read	= seq_read,
 	.proc_lseek	= seq_lseek,
-	.proc_release	= seq_release,
+	.proc_release	= seq_release_private,
 };
 
 static int __init input_proc_init(void)
-- 
2.45.2


--ijrkgxanuoezdhlk--

