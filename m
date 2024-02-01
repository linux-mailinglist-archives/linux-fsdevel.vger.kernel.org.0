Return-Path: <linux-fsdevel+bounces-9801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6341E845018
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 05:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35FF28B0AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 04:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4940F3B7AC;
	Thu,  1 Feb 2024 04:17:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27713A8EC;
	Thu,  1 Feb 2024 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761066; cv=none; b=HhJd38RwV9F7XqICyqm5Zya6AW2XKDWDcxK+hYlqL+1bSHCGAuCtXz8NYsGxKakfmDFiV6sS3PLLH4FdYNxijVxiJ4Ezsr+F62pZDDITJd6I0aRIFWXGlLP9EMQF2zIkfG3uZxE0dY+Q/YqF4UrShNUoAXjzDt3kiwzfw6+cs7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761066; c=relaxed/simple;
	bh=1jz/F0H9uzx4iimjF6QGPOPc8awhpHtiBXKNQWRuH20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aw8naRszGXs1c3G6fXo06zUkWhFtqA28V9nl7Fofnjpb6s7MVKxNXX0kHUZx2ZREAGzpn7gX5knnI5HR6yf6/5OMMF4DRpNhJ+K7U4Whi8As/6GHB4aQoLA68uDvIZ+fwDoE93ltTUr98sTqZFGntiNd3Bh7/MigqWekf/eBQUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FAAC433F1;
	Thu,  1 Feb 2024 04:17:44 +0000 (UTC)
Date: Wed, 31 Jan 2024 23:18:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/7] tracefs: dentry lookup crapectomy
Message-ID: <20240131231800.35e3e715@gandalf.local.home>
In-Reply-To: <20240131222127.15b2731b@gandalf.local.home>
References: <20240131184918.945345370@goodmis.org>
	<20240131185512.799813912@goodmis.org>
	<20240201002719.GS2087318@ZenIV>
	<20240131212642.2e384250@gandalf.local.home>
	<20240201030205.GT2087318@ZenIV>
	<20240131222127.15b2731b@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 22:21:27 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> We (Linus and I) got it wrong. It originally had:
> 
> 	d_add(dentry, NULL);
> 	[..]
> 	return NULL;

OK, so I changed that function to this:

static struct dentry *eventfs_root_lookup(struct inode *dir,
					  struct dentry *dentry,
					  unsigned int flags)
{
	struct eventfs_inode *ei_child;
	struct tracefs_inode *ti;
	struct eventfs_inode *ei;
	const char *name = dentry->d_name.name;

	ti = get_tracefs(dir);
	if (!(ti->flags & TRACEFS_EVENT_INODE))
		return ERR_PTR(-EIO);

	mutex_lock(&eventfs_mutex);

	ei = ti->private;
	if (!ei || ei->is_freed)
		goto out;

	list_for_each_entry(ei_child, &ei->children, list) {
		if (strcmp(ei_child->name, name) != 0)
			continue;
		if (ei_child->is_freed)
			goto out;
		lookup_dir_entry(dentry, ei, ei_child);
		goto out;
	}

	for (int i = 0; i < ei->nr_entries; i++) {
		void *data;
		umode_t mode;
		const struct file_operations *fops;
		const struct eventfs_entry *entry = &ei->entries[i];

		if (strcmp(name, entry->name) != 0)
			continue;

		data = ei->data;
		if (entry->callback(name, &mode, &data, &fops) <= 0)
			goto out;

		lookup_file_dentry(dentry, ei, i, mode, data, fops);
		goto out;
	}
 out:
	mutex_unlock(&eventfs_mutex);
	return NULL;
}

And it passes the make kprobe test. I'll send out a v3 of this patch, and
remove the inc_nlink(dentry->d_parent->d_inode) and the fsnotify as
separate patches as that code was there before Linus touched it.

Thanks,

-- Steve

