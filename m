Return-Path: <linux-fsdevel+bounces-76640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKELLRBChmmbLQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:33:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8F4102C9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0323C3019807
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 19:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49361330640;
	Fri,  6 Feb 2026 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTTcotFc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D532D949F;
	Fri,  6 Feb 2026 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406152; cv=none; b=U15FIvxlpwr4+Dbcd3kogDahaOydXuj7f+rOQoR2USA+ndiK4mCeMJPPo1ogEO+6pEyEcxqJQhvGqvoaMt1D/wVMzDsD1g6w/MZIk0Yon6EC0G79pSgKMvYUCiQNoLbv6FtBrrFmlalwAViSJxMf3Td6MM+yp7TtyidMV0nF8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406152; c=relaxed/simple;
	bh=H19CTmslTs0mcQ7KjWaj+mu13duhxLwq9lwwVm2UFzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKNz7RXTnkpzHILwoCGVUWMswqWKERHiapYiVY7wQkO24AVcHWGZjeD3ycUEaTA64Qr2tHuER+B7foy4P5wNlQVwvx5DbK/B9XN0hJpmfp/LJz18z4WB6BttrBqeeYJRnND4fPsSEFDKerUZdyeW/ny2SNse8c/zAVAZpQG/6l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTTcotFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1BFC116C6;
	Fri,  6 Feb 2026 19:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770406152;
	bh=H19CTmslTs0mcQ7KjWaj+mu13duhxLwq9lwwVm2UFzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTTcotFc3gc6fmpzfmk7wakAZ1AsWntoMJIyKzjixY73Fwi/P8uUfjpRwICRn8ocx
	 NhCuApAq3PMLhEED38jc0PvFJ25mkBNzXmfIV812ioxFPFerTh21KMUuBxD6Z0bLu1
	 X2q3n8ZQ1AQ3slKJL9vUN+XBzIQEQ8/xzjCaQ3wp/vtdMCsnbkbDL/cxwRb+6n5KNM
	 b6T/ar4qMfYDk1tMFSJcrPARgPGrR/ZTyaL1x2UHbMnKLX33rtw339NvIBxOsjEvIP
	 Mj6xeJy2cfZV+zT5yyICulr7XHNNPTSJDZhRGECDzAr92DCViFoa0NYVgrriXp5ZDs
	 9H7A2WmFARSdQ==
Date: Fri, 6 Feb 2026 11:29:11 -0800
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
Message-ID: <202602061032.63DD1CA3AE@keescook>
References: <CAHPqNmzBb2LruMA6jymoHXQRsoiAKMFZ1wVEz8JcYKg4U6TBbw@mail.gmail.com>
 <aYX4n42gmy75aw4Y@smile.fi.intel.com>
 <aYYD3rxyIfdH2R-d@smile.fi.intel.com>
 <aYYE4iLTXZw5t0w_@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYYE4iLTXZw5t0w_@smile.fi.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76640-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,mit.edu,dilger.ca,vger.kernel.org,googlegroups.com,kernel.org,linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0D8F4102C9F
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 05:12:34PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 06, 2026 at 05:08:19PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 06, 2026 at 04:20:15PM +0200, Andy Shevchenko wrote:
> > > On Mon, Feb 02, 2026 at 12:19:45PM +0800, 李龙兴 wrote:
> > > > Dear Linux kernel developers and maintainers,
> > > > 
> > > > We would like to report a new kernel bug found by our tool. The issue
> > > > is a WARNING in ext4_fill_super. Details are as follows.
> > > 
> > > First of all, the warning appears in parse_apply_sb_mount_options().
> [...]
> Actually, the documentation says that strscpy*() must be used against C-strings.
> This can explain the bug, id est the given string in mount options is not
> NUL-terminated. That's where bug may come from. So, the Q is why is mount options
> not NUL-terminated when it comes to ext4_fill_super()?

parse_apply_sb_mount_options(...):
	...
        char s_mount_opts[64];
	...
        if (strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts) < 0)
                return -E2BIG;

Is sbi->s_es->s_mount_opts expected to be a C string? If not, this
strscpy_pad() should likely be memtostr_pad(). (s_mount_opts is expected
to be a C string based on its use with later C string API calls.)

It seems like s_mount_opts is expected to be a C string, I can see it
being used that way in lots of other places, e.g.:

fs/ext4/ioctl.c:        strscpy_pad(ret.mount_opts, es->s_mount_opts);
fs/ext4/ioctl.c:        strscpy_pad(es->s_mount_opts, params->mount_opts);
fs/ext4/super.c:        if (!sbi->s_es->s_mount_opts[0])
fs/ext4/super.c:        if (strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts) < 0)

I can't tell where es->s_mount_opts comes from originally?

This one:

fs/ext4/ioctl.c:        strscpy_pad(es->s_mount_opts, params->mount_opts);

comes through ext4_ioctl_set_tune_sb() which has:

        if (strnlen(params.mount_opts, sizeof(params.mount_opts)) ==
            sizeof(params.mount_opts))
                return -E2BIG;

So it's already checked for, and suggests it must be NUL-terminated.

> > > > loop4: detected capacity change from 0 to 514
> > > > ------------[ cut here ]------------
> > > > strnlen: detected buffer overflow: 65 byte read of buffer size 64
> > > > WARNING: CPU: 0 PID: 12320 at lib/string_helpers.c:1035
> > > > __fortify_report+0x9c/0xd0 lib/string_helpers.c:1035
> > > > [...]
> > > > Call Trace:
> > > >  <TASK>
> > > >  __fortify_panic+0x23/0x30 lib/string_helpers.c:1042
> > > >  strnlen include/linux/fortify-string.h:235 [inline]
> > > >  sized_strscpy include/linux/fortify-string.h:309 [inline]
> > > >  parse_apply_sb_mount_options fs/ext4/super.c:2486 [inline]
> > > >  __ext4_fill_super fs/ext4/super.c:5306 [inline]
> > > >  ext4_fill_super+0x3972/0xaf70 fs/ext4/super.c:5736
> > > >  get_tree_bdev_flags+0x38c/0x620 fs/super.c:1698
> > > >  vfs_get_tree+0x8e/0x340 fs/super.c:1758
> > > >  fc_mount fs/namespace.c:1199 [inline]
> > > >  do_new_mount_fc fs/namespace.c:3642 [inline]

So, something via do_new_mount_fc? Probably:

static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)

which calls __ext4_fill_super(), and eventually
parse_apply_sb_mount_options(). Which depends on:

        struct ext4_fs_context *ctx = fc->fs_private;

But I can't figure out where that comes from. Seems like fs_parse(), but
I don't see where mount option strings would come through...

Anyone more familiar with this know?

-Kees

-- 
Kees Cook

