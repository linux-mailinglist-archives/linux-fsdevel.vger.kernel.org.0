Return-Path: <linux-fsdevel+bounces-4712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7995802A4D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 03:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E14B20797
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB17E20FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u7lZnruM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RmajFuPo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED226E4;
	Sun,  3 Dec 2023 17:30:42 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CDED31FE37;
	Mon,  4 Dec 2023 01:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701653440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpF3yPijHir05CtVXuq0rn9FMGQjG6Rj2eqgcCq5e1k=;
	b=u7lZnruMqQEyagHnHsja0hsdP9sawBcfQHMom2Sb94gjM/eNa/wbVQ6GzSzjB8apYUbqcl
	9MGI2UTCxhgZTLQ93My5a+dvvPXbPJuP0liX0cG4b91ho0rwprQwYgB2RfVUcd1OGUJrEe
	19Z283BZeM6J9RQq1HB2YewOzvxy/L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701653440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpF3yPijHir05CtVXuq0rn9FMGQjG6Rj2eqgcCq5e1k=;
	b=RmajFuPosmkaO2e4Fq4zjp+shAec8iz+KZ5mCnbmdkky6or6nDZ1rZXTZD3+r+AIKtS97u
	57NzovxsVpSHyPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7450F1368D;
	Mon,  4 Dec 2023 01:30:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 81aKCL4rbWVYNgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Dec 2023 01:30:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>, "Jeff Layton" <jlayton@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
In-reply-to: <20231129-querschnitt-urfassung-3ebd703c345a@brauner>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>,
 <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>,
 <170113056683.7109.13851405274459689039@noble.neil.brown.name>,
 <20231128-blumig-anreichern-b9d8d1dc49b3@brauner>,
 <170121362397.7109.17858114692838122621@noble.neil.brown.name>,
 <20231129-querschnitt-urfassung-3ebd703c345a@brauner>
Date: Mon, 04 Dec 2023 12:30:34 +1100
Message-id: <170165343439.7109.3106838865273118254@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.950];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.29

On Wed, 29 Nov 2023, Christian Brauner wrote:
> > If an nfsd thread only completes the close that it initiated the close
> > on (which is what I am currently proposing) then there would be at most
> > one, or maybe 2, fds to close after handling each request.  While that
> > is certainly a non-zero burden, I can't see how it can realistically be
> > called a DOS.
> 
> The 10s of millions of files is what makes me curious. Because that's
> the workload that'd be interesting.
> 

I think the main effect of the 10s of millions of files is to bloat the
icache which causes it to be cleaned and this results is synchronous
reads from storage is situations that you wouldn't usually expect them.

It appears from examining a memory-snapshot that some files being closed
have already been unlinked.  This is quite unusual with NFS but can
happen if they are unlinked from one client while open on another
client.  (The directory containing the file in one case is called
"Cache".  Maybe cleaning of that cache by the applications often gets
files that are in use).

This pattern means that the final __dput calls __dentry_kill and
eventually xfs_fs_destroy_inode.  This sometimes needs to read
synchronously from storage - if the required info isn't cached.  This
causes the delays.

I've modelled the delay with 

diff --git a/fs/file_table.c b/fs/file_table.c
index d36cade6e366..51563f79385a 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -29,6 +29,7 @@
 #include <linux/ima.h>
 #include <linux/swap.h>
 #include <linux/kmemleak.h>
+#include <linux/delay.h>
 
 #include <linux/atomic.h>
 
@@ -375,6 +376,9 @@ static void __fput(struct file *file)
 	eventpoll_release(file);
 	locks_remove_file(file);
 
+	if ((file->f_mode & FMODE_WRITE) &&
+	    (current->flags & PF_KTHREAD))
+		msleep(25);
 	ima_file_free(file);
 	if (unlikely(file->f_flags & FASYNC)) {
 		if (file->f_op->fasync)


I loop-back mount a filesystem with NFS on the test machine.
The PF_KTHREAD test ensures that when "cp -r" writes to the NFS
filesystem there is no delay, but when nfsd writes to the local
filesystem there is a delay.

With this patch I can easily demonstrate the number of open files
growing without bound.  With my patch as well (I'll send new version
shortly) the growth is bounded.

Thanks,
NeilBrown

