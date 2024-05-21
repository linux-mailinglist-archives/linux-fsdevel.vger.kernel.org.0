Return-Path: <linux-fsdevel+bounces-19883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C8E8CAE74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6B61F21FF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E87A7602B;
	Tue, 21 May 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHeIermh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82E28E7
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716295229; cv=none; b=QA1fTOhoP1m15vDol8FfNyM/ztihjyzicDIJ75IC7BnPg0GqvQ1czWRLD9Tw7WQ6VDv4WyMcCwzyeGD4DyIO5ZwQR5CNhMdReWmQbvM8UwxlhQy1+FrhZLY8hcFXQjYdXL9u3MiNzZ20x3JV++G7c/5G9pZKyzpmSpOZa6Qkx7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716295229; c=relaxed/simple;
	bh=Y38PQeqA44hIHID6a/blOxBJGcCtMa90U6hpXM5KERc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozkXV9j2TVWu07E2lMHd8yWaUszIRbkFvCFr8gvz60v+3BpE7IE4vMhtHjsqTogvAU+jfY8rNydc52XHG1TzKRNsySuA1gyoJ9QQEVZP7FlpCah5VpfR84uXE8f713nJbIUyCsrJ844DMwG4AXihoO7/+7IlmoAhrgCL6p6BvYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHeIermh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C52AC2BD11;
	Tue, 21 May 2024 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716295229;
	bh=Y38PQeqA44hIHID6a/blOxBJGcCtMa90U6hpXM5KERc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHeIermhWjwCfv9o9+EgyTFeoAjx4tGErKJUIESTEjh/2sbYKV7UYv15d943oDpPq
	 MgN8/+f8fPqKJ6DwAgctFuByGSCapSCrAb1yIlAvUGiNmzbpO7gIlg3pOGKXOJywzE
	 AGvghKd2TRKiqrdwBb8u5hKkAmHt83zurFsDx+pXY/xQcw/wujLqRIEhZcgZXUUU6S
	 O9wa4JOmc45c45gtcbsbbtzgNYte6sEhI8h1g8jaEARhcZbXaXyhj5R2wOa41oQZnU
	 MYuR6JdmRHTQVs9pC1kZxAdhTJC9/xT37K1ywwU3rsQWH81l/i6rhk5TAG6VZNK9iy
	 ZoMw96RGl9ALA==
Date: Tue, 21 May 2024 14:40:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240521-girlanden-zehnfach-1bff7eb9218c@brauner>
References: <a15b1050-4b52-4740-a122-a4d055c17f11@kernel.org>
 <a65b573a-8573-4a17-a918-b5cf358c17d6@kernel.org>
 <84bc442d-c4dd-418e-8020-e1ff987cad13@kernel.org>
 <CAHk-=whMVsvYD4-OZx20ZR6zkOPoeMckxETxtqeJP2AAhd=Lcg@mail.gmail.com>
 <d2805915-5cf0-412e-a8e3-04ff1b18b315@kernel.org>
 <CAHk-=wh68QbOZi_rYaKiydsRDnYHEaCsvK6FD83-vfE6SXg5UA@mail.gmail.com>
 <CAHk-=whgMGb0qM638KfBaa2AA9TR95D3oHJTu6=5YtRoBVWa3g@mail.gmail.com>
 <e983a37b-9eb3-4b53-8f02-d671281f82f9@kernel.org>
 <0bbf8e1d-0590-4e42-91b2-7a35614319d3@kernel.org>
 <20240521-ambitioniert-alias-35c21f740dba@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="o7ruptcawbf3t3rg"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240521-ambitioniert-alias-35c21f740dba@brauner>


