Return-Path: <linux-fsdevel+bounces-10047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D118474B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562DB1F28BDB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7A11474D4;
	Fri,  2 Feb 2024 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LupnOBpP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD561474CD;
	Fri,  2 Feb 2024 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891345; cv=none; b=KR25YcmyX34HSbuxdi4Eoh9NM69tE+RdwA0QJxHkSFOzRm5fdEwaMIuaTFQqQxZdPfncTwrIbqk3I5qN5RrfUPJNFy/uY4m0hnog0QqOoj/Vnr0u3MOruFmXC5xzFxw7Wp3CfJ504TY5yvVZJ6weA2S16C9TLEdh7jDFrdvLEXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891345; c=relaxed/simple;
	bh=yTf2N5hieH76/snamkyDPuaivV84pXMLNyFSjKDEC/w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ffa6dC7eRSC/sIINOvnt0T6mVt3bjPxFJqe3r5sNvejGaFH11zmn7Z9dGrpu41XLrS834LSAyNX7W20k9m7jjmZ9R+1N+rbMYFKIk+8PifiB70FSX3RrJ+H7T0EhiKIkMytc5tBR6wNQ7omqGU4KVoXI244TBhkGQLxHs5ujI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LupnOBpP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Yv89qsijhL8lE7JeRJ9pRE/QquGa9JQWLz2IsajqlBs=; b=LupnOBpPM7vOxUoL0szt/IoMn2
	F66A8AOYNKkWiA5U7g6aqHrhkZQpS5bHjROLG3EPb6L3eMYFzEveKlh3osmMmSpsWTYzDrJWsscSU
	WRoqUj0aaThljAVKz6Zodjnx4h6FV0bN7zCia1RxICB3IglElc/83cb5NtDG4SSksdqu+1N/ryFIa
	9NC5aoxlMipUHLI2BH7grBhfY88f/CH0js/1SDCgucWZo0gcD2A1jQXLtsD2yZgARPWzuR+wkqsY7
	D4qsG1S9OYcqW4slm3kn5GW/RJ8z1any9KcewnC7RTupQkpkhHRwA/Tikl6BoYJ6TjXuZJGI+2QtT
	hWeDhWzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVwPS-00000001Wnv-2KCT;
	Fri, 02 Feb 2024 16:28:58 +0000
Date: Fri, 2 Feb 2024 16:28:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Message-ID: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

LFrom willy@infradead.org Fri Feb  2 16:28:25 2024
Date: Fri, 2 Feb 2024 16:28:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [resend, PATCH v1 1/1] logic_pio: Use RESOURCE_SIZE_MAX
 definition
References: <20231016132611.1201402-1-andriy.shevchenko@linux.intel.com>
 <Zb0LzpBkE71wWyqO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb0LzpBkE71wWyqO@smile.fi.intel.com>
X-Mutt-References: <Zb0LzpBkE71wWyqO@smile.fi.intel.com>
X-Mutt-Fcc: ~/sent
Status: RO
Content-Length: 237
Lines: 7

On Fri, Feb 02, 2024 at 05:35:42PM +0200, Andy Shevchenko wrote:
> On Mon, Oct 16, 2023 at 04:26:11PM +0300, Andy Shevchenko wrote:
> > Use a predefined limit instead of hardcoding it.
> 
> Can we apply this one?

Why are you asking me?

