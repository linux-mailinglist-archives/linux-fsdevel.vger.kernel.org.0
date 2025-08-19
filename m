Return-Path: <linux-fsdevel+bounces-58262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85110B2BB8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3AB3A8A5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 08:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601563101CD;
	Tue, 19 Aug 2025 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xM/wFLEe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEF43451D7;
	Tue, 19 Aug 2025 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591341; cv=none; b=o9lWIb9pj9eI/xYm1vHRriKtJVOntbRjFdtII2zjrmSHOv+TjHSc3GMhdCVyiBSynO+OjjRamWi9kPlfqi4SUFWOhFl1vw+PmdzK4lY7tYLd/6ZQr8CKHOvpsxjKyo5bbBBUXb+FGZ/ynvMP0iHWTtb0BsUFIlbRI99eJMaTNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591341; c=relaxed/simple;
	bh=k6y6AF54juU7kl6kbKvDXfrb4wSrYoD5+fTUFg6zBto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUf3HTFqTTJJW13yLxHk6wRI7CkriWF0jOvnc8o4cq5jSZBBbG4USTrTnWEZ/+uAxjvxZAIP6IHYKcGbF2E59goAECSZppaaVuahZlMSf8MpG8IKRcknl+Me6hbROxwQNhoxFw9jA2EJSDbF169tK7YcjSl8dMKy2dpbdTLRRqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xM/wFLEe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fRcvtU+W6HkjI1y5wLjk7QWRQYSRuxCjLLd23beixwY=; b=xM/wFLEeMOGcYpFv+dN0VueW/A
	TAHSYW6NlFW/ySvzvulmO4zXxTC3hsKn2cWEMzJHIZeZHtfo16WoZ/fkFl/B6EnYl3U3RD5Q3s55S
	Rnj0SFoFdtZrfncphbJ9d5Bz6JMvHdZuB2n+JSTth/njx+9ARiJtMY9g1rKZE2cXif8SBhgzh+mNF
	7B7ROiBTMx5wK3RXf9VZpwKSkYH/ZiXdmj06DYuP3iGA0rEgUzmueUmUPy5LYU2iSU2Ob1f4kKD3a
	yglYDgygL4zKj69GwJZ8cT94WCx0o4NI5AzrzX8YnP+mr0TjHpq0GD//sCFe/AYj+Wj30jBKMgWCK
	tRjEZ8lg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoHVM-00000009mHF-0bHD;
	Tue, 19 Aug 2025 08:15:40 +0000
Date: Tue, 19 Aug 2025 01:15:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ethan Ferguson <ethan.ferguson@zetier.com>
Cc: hch@infradead.org, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Subject: Re: [PATCH v2 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Message-ID: <aKQyrMX7xS5A8cv6@infradead.org>
References: <aKK_qq9ySdYDjhAD@infradead.org>
 <20250818174911.365889-1-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818174911.365889-1-ethan.ferguson@zetier.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 18, 2025 at 01:49:11PM -0400, Ethan Ferguson wrote:
> That's fair. I took a look at how btrfs guards against this, it seems
> as if they use mnt_want_write_file to guard against bad writes, and
> only write to the in-memory superblock, and commit the transaction
> afterwards. However, this (during my testing with
> CONFIG_BLK_DEV_WRITE_MOUNTED both on and off) still results in an
> immediate disk flush.
> 
> My changes from this thread also seem to work with
> CONFIG_BLK_DEV_WRITE_MOUNTED both disabled and enabled.

What I meant to say is that we actually need your change to work with
CONFIG_BLK_DEV_WRITE_MOUNTED, as the current way in tunefs is broken,
even if that's something a few Linux file systems have historically
done.

> Maybe an alternative would be to only write to sbi->volume_label (with
> mutex guarding), and only flush to disk on exfat_put_super? And to use
> mnt_want_write_file as well.

I think your patch is fine as-is.  I've just been trying to give you
additional ammunition.


