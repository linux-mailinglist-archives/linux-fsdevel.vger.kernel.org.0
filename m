Return-Path: <linux-fsdevel+bounces-18399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EA78B85AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 08:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5B12838FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AEC3A29A;
	Wed,  1 May 2024 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LFSqsaQO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7235894;
	Wed,  1 May 2024 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546111; cv=none; b=Yu2cKbFhWVLMG73fTbAumvewLnz76fghP+8uZubKX4Awau1mOHjeBHTz9OUA0c8oFNrtEf/jD/7AvAKiQ5bzLROeFAOBq63pk2X4NW7BGGZwtJ3fW08/qLxpeEpP1z/CCPqsNuPzwps0LDQK9F/4V/HQkwr66LZ9LLlTCRhsl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546111; c=relaxed/simple;
	bh=zQYeBQup8koeOy0BbhTB+3HXCNjD0J715IuDZhcIKkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAEFPU9Ti804dB4dLeS/xjka8AfZLZgQ9/v8IEXPhXMwydtSMo3Nbi+EDkFiubwAaWjtvWcg676YxZcnA6rQa+w4RtMvwspK38viNNCZD8n6g+jGorMtHIwI8OI49Dxdf1CN/Xe0Ktj2LqqixaZhBmqkOpn8TGQu/lHlEIwlLSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LFSqsaQO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aloOOHazKhWyzOKwlZTahyM1cmwVW+G/AoWwxYbddo4=; b=LFSqsaQOQtS54AbUSFfCXKjMvo
	RKn+k1tmqq7mBsrgfa7BbraLNNSQZH6I5D+jxcMc9vFXKzz6MUkMrk6DlFXu+4/+pxIVjSDRGL20H
	Vp987LrRt0lHUOa0pX1wi81ALebBnyjYlJUYI+UjDaC3oXdgDWz0P+tTlZkBg6vSM8cMPFKs+9/Wn
	iwrbyWDnEh0sWgMHsWwsvBcsKdPkUxRyctAkhoXL3JfLgt2WJEv5/+XEux2a5cDISMBp+zNt1njgk
	qOQc8ch0AyaM6InhTDuL82Azafbw7d1Ea4G95/0PGrFSrrUGBSpD74IAYzsQUk4ImPh97amypbN6i
	C24Lk1yw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s23lV-00000008hdb-1mat;
	Wed, 01 May 2024 06:48:29 +0000
Date: Tue, 30 Apr 2024 23:48:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/26] xfs: make it possible to disable fsverity
Message-ID: <ZjHlventem1xkuuS@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680792.957659.14055056649560052839.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444680792.957659.14055056649560052839.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 29, 2024 at 08:30:37PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create an experimental ioctl so that we can turn off fsverity.

Didn't Eric argue against this?  And if we're adding this, I think
it should be a generic feature and not just xfs specific.


