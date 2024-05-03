Return-Path: <linux-fsdevel+bounces-18575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636868BA87B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 10:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946ED1C21E93
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5603415218B;
	Fri,  3 May 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DYyQbl2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742D2152161;
	Fri,  3 May 2024 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723965; cv=none; b=chXPQ66/BzpoCfySL8hfdxEeG1atiIP4yFs5R1jmPNH4Z9CpuHfHrLsVptyrkdkJ8JD8q6qX9sZD2Rn4E+J1bHXXfYoJC9d2SEU5HY/T8XyR35HglZASqEzJsxqhswbDInFzv75eznzaHH/WTHG/LOr8qfUeJG/6Hs7MoP/5lHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723965; c=relaxed/simple;
	bh=HX+ztsrF+CG4VNlsnzJVrUjFE38x07+ooV4j/l66jCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az0ZKkSuFCt/VvDBZ8N8bQXjLuW0cJ99PTQpgs/TDH8Xom5p8JX03ym7jGHPhI5hXYCghiCQLYov6HD6U6ay0lRRIER+ohzFojEQ5qoVcoQhIEDPKJd54VaVnQP/tv+OxbrOXO3aFWaCeNQogFnTKE/9594o/iygOofUQlojozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DYyQbl2I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HX+ztsrF+CG4VNlsnzJVrUjFE38x07+ooV4j/l66jCE=; b=DYyQbl2IEXIKvFVlwuYebjH3xr
	ruoboIfr9ujTgXzVumIfnGOGGMjTp8Ha9vlcVave2C+JSXn04uVdAFEyPNxucClrz24PqGPIkPJ07
	tR8u5UY9XOcjk1Lk8SLjNXG3gzmm1Mg7OjHcpLYEPNDSsTbAkxSLIgrWcBp8gb/fEq7QxW/yLLi5C
	b6XYWSEeuMHtupZs3lREQh3H+FTcoLr9wjI93jtN9SivGd9kw4CWzfQ5bKmSLc+CsdnmZfDqn4irz
	djQyuTJp6bClXJ3bVrlWOI/kaGYc8RaelG4n9lMQEvMkhmz5/jCtxa8N2HxTC3BL37riDZZPpEAMM
	fKH5vdYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2o25-0000000Fapr-2Ozz;
	Fri, 03 May 2024 08:12:41 +0000
Date: Fri, 3 May 2024 01:12:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: syzbot <syzbot+0a3683a0a6fecf909244@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (2)
Message-ID: <ZjSceYHsTeeA5Len@infradead.org>
References: <00000000000048aa8506177649b0@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000048aa8506177649b0@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

For the fsdevel and xfs lists: this is a bug in blkdev_iomap_begin,
I just sent the fix:

https://lore.kernel.org/linux-block/20240503081042.2078062-1-hch@lst.de/T/#u

