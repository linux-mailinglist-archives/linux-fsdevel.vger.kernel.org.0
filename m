Return-Path: <linux-fsdevel+bounces-42855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AA5A49B0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 14:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFC43AD961
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5548526D5D3;
	Fri, 28 Feb 2025 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HZja0rt1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EKbEXUzQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v6hT9j83";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4OCbwd70"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BAD25F984
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750955; cv=none; b=QC8lF69nCW4JYvch0wbtgS6hmJLL/23c7+sM27SdksOh75vbIobSiwvGPpul3T5fvnSAVTAO0ILQuflZq7qM9+eB4RVBxxH6Oyy0+sWQWl0Tkm1SB+8+PPca13E79Ykmcz2bcispzisaMantHX4mpuJTJ8MGvzixjgpstaQV8/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750955; c=relaxed/simple;
	bh=+WqeiIJb4j75GPAXrEevIo+zv8XKGSOUbD+/cXz7EqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDubNFA9oEPfFZ4q/hzcDmuPVXd3zGnxjuUZA3pAq3zUQ9S5FP/3+qxs2twsOJsGSRhum9bqwPL/+Zi1t1TPDOWLGL5T5pH63mR4e6ME+EGxe6BDpjfqR98NlEscPpenYdxs35Lp7/4VraP4GWnAOyiMXeIlbAxg/a3qMVWNDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HZja0rt1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EKbEXUzQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v6hT9j83; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4OCbwd70; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E31A01F38F;
	Fri, 28 Feb 2025 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740750952;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPt5sHGWmn/KstzopdmY0CQ8/tw2Eh65XhRod/YG23A=;
	b=HZja0rt1TfCPVgLYCtj8ee1OjbBCVykoWxJnfRZ1jTQT1RAzEKErmlD8ECNJ+OQvbeV+HU
	BdjIRzwP5QkTfMFT8T/R/tuRIo6rXyONPlrZ7jO5/qWrxKSJy9LxzMYirsY70a4z+zpYlZ
	LVLD9fTibMox/FP6eAB9mqqiIwpv+gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740750952;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPt5sHGWmn/KstzopdmY0CQ8/tw2Eh65XhRod/YG23A=;
	b=EKbEXUzQYhi6oNCSEnv24vxTUVo20BFGzKjeNfO7uS47m3S5zNUxjgJ9ZOklpQHBsVZT6J
	zcdBVbuPZh/Gl/AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v6hT9j83;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4OCbwd70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740750951;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPt5sHGWmn/KstzopdmY0CQ8/tw2Eh65XhRod/YG23A=;
	b=v6hT9j83xDzKSN8+gXif6WdMp7s2ZHmf9zRiWdfkI6nxyxCiyOjeBaVbmcNlaVbmQwN5Ir
	5Quc1MC0DoJVbOySxQqdoqewBF0H8P1ryJzBeT/iZVY7yy0OsgRHPoE68Bf9CyHafcB3oW
	G/JHTwnzu/9R1lLJBbRQ8gh9vRCeTyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740750951;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPt5sHGWmn/KstzopdmY0CQ8/tw2Eh65XhRod/YG23A=;
	b=4OCbwd70ekNH4FF6YUfl2NAlPDq/k3tW3BFXMpDuFuiZAqyPYLmjXn1C9kRihIgWnIRbbl
	S7cDpKREdphzt7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B662C1344A;
	Fri, 28 Feb 2025 13:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V0lWLGfAwWdQKgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 28 Feb 2025 13:55:51 +0000
Date: Fri, 28 Feb 2025 14:55:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] README: add supported fs list
Message-ID: <20250228135550.GH5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250227200514.4085734-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227200514.4085734-1-zlang@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: E31A01F38F
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Feb 28, 2025 at 04:05:14AM +0800, Zorro Lang wrote:
> To clarify the supported filesystems by fstests, add a fs list to
> README file.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Hi,
> 
> David Sterba suggests to have a supported fs list in fstests:
> 
> https://lore.kernel.org/fstests/20250227073535.7gt7mj5gunp67axr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#m742e4f1f6668d39c1a48450e7176a366e0a2f6f9
> 
> I think that's a good suggestion, so I send this patch now. But tell the truth,
> it's hard to find all filesystems which are supported by fstests. Especially
> some filesystems might use fstests, but never be metioned in fstests code.
> So please review this patch or send another patch to tell fstests@ list, if
> you know any other filesystem is suppported.

