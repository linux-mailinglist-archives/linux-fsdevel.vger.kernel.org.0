Return-Path: <linux-fsdevel+bounces-78314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NobB9IinmnfTgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:14:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FDC18D103
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C056230747A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CEF3446C3;
	Tue, 24 Feb 2026 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWfsbd2W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C4433C195;
	Tue, 24 Feb 2026 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971271; cv=none; b=C4Thn4GGkX4ycxiEJyiwfN1hynXWHvuKwUmdjD5LdISEHrPI7/+41qG4lZ1dSMpKiyvu3oHpIT+yaJuw0CZxyvtXngL+65KEqrbJu/cRj+cB0UNO5vQM87ZNCgtEncC23eEPBzAyZDA12C1Zrj2PoTXgM/66jhTh2xSSy0PxC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971271; c=relaxed/simple;
	bh=GP9EIHuH4fgI2CBBxJPTMNDNZPlznhw+7F4kt05v0Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rU2V66OO6zCgZ2Rs8UlplrGar0IHjvwENx8Ejbi/8/PyHAM/c4YmKqPRrV0xZutJb4Jv4GcgNnKB90r3yXancdx8mtZn9ss/IcR92GbeOd5EFSV0z8QQ+mnrqPsAvZxqJDzIx8YPf2qyf+U3JCMb8KOdDA7Oqga7OG5t9cjkank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWfsbd2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A286DC116D0;
	Tue, 24 Feb 2026 22:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771971271;
	bh=GP9EIHuH4fgI2CBBxJPTMNDNZPlznhw+7F4kt05v0Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWfsbd2W2HQOmeBAJ9Bvq+z8d2hXF4RotG6VaILGmRc8AeQtAywH/ypeeYT3N9AG2
	 9XlDTxX75XFUZF1O2cQp889b4L5RUvI4UK3HmNrDE2uNymxaFSfIZWy34Zs6deGOPo
	 eqHMt+njhkRbffQ+UWm5wJaey92J5kZNlmFsiFz7HTduIFSwsboO9T7WGt22cn713m
	 8dhOoUq5Ih0YFr9vW82u/rcl20+Ent8n09BOUppo00B2nfu1tVFiq9JERlr4G3dgaO
	 zgyjVsFF8qLZr9/LYCThi3GZRIqsAZGkO6W75JCpMWdrLNUvwt4JTsrTN+4zto8FrQ
	 LsJnBZkYQtABg==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v7 0/3] kNFSD Signed Filehandles
Date: Tue, 24 Feb 2026 17:14:27 -0500
Message-ID: <177197126045.98963.2578800193731993999.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771961922.git.bcodding@hammerspace.com>
References: <cover.1771961922.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78314-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,brown.name,gmail.com,hammerspace.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6FDC18D103
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 24 Feb 2026 14:41:13 -0500, Benjamin Coddington wrote:
> The following series enables the linux NFS server to add a Message
> Authentication Code (MAC) to the filehandles it gives to clients.  This
> provides additional protection to the exported filesystem against filehandle
> guessing attacks.
> 
> Filesystems generate their own filehandles through the export_operation
> "encode_fh" and a filehandle provides sufficient access to open a file
> without needing to perform a lookup.  A trusted NFS client holding a valid
> filehandle can remotely access the corresponding file without reference to
> access-path restrictions that might be imposed by the ancestor directories
> or the server exports.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/3] NFSD: Add a key for signing filehandles
      commit: 89c0e7ad8255e8c38610256aaad8c512eee065a8
[2/3] NFSD/export: Add sign_fh export option
      commit: ed55ed211423d7f4e221862748c92129abff2fd1
[3/3] NFSD: Sign filehandles
      commit: d247fc9b77bc575fa9452ef48dd28cf7b3808d58

--
Chuck Lever


