Return-Path: <linux-fsdevel+bounces-49311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC577ABA673
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 01:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35BB1B67509
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 23:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88B128001B;
	Fri, 16 May 2025 23:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kUxpfF0T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB522DA15;
	Fri, 16 May 2025 23:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437655; cv=none; b=Fhi6iWlOvWF2gPkcF055qy+t9lHstHZYQCYBvZCnzSaBssipi72JwrADQHSsC/7u4Pvznjb0ucS7V/LMatWEm/S9uFZdlzvj4jQex1xpdUScBghHQAaW7+5SHSZAnu7tI9qVRG1lwgH95N3XtLvRPwUWFTPooDEdopPTgYu0ZgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437655; c=relaxed/simple;
	bh=e2F/6StyG52CwA2JYoo0AgukZ0keLwK7GLH8EnBa/DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYtInoaV2myeNAYk67Y0HpL7TT4NDpuJtTHH+lapWepb0g3K3y7MV4b7dPZce6cElW1n2p3kDVlpcHCGJREe4l9EV/nsXcI5TfiOe67Nr6qExItKqtr4Ael+5/3SetJRp1rDGOK2l/AwKgJTfsHFAwKuG4EIaL0bXxsziJQNuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kUxpfF0T; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xp7EErupILxnMLXfB+a4CcMjkMukegAOKV+BDImfBaU=; b=kUxpfF0TrVITUX+ZdAUJOlD4gx
	7SrKFRysiIniVlUZsaKRDFTkQBFyKkk74wVPIJpgStOuB4sO5QASze1G7O5j3xJjHW+oVoPkDzFOS
	c+q+dBcXA8W3z6dfJAYWNL0cIK8QoT2Z9yypYcjVLF6uBgboBQxObzsoRiNsAJSs8Jkv0OOtSbUjQ
	fhKmWPZ17QpjMbFerL0JMf0mtE4y8Y+1gJteh2UhRwdXs4aXi6YQDH3MajyyuQ9GlYgdpfSYMjYUx
	tKG3Yn6tpNBebVT42RLxrsWP7Bx2rC9443snis91f6dtdrMQEqFyOOFJHbY1C6Q7Xs8CMJdlgisYH
	2cvZApJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uG4MA-00000003kwv-1vED;
	Fri, 16 May 2025 23:20:46 +0000
Date: Sat, 17 May 2025 00:20:46 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [pox on syzbot - again][exfat] exfat_mkdir() breakage on corrupted
 image
Message-ID: <20250516232046.GT2023217@ZenIV>
References: <680809f3.050a0220.36a438.0003.GAE@google.com>
 <tencent_55ACA45C1762977206C3B376C36BA96B8305@qq.com>
 <20250516193122.GS2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516193122.GS2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 16, 2025 at 08:31:22PM +0100, Al Viro wrote:
> On Wed, May 14, 2025 at 06:39:40AM +0800, Edward Adam Davis wrote:
> > In the reproducer, when calling renameat2(), olddirfd and newdirfd passed
> > are the same value r0, see [1]. This situation should be avoided.
> > 
> > [1]
> > renameat2(r0, &(0x7f0000000240)='./bus/file0\x00', r0, &(0x7f00000001c0)='./file0\x00', 0x0)
> > 
> > Reported-by: syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=321477fad98ea6dd35b7
> > Tested-by: syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  fs/namei.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 84a0e0b0111c..ff843007ca94 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -5013,7 +5013,7 @@ int vfs_rename(struct renamedata *rd)
> >  	struct name_snapshot old_name;
> >  	bool lock_old_subdir, lock_new_subdir;
> >  
> > -	if (source == target)
> > +	if (source == target || old_dir == target)
> >  		return 0;
> 
> What the hell?
> 
> 1) olddirfd and newdirfd have nothing to do with vfs_rename() - they are
> bloody well gone by the time we get there.
> 
> 2) there's nothing wrong with having the same value passed in both -
> and it's certainly not a "quietly do nothing".
> 
> 3) the check added in this patch is... odd.  You are checking essentically
> for rename("foo/bar", "foo").  It should fail (-ENOTEMPTY or -EINVAL, depending
> upon RENAME_EXCHANGE in flags) without having reached vfs_rename().

4) it's definitely an exfat bug, since we are getting
	old_dentry->d_parent != target
	old_dentry->d_parent->d_inode == target->d_inode
	S_ISDIR(target->d_inode->i_mode)
All objects involved are on the same super_block, which has "exfat" for
->s_type->name, so it's exfat ending up with multiple dentries for
the same directory inode, and once that kind of thing has happened,
the system is FUBAR.

As for the root cause, almost certainly their ->mkdir() is deciding
that it has just created a new inode - and ending up with existing one,
already in icache and already with a dentry attached to it.

<adds BUG_ON(!hlist_empty(&inode->i_dentry)) into exfat_mkdir()>

   [   84.780875] exFAT-fs (loop0): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
   [   84.781411] exFAT-fs (loop0): Medium has reported failures. Some data may be lost.
   [   84.782209] exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0xe62de5da, utbl_chksum : 0xe619d30d)
   [   84.783272] ------------[ cut here ]------------
   [   84.783546] kernel BUG at fs/exfat/namei.c:881!

... and there we go.  exfat_mkdir() getting an existing in-core inode
and attaching an alias to it, with expected fun results.

For crying out loud, how many times do syzbot folks need to be told that
getting report to attention of relevant filesystem folks is important?

Subject: [syzbot] [fs?] INFO: task hung in vfs_rename (2)

mentionings of anything exfat-related: 0.

Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
		 viro@zeniv.linux.org.uk

mentionings of anything exfat-related: 0.

In message body:
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=12655204580000)

Why, that does sound like some filesystem bug might be involved
and presumably the damn thing knows which type had it been.
<start browser, cut'n'paste the sodding link>
... and the very first line is
fsck.exfat -n exited with status code 4

Result: 3 weeks later it *STILL* hasn't reached the relevant fs
maintainers.  Could that be a sufficient evidence to convince the
fine fellows working on syzbot that "you just need to click a few
links" DOES NOT WORK?

We'd been there several times already.  For relatively polite example,
see https://lore.kernel.org/all/Y5ZDjuSNuSLJd8Mn@ZenIV/ - I can't be arsed
to explain that again and again, and you don't seem to mind following
links in email, so...

