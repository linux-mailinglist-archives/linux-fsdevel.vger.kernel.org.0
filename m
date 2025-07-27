Return-Path: <linux-fsdevel+bounces-56110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96556B13233
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 00:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02ACB3B85F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 22:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921322472B0;
	Sun, 27 Jul 2025 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dpaUWuT/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FFB1DE4FB;
	Sun, 27 Jul 2025 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753654275; cv=none; b=ifw6PshWPap4DLlJV4DmkP9V1TWutZ9BcLJ0kQLsrpwbrazaWqbZeb6yeJVoqJMLy47LZFqtbH4X/fWeik9cbsbiwv0lJQTQDUoJZO6Z1xM9lS9ClUOGp7OsqXuUlpLgDyfpRPh2VJywMsAYieGZhM68sampxRySKrzauXrpyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753654275; c=relaxed/simple;
	bh=30hp32qG5yGyWXbTJhUAM3eIIZb3cEDwJ8ZUZKMcD8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc80R223W4dqWFtUAV7Uaz47KF7cHYorsDFJt4ZkYkuEIu4eBFVDQioB0q7zqmLQ+TWVOKMIW5Pmw4iMob8wqvG/8Ymev/a8dZX+ZYF9JDywGRkfRmm6ccRvKaDuMqpNGiF9qwVh9Q4iFB9ZziDKRJ1LjhMZlCyxlLLpzXYy8oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dpaUWuT/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+hW4d7DI3zWYNgpta3mmqm8OPL25IKhqBbArFcbHXd8=; b=dpaUWuT/ujQoHZobKmJKT/dBLC
	/f0WkM9WTQryrsor7WZ4ag8hTzEgeqc75dnIeiWUHK69AgSdFji9S3Fi8J58qdAPvg1xIlVXFu+k+
	03mohxWGmmuDSCS6y8UWRcqzDji+SIuRPsUEhkhhhxq65fNBXss4CWeP/DLuJj1kYtGbBoEbS/xd5
	deW8xhv/13mpcn5BkpVhBO68toOK6+/KDyCJenA+tQWZ5J/+W0JC2lY8z2DeQsm2mSQbE+MTnna3a
	KdNprXWJM2irc4pux1ngybWKZvsdQyth7Rfk2+TPMAaLZAt/Fcmk+P0fZMjLYOXZ4Yj7BgS9bsy3n
	Jw3kALjg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ug9Zz-00000000Dqj-1nZK;
	Sun, 27 Jul 2025 22:10:51 +0000
Date: Sun, 27 Jul 2025 23:10:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, djwong@kernel.org, dave.hansen@linux.intel.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH] iomap: move prefaulting out of hot write path
Message-ID: <aIaj69N19WCbKKy8@casper.infradead.org>
References: <20250726090955.647131-2-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726090955.647131-2-alexjlzheng@tencent.com>

On Sat, Jul 26, 2025 at 05:09:56PM +0800, alexjlzheng@gmail.com wrote:
> @@ -992,6 +977,12 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		if (mapping_writably_mapped(mapping))
>  			flush_dcache_folio(folio);
>  
> +		/*
> +		 * copy_folio_from_iter_atomic() short-circuits page fault handle
> +		 * logics via pagefault_disable(), to prevent deadlock scenarios
> +		 * when both source and destination buffers reside within the same
> +		 * folio (mmap, ...).
> +		 */

Why did you change this comment from the one in 665575cff098?
The comment in that commit is correct.  This comment is so badly
mangled, it isn't even wrong.


