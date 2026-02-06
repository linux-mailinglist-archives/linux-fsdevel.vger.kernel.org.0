Return-Path: <linux-fsdevel+bounces-76644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCXrC6pGhmkhLgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:53:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FAA102E88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C73AB300F122
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 19:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5EE335BCD;
	Fri,  6 Feb 2026 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APKc6cMw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2614726ED59;
	Fri,  6 Feb 2026 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407590; cv=none; b=atQl2VPy8rQAlA1DTUMI2fPI4M7XLnvcs5fGWuqBIWBfBZe/+2vyY7zZ4U5CuOyijPv6fJMaO2o6+dUE3U3AX8l9a0MfwfLX7MctxGy9kMgV/vFphZ1YFWDM4SBSw2VYIIeNpP8HZjJIvMHiaAQgdvYBkB6Sk5vn8nWW7t2/jMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407590; c=relaxed/simple;
	bh=lBlkB72HUvOQFuV0uVPFFGeGkIF0carnA0N3Sr9OGcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCYthRZAjmQFg1utqGm1S/MxKIMCkFZG/2WZ4xuD25QYj5Zh3SjT1VvnOD9BAAL/7uZd55j3PSG9X0oM02GxvoidHW01fP7Tngyg0NYVhrv72MRwWwH6SXe3lQ29iyGFQr8ZXy6p5Y8pMEIHReEF8VRr4CNTuePgI0gNtiEHZ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APKc6cMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE927C19422;
	Fri,  6 Feb 2026 19:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770407589;
	bh=lBlkB72HUvOQFuV0uVPFFGeGkIF0carnA0N3Sr9OGcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APKc6cMw6j67oFsTD654c/iapJtc2tWGVClckylUlb98I02Cas4BMDNfPNuNpFGlE
	 AAtizw+MYZDJMCcoyPrlYozT32ADsVmOz2uYCX6jlbQsL7RLqfvCOxYzQqFBINMalm
	 /CqkYPg1YuPTpoTtj+gn5tPOjwCERcFJzjXfJ/RY/9r7kJNVqDGV+y+7qnHAv3iwkf
	 Ly9b645GgHJF1IgXD0SEvG2LFzE1RdwnNhrsWbM8EExu09zL0Ffr8rotlTDoJf+o+f
	 pEYxJvZO9slvcRnjvZIDxjKqEvBFKsGoXfarFBHTUsyqHQZcFIt8tM/rdICqYo7JI+
	 /7SbaE7qCbHdg==
Date: Fri, 6 Feb 2026 11:53:09 -0800
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, syzkaller@googlegroups.com,
	andy@kernel.org, akpm@linux-foundation.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [Kernel Bug] WARNING in ext4_fill_super
Message-ID: <202602061152.EAAF56214@keescook>
References: <CAHPqNmzBb2LruMA6jymoHXQRsoiAKMFZ1wVEz8JcYKg4U6TBbw@mail.gmail.com>
 <aYX4n42gmy75aw4Y@smile.fi.intel.com>
 <aYYD3rxyIfdH2R-d@smile.fi.intel.com>
 <aYYE4iLTXZw5t0w_@smile.fi.intel.com>
 <202602061032.63DD1CA3AE@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202602061032.63DD1CA3AE@keescook>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,mit.edu,dilger.ca,vger.kernel.org,googlegroups.com,kernel.org,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-76644-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4FAA102E88
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:29:11AM -0800, Kees Cook wrote:
> But I can't figure out where that comes from. Seems like fs_parse(), but
> I don't see where mount option strings would come through...

Oh! This is coming directly from disk. So we need an in-place sanity
check. How about this?


diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87205660c5d0..9ad6005615d8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2485,6 +2485,13 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	if (!sbi->s_es->s_mount_opts[0])
 		return 0;
 
+	if (strnlen(sbi->s_es->s_mount_opts, sizeof(sbi->s_es->s_mount_opts)) ==
+	    sizeof(sbi->s_es->s_mount_opts)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Mount options in superblock are not NUL-terminated");
+		return -EINVAL;
+	}
+
 	if (strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts) < 0)
 		return -E2BIG;
 

-- 
Kees Cook

