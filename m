Return-Path: <linux-fsdevel+bounces-72049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4D2CDC340
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5B663026AA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E766F3358CE;
	Wed, 24 Dec 2025 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceAWzocg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084B4C98;
	Wed, 24 Dec 2025 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766579366; cv=none; b=D7GiNG+FPLYd/g1tYTqEH6LA8ixbs+Vqqzn7uoNltVCvz6XTTx9muRbDyBbiHHsUpZcAlDMibIrCqkn7MME7zwYY+F5fkOIHJkgmQJEC+yBc6+rLvXghDbgauHDrugUXAcoDxMQH4SqH+d674dwN0+xRV46qCRuW7KpPOsAjNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766579366; c=relaxed/simple;
	bh=MCou5IIJNXBqY/37G4uvi0vBqgBno2j5Q+2SEVdvl1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIL+kfP3g8vwGmGduJAcktQXB3LE7Y1ueETH06hnuz6DZT4i6UaflJRVrxnUiNJbtBIbFCGhuR41mQ9Hjb4cnh6bDf9Uf10u1kfpPfT5A5GGFNNr9heBu/Bt+awVFgbnmqfV3Y0Sfcxer5cLftnliAecW9U3NKnY35LROSn/5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceAWzocg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2C3C116D0;
	Wed, 24 Dec 2025 12:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766579366;
	bh=MCou5IIJNXBqY/37G4uvi0vBqgBno2j5Q+2SEVdvl1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ceAWzocgKZRvVvPs/BageDG+Do8HkS9K8iXScqwkpzLGnagGsKPG5SYIllKwuJ+MR
	 QNcyk6w4kYtMjisd/lhFkd7eSsHP7ibJvFxzYm5cqn9YelQjfc2N8tnuev4SWeLgMc
	 lbRRaocGUnbFcZQ6s2WK454LGzLwgLoE1ndC5zIhTFiMgsiR+AqcmjVYYq6EN/Eqq1
	 iJ/eZlsVq1HWDoKG9cd6LqfyC2h5EPSodsShBxOUoWEzmircUQHGMwp1u55XfiIV1d
	 cm2DvJO1pXJV0RGATzy7UIrLxzpevJtctUbLJQpxCpnmmJ07fZGXSV7ZJfNZCf3OxP
	 x4ZJB/MnLJYIg==
Date: Wed, 24 Dec 2025 13:29:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org, 
	jack@suse.cz, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gabriel@krisman.be, amir73il@gmail.com
Subject: Re: [PATCH 2/6] fs: report filesystem and file I/O errors to fsnotify
Message-ID: <20251224-nippen-ganoven-fc2db4d34d9f@brauner>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332171.686273.14690243193639006055.stgit@frogsfrogsfrogs>
 <aUOPcNNR1oAxa1hC@infradead.org>
 <20251218184429.GX7725@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251218184429.GX7725@frogsfrogsfrogs>

> Nope.  Fixed.

I've pulled this from the provided branch which already contains the
mentioned fixes. It now lives in vfs-7.0.fserror. As an aside, the
numbering for this patch series was very odd which tripped b4 so I
applied it with manual massaging. Let me know if there are any issues. 

