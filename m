Return-Path: <linux-fsdevel+bounces-50285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CC8ACA8E7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 07:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266EF164CE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 05:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367F9158538;
	Mon,  2 Jun 2025 05:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yKr/rU88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A42C3242;
	Mon,  2 Jun 2025 05:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748842357; cv=none; b=teEooTezk2ujKdEFAGVg3/Ue4Qu4tN31HP5dBOL6KCx4boqoyTyrr+/wOxUJuAuxWuhbsHv/6Yyo8GGTRWFG5mUqCODWaM/yz42r4obsTUyJrI09puoAr3EWEOGlYIa50Tq6NeM8yVVTAeugqnC3b5tLypFuhp9vI5L4R93yR9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748842357; c=relaxed/simple;
	bh=lPcO3Azsmsf0X40kHdWiwFGDUrYiOMRXFHp8aLMYX/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mn+bhuwMhBQ+AwImu66iBTPfcWs1zEqpcE8bt8I6y5PvPlw4TtyEU2qRugrlqdNXtEeneON0PD8xA6srwLoba01i5gVbIA9dijFSOsjVLusvJMj9AF/pqOS1hLDmVIG1Lo7LzEmYq1oy2BcLW2oDHSQ0NsMY9JVy6lnYmmQxN98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yKr/rU88; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lPcO3Azsmsf0X40kHdWiwFGDUrYiOMRXFHp8aLMYX/Y=; b=yKr/rU88xiRNli3j/U0vP/WvbY
	itZq1BMKthk9p4gjBfif73XpnETeDQhoKsyhtmhPWpvMjT3ksHWME3EQW9UZ+WqqoFGItbH7XjZzy
	AJWwg5fr0MQzBiFanRP0sdHpk3eHG1oIApTKBGRd6ONhfOq/o0fYjJybiowJxJN3v6ctcH22Pyr3B
	hoYoBAqltgVGcou88OBn/Pwd1Hy5nltDwgJQTwo0aRY585ZIN+7BPivlzUXWmIZB74vU/CsXSj/+9
	w7PiefCHtTrnVvK8CML8qmn4IHuvb94n7sjAp+sbnDecrEfSVaGv5eeJ9kBjIEYgsK7ouuQKonwdD
	WHssSvHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLxmj-00000006keP-4860;
	Mon, 02 Jun 2025 05:32:33 +0000
Date: Sun, 1 Jun 2025 22:32:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Christian Brauner <brauner@kernel.org>, cem@kernel.org,
	linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aD03ca6bpbbvUb5X@infradead.org>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <20250529042550.GB8328@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529042550.GB8328@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 28, 2025 at 09:25:50PM -0700, Darrick J. Wong wrote:
> Option C: report all those write errors (direct and buffered) to a
> daemon and let it figure out what it wants to do:

What value does the daemon add to the decision chain?

Some form of out of band error reporting is good and extremely useful,
but having it in the critical error handling path is not.


