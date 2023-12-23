Return-Path: <linux-fsdevel+bounces-6839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA5481D54B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 18:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E021C214D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E8314F90;
	Sat, 23 Dec 2023 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGjc16AT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2BE12E71;
	Sat, 23 Dec 2023 17:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5621DC433C8;
	Sat, 23 Dec 2023 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703352545;
	bh=7xG6o54wRSyxhLE5knTREAIYMUB47waY0f2uTnrJ8Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGjc16ATLDegO3xcDc4uo3f6yfiQzSUA2ip8Lfmg7uIgVBm84VUfpA7fdKtjtQQX2
	 mCEStsb6okKJO0jI6XNhhImL2WgbTaQ6cOT5uvz9kfPlpCC3Cy3fmy7PksUfrKJjmu
	 SQj2gEx3c3zy6WoFu1sJV5+bmA0dl0AyvtOJpCaigrxgv4DBqj4j4xo9ugO6hV2z6d
	 sKOmklTMiLes054XPs2Uka7IMCJXmS6e3dYQBa/EYbGoNSdffgLRDFKjqDwzqpY3Br
	 HEskgr05zQdv+o11jRs1yqfLNLSJzefrqZCLOc3q4zboFQbZ+DfuRa1UJSBK5omam4
	 d4OOg7/WaXLNw==
Date: Sat, 23 Dec 2023 17:28:58 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org,
	Markus Suvanto <markus.suvanto@gmail.com>,
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
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Edward Adam Davis <eadavis@qq.com>
Subject: Re: [GIT PULL] afs, dns: Fix dynamic root interaction with negative
 DNS
Message-ID: <20231223172858.GI201037@kernel.org>
References: <1843374.1703172614@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1843374.1703172614@warthog.procyon.org.uk>

+ Edward Adam Davis <eadavis@qq.com>

On Thu, Dec 21, 2023 at 03:30:14PM +0000, David Howells wrote:
> Hi Linus,
> 
> Could you apply this, please?  It's intended to improve the interaction of
> arbitrary lookups in the AFS dynamic root that hit DNS lookup failures[1]
> where kafs behaves differently from openafs and causes some applications to
> fail that aren't expecting that.  Further, negative DNS results aren't
> getting removed and are causing failures to persist.
> 
>  (1) Always delete unused (particularly negative) dentries as soon as
>      possible so that they don't prevent future lookups from retrying.
> 
>  (2) Fix the handling of new-style negative DNS lookups in ->lookup() to
>      make them return ENOENT so that userspace doesn't get confused when
>      stat succeeds but the following open on the looked up file then fails.
> 
>  (3) Fix key handling so that DNS lookup results are reclaimed almost as
>      soon as they expire rather than sitting round either forever or for an
>      additional 5 mins beyond a set expiry time returning EKEYEXPIRED.
>      They persist for 1s as /bin/ls will do a second stat call if the first
>      fails.
> 
> Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
> 
> Thanks,
> David
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216637 [1]
> Link: https://lore.kernel.org/r/20231211163412.2766147-1-dhowells@redhat.com/ # v1
> Link: https://lore.kernel.org/r/20231211213233.2793525-1-dhowells@redhat.com/ # v2
> Link: https://lore.kernel.org/r/20231212144611.3100234-1-dhowells@redhat.com/ # v3
> Link: https://lore.kernel.org/r/20231221134558.1659214-1-dhowells@redhat.com/ # v4
> ---
> The following changes since commit ceb6a6f023fd3e8b07761ed900352ef574010bcb:
> 
>   Linux 6.7-rc6 (2023-12-17 15:19:28 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20231221
> 
> for you to fetch changes up to 39299bdd2546688d92ed9db4948f6219ca1b9542:
> 
>   keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry (2023-12-21 13:47:38 +0000)
> 
> ----------------------------------------------------------------
> AFS fixes
> 
> ----------------------------------------------------------------
> David Howells (3):
>       afs: Fix the dynamic root's d_delete to always delete unused dentries
>       afs: Fix dynamic root lookup DNS check
>       keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry

Hi Linus, David, Edward, Networking maintainers, all,

This is a heads up that my understanding is that the last patch introduces
a buffer overrun for which a patch has been posted. Ordinarily I would
think that the fix should go through net. But the above patches aren't in
net yet.

Given a) we're now in a holiday season and b) the severity of this
problem is unclear (to me), perhaps it is best to wait a bit then
post the fix to net?

Link: https://lore.kernel.org/netdev/tencent_7D663C8936BA96F837124A4474AF76ED6709@qq.com/

N.B. The hash in the fixes tag for the fix patch is now incorrect.

For reference the fix, from the link above, is below.
I've fixed the hash for the fixes tag and added the posted review tag.
And added my own SoB, because the patch is in this email.

From: Edward Adam Davis <eadavis@qq.com>

bin will be forcibly converted to "struct dns_server_list_v1_header *", so it 
is necessary to compare datalen with sizeof(*v1).

Fixes: 39299bdd2546 ("keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry")
Reported-and-tested-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Simon Horman <horms@kernel.org>

---
 net/dns_resolver/dns_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 3233f4f25fed..15f19521021c 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -104,7 +104,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 
 	if (data[0] == 0) {
 		/* It may be a server list. */
-		if (datalen <= sizeof(*bin))
+		if (datalen <= sizeof(*v1))
 			return -EINVAL;
 
 		bin = (const struct dns_payload_header *)data;
-- 
2.43.0



