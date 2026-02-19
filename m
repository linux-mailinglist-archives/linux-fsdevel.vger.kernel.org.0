Return-Path: <linux-fsdevel+bounces-77680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP7hK7SylmmRjwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:50:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F61715C7C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBB3A300C331
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25026F2A7;
	Thu, 19 Feb 2026 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xYd8Saqu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD873033F6
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771483824; cv=none; b=EuGsgt4mcB5dPH6IHCBXflcRjbFXezaaZf0WTg532HK5uMql3eXd3tAJIoZRPpk5sDMi7Ma/BLRI3MHHDG/bX4bgL7l6JDuWwFs/8Xqaap9oCpnxrAkYwnJRaM3iHEPJKa3EgAoTPXsfaZHxQvtMAkLIyKNiuAGzuXRuLNzS4xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771483824; c=relaxed/simple;
	bh=02hO6FJQk//Cz3/IkD0WLPeAEwochiixOF7nIEKWrgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2kAJ1uHKuB0k9m7TPBxblaqrQk4FJwgEQrSBkyncf7n49c0gBBl8CiJtt99Qa8Lf4s575+gP4pAjTlpi7xT2tJXU9pm4ef975BFeliJcsBtOs5M9f7N5qlB6tsnrn7tqggnp+gknQRf0MZJmyZ6EhBomt2qs/GSqCnGGoH6+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xYd8Saqu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9sxDwQvq4sjpxd8rPY7pJ4oxRMkA9KdRw25rA3vb7CI=; b=xYd8SaquIuytB7512vmGe/xdlH
	MsXcXB2d7FGX0qgzn/Sjl4n6sq9vs9FwZuo42SBJdztHAOEre4eHyl6r+RmRgLCJ54DXCq7anNWNg
	iqVuZ6oV7g9cYsJaz63cQVdgL2Ew1wpGVpxsZp+ud/EuN79lCTU2JzPx7LMot03ZPYvAw9OaDLiql
	P9gC3imLB06edc4kiuKWOM3By0JGSL+/3Fo65SrHtSJZknsRqzXY/LwQuVE3v/QNWOqkLE8hLXRw2
	p6Lct5P7DaEnciWLu6of/kzHTORkHo5Wx43y2T//1Gvi9jtIWzYFDj6Nz4eC8pLCSdH1ev9/cEJPO
	SVmgLA8g==;
Received: from [212.185.66.17] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsxri-0000000AzIF-2O2S;
	Thu, 19 Feb 2026 06:50:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: remove or unexport unused fs_conext infrastructure
Date: Thu, 19 Feb 2026 07:50:00 +0100
Message-ID: <20260219065014.3550402-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77680-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 5F61715C7C7
X-Rspamd-Action: no action

Hi all,

now that the fs_context conversion is finished, remove all the bits
that did not end up having users, or unexport them if the users are
always built in.

Diffstat:
 Documentation/filesystems/mount_api.rst |    4 ----
 fs/fs_context.c                         |    1 -
 fs/fs_parser.c                          |   19 +------------------
 include/linux/fs_parser.h               |    8 ++------
 4 files changed, 3 insertions(+), 29 deletions(-)

