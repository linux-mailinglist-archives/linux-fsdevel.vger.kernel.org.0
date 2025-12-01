Return-Path: <linux-fsdevel+bounces-70330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DC9C96E7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 12:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 797CE4E3E89
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 11:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0C330DD13;
	Mon,  1 Dec 2025 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o4Bc1zQM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F25307AEB;
	Mon,  1 Dec 2025 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588176; cv=none; b=MxRi6WZRwQjjfdSPEyXM5WU4WybeW4YuoqcTwQrORee+D91bPxhfcPx5D8S1HxzZFCEnmjv3TlTc9bTlZigCNuPRApFZ9Si9j8ydpWCWjjh/7SK6rMw7c2qShVH05HVCa5ss93hxwS3NHKdNbxm7zbc6B0MHTIBJV0YFdbfc41E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588176; c=relaxed/simple;
	bh=tsEd2yJeebprK0pa5efqqDy4D9yZX55a0KkZh61WRsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7gkPPYq2iQrGAHszwS/5FIIM4BnMZk0Ybuwzh0LYI4hsHkHhW2eKrqru05osyT5XXW9udMCybWjpQSvDfwK+3PPSX47qLe9FgPwveGd/5nFk+UUxC7U5A861zctoDSoYA5qpmu5sx/2bLXZRvLb7Tep1J8KNS8VWfyvWl3oXa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o4Bc1zQM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tsEd2yJeebprK0pa5efqqDy4D9yZX55a0KkZh61WRsA=; b=o4Bc1zQMdQuyguZzDE6S+bwjiU
	1MYWLPHBbO/klsaa8pOYiM/rmZFrBFJUSZCqKMMM+hUyAxqg3bMOScxcHQimEdkt+whQj2g0tu1WA
	qhkRgyI0Im1Ul8D0zn8SdHPMPKj3Msf+fs6ggfM/O2Re4cLqPGxxn1TfQEKgbpHA19B70x5pGUjYt
	uFgebMVWUDPBTwYYSKgFhZJ4TQMYPdemSxxGU5Y1yOP3vGzuedR9D4tHvXWI5+few+i+xojlhpjZ6
	iV1jF0EdZEKyqL4meUfescyioJJEQQE8/f/MEb5GaUVHMKadswUSeoTSz3B6hTewPJE5Vmsy/GteV
	1VzottzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ1zP-00000003RF2-2tyv;
	Mon, 01 Dec 2025 11:22:43 +0000
Date: Mon, 1 Dec 2025 03:22:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@lst.de, tytso@mit.edu, jack@suse.cz,
	djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH v2 01/11] ntfsplus: in-memory, on-disk structures and
 headers
Message-ID: <aS16g_mwGHqbCK5g@infradead.org>
References: <20251127045944.26009-1-linkinjeon@kernel.org>
 <20251127045944.26009-2-linkinjeon@kernel.org>
 <aS1AUP_KpsJsJJ1q@infradead.org>
 <aS1WGgLDIdkI4cfj@casper.infradead.org>
 <CAKYAXd-UO=E-AXv4QiwY6svgjdO59LsW_4T6YcmJuW9nXZJEzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd-UO=E-AXv4QiwY6svgjdO59LsW_4T6YcmJuW9nXZJEzg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 01, 2025 at 07:13:49PM +0900, Namjae Jeon wrote:
> CPU intensive spinning only occurs if signals are delivered extremely
> frequently...
> Are there any ways to improve this EINTR handling?
> Thanks!

Have an option to not abort when fatal signals are pending?

