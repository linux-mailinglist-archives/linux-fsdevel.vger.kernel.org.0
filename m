Return-Path: <linux-fsdevel+bounces-77039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCePKz8QjmkM/AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:39:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FE112FFFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9591F3062C70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AD826738B;
	Thu, 12 Feb 2026 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv8CF48v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F961E9B3F;
	Thu, 12 Feb 2026 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917927; cv=none; b=nCpEfWr6eba6osHZwyuKWqdNo8bj5JKNGq76hBxfoUgCuVszUnnEsoAFnt8CkGxAmUx9MA1s4fLOC8QBrnHzid2yRrrYEu1xU7z1mKN2fW0J+qNgHC9CMEsDyfq5VSzgCp16gmNRc2OBsU5gMYPw1OhPgKU37LnXRM9EZ12CgnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917927; c=relaxed/simple;
	bh=TqF9aIKz2uR9+dly+MlnligW4ks92ie5pSvuy9CPkDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHU1UGYzZRFS8ctNYsr53vOWrxbrSEWl0pYinO79XUAib6OI9xrCecJOUcdGUrCvqy20UleI6daea4QPo2LDJlpVcFBWkYq3QQfLi0rxtk4hUKLYbKrwrCy2YT6fhBEEcXaCyPuUYacNzv1c6/Xrh1zI2dAemYtCppRt/tvSgfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv8CF48v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3F2C4CEF7;
	Thu, 12 Feb 2026 17:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770917927;
	bh=TqF9aIKz2uR9+dly+MlnligW4ks92ie5pSvuy9CPkDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jv8CF48vNekptbF9CDRbMPI1AeMb3eQ9AgSrw2sRQ00z3E9GMbY7sfKluFaoyfOuM
	 YhGpy/E807v6jtILxynxn9B1eXY9+FvqV/aSPSJ6W5XX2453jJEkUhrehSyNy97JYP
	 +pSwtphBOnhzw2KeLi0QrQioz620nBm5Mn93MbGxJ+4feur7EbO8+RdxM/fgKJpu5f
	 9ErLqc0fs2gVXoIyIEoT/Ce5JxW1K/1YzXo9YmiqH3Qe1m8R50ly5/OvJ/QEmpoM84
	 lVCJY5CK3xps7Yeen5o6EVOqZwCW0PrrkPuFD9Ns+syH0ztHJXDHK9zQOIrCd6MfVX
	 qFihRSy4ppaYQ==
Date: Thu, 12 Feb 2026 09:38:02 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [GIT PULL] fsverity updates for 7.0
Message-ID: <20260212173802.GA2269@sol>
References: <20260212012652.GA8885@sol>
 <20260212101143.GA7951@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212101143.GA7951@lst.de>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77039-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41FE112FFFB
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 11:11:43AM +0100, Christoph Hellwig wrote:
> Note that this had a merge conflict in linux-next.  So unless that
> went away, it needs a merge resolution like:
> 
> https://lore.kernel.org/fsverity/20260203053604.GC15956@lst.de/T/#m291294c1f6b7368d3c426ee47e6d23dc854b3ba6

It will be needed after both this pull request and the f2fs pull request
are merged.  Currently, the f2fs pull request hasn't been sent yet.

- Eric

