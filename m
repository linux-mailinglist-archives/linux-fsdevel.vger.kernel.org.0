Return-Path: <linux-fsdevel+bounces-78922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKQ6EiGhpWmuCAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:39:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D03131DB046
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6023F30899A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A8F3FD151;
	Mon,  2 Mar 2026 14:27:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6803B3FB059;
	Mon,  2 Mar 2026 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461642; cv=none; b=OApW7cXz6LBq+nip1tUu9Z2vNZStM0nz0qHOBkYRlGYxizcp1X4DgzjqWYi/ahtxfXzbRwURVRoMM/DARJTwu1YQrIlNx5OCK/P9tAFAKsUIli5amx/MUrBiI8wUv+FP87D3g7EQTVH8ujJ8dYAER0WUTy0q4GPjrzWwA6/xgf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461642; c=relaxed/simple;
	bh=wW9EUyVuujXOwrypBxDwFKywJlhyz1UK5BScvNNRfRE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZnLwegMxn0NB8Nlb7Ooc5NPxtwSHu5OSjBdB5LPOz03Ne92wuujnbsbYu0BQO2lcvyas21i53eLWzRMPrxDWFfkZlAUoZNnG8qOVJtLurNW+pYNrm+9WjjChqUsQdy7ABUx/Yzv9y4cffH6dKs6nhIGh6Zr+fgnnaxWQTwxh3zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9364F68B05; Mon,  2 Mar 2026 15:27:18 +0100 (CET)
Date: Mon, 2 Mar 2026 15:27:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: dropping the non-inline mode for fscrypt?
Message-ID: <20260302142718.GA25174@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Queue-Id: D03131DB046
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78922-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.324];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

After just having run into another issue with missing testing for one of
the path, I'd like to ask if we should look into dropping the non-inline
mode for block based fscrypt?

I did a few simple fio based benchmarks, and writes are a minimal amount
fast for the inline mode, while the reverse is true for reads.

The big blocker seems to be this comment in fscrypt_select_encryption_impl:

        /*
         * When a page contains multiple logically contiguous filesystem blocks,
         * some filesystem code only calls fscrypt_mergeable_bio() for the first
         * block in the page. This is fine for most of fscrypt's IV generation
         * strategies, where contiguous blocks imply contiguous IVs. But it
         * doesn't work with IV_INO_LBLK_32. For now, simply exclude
         * IV_INO_LBLK_32 with blocksize != PAGE_SIZE from inline encryption.
         */

from touching the file system callers lately, the only obvious place
for this is fscrypt_zeroout_range_inline_crypt helper, or did I miss
anything else?  Does anyone have a good xfstests setup for the
IV_INO_LBLK_32 mode?

