Return-Path: <linux-fsdevel+bounces-8065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEBE82F172
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 16:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC50283EBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 15:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A411C298;
	Tue, 16 Jan 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tXYH13F7";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tXYH13F7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A91BF59;
	Tue, 16 Jan 2024 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705418723;
	bh=MvWh+67ftiWh2+3eSFJmv3mJL/+4kfnHoljEwqdxTPw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=tXYH13F7f9/A2kjZUfgcLq4Xw+gQVdGFIUdRYIZ5VtDKmcoc9XR1Ce2tI4o0xdzwC
	 R5NGKecPG+8lXOghqb7ohkUIEQt4OiNrdy+9uAtfyoM2AzA/TErDC76D04PYrjW/4C
	 LlxOo0M6PMBGIaAXCITzQvQyqcnsMjFwb4PCPIEU=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 61F911280773;
	Tue, 16 Jan 2024 10:25:23 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id c3eCd6WnbF3W; Tue, 16 Jan 2024 10:25:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705418723;
	bh=MvWh+67ftiWh2+3eSFJmv3mJL/+4kfnHoljEwqdxTPw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=tXYH13F7f9/A2kjZUfgcLq4Xw+gQVdGFIUdRYIZ5VtDKmcoc9XR1Ce2tI4o0xdzwC
	 R5NGKecPG+8lXOghqb7ohkUIEQt4OiNrdy+9uAtfyoM2AzA/TErDC76D04PYrjW/4C
	 LlxOo0M6PMBGIaAXCITzQvQyqcnsMjFwb4PCPIEU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5E5FD1280473;
	Tue, 16 Jan 2024 10:25:22 -0500 (EST)
Message-ID: <458822c2889a4fce54a07ce80d001e998ca56b48.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Christian Brauner <brauner@kernel.org>, lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org, Matthew Wilcox
	 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Christoph Hellwig
	 <hch@infradead.org>
Date: Tue, 16 Jan 2024 10:25:20 -0500
In-Reply-To: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-01-16 at 11:50 +0100, Christian Brauner wrote:
> So when we say luksSuspend we really mean block layer initiated
> freeze. The overall goal or expectation of userspace is that after a
> luksSuspend call all sensitive material has been evicted from
> relevant caches to harden against various attacks. And luksSuspend
> does wipe the encryption key and suspend the block device. However,
> the encryption key can still be available clear-text in the page
> cache. To illustrate this problem more simply:
> 
> truncate -s 500M /tmp/img
> echo password | cryptsetup luksFormat /tmp/img --force-password
> echo password | cryptsetup open /tmp/img test
> mkfs.xfs /dev/mapper/test
> mount /dev/mapper/test /mnt
> echo "secrets" > /mnt/data
> cryptsetup luksSuspend test
> cat /mnt/data

Not really anything to do with the drop caches problem, but luks can
use the kernel keyring API for this.  That should ensure the key itself
can be shredded on suspend without replication anywhere in memory.  Of
course the real problem is likely that the key has or is derived from a
password and that password is in the user space gnome-keyring, which
will be much harder to purge ... although if the keyring were using
secret memory it would be way easier ...

So perhaps before we start bending the kernel out of shape in the name
of security, we should also ensure that the various user space
components are secured first.  The most important thing to get right
first is key management (lose the key and someone who can steal the
encrypted data can access it).  Then you can worry about data leaks due
to the cache, which are somewhat harder to exploit easily (to exploit
this you have to get into the cache in the first place, which is
harder).

> This will still happily print the contents of /mnt/data even though
> the block device and the owning filesystem are frozen because the
> data is still in the page cache.
> 
> To my knowledge, the only current way to get the contents of
> /mnt/data or the encryption key out of the page cache is via
> /proc/sys/vm/drop_caches which is a big hammer.

To be honest, why is this too big a hammer?  Secret data could be
sprayed all over the cache, so killing all of it (assuming we can as
Jan points out) would be a security benefit.  I'm sure people would be
willing to pay the additional start up time of an entirely empty cache
on resume in exchange for the nicely evaluateable security guarantee it
gives.  In other words, dropping caches by device is harder to analyse
from security terms (because now you have to figure out where secret
data is and which caches you need to drop) and it's not clear it really
has much advantage in terms of faster resume for the complexity it
would introduce.

James


