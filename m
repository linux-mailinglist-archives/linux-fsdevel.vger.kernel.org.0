Return-Path: <linux-fsdevel+bounces-38661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B409A061C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 17:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33AF8188277C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A661FF1AC;
	Wed,  8 Jan 2025 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GYi4Eyiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F414A82;
	Wed,  8 Jan 2025 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353566; cv=none; b=LXDvLkUji01gf0X/EqNAseh7FHu/LooE3hXa3QV7LJzw+LF7zCTKNbdHgIf44K+cgzgW3Z/AQLz+EKEG85T47mq7srxbaXJgrw+jq0J4CjgcJ5VyrhrgryaQlyRR+uYlm4qkfWTGJo8qNOSeglU/3B/v2h/WNh7iOegD/O/UMaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353566; c=relaxed/simple;
	bh=Q9ltSLrIoPAesJrmWVWqpAfai5DFPHIjAeg0/+UmCXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aO7sBr3DzFYb0HfWh57rL0e2pJDZwKMp/1E/O2+HEXyl6oKjJL56PRgfAy0xnZ5cUJMhlo4swYIcC7v24wNNJQAURg/U5Hy6d1i7CKmJBlhW2BJ2Ih0h6s/aQ784mVQBuzCsxFG8oXKsXjxT+LfNmAfQ8D96g6+K73LlUGJPwTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GYi4Eyiy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=weWpNM3fKbzDtXKx1WecMn9tVZ8r3NqC8kWjrcpxoog=; b=GYi4EyiywAfM72Wy2ZB5y5FcJF
	wCU60p+4DHb9EkXf4MDN3ZgISwEZc1s4/+VSa0SvPUjY+1jdCiUENQ3ch8+MrwsOlF3LnR+zNBC0s
	w5cpV2J3x5Vbw0iSrOOhLJjq2Izk+8kkpggXP8w5Bzvu+bxM0YO/GCtPWnNRAgidyOtDKiGlsoF83
	5Ss52MxM5fT5rMRvcZsIiAB5lZYM0tzH4Y+4oYI9jUSMR4Wub1eexEPiiagxsLH5+f0MqPV/Am8rj
	i54/XrmQiVUOI4YZIGajEWPj9jO6i36/MrApw7e2AMKVmnuKEoUgoqRgkGgx20dhmxtuKiNqc0Msg
	ZB0E83HQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVYsW-00000001xkP-3OMp;
	Wed, 08 Jan 2025 16:25:56 +0000
Date: Wed, 8 Jan 2025 16:25:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Liebes Wang <wanghaichi0403@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: Bug: general protection fault in hfs_find_init
Message-ID: <Z36nFJb1045DH_Tr@casper.infradead.org>
References: <CADCV8soCn9d_Z1OW0L+D8yirjj8vyT231yBOuKnWrSfM2Mc2pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADCV8soCn9d_Z1OW0L+D8yirjj8vyT231yBOuKnWrSfM2Mc2pQ@mail.gmail.com>

On Wed, Jan 08, 2025 at 02:27:59PM +0800, Liebes Wang wrote:
> Dear Linux maintainers and reviewers:

We are all quite busy.  Could you do some analysis rather than just
saying "my tool found a bug"?





