Return-Path: <linux-fsdevel+bounces-69645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F46FC7FA60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 10:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A51E54E4D67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507AD2F60C4;
	Mon, 24 Nov 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AfLNv+Vi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88E62F5A14;
	Mon, 24 Nov 2025 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763976622; cv=none; b=T8Rtt8mRSQvhv5N3hb3jLFBqMR216kFQHCpszPfKQ5WJApCLIXtUGrNUb7j7VjXHN3A0KzKe3LJDA69jK7VOizWZiTc0mLZROu+B+78sXV99O6ZwkNDJpybUz8u8WFLZ8aHpBA1arhfBcqpKFLGs+l0+MDUkWLp0fhnyx2UHg3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763976622; c=relaxed/simple;
	bh=ZkYVnwCA/XinSdGWA0IYP6/9IRxWHJXltkJgMPHbf5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkZ8L+pl5X6yeOdipFWyr1rRh+keD13GGn0/f224VbV9wHvPWAlC6ubSKneMCdurFX+0fcBi1BpQ9JGgBN57D/WJ/TSxkRFAvAjVXgXYUWTitNHTjWzX9/1dSggR47haRRaUeMaBDVEV9Zrq4Ld2Dlaf4S1fxh2gSTGs4BjzBgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AfLNv+Vi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZkYVnwCA/XinSdGWA0IYP6/9IRxWHJXltkJgMPHbf5k=; b=AfLNv+Vip5RSK4JQaYVltdwHhK
	mEHUTtzaff0DFu7Fdu0/N0AtpKIflnwfT5QCbzHLBNOkmv4wy7YdzzR6qiP5IbAXd0Ksqf0i2/sKt
	KkhR1ejLB0tRoxq/uDS78hRzqYIXXEdQ6BC1cvMqYlbMUiFA7DNdq9vZsyKJM5WAFoHxm3XExtSZx
	Fm9UCiesoZ10fgUjaHh9wzKzRo3V8J77IsuKeM7TTxZEFNnxRNNjl0YN81mZE8kfO8S0oWtLDcjv6
	VT9roUunubVVNCdXBLAwzPbeU0NxUtVAILuBrNleFiNvt8x0M0j2hTozD3Sx5j5F+8r0VHlKjrfao
	1HpL48FQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNSto-0000000BLt2-12ZM;
	Mon, 24 Nov 2025 09:30:20 +0000
Date: Mon, 24 Nov 2025 01:30:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: syzbot <syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iomap?] general protection fault in
 iomap_dio_bio_end_io
Message-ID: <aSQlrJxWxNyCVt3z@infradead.org>
References: <6923a05a.a70a0220.2ea503.0075.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6923a05a.a70a0220.2ea503.0075.GAE@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

#syz test git://git.infradead.org/users/hch/misc.git iomap-dio-read-fix


