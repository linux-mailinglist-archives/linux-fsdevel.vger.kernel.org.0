Return-Path: <linux-fsdevel+bounces-45198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C26A748A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 11:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B31895A6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 10:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4081F3FF3;
	Fri, 28 Mar 2025 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eR8e3Klg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11466FBF;
	Fri, 28 Mar 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158762; cv=none; b=h4kzbHa5ZqtbhJdcNbuG1Mu3xMOPkrLGc+TMLtbNrpLtONMUb+Q3YYfYf/Cj+C+clfuaBzvC5jH+YVT+XYcGdIX2KxzKFRCTIEUsOqar6+l0mQBGiprzyqGl84dk2EAifCitGQXFPBhp3kjleaLfiqWS+sFh3dzclQ4uI2SWm2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158762; c=relaxed/simple;
	bh=HX4L70QTi47Xyax4mvQKMiRVkvBpNvXUFLKXEnV2Uj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeiW+lN+gdWdJV2jwT1Q3fIfaGpmleKGhVhMH0ejvYWi/4950rSY8PH2RR3MSTPv8J4gzzORLptFp0gd+wgT5VE7d92Lv6fOTH9b/bF65Rt4MHpJ0Z2mJd2aCSM98zbxVwzNgsvw6fePHUPDWitnkILjIf8KpJajic4tEk3oq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eR8e3Klg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7/ZRM+Jgttx6GELXH1bXNxJMDypsQo+VPqHGzIsFl8M=; b=eR8e3KlgEmnGbaljZtyjvTSpwC
	viEb0pV00OPfxmLrMiI9RdAWyl1+n1Q9oJSbw0PrN9npp7wbyii1AJ472t2B2CFCaflmwh0h3pdqj
	pTIekseNHeyL3gd/TfubrhCe5ALNXisa010EP98HlJMtM5weBgxROsZAhRKWgxDcIWOoHrOvVbZ/K
	PWbWqd3mPJC209QEVwetkq5baZzTmPGf0et5Abo/E5zxUJSQiqseWz3VEBb13U8DTgibtUW2Otr6G
	iwwH9ZRyq5SOvrma3ZZ6hUkOadqGFzCG8AxbUTdA1A5be9OPqOu51m5iyhPLSkq6Ydi+Hli2Z90SL
	PRKEgR2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1ty7Dp-0000000DAUI-3wy4;
	Fri, 28 Mar 2025 10:45:57 +0000
Date: Fri, 28 Mar 2025 03:45:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nicolas Baranger <nicolas.baranger@3xo.fr>
Cc: hch@lst.de, Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <smfrench@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [netfs/cifs - Linux 6.14] loop on file cat + file copy when
 files are on CIFS share
Message-ID: <Z-Z95ePf3KQZ2MnB@infradead.org>
References: <10bec2430ed4df68bde10ed95295d093@3xo.fr>
 <35940e6c0ed86fd94468e175061faeac@3xo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35940e6c0ed86fd94468e175061faeac@3xo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Nicolas,

please wait a bit, many file system developers where at a conference
this week. 


