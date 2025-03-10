Return-Path: <linux-fsdevel+bounces-43645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8F5A59C87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA9F3A941F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FD223237C;
	Mon, 10 Mar 2025 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q3r5zqLZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271CB23099F;
	Mon, 10 Mar 2025 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626692; cv=none; b=bnA5PAwQKVhj41N8WfeFGZRCy17gcfcQxhH0lkMHuJyXW3mNlIvilI5mqdK28jRZh7PIZBIVIYZCv3qQjdH+LSf5/y/t4WODu8SzND9iwZlesqndIJ/s4TMBBOzFpQDkjuTgBwnr2SuG/avogS/i9oKq2VeEAOEc0SqRtlb2YNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626692; c=relaxed/simple;
	bh=9TTnEQPkzr4juZjjYYfiu3LYq+87EM8AwhJ+6HfQ3ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjJlN8lQmMUeQgP5i5jtIlQW9TlmRwLE3zKpw/xNJW2obNBBvdJ4zTfHvzTYcrPYO6yz77l5+XocJLtqVM8TPvmw7iXOTLWF9MY+DMSWS+plcOihXjToyY2awjc4Hs27Fzfdrr6G81tOSIS8LFzzQR7PkQDNiGJtdYA3wbpqCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q3r5zqLZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Lv1yCpSVQyMIiwfaIWG832e3Gp7/oH0tazXadlyAtc4=; b=q3r5zqLZDaREtVev5Q07XWpqcB
	OpggNXiz3GYKrz5rChcUe9tUlfgoLE2i97b4mU3bFSlFyhueW2gY9HVz9ui0LlikwLtptQn6AEtHH
	SX6Xlj7bE0VezkkhqkIOse6wq+Ii4jji1AOsdRpPJcQxiA5X37P9KMuKpj0l32Aje0I/iCaTvJ16d
	zfTb3wQ6gH687orqT6cum5wShFpBZa3CjsW4lGc6aMTzjedIYfma+32/c3PNvAKd+qvU75wOIvp51
	2Ig9ZqrPgcwc7SvZFbyVxIlMS4lO0zclz/Y2Kl7m/rVVIEy5kHJJ61I4xtZ2xNjxuc0mQPJYo10k9
	oSmRdV6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1trgew-00000008LUs-428i;
	Mon, 10 Mar 2025 17:11:24 +0000
Date: Mon, 10 Mar 2025 17:11:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yuan Tan <tanyuan@tinylab.org>
Cc: axboe@kernel.dk, syzbot+f2aaf773187f5cae54f3@syzkaller.appspotmail.com,
	linux-block@vger.kernel.org, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
	falcon@tinylab.org
Subject: Re: [PATCH] block: add lock for safe nrpages access in
 invalidate_bdev()
Message-ID: <Z88dOtsjiIUx6apV@casper.infradead.org>
References: <67ceb38a.050a0220.e1a89.04b1.GAE@google.com>
 <20250310165400.3166618-1-tanyuan@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310165400.3166618-1-tanyuan@tinylab.org>

On Mon, Mar 10, 2025 at 09:54:00AM -0700, Yuan Tan wrote:
> Syzbot reported a data-race in __filemap_add_folio / invalidate_bdev[1]
> due to concurrent access to mapping->nrpages.
> Adds a lock around the access to nrpages.

Did you even read my analysis?  This is a grossly inappropriate fix.
NAK.

