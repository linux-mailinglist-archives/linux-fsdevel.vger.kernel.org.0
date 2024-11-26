Return-Path: <linux-fsdevel+bounces-35927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC649D9B5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 17:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431EF282BAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16391D8A0D;
	Tue, 26 Nov 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sV144xlA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6831D86F6
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638271; cv=none; b=mbRzSxfzOdjZVkOiN1yfNX5u2y1ZtzqmXlMa/IVmTQsS2e82kGypDfR1Cogx9w5DMFXJd2uswePPiGMQYgDKIH+HpQ1YmGWNL+qBQE8tJ8QAQ5d8ehDd0SY7rT8UELnW4nxP3SCt/DqJgvUgJD8vlfI0Zwl8ghFj7geEuOWZzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638271; c=relaxed/simple;
	bh=p9C8NOHvMxF8biksRTaV5Qeq5m6isuBRG/uxUjxyieo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiJMoXxWTJdC9hPvO4d8N5BZEqu5DnSMkjYNm66LL/NMaxdXImlz1OEAUg5LaBnJpaIWPSDPE6RxybYhBfk0HNHDcajrF6SkQADeEEgZnfM+cuz4KU8KBaY+2VEf+2mgiSoKjXXRiAfnLDLFC6XA9K08ixLckXbipQ43CY+ynew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sV144xlA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S8QgynpgATJHol45Ib4baCY+lnCFHsFkq/3Ee7lR0Gc=; b=sV144xlAwUxix6TTVgVbWcx9hH
	XxB3I5G21fCCJ2lqap7WWK6U5CwL+1DdChNgP8J4lOE7ixW6v422BHyjRM+D8Pw5D2kIAO38vInXH
	XZ3Ug7KTs3eVvmaAx7xP4KdF/8u+2yWwCcFdFFySxmgPFEBMQnZzVjip2RAfgsPzazyClCPgBHCn4
	YaRY2fSdclAI/n1d2Fn+V4TY6SIduiw7dyDTLEGMZ4pN9w4gZpo5dg/nC7v5BZ8Tg7ehZ0S46gEE7
	DlusISPHwnVwJB/UQhbVtmWQi3Yr0DG0YcMsUR19BkgJPpaBOQQTxZfcrpN58j90hLEEZoSprs5Zr
	KP1V42Rw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFyMW-0000000B9OL-3ohz;
	Tue, 26 Nov 2024 16:24:28 +0000
Date: Tue, 26 Nov 2024 08:24:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: cel@kernel.org
Cc: Hugh Dickens <hughd@google.com>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, yukuai3@huawei.com, yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH v2 0/5] Improve simple directory offset wrap behavior
Message-ID: <Z0X2PAZy04JGjjFN@infradead.org>
References: <20241126155444.2556-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126155444.2556-1-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 26, 2024 at 10:54:39AM -0500, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> This series attempts to narrow some gaps in the current tmpfs
> directory offset mechanism that relate to misbehaviors reported by
> Yu Kuai <yukuai3@huawei.com> and Yang Erkun <yangerkun@huawei.com>.

Any chance you could write xfstests test cases to exercise these
corner cases?


