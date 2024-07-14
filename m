Return-Path: <linux-fsdevel+bounces-23647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 481D1930B69
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2024 21:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E5EB20977
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2024 19:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF43C13CFBB;
	Sun, 14 Jul 2024 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YwR9iHLm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1529213AD16
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jul 2024 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720986687; cv=none; b=ucH8rTY/ZTUxXzcxe1pKvTWyYlUFKutTAftUpNF+0Fh8afUum1TLd9LcmBD6rCqen2h5FqSWYmSQIWKQYMQvJTBDkV2N/WBxLWk6x0BrTH4RJwxBOAZVdgI+WFNsiS0S62i/oEqAsKZfh3ugqyZWBWrITAWBfY8bZ/cxjUu/93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720986687; c=relaxed/simple;
	bh=qwpVMIGILSjH+S1u8ChqE32H7tIdNnojFSNgHK2/z3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPpMLXSrOWKEAPoxONWlheRpPcmECbbvHa0vUvjX5FO/jg+Nr+nPP4FcnYtOCLtFbBkvXQ9yhqhcw3O8gv1yhvsCBuprLEuJjUMjpygQS3yK6NcSC9q3NIMlTBLDToECttRbgHUO+U7V0s7JF/AQ2his3wnZ/1MXdHHKz97oQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YwR9iHLm; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mic@digikod.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720986681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EDnpxVq2n3pmq5E38ZuOeZNSxkw5vwWED2AUGlzvN8=;
	b=YwR9iHLmEsJ78v5XGzF5O9i+YAqQMx44BGNYQyXxDBPUu164JSClm1VzVEn3fy//mH/2ti
	dMm1tqiWg10lYsz6Ob1z7edqJzXb1bf+I9cNYmf4aDwNfinh/1feXYbS/Tppue0TcTUOAE
	vFttLdiIdKptM6YdIJWv07qxYQTtPNI=
X-Envelope-To: paul@paul-moore.com
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: syzbot+34b68f850391452207df@syzkaller.appspotmail.com
X-Envelope-To: gnoack@google.com
X-Envelope-To: jmorris@namei.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-security-module@vger.kernel.org
X-Envelope-To: serge@hallyn.com
X-Envelope-To: syzkaller-bugs@googlegroups.com
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-xfs@vger.kernel.org
Date: Sun, 14 Jul 2024 15:51:17 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, Brian Foster <bfoster@redhat.com>, 
	linux-bcachefs@vger.kernel.org, syzbot <syzbot+34b68f850391452207df@syzkaller.appspotmail.com>, 
	gnoack@google.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [syzbot] [lsm?] WARNING in current_check_refer_path - bcachefs
 bug
Message-ID: <4hohnthh54adx35lnxzedop3oxpntpmtygxso4iraiexfdlt4d@6m7ssepvjyar>
References: <000000000000a65b35061cffca61@google.com>
 <CAHC9VhT_XpUeaxtkz0+4+YbWgK6=NDeDQikmPVYZ=RXDt+NOgw@mail.gmail.com>
 <20240714.iaDuNgieR9Qu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240714.iaDuNgieR9Qu@digikod.net>
X-Migadu-Flow: FLOW_OUT

cc'ing linux-xfs, since I'm sure this has come up there and bcachefs and
xfs verify and fsck are structured similararly at a very high level -
I'd like to get their input.

On Sun, Jul 14, 2024 at 09:34:01PM GMT, Mickaël Salaün wrote:
> On Fri, Jul 12, 2024 at 10:55:11AM -0400, Paul Moore wrote:
> > On Thu, Jul 11, 2024 at 5:53 PM syzbot
> > <syzbot+34b68f850391452207df@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    8a03d70c27fc Merge remote-tracking branch 'tglx/devmsi-arm..
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=174b0e6e980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=15349546db652fd3
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=34b68f850391452207df
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > userspace arch: arm64
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13cd1b69980000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12667fd1980000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/efb354033e75/disk-8a03d70c.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/c747c205d094/vmlinux-8a03d70c.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/5641f4fb7265/Image-8a03d70c.gz.xz
> > > mounted in repro: https://storage.googleapis.com/syzbot-assets/4e4d1faacdef/mount_0.gz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+34b68f850391452207df@syzkaller.appspotmail.com
> > >
> > > bcachefs (loop0): resume_logged_ops... done
> > > bcachefs (loop0): delete_dead_inodes... done
> > > bcachefs (loop0): done starting filesystem
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 6284 at security/landlock/fs.c:971 current_check_refer_path+0x4e0/0xaa8 security/landlock/fs.c:1132
> > 
> > I'll let Mickaël answer this for certain, but based on a quick look it
> > appears that the fs object being moved has a umode_t that Landlock is
> > not setup to handle?
> 
> syzbot found an issue with bcachefs: in some cases umode_t is invalid (i.e.
> a weird file).
> 
> Kend, Brian, you'll find the incorrect filesystem with syzbot's report.
> Could you please investigate the issue?
> 
> Here is the content of the file system:
> # losetup --find --show mount_0
> /dev/loop0
> # mount /dev/loop0 /mnt/
> # ls -la /mnt/
> ls: cannot access '/mnt/file2': No such file or directory
> ls: cannot access '/mnt/file3': No such file or directory
> total 24
> drwxr-xr-x 4 root root   0 May  2 20:21 .
> drwxr-xr-x 1 root root 130 Oct 31  2023 ..
> drwxr-xr-x 2 root root   0 May  2 20:21 file0
> ?rwxr-xr-x 1 root root  10 May  2 20:21 file1
> -????????? ? ?    ?      ?            ? file2
> -????????? ? ?    ?      ?            ? file3
> -rwxr-xr-x 1 root root 100 May  2 20:21 file.cold
> drwx------ 2 root root   0 May  2 20:21 lost+found
> # stat /mnt/file1
>   File: /mnt/file1
>   Size: 10              Blocks: 8          IO Block: 4096   weird file
> Device: 7,0     Inode: 1073741824  Links: 1
> Access: (0755/?rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2024-05-02 20:21:07.747039697 +0000
> Modify: 2024-05-02 20:21:07.747039697 +0000
> Change: 2024-05-02 20:21:07.747039697 +0000
>  Birth: 2024-05-02 20:21:07.747039697 +0000

Ok, this is an interesting one.

So we don't seem to be checking for invwalid i_mode at all - that's a bug.

But if we don't want to be exposing invalid i_modes at all, that's
tricky, since we (currently) can only repair when running fsck. "This is
invalid and we never want to expose this" checks are done in bkey
.invalid methods, and those can only cause the key to be deleted - we
can't run complex repair in e.g. btree node read, and that's what would
be required here (e.g. checking the extents and dirents btrees to guess
if this should be a regular file or a directory).

Long term I plan on running our existing fsck checks (including repair)
in our normal runtime paths - whenever we're looking at one or more keys
and there's a fsck check we can run, just run it.

I wasn't planning on doing that for awhile, because I'm waiting on
getting comprehensive filesystem error injection merged so we can make
sure those repair paths are all well tested before running them
automatically like that, but if this is a security issue perhaps as a
special case we should do that now.

Thoughts?

