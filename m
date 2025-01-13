Return-Path: <linux-fsdevel+bounces-39001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B54A0AE85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 05:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECDD3A47AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 04:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF118C936;
	Mon, 13 Jan 2025 04:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W3TkhZ5T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5B1474D3;
	Mon, 13 Jan 2025 04:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736743726; cv=none; b=qn4zXoxnno7FG6IczX2TpleNe2rI8DBltmmrrNdmlMnJ2ZV27H8NjTmlWGzdNipLcAkettBl6pwR34K3J/F99QE4m5RvJLYuW3RSEtFq/siDjFFtA5jY83ivWlrxR2xLPtoHE6dKPwlLp31XlI4Af6zghiq9C5yIPx6dAsAQzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736743726; c=relaxed/simple;
	bh=Vo3rGJDx0SFUqx2Y8QNPgqVD5aN1JQVWdekojw4dupk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg6IHnc3ko2k4Cnk39XOIBc6E/il9cyjlNB9FhYJE3u1INVMIu1if/+4GfVWyPtZQ7Vrn7VV4Gl3aLRWqgqcd0ayTj4QbNvdTKMj95ZZx0Jam0RyAdWNGJ+eJaPu9TC3Kf60BA8rzuW6/hLW8flSKEKC2Y+HWVT51DZep2RKKQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W3TkhZ5T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mzeab+WITSUW2Y7z/af9/JfEuEb07f4EZZ7SKCYY6Ws=; b=W3TkhZ5T/a3pwQnRF7BMifkTcx
	nEjHrIHWVUFylepllluYXv+sdGWbaKCi2C7xBj+T2NYqmvFt++zPyb38G8grryS9hTeudlDpk/pZf
	6RlN8OnB8SQaikn0sHPyQxF3YngxNMK/VSZ/Se7QNI5BNbdpuk7WgBX1CzDQajN/zuWe1ZnmzZvWH
	MGCc6nVt/OnwHfxDGyx9skWBB4KdTsieM5w6XaLgMAxyyjlwFy2OBYrHaleXgh4w67Koqom1RBoRJ
	0saLHAvUpyaHM74hFfOnYOMYUhAX5BRpMtHMofZedc1T3A9++KuWaBaCI/T8FBglTiXo6eekl8TM8
	hsdg+N1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXCNY-000000040sJ-1ri4;
	Mon, 13 Jan 2025 04:48:44 +0000
Date: Sun, 12 Jan 2025 20:48:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/6] iomap: support incremental iomap_iter advances
Message-ID: <Z4SbLBtacHgN3qd-@infradead.org>
References: <20241213143610.1002526-1-bfoster@redhat.com>
 <20241213143610.1002526-4-bfoster@redhat.com>
 <Z391qhtj_c56nfc2@infradead.org>
 <Z4Fd4tUp1hFmGB2G@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Fd4tUp1hFmGB2G@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 10, 2025 at 12:50:26PM -0500, Brian Foster wrote:
> Yeah, I agree this is a wart. Another option I thought about was
> creating a new flag to declare which iteration mode a particular
> operation uses, if for nothing else but to improve clarity.

I actually really like the model where the processing loop always
advances.  It'll make a few things I have on my mind much easier.

That doesn't mean I want to force you to go all the way for the initial
patch series, but I'd love to see a full switchover, and preferably
without a too long window of having both.

> reason.. would we think this is a worthwhile iteration cleanup on its
> own?

Yes.


