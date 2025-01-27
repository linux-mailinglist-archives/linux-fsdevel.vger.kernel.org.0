Return-Path: <linux-fsdevel+bounces-40136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C20A6A1D093
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 06:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239D73A6EC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 05:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426BF154BE5;
	Mon, 27 Jan 2025 05:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jYMJ3F/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37196282EE
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 05:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737954262; cv=none; b=lF4cO9RlMVk2SfKHNI+HgcBnfSQOul5fINUek+JOMLNShHlgackunumtfxf2+u/xHNi0+6dU4Luc5UBvme6JgauZ/lNXgP6ObPRrzWKqy2HSmUZBbdMPNDURYkWJYe36/v8CKdkShfG0mZr23xZH1lLgW/Zu+LU0aMrieQ1WV/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737954262; c=relaxed/simple;
	bh=xBNoXLXvaTldBWNpNe24PdMvQe0Wu6XrWuUeZyrVQ4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gV7Z1fa7HpV+2UlvGcpOpF9RWqU5dfzds7/Wjn9YTQvSLywFYolawuDZImhaVA1JIFvsaaDmChlYDq2AItagrx6BZxBqDHlBD3mmE1LyjCYbBmkFi1wKcCroZEBv8FnkJ4/FKGk3hgF4eDQxlEfLivYaT8PNmvmJx+SuK7hDljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jYMJ3F/j; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xT9F/RFdKtk5OzK8AQYzsZ/3h+Z8KyH5het+sIQGzCQ=; b=jYMJ3F/j2kGZiATTBD4dvFqwds
	jNwOhE53FvO6ss+ikAuDcFyZ3ZdaXPfu741xu7ZqTPjeWNoyI3cBzRdN26FgVpWIylhpx6zvMQdlS
	U4qonSMd4H6zF02WZud0iQUiL/o8nL9ng2n8MFgwL+U3KU5IKX5CFUnF46qNyXe3hhRabBSI3tFep
	WBDl9tQL4qvaM88srg5gfnvfi/fTJqAaFzAFO8zcbwQnU7THHgcQ3Xpq2z7CeuNE+amtgA6Fex87F
	O33JgG/xDlCCtgTQO3mZLXJMc0nVpr6qHrrxI1PKiI460lJpeOTqtePRND8z8RWfB3cRJvEZIB+yH
	fPIiolXA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcHIG-0000000Ct3Q-3b0i;
	Mon, 27 Jan 2025 05:04:16 +0000
Date: Mon, 27 Jan 2025 05:04:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: Regression on linux-next (next-20250120)
Message-ID: <20250127050416.GE1977892@ZenIV>
References: <SJ1PR11MB6129D7DA59A733AD38E081E3B9E02@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250123181853.GC1977892@ZenIV>
 <Z5Zazwd0nto-v-RS@tuxmaker.boeblingen.de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5Zazwd0nto-v-RS@tuxmaker.boeblingen.de.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jan 26, 2025 at 04:54:55PM +0100, Alexander Gordeev wrote:

> > > Since the version next-20250120 [2], we are seeing the following regression
> > 
> > Ugh...  To narrow the things down, could you see if replacing
> >                 fsd = kmalloc(sizeof(*fsd), GFP_KERNEL);
> > with
> >                 fsd = kzalloc(sizeof(*fsd), GFP_KERNEL);
> > in fs/debugfs/file.c:__debugfs_file_get() affects the test?
> 
> This change fixes lots of the below failures in our CI. FWIW:
> 
> Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>

The real fix follows:

[PATCH] Fix the missing initializations in __debugfs_file_get()

both method table pointers in debugfs_fsdata need to be initialized,
obviously...

Fixes: 41a0ecc0997c "debugfs: get rid of dynamically allocation proxy_ops"
Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index e33cc77699cd..212cd8128e1f 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -111,6 +111,7 @@ static int __debugfs_file_get(struct dentry *dentry, enum dbgfs_get_mode mode)
 				fsd->methods |= HAS_READ;
 			if (ops->write)
 				fsd->methods |= HAS_WRITE;
+			fsd->real_fops = NULL;
 		} else {
 			const struct file_operations *ops;
 			ops = fsd->real_fops = DEBUGFS_I(inode)->real_fops;
@@ -124,6 +125,7 @@ static int __debugfs_file_get(struct dentry *dentry, enum dbgfs_get_mode mode)
 				fsd->methods |= HAS_IOCTL;
 			if (ops->poll)
 				fsd->methods |= HAS_POLL;
+			fsd->short_fops = NULL;
 		}
 		refcount_set(&fsd->active_users, 1);
 		init_completion(&fsd->active_users_drained);

