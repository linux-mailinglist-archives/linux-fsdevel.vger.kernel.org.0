Return-Path: <linux-fsdevel+bounces-21534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2CB905476
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 15:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140781F2653D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAF717E91A;
	Wed, 12 Jun 2024 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="siJpadAw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ABF17E45A
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200500; cv=none; b=BzW1oWqK7POsarnt/YL3z9sePez8MmD9UrxELei6F6j/BRKBxVFJlzI0l/POdL8rJA7ab4gll/cXZxipelvd30IkEy0lGOsFGS9Wdivz+yep4CFIwEh+UhIjXxFQiSO9vP99KXBFdKK6UHbNsGeNXRafGwewe4TBzx6Czo8XUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200500; c=relaxed/simple;
	bh=DWqDhIjZe3itPHO4LgW8bvdU8oXf8jzVGhQcR2lD9vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7FeTsgJhDcPj3u2Z14Y/83Sl/IwYGforch7fc1G9V+JFfhKksF7wYkNHelHQ2TsOlQwscjs8YoZ/ggBg8K7MLq93bUSX0UA9uHnQYCtlrNyR8/BsXX87Js9KnwQag5mtcvzrD+KxVYz3/PprGfeB05ne7ngShrwLUbQsptKEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=siJpadAw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DWqDhIjZe3itPHO4LgW8bvdU8oXf8jzVGhQcR2lD9vA=; b=siJpadAwWi9a2ps8GYoOTH9xMK
	4TPIax66fiMC2TZ5SuIjsLDcIVLSE1oGmO9axVo2tjJafUJnAhMQGk5GcIsOQlEVN7uFLzGl2EHZ4
	vTEosPg89+VFpKpnVUpTFvixjH5xyqQQvHOQBrFcGMa4cjrkrHrCV/ozB7D23sqmgwkNvKYOnaSnb
	7exNk4T63vMnEhb0pdF0S1A6ofqFO8Dq3PetnENSAPz7w/Js1JitvnL5lV9/AwjfOFZFuwPEmCJy1
	c4o3LANnQVDX2RHicdfMBBB5qKjBP2Yy5+nguxZFQIjqkJsShQJcGldmbDf9Vawr6a4hclhlSONkM
	FCrXZYQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHORD-0000000El8p-2c6u;
	Wed, 12 Jun 2024 13:54:55 +0000
Date: Wed, 12 Jun 2024 14:54:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 4/4] listmount: allow listing in reverse order
Message-ID: <Zmmor8Y1x7opCNU1@casper.infradead.org>
References: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>
 <20240607-vfs-listmount-reverse-v1-4-7877a2bfa5e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-vfs-listmount-reverse-v1-4-7877a2bfa5e5@kernel.org>

On Fri, Jun 07, 2024 at 04:55:37PM +0200, Christian Brauner wrote:
> util-linux is about to implement listmount() and statmount() support.
> Karel requested the ability to scan the mount table in backwards order
> because that's what libmount currently does in order to get the latest
> mount first. We currently don't support this in listmount(). Add a new
> LISTMOUNT_RESERVE flag to allow listing mounts in reverse order. For

s/RESERVE/REVERSE/g

> whereas with LISTMOUNT_RESERVE it gives:


