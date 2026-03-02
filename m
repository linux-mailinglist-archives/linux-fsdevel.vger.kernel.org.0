Return-Path: <linux-fsdevel+bounces-78903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEx7I3iWpWmPEQYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:54:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C621DA2D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CAC1308A89A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763A3385539;
	Mon,  2 Mar 2026 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K36bIsbh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1B62DC77F;
	Mon,  2 Mar 2026 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459343; cv=none; b=R5s3h32fKKA9K7uV0+9IVYmSoRdS38Isa6Uu+KzKC7sp16VIHk6+4T6Q8QHOALeJj5E0cv0e5Wjy4QQOKygzJ5lCMSBBKUpO8F0177cUbNKR1EZUeq24gDpCd+I6mEAft1MUQYtohB0RjaRdHcDEA/GqZvOFKP62TVHj9EKOpZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459343; c=relaxed/simple;
	bh=3oDPHQ27zjmwg0X53/sNtBZXfVW1DU7wX+SBWTA6mfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc08D5h+XaqRwLNglMBnuZ/dVFcnt0TV7CRNZnFbtojU6Hm56/JYn8SbY11oyKwQkWSVAXaOqfKrC8/WrF0ZzkRJUDSRkqJLZ8ejm/wW5EJI+VY07PTBHDfY3OvlQb9Jbv4JvCmPwKX+pPYO8ypMqK9ncSy9ToBWIik67EZfFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K36bIsbh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3oDPHQ27zjmwg0X53/sNtBZXfVW1DU7wX+SBWTA6mfU=; b=K36bIsbh0aow/qmFRvIG1jBmC5
	Teb6mIsR90WV9dU0FSqLKJrIHkdxGtFhNYrSJ9gSmGo5ZKKc2Zu+Kx3rjO+K/AMSJbnFqSEmbs36a
	twjPAnuB7W0PXbuN0eJVdLVHT2b+ksaYNJDkG3U6ZIF+NC/SrKQqAnObK/qFs1rE0zpNCb9KBLg0Q
	43dwz3e9zVH6g1WxHAmzvUWbh9A5M0JmIukRM19oh+rko19YHxKMFO1g/ob0qyUQNhb+GSYnAWxhc
	H5/bCugSkFqinVzMdIdlUxuvWWzKxLT4pArKU0E92X4b/Q5ynSIbocun3L2OuLBSo44v6Gk2tJ0iA
	Oug8gfMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx3dj-0000000D9hr-0xfV;
	Mon, 02 Mar 2026 13:48:51 +0000
Date: Mon, 2 Mar 2026 05:48:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: support file system generated / verified integrity information v4
Message-ID: <aaWVQ3g6vsDB4GvQ@infradead.org>
References: <20260223132021.292832-1-hch@lst.de>
 <20260302-legehennen-musizieren-08d0e3caa674@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-legehennen-musizieren-08d0e3caa674@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78903-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 28C621DA2D8
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:11:22AM +0100, Christian Brauner wrote:
> Applied to the vfs-7.1.verity branch of the vfs/vfs.git tree.
> Patches in the vfs-7.1.verity branch should appear in linux-next soon.

Note that the branch name matters much, but this is a different (and
older) use of integrity compare to fsverity/dm-verity.


