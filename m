Return-Path: <linux-fsdevel+bounces-69003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F657C6B0CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F7E44F0FF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989B92D5C86;
	Tue, 18 Nov 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3aJV63v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17411DF248;
	Tue, 18 Nov 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487919; cv=none; b=CtfVM0K0mWmQfS8QwDPU9c6Wh4fWH4pK+APCYfgdKBYfTchfQTpE9/WyvN2xx7zo1T53QRqye1H8p2ZrB/TCSiU+TkM4pdbnk+EpPvSaxUlVWdIGvqcv9cd9eaFw+TYdIk+92Xw3b7pgLFLAjdGN1LJHndFyHvCYjIgFT5/IelE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487919; c=relaxed/simple;
	bh=Xms7ZuR9GdTOCuOkQlKgZh4iTWs7YzqAJCW0uxiAOyI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iuil2bLJw0cJIubHpsLrWbsWS0l6yHI9y0yElHGoRpXVV+EIQB/MKfDkY3hdbfYmNYQExvqRNFRyHqGqyih4+AcfCwSXYvvCaFGYhhDhz1sWD0yPbZgm9zt7Uwch7F27X6bSdvXgAflMBQw9Nu9yafREXMU1Hg7/GN6ZwsXnykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3aJV63v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25C2C4CEF1;
	Tue, 18 Nov 2025 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763487916;
	bh=Xms7ZuR9GdTOCuOkQlKgZh4iTWs7YzqAJCW0uxiAOyI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=H3aJV63vWvEOv7yJjofOd+OumLQ3XNqagiBBi2opehDAVbCG5o2LwiKydDRJKXewp
	 b/uFv6IbUO2+EeZF4VLhgRE+++v44H/CSBjX6mgNVGTtWQYRAlexYfTrBeHmYjBX8d
	 u3neosPPXIwv0BUOZI8icQFumnr400RFzzwbp9sTUhf+HziHe0Kj8KevxNtA5ZJD6y
	 jSq4s4urIp86GWMX7NyKkj/TzqWNZlzJW1B9BnsKgjBt7jCd/joOs5wPSbQSwFCgu3
	 wyFeD4eD+LPw2OQpT1hNazGtv/pv+F5oiU9224gohvkv78Y1TNXwFS5/bWavXgNz6U
	 3FxkotpXKKHAA==
Message-ID: <a578b2e33aa145be3f0d63a23bc7dfe2bd56d0ab.camel@kernel.org>
Subject: Re: [PATCH v1 0/3] Allow knfsd to use atomic_open()
From: Trond Myklebust <trondmy@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Benjamin Coddington	
 <bcodding@hammerspace.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff
 Layton <jlayton@kernel.org>,  NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,  Tom
 Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Date: Tue, 18 Nov 2025 12:45:13 -0500
In-Reply-To: <050d60a8-7689-46f3-a303-28e01944b386@oracle.com>
References: <cover.1763483341.git.bcodding@hammerspace.com>
	 <050d60a8-7689-46f3-a303-28e01944b386@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-18 at 11:58 -0500, Chuck Lever wrote:
> On 11/18/25 11:33 AM, Benjamin Coddington wrote:
> > We have workloads that will benefit from allowing knfsd to use
> > atomic_open()
> > in the open/create path.=C2=A0 There are two benefits; the first is the
> > original
> > matter of correctness: when knfsd must perform both vfs_create()
> > and
> > vfs_open() in series there can be races or error results that cause
> > the
> > caller to receive unexpected results.
>=20
> Commit fb70bf124b05 ("NFSD: Instantiate a struct file when creating a
> regular NFSv4 file") was supposed to address this. If there are still
> issues, then a Fixes: tag and some explanation of where there are
> gaps
> would be welcome in the commit message or cover letter. We might need
> to identify LTS backport requirements, in that case.
>=20

That patch only fixes the case where you're creating a local file and
then exporting it over NFSv4.

The case where we see a permissions problem is when creating a file
over NFSv4, and then exporting it over NFSv3.
i.e. it is the re-exporting over NFSv3 case.

Note that independently of the permissions issues, atomic_open also
solves races in open(O_CREAT|O_TRUNC). The NFS client now uses it for
both NFSv4 and NFSv3 for that reason.
See commit 7c6c5249f061 "NFS: add atomic_open for NFSv3 to handle
O_TRUNC correctly."

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

