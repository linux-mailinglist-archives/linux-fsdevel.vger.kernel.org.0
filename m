Return-Path: <linux-fsdevel+bounces-79585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE+/I3evqmm6VQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 11:41:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF5E21F02E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 11:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB2883026D95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 10:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5D837C0F0;
	Fri,  6 Mar 2026 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rT0qPMf1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C630FC30;
	Fri,  6 Mar 2026 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793613; cv=none; b=EF/f9R9jph2sek+u1KJRZh2o/b3v+/lXL48XoGeZfxRPNdjuQVEeMqh4gz/Yz1Lqla7fcBsN9TUeX7h30RjkaqRTRqInPxTciIEP8I3ccqs9Z7XSJQl1Qt0yHdY3Es93MdwKZQM/MYlvyGLJAo56v/5yNzlkKOEGVDYLsXgqc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793613; c=relaxed/simple;
	bh=fLV+HWHyQ9rsS3Mae74R0FMH25Gpfx00+e4ZcI0fxCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3xkHMvHB6bl33tDlCXo8smPrBNUDeJFuX6t3uNDT9o8grU9hBzn2P1aHa5HVw2Jd9KTlcPhK825uAw33GRwYd4Xj11Z4hGOhKFg65Fe1iyPpHzpWKxNXg3VXeb6JDlxQDWu2gejlEpRHg2tXUd54G457C+nzxQjyLnVVAxyITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rT0qPMf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ACBC4CEF7;
	Fri,  6 Mar 2026 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772793613;
	bh=fLV+HWHyQ9rsS3Mae74R0FMH25Gpfx00+e4ZcI0fxCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rT0qPMf1wpW8qjbSs8HQZS+lFQl6dKhRHiJrNgkxOcqU+4xy/Tm1ld4h3mfptVMjU
	 h1FVlTF5I8cQT0jJXRdrkZe61SsDv4eu9fKqIgKbKM9crbSwDtQumd0tMZ7e9v76V1
	 qrARmJzDlUCPSQD8RAMfafiAg3bYY0v86PFpuXsBikrRxksS9XCJIqQajXz6RD0P4z
	 h/V8kgf7dmsCkPsjyF2kuNjOH2pLIm2VPyPMuacI3VdLJOqY9+6Lfh8S8Yq0sf1l1h
	 SSt9L1dvU9VzNOfO6uBv4bhcUuNa6jwj4edKWk53rwkwpfPNuaO48cN9ZR61Pof71L
	 x3+Y5MMKG93CA==
Date: Fri, 6 Mar 2026 11:40:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v3 00/15] Further centralising of directory locking for
 name ops.
Message-ID: <20260306-wildfremd-wildfremd-43848a9e91cd@brauner>
References: <20260224222542.3458677-1-neilb@ownmail.net>
 <177267387855.7472.13497219877141601891@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <177267387855.7472.13497219877141601891@noble.neil.brown.name>
X-Rspamd-Queue-Id: ACF5E21F02E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79585-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,kernel.org,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 12:24:38PM +1100, NeilBrown wrote:
> 
> Hi Christian,
>  do you have thoughts about this series?  Any idea when you might have
>  time to review and (hopefully) apply them?

Sorry, for the delay I picked it up but have two minor comments.

