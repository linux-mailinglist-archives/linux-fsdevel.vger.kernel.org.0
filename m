Return-Path: <linux-fsdevel+bounces-27344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6461960738
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 12:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F632831FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900B11A08BA;
	Tue, 27 Aug 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IFq11HQo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAC21A073C;
	Tue, 27 Aug 2024 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753627; cv=none; b=jTJH+08XUa2ubxlUdzVa3gQryRzV1p3nlw5DnJe3QxC1kYwGdy6TEu5KsGmKj/PfLr29tzOPnRWRxqu2+xiCplkAYR6BMnZ0UqiuaZU4XQY02+mlQYj/mEiJ++T9/a2XSN73Ui/ZT3rHCnelLomoZlkp34jSMUeX45mowskWirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753627; c=relaxed/simple;
	bh=OtKLKLovPXlPeSXxDYFfqWc1OdexnokcwRWezfoZEfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irgvcPYrhBkkw/kAcd+3aKT4ERvOI5CGEXaSkWKKaUxCYxcsNVtg7QrLk3NYSWMiqJKk9JG+07xR6PRhS0jB7dkwTCeDADUpLtgGFa65dunm5NrINHY0Ks6kKDppt9Sr4vIXKRLzBwmzneSytDWOy5ouwtz5g3ezVtiVtE1ITno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IFq11HQo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oTpgnzArF2ljhVVf8MMWOhH6rtMPFPfD+TCF0oj6yfk=; b=IFq11HQohnkjBHntHpFG0iYr0j
	asZC3RUnexBi3yUL4MBE7il6zzcqabH2zAcUmZjVMq0tF32n57UMi1YypLKQqqF4K1DGr+LYfn6QI
	BCWOOM8TesyNTvSDyLFFyLYk+7VmCjvG5VSsi8uVs/8XGEtNKygFJec0304UVDoZ8wDwN6te3GiLd
	nDeGMNtLUVK0Njfs/9HV3iLDYYPkp4ilzUq+K5uhWWF5AQWvYF7Muhoq87ohCkwL9A/Jb5jKWdr93
	d/RBMxozwXCt5mj1owY8nzZGmQ/mALd8kTv8R5ZRSSsHOBwzMEMyLpF1OT3MwnOH4PHNwk8/kY6Am
	BSl3uONw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sitCo-0000000AlHG-00a5;
	Tue, 27 Aug 2024 10:13:42 +0000
Date: Tue, 27 Aug 2024 03:13:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: syzbot <syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com>,
	brauner@kernel.org, chandan.babu@oracle.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iomap?] [xfs?] WARNING in iomap_write_begin
Message-ID: <Zs2m1cXz2o8o1IC-@infradead.org>
References: <0000000000008964f1061f8c32b6@google.com>
 <de72f61cd96c9e55160328dd8b0c706767849e45.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de72f61cd96c9e55160328dd8b0c706767849e45.camel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 27, 2024 at 04:54:41PM +0800, Julian Sun wrote:
> On Tue, 2024-08-13 at 01:14 -0700, syzbot wrote:
> Hi,
> 
> Is this still a valid problem, or is it a known issue? If it is still
> valid, I'd like to dig it into, but do you have any ideas or
> suggestions before I proceed? Thanks.

I tried to reproduce it locally but haven't hit it.  Once reproduced
the next debug check would be which of the need zeroing conditions
triggers.


