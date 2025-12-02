Return-Path: <linux-fsdevel+bounces-70454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80793C9B96A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 14:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21810347DB5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057F314B93;
	Tue,  2 Dec 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bn9oyud0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9E3148DD
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764682025; cv=none; b=Co05yesh9YltBSnRLkJHjZpZYY7/G2/OYqW7r/1UDmpkD5Cwwq8IEAFQesi9TVfBlEUaLICqQ8MgNjDj04yq+xf5fMWy+Gp0zREpaOu/KXzw76FyXQTitoCRezCGxHvkDDS365q/VjcmwKTxe7jcEkxoQGzBUoAapb//p1uItuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764682025; c=relaxed/simple;
	bh=eb9f46mWLjkor5e33rN5MnjEf42ppEC04fQcT4X3vO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvLdvssBMH7vx29KoFzdrB0dhtNj4KE+V+Ce+YdV92AULTGH1FBUAuMK3+dN48hbz+V+XPUBP+a7wtHr8/083rKKr8ZptoQu6fM1DmCIvsRBXR6d0mmRnTXXPkV9KK/L2WNhvDPgGor1mFjZG4tZxsLiNrhV9wOA2LVDsDnv6Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bn9oyud0; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-102-12.bstnma.fios.verizon.net [173.48.102.12])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B2DQjTa020557
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Dec 2025 08:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764682008; bh=qsBJ4L0WYEajRt+TV44WQ+0HqqsSol1QaEK5jO/2vzw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bn9oyud0h/ujMTcppKRHpfqHt4VdfyNSutTfpy5lxAmZPqbpk9lANPsCSveB+DP7E
	 FPzClPjN+Mtt1waGmhWEQWBFgCXyKnODW8x25UHrmyboXgauqP1ctKPBh8U1LxRfSv
	 BdC4xBEwvlw0ci9QHXIuHHrOsiFmDCF+qkk8XQtyf643vvVnMyMY3Lpf/Ikgf9RoHX
	 ygPmVEiITOH3L7RJMzXC3xdtpf1qD5FwR403WnoxhzpYV/rPjFJoObmZF1XkLu4P/N
	 SMqNNX/qvkUoVD51GVNka8mror5cJjfy/uOL6T42+dY+tDyV0wed2LOzjdav5iKuLj
	 OaHc/1EAAAV5A==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 62A824DD6FCB; Tue,  2 Dec 2025 08:25:45 -0500 (EST)
Date: Tue, 2 Dec 2025 08:25:45 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: syzbot <syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: [syzbot] [ext4?] WARNING in __folio_mark_dirty (3)
Message-ID: <20251202132545.GA86223@macsyma.lan>
References: <691f44bb.a70a0220.2ea503.0032.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <691f44bb.a70a0220.2ea503.0032.GAE@google.com>

On Thu, Nov 20, 2025 at 08:41:31AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    23cb64fb7625 Merge tag 'soc-fixes-6.18-3' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1287997c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=38a0c4cddc846161
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0a0670332b6b3230a0a
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172cd658580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15378484580000

Not reproducing locally, so let's see if Syzbot can reproduce in its environment....

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev

