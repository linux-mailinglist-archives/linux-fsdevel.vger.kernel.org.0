Return-Path: <linux-fsdevel+bounces-44414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4D8A68655
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99593B924E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB01250C04;
	Wed, 19 Mar 2025 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2IwkNzvV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD1A206F04;
	Wed, 19 Mar 2025 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371493; cv=none; b=NOBeM/2has9Gq69ZmWiTEP5fss/FXnwXHPWqzL4033Y3wNKnn1+1sqDOkt9EtsewzhfZ/HJTrmoZO/M1HbIDkECnJLPWmVoNWKuPyupC06yf+SykjWhW7g+tlQdU4wk8ic3JQ2+kklKIhLJX8NjgyVWMwFvXooXSTcTu0M3vap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371493; c=relaxed/simple;
	bh=FSNFV5aiawfVEPuMK3UBCZZb3/nWmzSnJzh+8OKYIrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5UNZfX3Davbj33OJihXvKkCurGXSDpkdPYpZLhzQ8RfExo+/mMtaaQAafByh1sS3e1wl59ZEAmaZgboKd7/RfM+gG4VmUvv1cmsRjlNWnwhyTE8FJUxbtI12039lLfdYaP1yr3GjhSsDizyHijftQyKnYWZuSXpvmip2egV4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2IwkNzvV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FSNFV5aiawfVEPuMK3UBCZZb3/nWmzSnJzh+8OKYIrk=; b=2IwkNzvVlrZXNwyCeTEPJQ8F07
	mHBnaZm+2SYzj9yte8H+h4ugukyHaooQN44YZ5VaYs/3ou0ePckDXk74CwhuRgUqJuOEPMfF6iUDe
	hQcdu6v22lTgEkab4Iq6naRWcxrNTluRM+NprIS7DRr0K8wcCDfiM/OR9YYYL4flt14X9gs8tVHON
	anS8xHd3sCoM8QzTE9EC30hBSL7mM7IG+1kla2ZQFM5VNpzj6JCVcSNivw+5a2PlLbRmVqasI3wrH
	w9n+03TD5fFP8m+W6G2FuB3u4cNsXCeDEjRFy5YwdefmTPW/57pJqwp9vqByYtsQToDwsMDe5Qz0v
	YcjedCWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuoPw-00000008IXM-33MY;
	Wed, 19 Mar 2025 08:04:48 +0000
Date: Wed, 19 Mar 2025 01:04:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z9p6oFlHxkYvUA8N@infradead.org>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
> One way to fix this is to add zerocopy notifications to sendfile similar
> to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
> extensive work done by Pavel [1].

What is a "zerocopy notification" and why aren't you simply plugging
this into io_uring and generate a CQE so that it works like all other
asynchronous operations?


