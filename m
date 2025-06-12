Return-Path: <linux-fsdevel+bounces-51398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD0AD66C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 06:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE60C3AC19C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 04:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2EA1DF977;
	Thu, 12 Jun 2025 04:30:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839128382;
	Thu, 12 Jun 2025 04:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749702640; cv=none; b=Hnai8BSU45j/g1GJDFAp4opnzRhWarNI2gLyvqECSLgu1JUd1AhkKmi++BkrQYlDkIwi5JKo2wVmoCD5unwM9/o28rwbwhSK6St+A2RcBlfVWfopZRZc5bekrzRZq2cYPfWnMAcde9IQMJOssCgUz5RwoBSg7kVNsfC7dyjCkJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749702640; c=relaxed/simple;
	bh=KtZUjJAg2eQN1hqERrYkxxQnWfsOhN7ohu1dvZH3944=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=VdI+UWobTeui35G0tPUdUXD0jGS2LmPkrIGCSVrVmTlaYqjn7n2IPT1Cum157umVzOA8n2rSkJY3K7k9eYbvy1FIPGIhmDGe+Ffhr6hB0y8xyC8RC2xLRyMUZaY2YI2Ou6XsUUyHy3L5DSVFzEbnvPgmh/a7THZ1x2/62Jay7Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uPZa0-008YSz-KI;
	Thu, 12 Jun 2025 04:30:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Amir Goldstein" <amir73il@gmail.com>,
 "Kees Cook" <kees@kernel.org>, "Joel Granados" <joel.granados@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>, netfs@lists.linux.dev,
 linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 2/2] fs/proc: take rcu_read_lock() in proc_sys_compare()
In-reply-to: <20250611233306.GA1647736@ZenIV>
References: <>, <20250611233306.GA1647736@ZenIV>
Date: Thu, 12 Jun 2025 14:30:20 +1000
Message-id: <174970262010.608730.16666030974664097741@noble.neil.brown.name>

On Thu, 12 Jun 2025, Al Viro wrote:
> On Thu, Jun 12, 2025 at 08:57:03AM +1000, NeilBrown wrote:
> 
> > However there is no guarantee that this lock is held by d_same_name()
> > (the caller of ->d_compare).  In particularly d_alloc_parallel() calls
> > d_same_name() after rcu_read_unlock().
> 
> d_alloc_parallel() calls d_same_name() with dentry being pinned;
> if it's positive, nothing's going to happen to its inode,
> rcu_read_lock() or not.  It can go from negative to positive,
> but that's it.
> 
> Why is it needed?  We do care about possibly NULL inode (basically,
> when RCU dcache lookup runs into a dentry getting evicted right
> under it), but that's not relevant here.
> 

Maybe it isn't needed.  Maybe I could fix the warning by removing the
rcu_dereference() (and the RCU_INIT_POINTER() in inode.c).  But then I
might have to pretend that I understand the code - and it makes no
sense.

If a second d_alloc_parallel() is called while there is already a
d_in_lookup() dentry, then ->d_compare will return 1 so a second
d_in_lookup() will be created and ->lookup will be called twice
(possibly concurrently) and both will be added to the dcache.  Probably
not harmful but not really wanted.

And I'm having trouble seeing how sysctl_is_seen() is useful.  If it
reports that the sysctl is not visible to this process, it'll just
create a new dentry/inode which is that same as any other that would be
created... 

NeilBrown

