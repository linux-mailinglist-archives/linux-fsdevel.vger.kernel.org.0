Return-Path: <linux-fsdevel+bounces-77833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNgdMwnvmGlWOQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 00:32:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3571B16B655
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 00:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C961303BB10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 23:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228BD313545;
	Fri, 20 Feb 2026 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAbKHIDQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37A450FE;
	Fri, 20 Feb 2026 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771630329; cv=none; b=SN4sTVF0dB7o/QzeUYYGCVzU0fQ8QX6hJzDgnZ3zMyIBChw0tvEx9z9RJCKJalqBwwR9gPQ+ca3OZBdH7exIGjaVISiNhzczZbl2zk+VY8DqyY15sxT38fY4OAWfXI6FRFqvK0EBjvwA2dgV/P6473/yq5GKjvrRewzuukVcPZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771630329; c=relaxed/simple;
	bh=/bSsXEdaIKKeFGiASesky/KjEVa6IyrjpIr3goO6XWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM4AfdXkvchrFYRtGxGoVViNe2R8tnMaXAf3aVYeYIOSLFSCLnD8HgVSsn/nvCgy7AN5M81nZ9RNvoHwNxnTBf3Ar8Zipt83E9edJJNCDi8JU4deOU/fLqSBcqI7Ovgcgp+rK/fiETZEvo2CnI3YEp/rQ513PqG3HuMxJPjrCAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAbKHIDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1258AC116C6;
	Fri, 20 Feb 2026 23:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771630329;
	bh=/bSsXEdaIKKeFGiASesky/KjEVa6IyrjpIr3goO6XWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAbKHIDQi3vLekKzDjHKpJqvvmgaoTdMRRaZcLZ61LLO73si/qTO476lY7fbRrB8b
	 +dp6bct1/IKE55kmm1exaApfAaP60F8SmPnLh2omFNch7Ou61a/WpFHB5DHHLxqeXk
	 e44E6Kcs4AXVUa9svtmZ2WCpZT9/tMN2499yKhNrb9ZMuVuu9wcRGXX9w6It2/qpLg
	 R+KnQb/vCpicLo0bcOFAt74d7kYXD1PAponMy8VmXizG1i+6b2hym459mo4GiSsH4p
	 Q4TCr7iXt0Gx6c+XEySzkqbArftF6PVBYYye/4V8xkntisHcDBZBRVJbFrl55SfMFq
	 IrQQNZ7jH4ZDw==
Date: Fri, 20 Feb 2026 13:32:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, gregkh@linuxfoundation.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jack@suse.cz, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 2/3] kernfs: Send IN_DELETE_SELF and IN_IGNORED
Message-ID: <aZju-GFHf8Eez-07@slm.duckdns.org>
References: <20260220055449.3073-1-tjmercier@google.com>
 <20260220055449.3073-3-tjmercier@google.com>
 <aZh-orwoaeAh52Bf@slm.duckdns.org>
 <CAOQ4uxjgXa1q-8-ajSBwza-Tkv91tFP-_wWzCQPW+PwJMehEWA@mail.gmail.com>
 <aZi6_K-pSRwAe7F5@slm.duckdns.org>
 <CAOQ4uxjZZSRBwZ2ZL31juAUu0-sAUnPrJWvQuJ2NDaWZMeq0Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjZZSRBwZ2ZL31juAUu0-sAUnPrJWvQuJ2NDaWZMeq0Fg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77833-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3571B16B655
X-Rspamd-Action: no action

Hello, Amir.

On Fri, Feb 20, 2026 at 10:11:15PM +0200, Amir Goldstein wrote:
> > Yeah, that can be useful. For cgroupfs, there would probably need to be a
> > way to scope it so that it can be used on delegation boundaries too (which
> > we can require to coincide with cgroup NS boundaries).
> 
> I have no idea what the above means.
> I could ask Gemini or you and I prefer the latter ;)

Ah, you chose wrong. :)

> What are delegation boundaries and NFS boundaries in this context?

cgroup delegation is giving control of a subtree to someone else:

https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/tree/Documentation/admin-guide/cgroup-v2.rst#n537

There's an old way of doing it by changing perms on some files and new way
using cgroup namespace.

> > Would it be possible to make FAN_MNT_ATTACH work for that?
> 
> FAN_MNT_ATTACH is an event generated on a mntns object.
> If "cgroup NS boundaries" is referring to a mntns object and if
> this object is available in the context of cgroup create/destroy
> then it should be possible.

Great, yes, cgroup namespace way should work then.

> But FAN_MNT_ATTACH reports a mountid. Is there a mountid
> to report on cgroup create? Probably not?

Sorry, I thought that was per-mount recursive file event monitoring.
FAN_MARK_MOUNT looks like the right thing if we want to allow monitoring
cgroup creations / destructions in a subtree without recursively watching
each cgroup.

Thanks.

-- 
tejun

