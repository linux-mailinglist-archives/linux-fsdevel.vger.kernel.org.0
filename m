Return-Path: <linux-fsdevel+bounces-42792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A99FA48BF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 23:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3073B5871
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 22:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EA81E833A;
	Thu, 27 Feb 2025 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fRzrjbBu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D72777F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696512; cv=none; b=DXlGoe41QFnsB3Fxx/lQeitfud/SfYGm6fMs/Lj3M6spJbQafgJ6mNHWdpDV6ErHHwMvRCjdXT6U0Dqo9B73ChL+kAEMqHrOjGpMi9Y31tIiBbBbUpcztBVB5u5EVP0/ARRbgFUdcRUTixyVHOKhU6bHA+O9W6jMHGS2GPhVHKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696512; c=relaxed/simple;
	bh=g16LKpgE23znTtpNoZPvANMkuZxuHB7/j2Mb/RGDka0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NBOxtgQF5cyUm8gJBnpwkpTpeChfvvZ9W10polp4SVB60GLKMNtuUefoQGPZdMGuie/KSkwcw1e8sHdyB/IfRDKvVdCf3wGiTHPx7snmt7Sx2gg6OcuYLJDNEM+kpItpYk9haN4Cf1coc9B8X6V6IHZ+bIwY9XM8EFEm+a6djGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fRzrjbBu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fKEIRBsvoKO3ZA5orZMrzJYm6DWPHQWM8gXIg2sf3e4=; b=fRzrjbBuUONogJgbTO+mn2R75T
	PGX5uoFHyqQvQWZYzT/bL70qbA2RcbcQ4ldigKJmZoGVDcdKG9sONClXQti8Bep8c+/jWdtcVKIMH
	ouyo6NiM/ayj0SmkvPmsT9mLIGTW3qjejdCPosD2caP2/hbb2SyTqrzAZwElbqLhJP+BZ6H5QXyoj
	IHi64jaKlNPQ0i3FLhyCUF4vuS7187CpQqaTo+5e+hhUqyKUl4nlnkCsO3jgYaqsmUvFaxgNwpee6
	zws3oGP3fr1fVmmMvwWEz4AYR3zMOaKpjB+ml7bAyl38qQRrbDAEfKJu6x6JKv66Tilfc22uOCMuD
	+X2UGKVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tnmg7-0000000Aq6M-0CWe;
	Thu, 27 Feb 2025 22:48:27 +0000
Date: Thu, 27 Feb 2025 22:48:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Namjae Jeon <namjae.jeon@samsung.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: [RFC] weird stuff in exfat_lookup()
Message-ID: <20250227224826.GG2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	There's a really odd comment in that thing:
                /*
                 * Unhashed alias is able to exist because of revalidate()
                 * called by lookup_fast. You can easily make this status
                 * by calling create and lookup concurrently
                 * In such case, we reuse an alias instead of new dentry
                 */
and AFAICS it had been there since the original merge.  What I don't
understand is how the hell could revalidate result in that -
exfat_d_revalidate() always returns 1 on any positive dentry and alias is
obviously positive (it has the same inode as the one we are about to use).

It mentions a way to reproduce that, but I don't understand what does
that refer to; could you give details?

