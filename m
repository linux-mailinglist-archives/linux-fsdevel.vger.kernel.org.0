Return-Path: <linux-fsdevel+bounces-14847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA9880812
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 00:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57001F22FE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 23:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2C85F870;
	Tue, 19 Mar 2024 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EVerhpi7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D5E4F889;
	Tue, 19 Mar 2024 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889984; cv=none; b=aNi07Ob0On4uXr54+SIk2SgFoxAkJDy5kKUQ7m+UFIAmUpmsEGsGLjo2SAAenIrSkS1vHnarcdkrJA0fm2FBt8ke0CYjnCzbMGsE7E92xQRi5rWWtH46QPIl4BHkfol/7bGW/ynI9+zHBKQaiDMPSXOSneDGUhhfMJeIROS/SQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889984; c=relaxed/simple;
	bh=e4ABYkiejxZ/WeBRjlbhmLDvIk9QHJC7+E1RT95ueX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfxc92zk05EYXy/9aQvBdbtSv1u7ZMI6/AmxM31YfNltFMe1hUJObldP7z8p5/r0Ci3PhEMPlIOy+xnyNWtz+o5DSA3y/rC+u+Gc29oZazDisOm/n6/kAlvIinEcMxy6S909ykrFvZqFHHtKUZqrgMdQKpbEvURnQ8bEsVDwkZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EVerhpi7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DeXv1ZMlFffJ2oqq/nfKbNqdo3HwIj/vCc8eKnkCOuU=; b=EVerhpi7R1ZUApBj75uHz/qDL8
	O68REYY+89VQMBx5vFg72hyQpVupTPApDJEdYTMbHzEWhDoAYsKJmT1SNLwRrZWUXjUB+21vVRDx7
	JPHG664AsX4+vBeiwaVI09fi/YI0dCnO/N8f+FS/L5oMvGFHpPEZIZqw/pMKtgfezFtnrgKrJIZPC
	521lITz137eGQ1JfgVnsc50zst/4cf05EgyW/YqFmLv7fw6zNvV0nWV3EPs4xehtYUaUhBDoo76VD
	7GyXMmDerc0Lwweyd0XXsEHz+MmdaeHvlIiVymsJgz9rIJA2VCjeUlupBXrrw+PPc7DKUpbizMMt9
	XCWnfkoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmidi-0000000EaRu-0vhi;
	Tue, 19 Mar 2024 23:13:02 +0000
Date: Tue, 19 Mar 2024 16:13:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: remove holder ops
Message-ID: <Zfob_q0bD_mqc98m@infradead.org>
References: <20240314165814.tne3leyfmb4sqk2t@quack3>
 <20240315-freibad-annehmbar-ca68c375af91@brauner>
 <20240315142802.i3ja63b4b7l3akeb@quack3>
 <20240319-klippe-kurzweilig-ae6a31a9ff31@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319-klippe-kurzweilig-ae6a31a9ff31@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 19, 2024 at 05:24:44PM +0100, Christian Brauner wrote:
> So Linus complained about the fact that we have holder ops when really
> it currently isn't needed by anything apart from filesytems.

Err, that's jut because we haven't gotten to it.  The whole point of the
ops is that we do want device removal (and in the future resize)
notification for others users as well.  In fact what drove me is to
have proper notifications for a removed devices in md parity raid, I've
just not gotten to that quite yet as I've been busy with other things.

Vut even if that wasn't the case, calling straight from block layer code
into file systems is just wrong.

