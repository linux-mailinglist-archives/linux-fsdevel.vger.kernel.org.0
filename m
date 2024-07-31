Return-Path: <linux-fsdevel+bounces-24646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B2E9423ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 02:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F098E1F24826
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 00:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C59F8F58;
	Wed, 31 Jul 2024 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KXQpUCxQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4024A31;
	Wed, 31 Jul 2024 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722386589; cv=none; b=KH71xYPzsBIxzgmwNSCXmvSpw2dZO8hgrLK46A/RseSsRZgX+NS0X2ybQSbN2/Dm+ZWlD9AV3/7a/ng0S7zJ+WIDBdbqN77GfZOPfH8/8sxkx0XW8tSBaLnFx/rz/kP2WNHB5Yw4GiCCZKoxG+Y2usTAuKWDKvkV2Np8q8dvcak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722386589; c=relaxed/simple;
	bh=0Ucwoq06RuZunJH9ZTsuF1H8BZYdv3fYzTqpVSxm0js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr3wDB45+kCW/LjW9qqdoD/qPa/0RDLrvGk12bVhzBBKuFd9IE/IQHDT5A2C1Pw7JzTMKV/m3YZl5BJv1pm2uJpK652FRk1G+hQWTOLR+4O3g+dBXHtLh71+SPg9ThHfY91Kr5JtT8kanP2D2GqpqYb+YdgSeBxJGe+mLyQYAY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KXQpUCxQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PbApO/TIp5V0FKdRkfodevei4EDfm4ALsJAsgQBECAQ=; b=KXQpUCxQeQh/BBdWhJy+KlHr5X
	2IU0R8zcgoaWX3U0jChl1zzFm2lPJR/vOavGb8a17TqNlUNF2v4V6kOlhxpJk5Ae6+6MBmUqbQ7av
	VJqNnvD+nW9sHB7/jiEaX99/vLNCJS63npVjqClID8z5O/y6ND4e42Tj/VXWRMhg1N4GRoBBRvLDd
	nXo6TXpFdyh6N0bRI1QsEi4+83HAahArycPqeVdST4adY47escnKNq15X4wcN1Q92oEij7Q13dHOA
	RR5FmIm9pDH6nbWu+VdWnw2h7312jzj/HZAi45Srj8sUmIicEImgy6naSj9l4ZuFDQC/rKRVGCmt0
	owD4J1/w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sYxQm-00000000MLz-0Nq3;
	Wed, 31 Jul 2024 00:43:04 +0000
Date: Wed, 31 Jul 2024 01:43:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCHSET][RFC] struct fd and memory safety
Message-ID: <20240731004304.GI5334@ZenIV>
References: <20240730050927.GC5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730050927.GC5334@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 30, 2024 at 06:09:27AM +0100, Al Viro wrote:

> 	10a.  All calls of fdput_pos() that return a non-empty
	                   fdget_pos(), that is.

> value are followed by exactly one call of fdput_pos().

