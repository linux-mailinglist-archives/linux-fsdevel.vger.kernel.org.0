Return-Path: <linux-fsdevel+bounces-11309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 647F68528FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F50828430D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1603F156E4;
	Tue, 13 Feb 2024 06:32:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A751754F;
	Tue, 13 Feb 2024 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805949; cv=none; b=ulGxCyCJHSBpE44zPejqKDqF8pODF+WaXhrN3wMxRf3EdyMAX66RpKLZG8ETKHFNRsMZB4y4M2Hj+ANVaf6l77VYl4nVPu7PX565ie299bNtkgfdBFgiMwp9DBRa0PlBwZg4yw1D6JxhlGsMcJ5bdMGAHd6mDLaV++1RU5zkKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805949; c=relaxed/simple;
	bh=/b2W5dfca36Y/WDoeFmMMfgnTkRpcuKoJ9AScS+hT74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH5qQNg2iynJ5EHEn97Cark1LJb7dVvX/80BIVyB5+Uq0prcJojeRv/wGQ6HL+MV8dYQL0LpaGePVhr0RG7barrwqjNlO2HkhJKO9qoFgheulnWGRI07PdK4jxREQI9EQDQsor7qCnyDgcA0QJqZlbMy/JMmUe+8pnUr1ATXOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 994DB3000086B;
	Tue, 13 Feb 2024 07:32:26 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8330C70EB7; Tue, 13 Feb 2024 07:32:26 +0100 (CET)
Date: Tue, 13 Feb 2024 07:32:26 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org,
	dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/8] dax: alloc_dax() return ERR_PTR(-EOPNOTSUPP) for
 CONFIG_DAX=n
Message-ID: <20240213063226.GA4740@wunner.de>
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-2-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212163101.19614-2-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 12, 2024 at 11:30:54AM -0500, Mathieu Desnoyers wrote:
> Change the return value from NULL to PTR_ERR(-EOPNOTSUPP) for
> CONFIG_DAX=n to be consistent with the fact that CONFIG_DAX=y
> never returns NULL.

All the callers of alloc_dax() only check for IS_ERR().

Doesn't this result in a change of behavior in all the callers?
Previously they'd ignore the NULL return value and continue,
now they'll error out.

Given that, seems dangerous to add a Fixes tag with a v4.0 commit
and thus risk regressing all stable kernels.

Thanks,

Lukas

