Return-Path: <linux-fsdevel+bounces-63919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC55DBD1BF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 09:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A121C4E3F5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 07:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F284E2E7F20;
	Mon, 13 Oct 2025 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a7jS8hpp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F51C5F27;
	Mon, 13 Oct 2025 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760339511; cv=none; b=SYUHifpPZvuTfn90hBrRltr+jXQvYOTWj9mNtX0yK4Mn/hXwbUWFmnvsBILT3yYGZGb4VMqJqkhn6NGU02mmUTuuz44I7vIzxuRp0kpK60oVmauEe64coen+eZJHZ+oNzOCPsc/veTgPQVxngYDSsQRoDB2/E+1QKh1x5PeTrq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760339511; c=relaxed/simple;
	bh=Kd2zsFBiopgBm4y6P0SthcqKSiIiy6x4/ReBHnvuxc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFzrl3JW99KMCAzJvSs+yLBY6XMDTdB0APfD865gApBoXnpx1RDuFO3K/+2X79b1NxOkO1IjDanj/K+haJ54elBQZiHd6QhMl3yqQbd09QizYwiyyonO3vH6zmL8A51l02Cpo49/Gb7av2VgoCpUgOOGL7ddjVQp8gFSuY/I318=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a7jS8hpp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GfTZN3uLzAsAxY3q31/7T+wpydRrewZ5jCCK6eizBsI=; b=a7jS8hpp+L8PsTb7F0w8I0uspD
	7hVwHXv3BzhM5TQLsWk8UXpm3jwdS95OZakJAbJ+ocbzVqGd3nKlZ0exTCvjKv6/YbJaG95aGoHA+
	0UlZ0V3RzNuAWbjhZ/c3JSlgAsVkoUuvwXd0w1SUndo5+UAZPLf6NNBAzDBXERgdNnL8WFV4RhTRk
	Rkpn6PaVZSkQ2Q9TU0Q4VgXah4kKCEibOZrDtBamJVtRPfaCQhpgmr9SA99OiYb0krY/9zGyoZIai
	QJmJ2DjptIdW73TZvqVsoN1RPeYeM5EQhX40nVHChWJ+NWr94V5XD8yF0iBgyJZK5tdcXkk+1HxFP
	RJgv7JzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Cij-0000000CSq5-2pQJ;
	Mon, 13 Oct 2025 07:11:49 +0000
Date: Mon, 13 Oct 2025 00:11:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, brauner@kernel.org, djwong@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: add IOMAP_DIO_ALIGNED flag for btrfs
Message-ID: <aOymNZtfK3NXqGyJ@infradead.org>
References: <5dbcc1d717c1f8a6ed85da4768306efb0073ff78.1760335677.git.wqu@suse.com>
 <aOydN1rIsWiNo4m6@infradead.org>
 <595ea9e3-0f3a-4aa3-8915-de10e3085a8b@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <595ea9e3-0f3a-4aa3-8915-de10e3085a8b@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 13, 2025 at 05:36:25PM +1030, Qu Wenruo wrote:
> > Please avoid overly long lines in the iomap code.
> 
> I'm not sure if this line (83 chars) counts as long lines.
> As the recent patchchecker will only report lines over 100 chars as long.

But checkpatch is as often wrong, longer than 80 is only allowed when
it improves readability.  For iomap as for many subsystems that's only
for long printk lines.


