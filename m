Return-Path: <linux-fsdevel+bounces-39379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B323A132B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F97B164F94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC3F15B122;
	Thu, 16 Jan 2025 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l++9kEB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47DE29A1;
	Thu, 16 Jan 2025 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006040; cv=none; b=OaY8AlK+Z/oSbX1lPlMsf5ctnFGKzpUcJ6823bBwxvIJCFcdrtoxHKNfzQTEYjbOjgv1Tjw3TNYK5r43ZnZE2EFVnsAAKUlnnkRsJpkFcUrCZ83gXrGuvWAJnP53fZdmlyuyhzNELcrmFuNjdGuB7l4Ydg3UHoR7HMC4SMF9Ni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006040; c=relaxed/simple;
	bh=vgYCi+/alnDBSi7Q+Ztn2UqfnjMah6L/vWReeftHiF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsMYPKeCas+4W/UnxCH63Fpj6p1vqUdPHWEL84yjcP00u+4i/M+CIvCsOKLr4KLIsQqANcioaLoPNkaSDK+W/3lAHjJzIV9xoefe68kq2/y7j89ovqTW+X5cE0WxgJlQ3WULIJQTynizW+hpUp8SXd9FTg6U0mbY5tog5/rPNko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l++9kEB5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sM9RJti6gPYuB5Hi7Zwv62M/fGmbF72HOLsXcvXcPo4=; b=l++9kEB5aV8aEQTB+3H51zH8ng
	bHUZcDfSidqbsjIYGBaxjo0jPSAt5kOZYlrZj/K2T38KxfjeO77ELgM4HXq4ihBB2kbR+BqOukdFk
	8nrNvGERMbS0bhgbJKeNph4VdIL0VSYEHhz3oFKMfVCm5KsGiNOdCHt7u9sEDW0PIgtcfG90ZizE7
	dV1Aj7n4w3SecX0iduDIXy718MnVQtepeu27F0Ldhra5yoB4+yV55dcmKnQk36G+anxMPhqzjn0tH
	mevqRmBzmB+P6aW5LwkhYFIsqXVtQzpw+sKny1ufrpFTXbDcfT7POQPkcN5tns4NkAARj94kyjanZ
	RaV8y3wQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYIcQ-0000000DtcJ-45PG;
	Thu, 16 Jan 2025 05:40:38 +0000
Date: Wed, 15 Jan 2025 21:40:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
Message-ID: <Z4ib1tg2CcOVND9x@infradead.org>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 14, 2025 at 04:38:03PM -0500, Anna Schumaker wrote:
> I've seen a few requests for implementing the NFS v4.2 WRITE_SAME [1] operation over the last few months [2][3] to accelerate writing patterns of data on the server, so it's been in the back of my mind for a future project. I'll need to write some code somewhere so NFS & NFSD can handle this request. I could keep any implementation internal to NFS / NFSD, but I'd like to find out if local filesystems would find this sort of feature useful and if I should put it in the VFS instead.

Well, one actual not very detailed request, and one question from a poster
who just asks random questions on the list all the time for no good reason.

If you care about it prototype first, check is feasible and see if it
gives the expected results.  After that you can report back with the
findings and have an architectural discussion.  But unless that gets
stuck you should be easily do that on the list instead of wasting
meetings slots on hand wavy stuff.

