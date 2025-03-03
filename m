Return-Path: <linux-fsdevel+bounces-42936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB27A4C471
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A9518916D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099C52147F1;
	Mon,  3 Mar 2025 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MylLpo6j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD92144D0;
	Mon,  3 Mar 2025 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014832; cv=none; b=bXP1dLDpvhuCWVDcMW7aCPeEBPkuNOk928aDBlGI6MnJGg2SvRgROi7/WKd80sQkHCGawyPwflhQP6w3fHXJmfaQBjZNk/s7wLERmLZYUf4c8XXV4SqMDQxsN5W+sGYUCYZW+EPqyK0ZANA5xGkLvsqR2ELexNKOYUXvABJhj9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014832; c=relaxed/simple;
	bh=1Xzmv2RcDkj+UiUk11nbRmDeV8ULe9YNCvXFiY/maR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIn+aidEtwgKUdEhr8emVvqupZkme4PnQSpzNAqgX8Ghhs9lNhl61DX8a6vOKqKUqFQMSU3DaDHkCE+s7ZgECZGvbgECphTzM3OvRGDe1Uy9KMzJDlIfiFe2XpeU8bNOdpMqXZXoaM0hALgMvVNudWGYUUGYG9cBwc4kGhmoht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MylLpo6j; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i9mR4xyoj/FydC5/oouF1SUJM0/ZBGR59EGvwEO5nU4=; b=MylLpo6j6Tcxj/f/MM5fZBVEQc
	d1iLD+TvMdmgRFsmkBwC7X+ZWD3T23iymmAYT2Z7OEIVxqnAfOmjdsLruM837m3Hh9sHp71Qo3/Ci
	gc3EqZiFYuinAw8lY80hPiNV4Tii337m731/0+YIVAe7xZj4p8hshkLNUrgeItKnqxfOSEvqaI3r2
	edPFhykbPt+33MsPWv6u/+69pXuqNf4B+oL6+aB70n8fTUt1mrIUUOm7nxEJlSjVUphIV9OmX6WDj
	X0rTxXd8QN9oPmS1ce6jrcbfPZmoJ38CatKSqFxaig2x0LKd7dq6E4Qr0/SeJm8I0VjZxJG2ZUZ4v
	J4GB6LRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp7UL-00000001FEm-0gG0;
	Mon, 03 Mar 2025 15:13:49 +0000
Date: Mon, 3 Mar 2025 07:13:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Heinz Mauelshagen <heinzm@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z8XHLdh_YT1Z7ZSC@infradead.org>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <CAM23VxprhJgOPfhxQf6QNWzHd6+-ZwbjSo-oMHCD2WDQiKntMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM23VxprhJgOPfhxQf6QNWzHd6+-ZwbjSo-oMHCD2WDQiKntMg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 03, 2025 at 03:57:23PM +0100, Heinz Mauelshagen wrote:
> dm-loop avoids the file system abstraction, thus gains the resulting
> performance advantage versus the loop driver.

How?

> dm-loop obviously requires full provisioning, thus sparse files are being
> detected and error handled.
> 
> Additionally, block relocation on CoW filesystems has to be prevented.
> dm-loop uses S_SWAPFILE to do so but that flag's limited to swap semantics
> and is overloaded as such.
> 
> Should we avoid the flag and enforce use of non-CoW filesystems for backing
> or checks on non-CoW files (inode->i_flags)?

No, ->bmap is fundamentally flawed.  No new code should be using it, and
we need to move the places still using it (most notably swap and the md
bitmap code) off it.  It can't deal with any kind of changes to the file
system topology and is a risk to data corruption because if used in the
I/O path it bypasses the file system entirely..  If it wasn't we'd use it
in the loop driver.


