Return-Path: <linux-fsdevel+bounces-14687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1DD87E1CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 02:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECE91C21E51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 01:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D71CD07;
	Mon, 18 Mar 2024 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CZHuYJAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FABD168B7;
	Mon, 18 Mar 2024 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725788; cv=none; b=EB9ohwuUOMJydc44T0zNAT8D5ghajRdCI6Xqv4fzYlPcn35SK9mnLJnkkbIUvRb0PRLDP4oxIryxHDX3u8YRJGxCtVRtbRKCd3FRQ+OsiaeoH8ehWAWrfXfPC+hhI07B96Bz/PsGnV8b3+dhaBxq8HrwLuIV3hxhjHme2OcnPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725788; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWraev41UDns0akwS+YkzY7JEj0eoIp5kxEsQe3fvk0TOnkgwAgwFmlt7MPa9zIi4rr44PXBrK9GgZbCkZpOul3mMaroWgP0OGZm1nW8lmGGXoo3C+sCBGubYPgYgiJ5Fk94CR+hzzmU+5Q3+Yt1/IxUvKUp7Aarb42PskrHNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CZHuYJAn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=CZHuYJAnS00dhDyhdyG7vU9hsS
	QV+az6/zQZZGL2715aYv/lvrZW+whRbY3TpxP22IjdPvcfOY1Ekra98zM8gN9pjrBDFudkHH7MoQB
	YlB0/liNF2F5jXtTX/R358SLmV8WDNZ409ctTSVr7X1gKz9RCT8TJ6jJ3/uAFQRGyNZXErYYR+Yhi
	AyqiUAkfS+c4wzieN07tp0Y43hORL3//BzXDezbMPpNvcqQZc/sLyAH1Jyr4X5ua2jQoJOxufvVvc
	QAst0S7u48ERqg5ZubRbhKr07pv66c71IY6QvOqOddQlhf2hdV3TsQJ+c4kjoTCSqT8wrMjHKl7dQ
	DEZOGaJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm1vN-00000006whq-1UPW;
	Mon, 18 Mar 2024 01:36:25 +0000
Date: Sun, 17 Mar 2024 18:36:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, tytso@mit.edu,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v2 09/10] iomap: make block_write_end() return a boolean
Message-ID: <ZfeamTmWkYisiwTs@infradead.org>
References: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
 <20240315125354.2480344-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315125354.2480344-10-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

