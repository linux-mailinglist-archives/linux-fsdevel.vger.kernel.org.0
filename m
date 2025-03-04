Return-Path: <linux-fsdevel+bounces-43107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C77EA4DFC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 14:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9533AFE82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E872204C1B;
	Tue,  4 Mar 2025 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T32fOR6W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE30204C0A;
	Tue,  4 Mar 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096337; cv=none; b=biNP+lmtxBPNegF3KY9e9zZP7lruh9B7ZqvpPJop0PiKgj6ZNvJKz2e2Inc94J8rXbvebp4tDAHfiDL/RP2uI/Ozdsr8oPFVybfV9RtW/kfB0doJDLi58KOYDhNkifEm4cb8TZvMYY7oA6AWVBOZZeO0TB2KuTqDWJoFVaMEMpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096337; c=relaxed/simple;
	bh=ndqJ+0eHcqZRGXMltnB0aqNjR+haFA5ToHrWEK/Dk7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5GKOx/jp72/hdmWfsM8qtZH2Nmm9aUThPfIbO0OhuFWEV3hObCj9hOeQ08Cj4ewMCERlUUJhxMPtt9m4Z2vmGSw2o69R18X3hMVdtIBe+MwCLanUzsu91GSoCsHxTVBZAMJW0CNlj0rUxkIrg2unuX2q1dDhb4udM5bJGVYrtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T32fOR6W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VOaHS+ulMCTO2F4RvqbeepsYx3EWL/VD/LTZiKe7Itw=; b=T32fOR6WO+5AZuJnMw25Itml6J
	YymmlB27fCfNh1J5K4mJlQSK5PXShBOHDHaamvAIVWe+wALbypH+CfXB+NqUIv7SxKfTWtvDfqsty
	KfVWgzrHTFDy/dEGOdPVcK/kg+X941vM0pe0k16Wk7Py0z1JYlSL6ZAGsqhaw21JJBqTXSY+m5iOM
	NaEVa556T0cAjLlUORTv6VVr+lVjOEimT6VwrjV/AsbbPZXkUZXsYmvFfvp9qRudKqcC9lurFtIp0
	f6PfGFEIvXZmyag9ztmLD1TmVpRO8R2A/0Ao0xNhBfDrKSoqNdNcFD7r0PVo42CPD/wNxMMF88GWs
	FlVjmrpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpSgw-00000004qn8-44F0;
	Tue, 04 Mar 2025 13:52:14 +0000
Date: Tue, 4 Mar 2025 05:52:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Heinz Mauelshagen <heinzm@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z8cFjqiGiDjoZixr@infradead.org>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <CAM23VxprhJgOPfhxQf6QNWzHd6+-ZwbjSo-oMHCD2WDQiKntMg@mail.gmail.com>
 <Z8XHLdh_YT1Z7ZSC@infradead.org>
 <CAM23VxprSduDDK8qvLVkUt9WWmLMPFjhqKB8X4e6gw7Wv-6R2w@mail.gmail.com>
 <Z8Xl4ki3AjYp5coD@infradead.org>
 <CAM23Vxoxyrf9nwJd1Xe8uncAPiyK8yaNZNsugwX8p=qo1n6yVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM23Vxoxyrf9nwJd1Xe8uncAPiyK8yaNZNsugwX8p=qo1n6yVg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 03, 2025 at 06:34:45PM +0100, Heinz Mauelshagen wrote:
> It is, unless you ensure the pre-allocated and fully provisioned file to be
> immutable.

Which you can't.

> > > The inode fiemap() operation would avoid issues relative to outdated
> > bmap().
> >
> > No, using that for I/O is even worse.
> >
> 
> Are you saying it imposes more overhead than the VFS APIs?

No, but the reporting in fiemap is even less defined than the already
overly lose bmap.  fiemap for btrfs for example doesn't report actual
block numbers.

