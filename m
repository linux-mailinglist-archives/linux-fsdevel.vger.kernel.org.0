Return-Path: <linux-fsdevel+bounces-62403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C87CB9168C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 15:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D356D2A151C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 13:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF29830DEA6;
	Mon, 22 Sep 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F0Moyb8u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1BB25484B
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547945; cv=none; b=PruXR+Mr37y5JS14wN21ta1aecVaa/sfLJ8xDq4STlM/WhBz92rj47mhiT1jWoUJph9k+/EduWOoCYnUbz/IZMYl9hlP/MZKN24GDmOanVobcAZoBuraLwGACCET+JvWNShPhVZZus+KoqK57g+3ksSYywPTPyxC8tjVE0Ki2vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547945; c=relaxed/simple;
	bh=oTdz0yxfb86FnInWzhkWtt5260VKgHQovGeSyIG6LSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT3j38No6iHGIBz2g2EGalv3nadcN8bw1CroeX2dTM5B3Hs67tsnLGn3UCW0ayj+H4Gi8LlktXkD/oYrHyYSFMHzfmduY4CRj6L6avQ/9IMp3eWkJyUxpsAnPeTQdoswQRktKnEBCiHFJxM7cE8OSphh093TKTRzC+Ag4MlZ0D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F0Moyb8u; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NHiZyh9NB8PreRQD+I471hNhbqnQ0B0iPqR9Te0HaHI=; b=F0Moyb8uoOos0vMgQrWr65z9Sw
	b2K7f13EVJ+khbtmzD2uunii/vz2I30FRghIQaANK2A6Fvrsa4b43hAi4B+Eebp21j5mGmfEZeV42
	1sUF+9jaCBvO5/IKxzZRk1ZFR85WYYwiGaJpit29wqm/D5/l7O/m9c1vczW7QA4ROskP+dLBrB8Qj
	GbJCJWWMRvv/dCPMNTnoXnbvYWX9ZUtGDPKxZEutqPAhmThc4I3JEWfmb1f42vM7D3AzxoQcTso8A
	pUjf2o4taUS8R2q/33RWXyeecJSDmGefDU2HlUltjq/mNflIgp4pq68WZZtqEKdxe51O4uRXWwbpq
	3xMBcsAA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0geR-0000000FfWz-36Oj;
	Mon, 22 Sep 2025 13:32:19 +0000
Date: Mon, 22 Sep 2025 14:32:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] VFS: rename kern_path_locked() and related
 functions.
Message-ID: <20250922133219.GR39973@ZenIV>
References: <20250922043121.193821-1-neilb@ownmail.net>
 <20250922043121.193821-6-neilb@ownmail.net>
 <20250922052100.GQ39973@ZenIV>
 <175852620438.1696783.572936124747972315@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175852620438.1696783.572936124747972315@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 22, 2025 at 05:30:04PM +1000, NeilBrown wrote:
> +-  kern_path_locked -> start_removing_path
> +-  kern_path_create -> start_creating_path
> +-  user_path_create -> start_creating_user_path
> +-  user_path_locked_at -> start_removing_user_path_at
> +-  done_path_create -> end_creating_path
> 
> 
> Are you saying that it also needs to mention that start_removing_path()
> now calls mnt_want_write()?  Or that end_removing_path() should be
> called to clean up?  Or both?
> I agree that the latter is sensible, I'm not certain that the former is
> needed, though I guess it doesn't hurt.

My apologies - I'd managed to miss the relevant part of patch, actually ;-/

Al, seriously embarrassed.

