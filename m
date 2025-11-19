Return-Path: <linux-fsdevel+bounces-69032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C5DC6C222
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 01:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id BAD5E2C149
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 00:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285FB19F11E;
	Wed, 19 Nov 2025 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MjJoQKNI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB31C84DC
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763512211; cv=none; b=NNPS7+k7nIuqK6+YPHf02BCQIrcBzFkln8651vjjiwR1T/HpHaTCKd4mKIlqw0YSwZQyQKgpn6+TV/67oBgUBLFaMTs+UX2q/UlGLLvpMPsEPeRoNSSNrvHyVtSmcA5ANhxPHMH1CBVpohoiFjBfBDJ0KbA8uSwBo+nmScThvdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763512211; c=relaxed/simple;
	bh=eZsLuZtGCtNrxxAzjGqMYxXqUulY5foYPbp12kWNCc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg3JXu4H59VeDJ5Rg8MdN1r2D5Ndffa/kJA35Rzd2evno08/h2Y6eBmK82WEVblIVndZurA1xIJs9+du2FxQ4dMfMwJoGYcVDnCn5kZpWJuQQJCUZw/WR1xLiEYzeKWtEA8xfqCELYllIw4MDmNfojMcuxr1+667OMMA+BQc0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MjJoQKNI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eZsLuZtGCtNrxxAzjGqMYxXqUulY5foYPbp12kWNCc8=; b=MjJoQKNIdrilku8yuJFR4r2GQm
	T+sVAN+IGVUyny7BbH3NN9LJAPzqFRHaDFTphQyzvtOrdreEVtZJzt1advsMkklZLm18tqTZtwrUR
	VphLdoXCgD71dWWx2xjSk8ZGjszqTY0pcNaoNQCKnJaWZAfBA+kgVfzScJSg+Pqlj8YBFd92VRhpT
	phbdIWKGt91qIRD23GlfIWMzCBb5yMlX2IAIFs01cwmAiIqLqJ2TDa1fSYzk/vLavg86WxhHSAg3X
	aQgcHfwInvr0IR3eeSM+9pMEEZV0p7AVPjIkUdcTK74IAjqobRIHWna3KGvAFTonsDnUKViFwHGng
	iMYl1Ltw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLW5E-00000003GTq-3XgJ;
	Wed, 19 Nov 2025 00:30:04 +0000
Date: Wed, 19 Nov 2025 00:30:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: unexport ioctl_getflags
Message-ID: <20251119003004.GK2441659@ZenIV>
References: <20251118070941.2368011-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118070941.2368011-1-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 18, 2025 at 08:09:41AM +0100, Christoph Hellwig wrote:
> No modular users, nor should there be any for a dispatcher like this.

... and AFAICS there never had been any, so it shouldn't have been
exported in the first place.

