Return-Path: <linux-fsdevel+bounces-48997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6034AB7432
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 20:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D343A7D14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B721128136E;
	Wed, 14 May 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UqzkdvsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D5F1ACEDA;
	Wed, 14 May 2025 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747246876; cv=none; b=UdS3B1E9w3azDi2ErAEPapB5uWYkHbACNImuY50EBEL1B2melU4Ne/EirCWDagGRbzLYN1C938XJRyAeZP1pvwJJT5AQP/qrXIyMS/JmHWHGLXiUr9CMgmofiPp/f5C+mcD3oCBtCzja9ETQ0jhsWiOfOlJ4jJNFR5oLjT8ddMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747246876; c=relaxed/simple;
	bh=3HrNhq/4VZeyOc+vQpUKyW6B6Lzxf93AdxsgM/6niew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5nW4R7bf39zHorpmM5yTiR2JdJuee+EwY0Fq/9JSCnnH7By4oedKQqtcGzcVSiJ4QRFfr4gsvCn9uWOSeHs394FqroQ44bwIHyudsWHRrtLlMhhLQ3Jt3DJWGQYtYGpR1mJgPN2k0XgszqSMUsE7/4++xkEAkrFMUd5XZOXOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UqzkdvsE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uBqZXh7umPeufqcIkZj7q/kN2JQYyR31FjjXxN5ECog=; b=UqzkdvsEJLykRIzYinQEF4hCaN
	k0Rdxzck4I3cjt4f6sVajDv44Gb5qBOg1Y8inZ3rRvAtkgfrOs/RitXvk2v9q5jZzAJG2mY5T1tet
	81kkeNyeq0VSOKWzXZBJqIObRzZ8EhnzHRY4gsGjwjB6cIYsuoNG1f6nwVRGmRReEj8HnPRKFkvJM
	asLUTbsUsB4r3sSJzdQxlPBw4zAgDqCEddyHhV0xwKHV80dgdKKx0FWsENr10Ow9C9m8bYsLX2Tk6
	zfe7aqdtQmG0caY1swCYxtSt22pOxE6yE/ypw6N6iCvrYiqEAVp5HWcthcGD94ou/Ndobs3vv7v/b
	DPortUJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFGj9-00000009TF4-1fQs;
	Wed, 14 May 2025 18:21:11 +0000
Date: Wed, 14 May 2025 19:21:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+799d4cf78a7476483ba2@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, cem@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] general protection fault in do_move_mount (3)
Message-ID: <20250514182111.GO2023217@ZenIV>
References: <20250514180521.GN2023217@ZenIV>
 <6824dd34.a00a0220.104b28.0013.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6824dd34.a00a0220.104b28.0013.GAE@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 14, 2025 at 11:13:08AM -0700, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> failed to checkout kernel repo git://git.kernel.org//pub/scm/linux/kernel/git/viro/vfs.git/fixes: failed to run ["git" "fetch" "--force" "8a6d8037a5deb2a9d5184f299f9adb60b0c0ae04" "fixes"]: exit status 128
> fatal: remote error: access denied or repository not exported: //pub/scm/linux/kernel/git/viro/vfs.git

*blink*

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git 8a6d8037a5deb2a9d5184f299f9adb60b0c0ae04

just in case the cut'n'paste damage (extra slash before 'pub') was not
the only problem there...

