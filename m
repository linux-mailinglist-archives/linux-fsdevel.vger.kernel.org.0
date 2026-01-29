Return-Path: <linux-fsdevel+bounces-75918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMfLJuPke2nBJAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 23:53:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA65B58AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 23:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5B9330238CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF8036C589;
	Thu, 29 Jan 2026 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Xd3s3aE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DEC312821;
	Thu, 29 Jan 2026 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769727170; cv=none; b=kKJ931DHzk2Qtjhj0j5m+M58pYR+zekcb/nvSOLMv3epNKvb9YLdlGDbw1LWtkp4Ppbvak9Epa677intNAtuHSiJGW7/te98RoiO7PM1/ZwJvqNUEaoIXQeJJH0a+mD04VIh7Tb7camqVILHx1ScBTtCuytRKKxE9ts9DNs8ky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769727170; c=relaxed/simple;
	bh=a+uuu1UU4KTBHLlqRmYyRypp9XGFjSD6Z3KeUdDHXDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qsq4Wkxvo8ZViy70tHOYjIkqZ+/GRW7TPqNSpX0dI/QEDxTfC0EZ39eS3PYmuyFPCC1azWMf8GHGv1ucvK5XMdmsShKTyFhqz/9mEmbsj/KMLLJk5ZRvN1vXeKOamcVpdt9zPRVR42MpAHwswY3mx9N4/x3CgKS+ixfXWw5iiv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Xd3s3aE8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=NzC4ieMh6vmoXuGrRF8AJfVTPzFDIVwsq0W+97NeH6I=; b=Xd3s3aE8lP0Iuf76XmQmTqyylY
	kyjYtmWz3WE5Wp7qeyPuSNsrn7VnrFKLBLvg1QeejST/l0HFm8A1qmVzFffJgrhLWXrFqbyf6a33e
	/22zqtNz8ozygjvj4by61/hPWVbdmEB1InvlYHMIf70seSv2TGIK6fBViv/wS7HAbDGRBmDvmj2ZB
	JntUzR5O2yOGBeO5kVkWDZ996QY77yEhYaT27vlMP0zpBJ3x2kyXvwFS0IvjUmVIU8AbZJaqR0rdb
	wrNWss8rPX4hfCo90x1Ou0DJDoWZBnnF+jopJxNrM5FqeIqToCi5KntAUvJccM6KN/Cc2/WSy2jpw
	jyJAcUeA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vlauH-00000007wty-0EGP;
	Thu, 29 Jan 2026 22:54:33 +0000
Date: Thu, 29 Jan 2026 22:54:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Samuel Wu <wusamuel@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, clm@meta.com,
	android-kernel-team <android-kernel-team@google.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
Message-ID: <20260129225433.GU3183987@ZenIV>
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh>
 <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV>
 <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129032335.GT3183987@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75918-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,linux.org.uk:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0BA65B58AC
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 03:23:35AM +0000, Al Viro wrote:
> On Wed, Jan 28, 2026 at 04:58:57PM -0800, Samuel Wu wrote:
> > On Tue, Jan 27, 2026 at 8:58 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > > Very interesting...  Does 1544775687f0 (parent of e5bf5ee26663)
> > > demonstrate that behaviour?
> > 
> > Reverting only 1544775687f0 (functionfs: need to cancel ->reset_work
> > in ->kill_sb()) does not fix the issue. With 6.19-rc7 as baseline, the
> > simplest working recipe at the moment is with 6ca67378d0e7,
> > c7747fafaba0, and e5bf5ee26663 reverted.
> 
> Sorry, I hadn't been clear enough: if you do
> git switch --detach 1544775687f0 
> and build the resulting tree, does the breakage reproduce?  What I want
> to do is to split e5bf5ee26663 into smaller steps and see which one
> introduces the breakage, but the starting point would be verify that
> there's no breakage prior to that.
> 
> 
> PS: v6.19-rc7 contains fc45aee66223 ("get rid of kill_litter_super()"),
> and reverting 6ca67378d0e7 ("convert functionfs") would reintroduce
> the call of that function in ffs_fs_kill_sb(), so the resulting tree
> won't even build on any configs with functionfs enabledd; are you sure
> that you'd been testing v6.19-rc7 + reverts of just these 3 commits?

Could you try your reproducer on mainline with the following delta applied?

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 05c6750702b6..6c6d55ba0749 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -646,12 +646,11 @@ static int ffs_ep0_open(struct inode *inode, struct file *file)
 	if (ret < 0)
 		return ret;
 
-	ffs_data_opened(ffs);
 	if (ffs->state == FFS_CLOSING) {
-		ffs_data_closed(ffs);
 		mutex_unlock(&ffs->mutex);
 		return -EBUSY;
 	}
+	ffs_data_opened(ffs);
 	mutex_unlock(&ffs->mutex);
 	file->private_data = ffs;
 

