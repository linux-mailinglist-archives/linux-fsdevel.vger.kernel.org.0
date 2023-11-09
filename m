Return-Path: <linux-fsdevel+bounces-2651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26C27E73CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B1D1C20BCA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539BF38DEE;
	Thu,  9 Nov 2023 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pn6QAj3V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE02138DDD
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:45:40 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7F14204
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ct/qe7Weo4hFoCxTP3B7lRijHBTH9s6gDhm5GV2LjII=; b=pn6QAj3VpB3b3BqXTHBRRy1CQC
	0hRu79zljvxEBnzwGCHZBD5YJVM3ik1vvR9aSOi30mQPcxiBU0f4I2cW8IrXUQ6FVQT9E8edSWORo
	X178+E5OwXyQEjL7Fb/DhHBxSuJqwbycgNnBlKlPFtsN/TJ1Z+zyVMciOomZ8AW1FyR4uUv0kv3or
	gyIcjzYtSUP70TirWRHS8CcGxJk6DlswWQbIJE/akB6XCnI2E/d3qIpIocO2K9XoL1PqYuZO5RXBo
	b+yX6EIaJX6a59YYrN9GAZ+s6oQ0ltfaoUnO2pLP38RyM+vdVVnjQLvug3uyt18rRiRrJP6/VT9Wc
	PKSK8Bqg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r1CqH-00Db61-2p;
	Thu, 09 Nov 2023 21:45:38 +0000
Date: Thu, 9 Nov 2023 21:45:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/22] don't try to cut corners in shrink_lock_dentry()
Message-ID: <20231109214537.GH1957730@ZenIV>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-17-viro@zeniv.linux.org.uk>
 <20231109-designen-menschheit-7e4120584db1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109-designen-menschheit-7e4120584db1@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:08PM +0100, Christian Brauner wrote:

> It's a bit unfortunate that __lock_parent() locks the parent *and* may
> lock the child which isn't really obvious from the name. It just becomes
> clear that this is assumed by how callers release the child's lock.

__lock_parent() is gone by the end of the series.

> We're under rcu here. Are we sure that this can't trigger rcu timeouts
> because we're spinning? Maybe there's a reason that's not an issue here.

Spinning happens only if somebody is busy moving that dentry from
directory to directory or back-and-forth turning it negative/positive
with different inode.  It's not a livelock situation - for each
iteration you need a successful rename() and/or unlink()/creat() pair
on the dentry in question.  Coming rapidly enough to cause you
spinning there...

Note that lock_parent() had that loop under rcu for a long time;
so did dget_parent().  I don't remember seeing rcu timeout warnings
about either...

> That spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED) in
> __lock_parent() is there for the sake of lockdep to verify that the
> parent lock is always aqcuired before the child lock?

Yes.