--o7ruptcawbf3t3rg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, May 21, 2024 at 02:33:24PM +0200, Christian Brauner wrote:
> On Tue, May 21, 2024 at 08:13:08AM +0200, Jiri Slaby wrote:
> > On 21. 05. 24, 8:07, Jiri Slaby wrote:
> > > On 20. 05. 24, 21:15, Linus Torvalds wrote:
> > > > On Mon, 20 May 2024 at 12:01, Linus Torvalds
> > > > <torvalds@linux-foundation.org> wrote:
> > > > > 
> > > > > So how about just a patch like this?  It doesn't do anything
> > > > > *internally* to the inodes, but it fixes up what we expose to user
> > > > > level to make it look like lsof expects.
> > > > 
> > > > Note that the historical dname for those pidfs files was
> > > > "anon_inode:[pidfd]", and that patch still kept the inode number in
> > > > there, so now it's "anon_inode:[pidfd-XYZ]", but I think lsof is still
> > > > happy with that.
> > > 
> > > Now the last column of lsof still differs from 6.8:
> > > -[pidfd:1234]
> > > +[pidfd-4321]
> > > 
> > > And lsof tests still fail, as "lsof -F pfn" is checked against:
> > >      if ! fgrep -q "p${pid} f${fd} n[pidfd:$pid]" <<<"$line"; then
> > > 
> > > Where $line is:
> > > p1015 f3 n[pidfd-1315]
> > > 
> > > Wait, even if I change that minus to a colon, the inner pid (1315)
> > > differs from the outer (1015), but it should not (according to the
> > > test).
> > 
> > This fixes the test (meaning literally "it shuts up the test", but I have no
> > idea if it is correct thing to do at all):
> > -       return dynamic_dname(buffer, buflen, "anon_inode:[pidfd-%llu]",
> > pid->ino);
> > +       return dynamic_dname(buffer, buflen, "anon_inode:[pidfd:%d]",
> > pid_nr(pid));
> > 
> > Maybe pid_vnr() would be more appropriate, I have no idea either.
> 
> So as pointed out the legacy format for pidfds is:
> 
> lrwx------ 1 root root  64 21. Mai 14:24 39 -> 'anon_inode:[pidfd]'
> 
> So it's neither showing inode number nor pid.
> 
> The problem with showing the pid unconditionally like that in
> dynamic_dname() is that it's wrong in various circumstances. For
> example, when the pidfd is sent into a pid namespace outside the it's
> pid namespace hierarchy (e.g., into a sibling pid namespace or when the
> task has already been reaped.
> 
> Imho, showing the pid is more work than it's worth especially because we
> expose that info in fdinfo/<nr> anyway. So let's just do the simple thing.

Here's the updated patch appended. Linus, feel free to commit it
directly or if you prefer I can send it to you later this week.

In any case, I really really would like to try to move away from the
current insanity maybe by the end of the year. So I really hope that
lsof changes to the same format that strace already changed to so we can
flip the switch. That should allow us to get rid of both the weird
non-type st_mode issue and the unpleasant name faking. Does that sound
like something we can try?

--o7ruptcawbf3t3rg
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fs-pidfs-make-lsof-happy-with-our-inode-changes.patch"

From 0e027ea62813cb61d95012757908e92e8cd46894 Mon Sep 17 00:00:00 2001
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 May 2024 14:34:43 +0200
Subject: [PATCH] fs/pidfs: make 'lsof' happy with our inode changes

pidfs started using much saner inodes in commit b28ddcc32d8f ("pidfs:
convert to path_from_stashed() helper"), but that exposed the fact that
lsof had some knowledge of just how odd our old anon_inode usage was.

For example, legacy anon_inodes hadn't even initialized the inode type
in the inode mode, so everything had a type of zero.

So sane tools like 'stat' would report these files as "weird file", but
'lsof' instead used that (together with the name of the link in proc) to
notice that it's an anonymous inode, and used it to detect pidfd files.

Let's keep our internal new sane inode model, but mask the file type
bits at 'stat()' time in the getattr() function we already have, and by
making the dentry name match what lsof expects too.

This keeps our internal models sane, but should make user space see the
same old odd behavior.

Reported-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/all/a15b1050-4b52-4740-a122-a4d055c17f11@kernel.org/
Link: https://github.com/lsof-org/lsof/issues/317
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Tycho Andersen <tycho@tycho.pizza>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index a63d5d24aa02..dbb9d854d1c5 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -169,6 +169,24 @@ static int pidfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return -EOPNOTSUPP;
 }
 
+
+/*
+ * User space expects pidfs inodes to have no file type in st_mode.
+ *
+ * In particular, 'lsof' has this legacy logic:
+ *
+ *	type = s->st_mode & S_IFMT;
+ *	switch (type) {
+ *	  ...
+ *	case 0:
+ *		if (!strcmp(p, "anon_inode"))
+ *			Lf->ntype = Ntype = N_ANON_INODE;
+ *
+ * to detect our old anon_inode logic.
+ *
+ * Rather than mess with our internal sane inode data, just fix it
+ * up here in getattr() by masking off the format bits.
+ */
 static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 			 struct kstat *stat, u32 request_mask,
 			 unsigned int query_flags)
@@ -176,6 +194,7 @@ static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	struct inode *inode = d_inode(path->dentry);
 
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
+	stat->mode &= ~S_IFMT;
 	return 0;
 }
 
@@ -199,12 +218,13 @@ static const struct super_operations pidfs_sops = {
 	.statfs		= simple_statfs,
 };
 
+/*
+ * 'lsof' has knowledge of out historical anon_inode use, and expects
+ * the pidfs dentry name to start with 'anon_inode'.
+ */
 static char *pidfs_dname(struct dentry *dentry, char *buffer, int buflen)
 {
-	struct inode *inode = d_inode(dentry);
-	struct pid *pid = inode->i_private;
-
-	return dynamic_dname(buffer, buflen, "pidfd:[%llu]", pid->ino);
+	return dynamic_dname(buffer, buflen, "anon_inode:[pidfd]");
 }
 
 static const struct dentry_operations pidfs_dentry_operations = {
-- 
2.43.0


--o7ruptcawbf3t3rg--

