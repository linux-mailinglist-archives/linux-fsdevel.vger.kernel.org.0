Return-Path: <linux-fsdevel+bounces-70343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9C9C97C51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 15:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AF63A21C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 14:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5BF317701;
	Mon,  1 Dec 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Q1Rn0lHV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF3236D4F7;
	Mon,  1 Dec 2025 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598020; cv=none; b=X5FW290n/7tusIfJ1mq3HykVQevFROFnm/HtZtFJWneEpqJkohpYn+3GT5r30Y2qrRQ1AYtJS1xGEtGklbGg++q85Z4LGhYfzobkMw67AvigEXmeYMbRxmkRFy7vbU/kduf9N48qdU0sOKmKtYCUrXn9FUlbgr/7UWO38XuRN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598020; c=relaxed/simple;
	bh=xkJV2RQ5thOHN5xLDiAtxUQi4p9zL3HGEOIM9nz6ZFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfM8EHCT4RCzblj8XBnPa1W1E7pHU3NiQ1wxeyhSzjOqKuMdCTBqQUOPVNnueNMwm60JpbRuZFMVfxozWqFuIEZg5JdW8vZiROgLjg4/4yLJPnqDpCk21BmDwoHnP7BbXAlsDByAEML/SKg96ocbIS+vpoynXP0BhDgjKm6fINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Q1Rn0lHV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NJSpfg09ytdxsDNnz399hBNN4+NwPk9HPsXaFaTD/Vo=; b=Q1Rn0lHVWATCGNDptbtIctMGKp
	2kVg12vgNnDUfmo+VMq9EONH2qn9fM9/BE05/Z3btpbBIPgo5pt3dOymfPAglkVLvJdmqzws8ky1w
	bikQkJP/lO7m46OGz1vwLFkI/z+PVJaWB4mDmSSGEw65/FHYW/TxKv67IJXT9+ryKIsxqLnIdbfsR
	sxKaXhIpkBLQWgPSBk/xDf3Xzp7AvGHS7Mj3b40WytmFtmDWP/3RwBpUtB+9ldBzOBnamPynHEAvw
	/xNh5Bj4jh3siVwEA8QlUejG8tNwtCsx90xbpCQUrB3zQrrs9VbEPpCLlIPhyJmucsdNj+koUW29o
	tB+wm82Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vQ4YV-00000000IVw-2vBB;
	Mon, 01 Dec 2025 14:07:07 +0000
Date: Mon, 1 Dec 2025 14:07:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: syzbot <syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com>,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [syzbot] [fs?] kernel BUG in sctp_getsockopt_peeloff_common
Message-ID: <20251201140707.GF3538@ZenIV>
References: <692d66d3.a70a0220.2ea503.00b2.GAE@google.com>
 <cenhvze4xmjyddtovfr36c767ttt2dgbprtr4zef6n7wrkgrze@mnzax7kfeegk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cenhvze4xmjyddtovfr36c767ttt2dgbprtr4zef6n7wrkgrze@mnzax7kfeegk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 01, 2025 at 01:57:11PM +0100, Mateusz Guzik wrote:

> I suspect this is botched error handling in the recent conversion to
> FD_PREPARE machinery.

Quite.  FWIW, at that point I believe that FD_ADD/FD_PREPARE branch
is simply not ready - too little time in -next, if nothing else.

Christian, drop that pull request, please.