The idea is to make the list best-effort, we don't know which of the L1
and L2 are tested. It would be interesting to try them to see the actual
level of support. I kind of doubt that anybody has run e.g. pvfs2 recently.


> And if anyone has review point about the support "level" and "comment" part,
> please feel free to tell me :)
> 
> Thanks,
> Zorro
> 
>  README | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/README b/README
> index 024d39531..055935917 100644
> --- a/README
> +++ b/README
> @@ -1,3 +1,85 @@
> +_______________________
> +SUPPORTED FS LIST
> +_______________________
> +
> +History
> +-------
> +
> +Firstly, xfstests is the old name of this project, due to it was originally
> +developed for testing the XFS file system on the SGI's Irix operating system.
> +With xfs was ported to Linux, so was xfstests, now it only supports Linux.
> +
> +As xfstests has some test cases are good to run on some other filesystems,
> +we call them "generic" (and "shared", but it has been removed) cases, you
> +can find them in tests/generic/ directory. Then more and more filesystems
> +started to use xfstests, and contribute patches. Today xfstests is used
> +as a file system regression test suite for lots of Linux's major file systems.
> +So it's not "xfs"tests only, we tend to call it "fstests" now.
> +
> +Supported fs
> +------------
> +
> +Firstly, there's not hard restriction about which filesystem can use fstests.
> +Any filesystem can give fstests a try.

This could list what are the assumptions of a generic filesystem. For
example the mkfs.$FSTYP and fsck.$FSTYP should exist as the generic
fallback applies (other filesystems have the exceptions that skip eg.
fsck if it's known not to exist).

> +Although fstests supports many filesystems, they have different support level
> +by fstests. So mark it with 4 levels as below:
> +
> +L1: Fstests can be run on the specified fs basically.
> +L2: Rare support from the specified fs list to fix some generic test failures.
> +L3: Normal support from the specified fs list, has some own cases.
> +L4: Active support from the fs list, has lots of own cases.
> +
> ++------------+-------+---------------------------------------------------------+
> +| Filesystem | Level |                       Comment                           |
> ++------------+-------+---------------------------------------------------------+
> +| AFS        |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Bcachefs   |  L1+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Btrfs      |  L4   | N/A                                                     |

https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#fstests-setup

some additional information about required packages, kernel configs and
devices. This could be in fstests/README too.

> ++------------+-------+---------------------------------------------------------+
> +| Ceph       |  L2   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| CIFS       |  L2-  | https://wiki.samba.org/index.php/Xfstesting-cifs        |
> ++------------+-------+---------------------------------------------------------+
> +| Ext2/3/4   |  L3+  | N/A                                                     |

I'd suggest to split ext4 from that and give it L4, not sure if ext2 is
still being tested maybe it's worth L3. The standalone Ext3 module does
not exist and is covered by ext4, so it probably works with fstests but
is interesting maybe only for historical reasons.

> ++------------+-------+---------------------------------------------------------+
> +| Exfat      |  L1+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| f2fs       |  L3-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| FUSE       |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| GFS2       |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Glusterfs  |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| JFS        |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| NFS        |  L2+  | https://linux-nfs.org/wiki/index.php/Xfstests           |
> ++------------+-------+---------------------------------------------------------+
> +| ocfs2      |  L2-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| overlay    |  L3   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| pvfs2      |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Reiser4    |  L1   | Reiserfs has been removed, only left reiser4            |
> ++------------+-------+---------------------------------------------------------+
> +| tmpfs      |  L3-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| ubifs      |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| udf        |  L1+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Virtiofs   |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| XFS        |  L4+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| 9p         |  L1   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+

The table works as the way to present it but with so few links/comments
writing it as a simple list could give a better idea what filesystems
are in each category. Sorted alphabetically, like:

L4: Btrfs, Ext4, XFS
L3: ...
etc

