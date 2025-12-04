Return-Path: <linux-fsdevel+bounces-70630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A27CA2C73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 09:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 206BE301CD03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4C2329377;
	Thu,  4 Dec 2025 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SXdZd7B5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55A8186284;
	Thu,  4 Dec 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836508; cv=none; b=U0UUb5vqAw7AdsKCZykW4oXAwbubYybBrQEZg9eSbDwKhYdzjh5a0SaMtkFHp8xtB18e6P2DdfSxSAdccih9NVAYcEf/POuoLYNRpWe/U1lS40c5sXXYWdfnTD9K3Ev6GXeRAR2/vR8w2ZvV3Jzxg3M/1uruuuNpmd72XyK0t5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836508; c=relaxed/simple;
	bh=PE6qdcEhxrzvlSc5U+vub1yOo/YkufcFoqLqH+CSHlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reU6YS+XAjd+P+XON6HMvI2YrWtZgVwdmC7rrH/xXGBEFaOBmBYYAASeKD50Qv4QlCmF/gQ835d/FjhW69M1MJlUohh7QXcwhVnKLMktgImk5blS+5BC3Ztm5rhVA0H2Yfs5ynKev38PdhgyprheFNEn8iyODP21d5AEmPCL20s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SXdZd7B5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sY1vnamtudP1dKn2X3+WXVg5qyT9YG11qfCn5X7j9FE=; b=SXdZd7B5mVDES/vmkJj+ZxrU4B
	M6lNwV/X1ZVlvPAfjnVuq+BIldZjHba0aKnI4W9BI7XtvqHnfYunWC4oHSHrgse/yNg+T/NjUyAsJ
	bniiPzpPR20i/AuXpYYuBcW1bPqkWZf4gfTngZANNaiXhQV3FdYsq9XODVXN2d3nZm+glZNi0Kv60
	QGTsNsWeGXz2fkIIE5nkN9lRSLCfMiJ8h7rJf1+UUmZ0aabvcBkRG390/buOCxfyAqYpydZSbNa7t
	7XmmAizReOBj24Qcujft7XCaYotoxZUc9Aj8Ik1dPD9sxDNgS3lKjS3saKMMX7xYvNGBNGb4c+v1p
	r9ewQUgw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vR4b6-0000000C5EO-3YDn;
	Thu, 04 Dec 2025 08:21:56 +0000
Date: Thu, 4 Dec 2025 08:21:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>,
	brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	mark@fasheh.com, ocfs2-devel@lists.linux.dev,
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
Message-ID: <20251204082156.GK1712166@ZenIV>
References: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj>
 <6930e200.a70a0220.d98e3.01bd.GAE@google.com>
 <CAGudoHE0Q-Loi_rsbk5rnzgtGfbvY+Fpo9g=NPJHqLP5G_AaUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHE0Q-Loi_rsbk5rnzgtGfbvY+Fpo9g=NPJHqLP5G_AaUg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 04, 2025 at 08:45:08AM +0100, Mateusz Guzik wrote:

> Or to put it differently, lookup got entered with a bogus state of a
> dentry claiming it is a directory, with an inode which is not. Per the
> i_mode reported in the opening mail it is a regular file instead.
> 
> While I don't see how this can happen,

->i_op set to something with ->lookup != NULL, ->i_mode - to regular.
Which is to say, bogus ->i_mode change somewhere.

Theoretically it should bail out, having detected the type change
(on inode_wrong_type()).  I'd suggest slapping
	BUG_ON(inode_wrong_type(inode, new_i_mode_value));
in front of all reassignments (ocfs2_populate_inode() is the initialization
and thus exempt; all other stores to ->i_mode of struct inode in there
are, in principle, suspect.  Something like inode->i_mode &= ~S_ISUID
doesn't need checking - we obviously can't change the type there.
Unpleasant part is that struct ocfs2_dinode also has a member called
i_mode (__le16, that one), so stores to that clutter the grep results...

