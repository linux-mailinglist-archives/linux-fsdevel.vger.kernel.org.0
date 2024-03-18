Return-Path: <linux-fsdevel+bounces-14680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5255D87E1B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 02:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27248B21B58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 01:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46AA225CE;
	Mon, 18 Mar 2024 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h5kAgqRY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E4922337;
	Mon, 18 Mar 2024 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725356; cv=none; b=OsWB6yuZxB0OHPZoLhT6cl6DB7caV487KylTdVW3uE5FcBtrwfNlUNp4M+GXUg/EEHvh/W6foKKUcCLu0jHUNlWQ+2fzAhQyYcZ/kT1CvbkgGA9XtOO9waikxWsQ4o02MYjno48u+aaAVAlcCgyQHGVV8HTcifrjaLFbWdL9skQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725356; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oO4LILmU+9iP4vsNnIBa+o7JHvydAyJpt+vlfC3GvR4qbo6LC5So5xnbq4pWsLRsw76Eyu681JW+fzqvn7ej9rEpTay7w2Dwa5WZgNwLIJkFwjFtic3ouX7Bb4mreeEMR9XcFuIjacMlYbRWMGNz8Ps9F9dYUm15ZR3G7VE9FWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h5kAgqRY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=h5kAgqRY204kibigN3PARj96kp
	HW7R0W0IcITGRtfQm8kHSlEky7tCpWZdVqO1qliWxo0gKzBL+Z9MJLV+9Y0B7mnP9ojn54LHumc8o
	zDwxejornj0Ls2LOR0xTi31pzRHXgCtw1nMG7Hy1AsCIWrqnC2eKDG8CxWKkld2P95wUMsCa4yJXb
	7fRLl4F1PfVXqeyINqjF/6aGRbHw/5tA6J9BbOIjclbyTPT+P+bcxBV/t8Hgrbkym85rjq6rWcX/7
	d8c5/MxDyCQ+0W/GNSs799cGXKAyiTucEz06ALOKSoTZteaHwHcMvkMCwot0oLZpltwgHgXsHpjNn
	8G0+Alhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm1oQ-00000006vN6-01k3;
	Mon, 18 Mar 2024 01:29:14 +0000
Date: Sun, 17 Mar 2024 18:29:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, tytso@mit.edu,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v2 03/10] xfs: make xfs_bmapi_convert_delalloc() to
 allocate the target offset
Message-ID: <ZfeY6QaxhHiAGhuP@infradead.org>
References: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
 <20240315125354.2480344-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315125354.2480344-4-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

