Return-Path: <linux-fsdevel+bounces-5086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513B1807E85
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 03:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D791F219C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 02:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D683A539B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Y5tPjS0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29492D59;
	Wed,  6 Dec 2023 18:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v5tmTLroqHUMtpKAwnHCyW/ATXhF3F/AvQjB5qgH818=; b=Y5tPjS0LxQs70S63dITW2o225k
	H5Y0/WngVyREhx2toB1HqWBZArR+5G7HAEIYvIChsnDaWdQ7p/B8Zf2HXZOXTOSCYWTqMmgY5NwvV
	cRnVVnRABViHc7rIg07RthqUpuSmHymzsffNsF9TJVL5rnbBd8StwFoWD+dEofBVJO+WJCZwRjkBt
	GZXnPvOHiWs7f0Jb7wYEgWngXP7iWHIPRABMMkoAxJUwSoSHVSOSJIJKFaO2szfz6hZF+kVgRL+hy
	y93MJTBvyqg6LGey/Qp+9THZ+r0X7mADweNQT7xmO45SO1wakE8NZ5KnQbdKp50NmVQ17OX4OSZRQ
	f1UDQK6A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rB46N-00835V-1p;
	Thu, 07 Dec 2023 02:26:59 +0000
Date: Thu, 7 Dec 2023 02:26:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-cachefs@redhat.com, dhowells@redhat.com, gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] vfs: Remove unnecessary list_for_each_entry_safe()
 variants
Message-ID: <20231207022659.GT1674809@ZenIV>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-3-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206060629.2827226-3-david@fromorbit.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 06, 2023 at 05:05:31PM +1100, Dave Chinner wrote:
> From: Jan Kara <jack@suse.cz>
> 
> evict_inodes() and invalidate_inodes() use list_for_each_entry_safe()
> to iterate sb->s_inodes list. However, since we use i_lru list entry for
> our local temporary list of inodes to destroy, the inode is guaranteed
> to stay in sb->s_inodes list while we hold sb->s_inode_list_lock. So
> there is no real need for safe iteration variant and we can use
> list_for_each_entry() just fine.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Waiman Long <longman@redhat.com>

ACKed-by: Al Viro <viro@zeniv.linux.org.uk>

