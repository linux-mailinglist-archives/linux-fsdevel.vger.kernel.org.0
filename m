Return-Path: <linux-fsdevel+bounces-75981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOnQBA9YfWlDRgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:17:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B079CBFEC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3878E3027137
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7646F322C77;
	Sat, 31 Jan 2026 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XqfXg1dJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C01CAA65;
	Sat, 31 Jan 2026 01:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822202; cv=none; b=AjMqjfqOc0VR9vme9MhFKQNQW9VQSVBcHRUTXy/OrjNcRsV8vr8NqBQBAYAnKTWipjHYyN3Y3PUJekAWbTB2pJXgSFtB350TtPS9bls5a5KL0m33RiZNDUfj/mj5A4Ekzl9+IfE5CwCjnHSteAF4F2YvBf4IYluVc8UbH1yl9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822202; c=relaxed/simple;
	bh=s7cpkxammNxh6+d5d+3bqKdN3SPq8TpxVvWIZ8ZCcjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGYifQvBqHVSExSqbiLpMkqMM1bgPCOEC32hAVTVA8c6ossIh9ZtGVUY+VKFrJ3kZk1YeDOdh8oR1yhpUFulIsdYZHNz51qK1Ubbm9Yit6Q0cXD9Qpuz14lzJeUpNtwTlR1IJzcz59SNP6RVmVJdkLD2OBELHnWFUIvNZXdfzL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XqfXg1dJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4hGbcJX/zGCic8102G9qCIKZXSgkfeWlTMil/4Iaml4=; b=XqfXg1dJojWAta23wVrVGw8AbM
	T4YFUEpAGNRy8GVl2crq0/yviLHSn1RwjY7OLNXFUr7MBlJZLFlel+DfkeASAyFuazuY5gYbkZg3C
	r1X86wcMyDCgxj5D/ys/gdAHSFU7r5iSYp0zd049hk3wpBrFCur24CjExKXdOvqJN9VuHv/iRjxzx
	kX5RrybEcEtWMX2qA0ottyCV7wKy8E6VDoLBwHqezT7iyteAdLuRpPADA5DDr5S896BrFSnJfOEmd
	6JvaRmn5kwFYAVnGs71LXmLojX97iH8OqHMoKkN+pTlZ5RhbqGi9BrBSkACYzFfu78y9HaeWVKLwd
	KJWr0I9A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vlzd9-0000000DGbm-14ID;
	Sat, 31 Jan 2026 01:18:31 +0000
Date: Sat, 31 Jan 2026 01:18:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Samuel Wu <wusamuel@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
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
Message-ID: <20260131011831.GZ3183987@ZenIV>
References: <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV>
 <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV>
 <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV>
 <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV>
 <CAG2KctotL+tpHQMWWAFOQEy=3NX-7fa9YroqsjnxKmTuunJ2AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG2KctotL+tpHQMWWAFOQEy=3NX-7fa9YroqsjnxKmTuunJ2AQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-75981-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.org.uk:dkim]
X-Rspamd-Queue-Id: B079CBFEC1
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 05:05:34PM -0800, Samuel Wu wrote:

> > How lovely...  Could you slap
> >         WARN_ON(ret == -EAGAIN);
> > right before that
> >         if (ret < 0)
> >                 return ret;
> 
> Surprisingly ret == 0 every time, so no difference in dmesg logs with
> this addition.

What the hell?  Other than that mutex_lock(), the only change in there
is the order of store to file->private_data and call of ffs_data_opened();
that struct file pointer is not visible to anyone at that point...

Wait, it also brings ffs_data_reset() on that transition under ffs->mutex...
For a quick check: does
git fetch git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-wsamuel2
git switch --detach FETCH_HEAD
demonstrate the same breakage?

