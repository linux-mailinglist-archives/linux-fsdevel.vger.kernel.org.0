Return-Path: <linux-fsdevel+bounces-48995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F1EAB7416
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 20:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70808C6D24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D8E289377;
	Wed, 14 May 2025 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YPqO4Czt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A82882CF;
	Wed, 14 May 2025 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747245926; cv=none; b=Y1Wgg/xLDMlB1yopt08BGos7d1i+JSTasT8WF0P+29EugxHN9pzDUTsdRb3WVYG0mwVzt59H2Wdmtm90x2jE25WNWULKWZT5ETHzYAPXruJh6+gRuKjQbUrKwl9kUzKpIlv4Pl1T4jWGO2Jo880okWltID9T7xcMF9tl8FMzMdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747245926; c=relaxed/simple;
	bh=zDfoVW7qvoNgC2TbrD0z0LsYt8ML5jvy43hMLpKs3vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/lXrCzmi0N11TR+oaMBReadLRxO7l59JfI1ZDJFzAIPjiDZVz+VpibMpP9eh4vbgD3xjlqqLu7hT/MjJgBiYPGtkT7mQUVPuMpZWFgSNZep4pnBiWmsw3CvrfNWV2Bg6JmR2tlEE9d/sUdSxYX46nrnZWXX89Hri1MGvCjMo2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YPqO4Czt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zDfoVW7qvoNgC2TbrD0z0LsYt8ML5jvy43hMLpKs3vE=; b=YPqO4CztfQl9xMbA/5HXwAwgkt
	7fPeOc7bfuwx5ORKkP3QywQi4i1p4u7ipDd1BRuEn7jnlfbss7GkM4vjWfGLdF/39itxK6KjjIB2p
	EgcLBWqIcb5t+JFz2D9SSyboCZ+M7FBDJ+H0wzV1MMFnqvJrt7Ejzqt2y6Dd/einRLgm8o6fc+PZD
	kPXAWCQl0e05QxKKOcN1RKU3/GGwe3FKhV+FskDyAqzbzV9q7OeQM2mfzHaJcVF1MBzuR/Fucgm6q
	7agPm0JDJH+csrznSNrFoJQv8UscKEUVxpPvIELcFhmX3q1L9++hqegLsvQ0JYQXuqVUDXeQ8SxCJ
	RtEWgwWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFGTp-00000009Q2B-3n6l;
	Wed, 14 May 2025 18:05:21 +0000
Date: Wed, 14 May 2025 19:05:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+799d4cf78a7476483ba2@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, cem@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] general protection fault in do_move_mount (3)
Message-ID: <20250514180521.GN2023217@ZenIV>
References: <6824d556.a00a0220.104b28.0012.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6824d556.a00a0220.104b28.0012.GAE@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

Already reported yesterday...

#syz test: git://git.kernel.org//pub/scm/linux/kernel/git/viro/vfs.git fixes

