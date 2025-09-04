Return-Path: <linux-fsdevel+bounces-60307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD4BB44945
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 00:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B61A17A85D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 22:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462562E1C7A;
	Thu,  4 Sep 2025 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IA/GY3OG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53722DFF19;
	Thu,  4 Sep 2025 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023615; cv=none; b=YvTZkxd6/Iyc7VMNHmFCYi3Vokd7c4tmH2A0rh7mZ5x/64BrnjiVyyva6JP4F5u593Qb6XZUWETRxn5GRyiRLszFZbvBzZXz5s+O7Fs6HYE59vmyUlz/v7X97K9eLOz5aScByJzImSykyuaYhCLB2pPUjPhZeFDiBicG31/B9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023615; c=relaxed/simple;
	bh=goG337sZ/iRHs3pRg9IZxmLubB1x5C9U5Sw7O7bN8x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXJnbzThExEQ9Iqz3knIMJSp7rG0WtgZ8ELKUTtWZhTJ/lOpPwVIVFwV0bAF95T3LT9Z69Z6MAUYFOkq34MmUXif2YtEnMqC01bBt9UjenosATu/n6C7MHKBCVoZIQ4uzdIP3MfCaECsm1dbelVn2jqfblW81GT3Jh5sxOAAv2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IA/GY3OG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sUoP8dczSKqO6gmkDe5U7V6bW3hFctcl6QkG72jE5VE=; b=IA/GY3OGXbne4WiPiqvcWh0/sI
	BT5ootVDmUd+BOddTVFnEZMmdKkW2F64/+0ngNoLDXs7r5GLn4kI/pfVDyiUxLQd9fRTJwsIFrHmC
	9kGxOfpl3JS2FNaV3SGzygGx9F1rSCelnyAItDUJIbaIFbIt1i4v4rd7ll5XlNCzvG08fZ/qbZzu3
	tciJjkDe9HwU0dJ+Od4MWT1seLZsBN/3txptlomAGl7W8D6T9dxwPgcNbSIyghKlKzgvR0U/qAmB3
	H8YmcU3Dvtw3G6POd40lTIvq4Ro1x1JokwqfuAnuCrOf1/pSvawfaICir81SnmmVA0kQyXVIf2ZgB
	1bbHjdrw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuI6U-00000008x1R-0Yb4;
	Thu, 04 Sep 2025 22:06:50 +0000
Date: Thu, 4 Sep 2025 23:06:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Blake McBride <blake@mcbridemail.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	Colby Wes McBride <colbym84@gmail.com>
Subject: Re: [RFC] View-Based File System Model with Program-Scoped Isolation
Message-ID: <20250904220650.GQ39973@ZenIV>
References: <Oa1N9bTNjTvfRX39yqCcQGpl9FJVwfDT2fTq-9NXTT8HqTIqG2Y-Gy0f7QHKcp2-TIv7NZ3bu_YexmKiGuo9FBTeCtRnVzABBVnhx5EiShk=@mcbridemail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Oa1N9bTNjTvfRX39yqCcQGpl9FJVwfDT2fTq-9NXTT8HqTIqG2Y-Gy0f7QHKcp2-TIv7NZ3bu_YexmKiGuo9FBTeCtRnVzABBVnhx5EiShk=@mcbridemail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 04, 2025 at 09:52:22PM +0000, Blake McBride wrote:

> Proposed Model
> --------------
> The key concept is the introduction of *views*. A view is a named,
> use-case-specific file hierarchy that contains a subset of the overall
> files on the system. Each view presents its own hierarchy, which can
> be completely different from others. Files may appear in multiple
> views, and may even have different names per view.


What happens on cross-directory rename?  Within the same "view", that is.
How does it map to changes observable in other views of yours?

