Return-Path: <linux-fsdevel+bounces-75646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JAfBowceWmPvQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:14:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9959A455
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A6733055D50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 20:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F8D32ED28;
	Tue, 27 Jan 2026 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HEJ8AHlZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8032ED38;
	Tue, 27 Jan 2026 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544796; cv=none; b=mnopJc4JIlq9BLo8zlBLcK+4MlggSPRN3aIDTjTGl+HmKT5B4ticu8fDA/pvAMBX/yh5QNV4T0czxZhZvtbJDGIa3nXeBfBMFT8MTAl3JQh/8PFEfnnzaDd0KqDF1jmO6qGjwOiD5YTUsuR9pvNAuvaOX49oq3fcLc6HW3BPT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544796; c=relaxed/simple;
	bh=DkWAjAr3ro/0362KFmc8W3ZifYIfv/tTjACTZ8M1odA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVaBXhmxj66ON2s+v2Dc3szyVc/CaH00pgUouBo4Safsu7tgxT93pxOd+ns943FR+Zq8viA8Mlnpz1gPBijQCI/X6JwldXbXqMrWQw3I/vILfS17Nl/sEITUV1Y8VXZ7ho1ahkr4vklTlOpav6w+o7vrsSH0DykQZkW5QLjRc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HEJ8AHlZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BThmTYQxvIJzQkA/L/WO0umKgcoH0NckbPSOFRkaDt4=; b=HEJ8AHlZg14JJPbg8QtNWS1ji2
	tJT/2Fs1T5x5ADAyCAF83hSNvt9o3z0K3RSxk2gUB8Da5/tSbaBFKwqw22nB9KSBEdLXuDL7FqPew
	7Y+0P4xYkRhvZjXTFdCSvNynNniJgE6ZN0ESEh44Vc7Ehkj50lCswNvXEYERPQvdfeH75yQduHjQN
	Pq05K/lmA3+K8RokHDK11A0sXSW/FfXFcjSMTd9/8b2Gfp8Iz6ORbZwkKjtp/91tEjK8DcKs1Smzh
	pMHt05iiq6RxHZG8nxYrYmxa8r2p827g4+Rly5OrSWZkh9CWcaNv1tRLRrbeWiJeWu+s2oV5wvc/f
	Bx+2nTwQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vkpSg-00000001D3Z-2Fqa;
	Tue, 27 Jan 2026 20:14:54 +0000
Date: Tue, 27 Jan 2026 20:14:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Samuel Wu <wusamuel@google.com>,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, clm@meta.com,
	android-kernel-team <android-kernel-team@google.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
Message-ID: <20260127201454.GQ3183987@ZenIV>
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh>
 <CAHk-=whME4fu2Gn+W7MPiFHqwn51VByhpttf-wHdhAqQAQXpqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whME4fu2Gn+W7MPiFHqwn51VByhpttf-wHdhAqQAQXpqw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75646-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_TWELVE(0.00)[25];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AA9959A455
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 10:39:04AM -0800, Linus Torvalds wrote:
> On Mon, 26 Jan 2026 at 23:42, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Note that I had to revert commit e5bf5ee26663 ("functionfs: fix the
> > open/removal races") from the stable backports, as it was causing issues
> > on the pixel devices it got backported to.  So perhaps look there?
> 
> Hmm. That commit is obviously still upstream, do we understand why it
> caused problems in the backports?

This is all I've seen:

| It has been reported to cause test problems in Android devices.  As the
| other functionfs changes were not also backported at the same time,
| something is out of sync.  So just revert this one for now and it can
| come back in the future as a patch series if it is tested.

My apologies for not following up on that one; Greg, could you give some
references to those reports?

