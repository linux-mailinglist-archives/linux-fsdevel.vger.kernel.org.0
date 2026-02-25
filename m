Return-Path: <linux-fsdevel+bounces-78382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM5lHFoTn2nWYwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 16:20:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC881997B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 16:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A16D302A56D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C23D5225;
	Wed, 25 Feb 2026 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+9gjrFD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18093D3D02;
	Wed, 25 Feb 2026 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032832; cv=none; b=KR0Vnbp8d+TM0oy8yS6ZwGvXEpF1/ToybXmsuykIi8Hg/KRyGhvIAKM+uzO7KnhArl5MxAYgdRhQBt/n60gTNIwcOoHHpOr8T5m4NukWS5SdFcZUjgsRBiwm8Op4WYHaN0315RvT6/AwuXKqka9Wf27EzdGGOYnZpfbHhdeUXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032832; c=relaxed/simple;
	bh=BRx7ePiRM6IM6xYTQJGooau4EcGTKpq37riztwBysz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YqN3GcX+UIdSlNWa7qVJK9YYHGFe9TjY83pc7Kbz3MCRJufP5DAyid+4o2vQC61kYlLwmKdija9AcKAITCxzXurNpbDKtzRAxJQ6iO6EMCfhEISWeZ6kxa2ODbok9//DwlrmdnokjMdaxmaSITJ1D0tfXAR3wcmDKJY0q7i7RPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+9gjrFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F9DC116D0;
	Wed, 25 Feb 2026 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772032832;
	bh=BRx7ePiRM6IM6xYTQJGooau4EcGTKpq37riztwBysz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+9gjrFDskVEx0qP2hOBK8OrRP/Mp6Q/uQKSfL9tCeOnDQmuogsoF/eDIyhwH0h53
	 s3fR0H7FBLPj2cIEU290B4IlfAP0yyEY4dtRTqB/IOicY7Dy5MASTyTc7z1rRlwMpz
	 b9f+xBfwn9upr4bwxzYKUA39XiNX+TxXCbmgSzTT3yNI9AdCcepQgzBEmN8z3ygGjn
	 uiSptbI6GSY0yvfKlHHX+WVlVr4wFoqh+atzLHd1kSuq+bJhKnXH+lMZhLBFmMM3ya
	 Zd6OF0pu6ARkK7mKuabOmfGBxe979G159yI5DfFJ9eFv0pCa3H8fVvDqt1ozvRkw5/
	 93Wug+zO2VSDQ==
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
Subject: Re: [RESEND PATCH v7 0/3] kNFSD Signed Filehandles
Date: Wed, 25 Feb 2026 10:20:27 -0500
Message-ID: <177203282074.180717.12140239799657635407.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772022373.git.bcodding@hammerspace.com>
References: <cover.1772022373.git.bcodding@hammerspace.com>
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
	TAGGED_FROM(0.00)[bounces-78382-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: EFC881997B9
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 25 Feb 2026 07:51:35 -0500, Benjamin Coddington wrote:
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
      commit: 168286a8a886b760d3beb2ef41f0f69200393ea7
[2/3] NFSD/export: Add sign_fh export option
      commit: a90745b646b3f207e34c559b6a9d0e7e6c551f36
[3/3] NFSD: Sign filehandles
      commit: 5a51cb5090c646656958a008b8813ac7a849edaf

--
Chuck Lever


