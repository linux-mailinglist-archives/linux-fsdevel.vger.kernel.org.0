Return-Path: <linux-fsdevel+bounces-6861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8242C81D8B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 11:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24BC1C20D3B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7B32591;
	Sun, 24 Dec 2023 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJE0Zlcj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A61C14;
	Sun, 24 Dec 2023 10:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D836C433C8;
	Sun, 24 Dec 2023 10:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703413346;
	bh=Mz3pMSB8AjrvYpQ8ki/iSGNLj09VhVMZQeVWluYkSd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJE0Zlcj+tInWq2AOu3L5Vnjnko/yhnlqURWlLSiYwRt8tmcst790+zxfWdTLgean
	 5RijS9FPQ652dJz8U3/5DQDiZVyd205o63i8bbBlds02njxwKwczlDF28DGZaXZUqh
	 3h4VswN1DXDwLtAIPLxt4/I4cbGsBymBc+CQIbQZez7WAAdaiMWXIOPauUIKWeEDh1
	 O2mTIdogSZ3qO3yDXy51nJ4Z+nbvR6BXAcmEWI1zuBquKtvxOF0aSZJ1USTWK3BYIj
	 yPOTqI58raqlS+JAAAgMwktYS0PZ1bkQfdjK37YZo3NTMG95sKcxnjjDK3hP7RKaOZ
	 ogUsOeHTQN2GA==
Date: Sun, 24 Dec 2023 10:22:19 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Jeffrey E Altman <jaltman@auristor.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Wang Lei <wang840925@gmail.com>, Jeff Layton <jlayton@redhat.com>,
	Steve French <smfrench@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, keyrings@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys, dns: Fix missing size check of V1 server-list
 header
Message-ID: <20231224102219.GB215659@kernel.org>
References: <CAHk-=wgJz36ZE66_8gXjP_TofkkugXBZEpTr_Dtc_JANsH1SEw@mail.gmail.com>
 <1843374.1703172614@warthog.procyon.org.uk>
 <20231223172858.GI201037@kernel.org>
 <2592945.1703376169@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2592945.1703376169@warthog.procyon.org.uk>

On Sun, Dec 24, 2023 at 12:02:49AM +0000, David Howells wrote:
> Hi Linus, Edward,
> 
> Here's Linus's patch dressed up with a commit message.  I would marginally
> prefer just to insert the missing size check, but I'm also fine with Linus's
> approach for now until we have different content types or newer versions.
> 
> Note that I'm not sure whether I should require Linus's S-o-b since he made
> modifications or whether I should use a Codeveloped-by line for him.
> 
> David
> ---
> From: Edward Adam Davis <eadavis@qq.com>
> 
> keys, dns: Fix missing size check of V1 server-list header
> 
> The dns_resolver_preparse() function has a check on the size of the payload
> for the basic header of the binary-style payload, but is missing a check
> for the size of the V1 server-list payload header after determining that's
> what we've been given.
> 
> Fix this by getting rid of the the pointer to the basic header and just
> assuming that we have a V1 server-list payload and moving the V1 server
> list pointer inside the if-statement.  Dealing with other types and
> versions can be left for when such have been defined.
> 
> This can be tested by doing the following with KASAN enabled:
> 
>         echo -n -e '\x0\x0\x1\x2' | keyctl padd dns_resolver foo @p
> 
> and produces an oops like the following:
> 
>         BUG: KASAN: slab-out-of-bounds in dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
>         Read of size 1 at addr ffff888028894084 by task syz-executor265/5069
>         ...
>         Call Trace:
>          <TASK>
>          __dump_stack lib/dump_stack.c:88 [inline]
>          dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>          print_address_description mm/kasan/report.c:377 [inline]
>          print_report+0xc3/0x620 mm/kasan/report.c:488
>          kasan_report+0xd9/0x110 mm/kasan/report.c:601
>          dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
>          __key_create_or_update+0x453/0xdf0 security/keys/key.c:842
>          key_create_or_update+0x42/0x50 security/keys/key.c:1007
>          __do_sys_add_key+0x29c/0x450 security/keys/keyctl.c:134
>          do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>          do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>          entry_SYSCALL_64_after_hwframe+0x62/0x6a
> 
> This patch was originally by Edward Adam Davis, but was modified by Linus.
> 
> Fixes: b946001d3bb1 ("keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry")
> Reported-and-tested-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/0000000000009b39bc060c73e209@google.com/
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: David Howells <dhowells@redhat.com>

Thanks.

FWIIW, I prefer this approach where v1 and bin don't alias each other,
and the scope of v1 is constrained to the block where it is used.

Reviewed-by: Simon Horman <horms@kernel.org>

...

