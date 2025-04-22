Return-Path: <linux-fsdevel+bounces-46941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34179A96B06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643223B3F0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56CF27D763;
	Tue, 22 Apr 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sernet.de header.i=@sernet.de header.b="AAbVG9Jb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.sernet.de (mail.sernet.de [185.199.217.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF227CCE3
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.199.217.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745326455; cv=none; b=C/1/RGUyWodOxl905E6x1X+V1yLEmVbbTCiELb034oSokx9WNxiWeHZ9tvn3SahkPiuT15uyXcGUvtAptPD0E/mYkkjPlgWBT22uRVhF78Gm3XlO9qc0vzHmLD5OV8peh0jVzglUoK6z+tykgsVqY/gArcaR0jWWQIeYqAE9ZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745326455; c=relaxed/simple;
	bh=pizC1B93f/gGXsIN9BGuDQKRw7/VQSwJnVbmPYvS1z8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uok3bIVIgQPGCWrKkRYGOUcTN/O4YjnEM05cKGbq7J/0DPUvR+Q7AV9N38bOnAr4weikffNj4dW6ZohDD6IjtACtWT7xdITGG3jjCJJftijlJ0f+3JevQ/Y1vc0jDVS4mN94OU9gj0H52EK0sFXq7KDmszPYKsLxYndcNaPKQnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=SerNet.DE; spf=pass smtp.mailfrom=sernet.de; dkim=pass (2048-bit key) header.d=sernet.de header.i=@sernet.de header.b=AAbVG9Jb; arc=none smtp.client-ip=185.199.217.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=SerNet.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sernet.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sernet.de;
	s=20210621-rsa; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pizC1B93f/gGXsIN9BGuDQKRw7/VQSwJnVbmPYvS1z8=; b=AAbVG9JbP9oOZ7gXjmek18XlPD
	u4neu+/j9oHXtihSOYFxB2U24acHTRbHDlTrHT4XaypvA9I3Y4Cu3bLoc5kZ/uq42mxwftmbwaABH
	XPNPDi1AsiWl6bRJrVMY/mP8Ku1kgeLpFWlp96AJTFk+qPI2X+UhCKTRIjp+LapBxGyPkqCH25Q0K
	7P7JYtjYA3NfaK3pgguCMVUB9lKsBcgUHGcNFZvMdJvosd1KcLF7jNSyx87RD/MD08J34tsVei6Ai
	hKyro9V1dnLcyOs+7McchoNpZQBojTVZKriNKEHbxB+RCHzQ4+nJQ0J4scxg/4fbLT0N04iD8oAhQ
	9O5mZ9zw==;
Date: Tue, 22 Apr 2025 14:31:41 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= JACKE <bjacke@SerNet.DE>
To: linux-fsdevel@vger.kernel.org
Subject: casefold is using unsuitable case mapping table
Message-ID: <20250422123141.GD855798@sernet.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Q: Die Schriftsteller koennen nicht so schnell schreiben, wie die
 Regierungen Kriege machen; denn das Schreiben verlangt Denkarbeit. - Brecht

Hi,

I started to experiment with the casefold feature of ext4 and some other
filesystems. I was hoping to get some significant performance gains for Samba
server with large directories.

It turns out though that the case insensitive feature is not usable because it
does not match the case mapping tables that other operating systems use. More
specifically, the german letter "ß" is treated as a case equivanten of "ss".

There is an equivalent of "ß" and "ss in some other scopes, also AD LDAP treats
them as an equivante. For systems that requires "lossless" case conversion
however should not treat ß and ss as equivalent. This is also why a filesystem
should never ever do that

Since 2017 there is a well-defined uppercase version of the codepoint (U+00DF)
of the "ß" letter in Unicode: U+1E9E, this could eventually be used but I
haven't seen any filesystem using that so far. This would be a possible and
lossless case equivalent, but well, that's actually another thing to discuss.

The important point is to _not_ use the ß/ss case equicalent. The casefold
feature is mainly useless otherwise.

Can this be changed without causing too much hassle?

Cheers
Björn

