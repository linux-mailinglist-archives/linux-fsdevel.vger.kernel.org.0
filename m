Return-Path: <linux-fsdevel+bounces-44750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F0FA6C6BB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 01:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C036418923B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 00:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747E4B644;
	Sat, 22 Mar 2025 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jjnxhkN0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5510E3;
	Sat, 22 Mar 2025 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742603970; cv=none; b=O81cdMe15lZjiUhatUG9/1WfPIbCjY1uSZN8VXvWgDIDXqmZqoy8oj6N+WJLdZTMNnO9pj0w8ySVJsLIzN1CHvDY0EdLwFviMp96eZ5wpXvd6diRBd7wq8rwe5OO3cbjIn6Qa1oljQu8iF+8TiwgHz7sinPnX4TZ5He3pxeesgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742603970; c=relaxed/simple;
	bh=c/V5a//1qlr5iVsNs9NgpOaYa+Aj4MLtsna7PgrQ6Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAB7791DCEmrCnAnjntufo8c48YNteGXoEUelmGOS3frcpBgV8grktD4rvuPC+WjJWsf3vLKQXGUbuwHGQMb//mi75QhBspF5YyDUqPWPWGFj6nxYlg9zJiKomypwZmnHJoyL+rK73nK+zwVMMV7jjj2yT583SRjWxTqtiut0aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jjnxhkN0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4m/hhhx7Bs4SIxnI64dOeasdcghyf2gQcEOh44Oo110=; b=jjnxhkN0glQghuHdTwc8Mmr3Je
	QRpoyk2fnuYiTRk6Qu+GdNJ634QX9J7WX7wSH0H4hbj5DitBz7QE20KjALApjUf/cvmEYtR+BlQVu
	hjC2tdSw9H1f156U4uRMKHXeTDKfgqdur7oAKWs4AI77lcKUR17/NZxoT3lcGRArlaMikSzY1dg1E
	w3173j3igwhBd1gRWZ2HGVsnOE9GYlEFanE2vXR+zbu8QWCg5eCpWNCr1YgPNe3EN8xL5GWQg0PuW
	Li2okoIife8GzUhw9MMoAN9rx/ypTIh19jnUdINF3Jq20vJiwTjk3tWYPa9wc++rPnr5GqpuAvS1U
	t71dCtwQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tvmtZ-0000000BDl1-1HXU;
	Sat, 22 Mar 2025 00:39:25 +0000
Date: Sat, 22 Mar 2025 00:39:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] Use try_lookup_noperm() instead of
 d_hash_and_lookup() outside of VFS
Message-ID: <20250322003925.GF2023217@ZenIV>
References: <20250319031545.2999807-1-neil@brown.name>
 <20250319031545.2999807-6-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319031545.2999807-6-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Mar 19, 2025 at 02:01:36PM +1100, NeilBrown wrote:

	efivarfs stuff conflicts with jejb's fixes.  And rpc_pipe
part adds fuckload of conflicts for me; what's more, the only caller to
survive is rpc_d_lookup_sb(); the rest will be gone anyway...

Oh, well...

