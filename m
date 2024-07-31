Return-Path: <linux-fsdevel+bounces-24658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72571942735
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 08:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30340283E1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 06:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8C51A3BDF;
	Wed, 31 Jul 2024 06:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZngjHPP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C37D16CD17
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408891; cv=none; b=oKQAhAulMKnMJRDzwIyoHOE24ySccsw9ufAJyYDrKA0GiMr2O6cHtCgq+23T8aDd2kX63NNWvUCqZ/AXSo2ni7R9R/gXL3S6Re63yJ8rLZoZ5YxfzYa+JiKxmNvScXueHP5iPWrYHh9NnEHGxe2JOztVEgeXKNtysgaYkONc/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408891; c=relaxed/simple;
	bh=vsmgInSdh9YrklZh2sRsF4QijpDU1eDuLPf7py+lIdI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YC2kBtXdc3QdtBq1Zr9ZdLFJ0lAGjigUZoooG/4MjC2MyNZvphm9iasJKgA+sVwpFMvi9wnyPQYFRI2wot9XGodRKDhYR3c25dcBnbizP+A821M7uqGuJpQ7WPdZER/WaJOSzDtbu6a5+zUvzgV8/XeYYml4Gz8nuWssuyrKw0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZngjHPP4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=N5r7d+Od8opX3gud3ENFkClXJ+ObUReh2rSG0it8S78=; b=ZngjHPP4HFW4hV0EK8hUs/OrUg
	SEpbyoFOZNTKu8Bcsew0MGPRfq+ZNxL4xHf71/aawrSgDBKOOT9pP3dh3ZJ6ep9F2BzO3VPC0WmJm
	LO1hD15D/iuJEpEDIsg9U+y/gyxW4tvvbDKk0Iy/OJt1UlFkvgwQFdxvKb6D90ztVFKpyeKi7EavU
	9cQLla/OOeAdOmbB4gcwOUlOO1otZfiLKPmRUBwBsekzcTTfwh8gEqMQ3PEwJI5F6cwz8HdRr1bn/
	PCJVTatx1FqPlJKjL96L7ySY6Z7O2yjWkgLKeF5joODboQtdstxndDvFDvDFoU1rXSzukMwincamy
	hKwvvJ8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sZ3EU-00000000Pav-0sIH;
	Wed, 31 Jul 2024 06:54:46 +0000
Date: Wed, 31 Jul 2024 07:54:46 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Subject: [RFC] why do we have lookup_fdget_rcu() and friends?
Message-ID: <20240731065446.GJ5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	lookup_fdget_rcu() has two callers -
there's
        rcu_read_lock();   
        file = lookup_fdget_rcu(*fd);
        rcu_read_unlock();
in arch/powerpc/platforms/cell/spufs/coredump.c:coredump_next_context()
and
        rcu_read_lock();   
        f = lookup_fdget_rcu(fd);
        rcu_read_unlock();
in fs/notify/dnotify/dnotify.c:fcntl_dirnotify()

Now, look at the lookup_fdget_rcu() definition:
struct file *lookup_fdget_rcu(unsigned int fd)
{
        return __fget_files_rcu(current->files, fd, 0);

}
and compare with this:
struct file *fget_raw(unsigned int fd)
{
        return __fget(fd, 0);
}
static inline struct file *__fget(unsigned int fd, fmode_t mask)
{
        return __fget_files(current->files, fd, mask);
}
static struct file *__fget_files(struct files_struct *files, unsigned int fd,
                                 fmode_t mask)
{
        struct file *file;

        rcu_read_lock();
        file = __fget_files_rcu(files, fd, mask);
        rcu_read_unlock();

        return file;
}

In other words, both calls are weirdly spelled fget_raw().

While we are at it, all callers of task_lookup_fdget_rcu() and
task_lookup_next_fdget_rcu() could bloody well have rcu_read_lock()/
rcu_read_unlock() immediately surrounding those, with the obvious
next step being to push those in.

At that point calls of task_lookup_fdget_rcu() turn into
fget_task(), BTW.

That stuff had been added in "file: convert to SLAB_TYPESAFE_BY_RCU"
as replacements of lookup_fd_rcu() and friends.  The old ones did not
grab file reference; their replacements do (with good reasons).

But that had pretty much killed the rationale behind separate "we are
under rcu_read_lock(), so we don't need to mess with refcounts" family
of helpers.

I might be missing something subtle here; if not, tomorrow morning I'm
going to throw a patch pushing those rcu_read_lock() in (and killing
{task_,}lookup_fdget_rcu()) into the rebased fdtable series from the
last cycle...

