Return-Path: <linux-fsdevel+bounces-75350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCH9EpzAdGnU9QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 13:52:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B53B7DA90
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 13:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A04283005147
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 12:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3782B318B9D;
	Sat, 24 Jan 2026 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+lF+5cw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19BB2E0413;
	Sat, 24 Jan 2026 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769259150; cv=none; b=ZtMCSGujLIxCBL/crj532fpnKaLbvXS21sJ043mIG8LhDwOOBscvbrahFIxvK/MFtrne+27LR6nZU/pDaOqWXEWmVpBNecNdbGEKiGG/T0TTN+oT397+AKX0+6N8MELXccFQw0h0YYFXrbw8Dx/FiW5yGdxrImZRSw0k+ezeTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769259150; c=relaxed/simple;
	bh=tF55d1hz2qgaV0ckyIKSTzXVHak1AXu30pHTv/T/mwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/Z8Kr1iWl2DlOTsFULo0yHlVT5iMT7nnRFoRFL1XEmF2ugSWKMPP3dVQC526uIt4cw6KQWjhbP+1cjddlb9St1PkmsKRqTokEOY/HH2NeAr0iMYK/5P1P44KkSxfXquV3KxK22Fi7JXyJY5EqdTGJs8r2m/NF8NJANHYOqYBhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+lF+5cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ABCC116D0;
	Sat, 24 Jan 2026 12:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769259150;
	bh=tF55d1hz2qgaV0ckyIKSTzXVHak1AXu30pHTv/T/mwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+lF+5cwXE+InK8NAW7SdkJD0wOGPO5SHbCCzqKnVJfHTw275VH76hYus//Td+Gqs
	 Zd+ZunPF3ILfSZEZzPBQpRyDiragiKRjGpqqXrVfONayxSjMvuvNmBwXKNLh/vvLAm
	 XwUAFehKHHlLHHvzMfAfFR130CJe2Bs01+Vk5H5bsLGJC5WZh0mD0cIT1FfV+0m+yU
	 xl/RAjmX7pv+oCD3w2KN/Jut3RWFMHoS2K8EKWWjti2e5+RI9BTpcSdXgrTszzeL3S
	 EzZ9U0OxQ1KqFq4Z/qxBkgQWUSI9JWeUEuZPVdOoQqWWjA5+XbTPA+eiY7lIvCQzH6
	 oDJu3FYpngXdA==
Date: Sat, 24 Jan 2026 13:52:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, almaz.alexandrovich@paragon-software.com, 
	Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	Theodore Tso <tytso@mit.edu>, adilger.kernel@dilger.ca, Carlos Maiolino <cem@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v6 00/16] Exposing case folding behavior
Message-ID: <20260124-gezollt-vorbild-4f65079ab1f1@brauner>
References: <20260120142439.1821554-1-cel@kernel.org>
 <20260123-zwirn-verfassen-c93175b7a1ee@brauner>
 <41b1274b-0720-451d-80db-210697cdb6ac@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41b1274b-0720-451d-80db-210697cdb6ac@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75350-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B53B7DA90
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 10:39:55AM -0500, Chuck Lever wrote:
> 
> 
> On Fri, Jan 23, 2026, at 7:12 AM, Christian Brauner wrote:
> >> Series based on v6.19-rc5.
> >
> > We're starting to cut it close even with the announced -rc8.
> > So my current preference would be to wait for the 7.1 merge window.
> 
> Hi Christian -
> 
> Do you have a preference about continuing to post this series
> during the merge window? I ask because netdev generally likes
> a quiet period during the merge window.

It's usually most helpful if people resend after -rc1 is out because
then I can just pull it without having to worry about merge conflicts.
But fwiw, I have you series in vfs-7.1.casefolding already. Let me push
it out so you can see it.

