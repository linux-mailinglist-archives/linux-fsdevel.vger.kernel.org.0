Return-Path: <linux-fsdevel+bounces-62617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A362B9B250
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 19:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A174E134B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7803164A1;
	Wed, 24 Sep 2025 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GceJ10z+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9F1D5CFB;
	Wed, 24 Sep 2025 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736608; cv=none; b=u4mK2xDtgh0QKYpLnxBmzUXDobgwQwk0iBSmwmvBKmEUYWBzXbcybrlt3xSuGLa0sP1S4rm2M8OI27dhZfl/pVio2ACEpzRRMaQGSFphkjIyVBYEsX7c1UaQS4KRzzVnHLKOVXi6jIr+O7+TU5YF5Px4FhoBmBUby6F4vbNBmf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736608; c=relaxed/simple;
	bh=xK5KqKuwQoB0RtK0IX7HYDT9b74XRPuyJJWgwuEvVxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcHc07CU6kZmwP4cPQFmG/GtXZJKmnB1MvfPQHhsx2GsU3quydw+qGZ6DKDfJXAX2mELFtDxiEf0ud14+vTWAV3ZTyOZzDYxCzf9ITLfXN0FS9YmDRfrGw8UTy94bb2+JyJR1IcUH+DA+zgnrXpP1/TaFYU4OUTpotF+mJ3bnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GceJ10z+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e16Eb72VlU1k+f61VR7luEB0DzRHN+DcYDYq8EEG0V4=; b=GceJ10z+gQVvrltKh2M+JHmWIo
	GwE3/H2SUm9GnRJY79ImGKw3ZS0titlvjQ0dmXgiRtRjJLTmzEoVjFd1nGmCm3cKMIcJ1m5FACccj
	Aq7p9N4zntGBIlW64muYXWDYCcOAGQ/j51DqFVscnN5vbtE7GpVDFmhezV87Pt3+5oGog0L9DYAE7
	3V92mM/xXV9mSsugo1QXONHF3+O0rST3M+8Z4rmYKLxiA7Yf6vVFZtEZVUumxLslmE8n5fr2qQkBw
	t/Nqo9wRJg1zIZ+IeGDj7uuzkjEjfkaT3Cw/jh7NGhKDJAq2MY0BHgAhVRtYpI8opcBPSnfKG3b+t
	QWMgawWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1TjN-00000009O7t-0f5K;
	Wed, 24 Sep 2025 17:56:41 +0000
Date: Wed, 24 Sep 2025 18:56:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH Next] copy_mnt_ns(): Remove unnecessary unlock
Message-ID: <20250924175641.GT39973@ZenIV>
References: <68d3a9d3.a70a0220.4f78.0017.GAE@google.com>
 <tencent_2396E4374C4AA47497768767963CAD360E09@qq.com>
 <mb2bpbjtvci4tywtg5brdjkfl3ylopde3j2ymppvmlapzwnwij@wykkbxztyw2f>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb2bpbjtvci4tywtg5brdjkfl3ylopde3j2ymppvmlapzwnwij@wykkbxztyw2f>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 24, 2025 at 02:03:56PM +0200, Jan Kara wrote:
> On Wed 24-09-25 18:29:04, Edward Adam Davis wrote:
> > This code segment is already protected by guards, namespace_unlock()
> > should not appear here.
> > 
> > Reported-by: syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=0d671007a95cd2835e05
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> Indeed. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

I wonder where does that line come from, though.  Mismerge somewhere?
d7b7253a0adc "copy_mnt_ns(): use guards" includes this:

@@ -4185,13 +4186,11 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		emptied_ns = new_ns;
-		namespace_unlock();
 		return ERR_CAST(new);
 	}
 	if (user_ns != ns->user_ns) {
-		lock_mount_hash();
+		guard(mount_writer)();
 		lock_mnt_tree(new);
-		unlock_mount_hash();
 	}
 	new_ns->root = new;
 

