Return-Path: <linux-fsdevel+bounces-73477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E758FD1A876
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C072C30574E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FF334F479;
	Tue, 13 Jan 2026 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEFdbgZ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E102512C8
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323938; cv=none; b=HtB1yTS4UCw36PMOeV/Dd5VTkC3BSuqD9tvebEUIGPpGzCNVFvvlNSb2PRmRsa4XcOqu4GC0ax9QL3MY5ALTt0d+C0yubdqRDOERU9LJd5zn5J/i43QKe6X9JxMBfFGfKx7qfhKsVrzGb75pl+qdp9S/HPrAeQ1RoM8wc5w+l4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323938; c=relaxed/simple;
	bh=aqmoNqWtVgAcpIUZZw9iu4GHlM6fBGKiwmFvCSZDjNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGhlmOodwEygOvRJQXa8CEJDkY4W1nL0W5shxw1iyg1ezEaABTF6iyy+DO+ucTeUtQ9D/zMJYYMVJvK0kgNU6WOmU9hIo5pX04/mu4qSU/wZdraAhdP76VnZOx+7u4BpoHUsjgWdHA+yH2SHhZS9mkPWi98oOVAoU9wCdbRCyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEFdbgZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BDFC116C6;
	Tue, 13 Jan 2026 17:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768323937;
	bh=aqmoNqWtVgAcpIUZZw9iu4GHlM6fBGKiwmFvCSZDjNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEFdbgZ+2AoJAKNzsXOceScIEDYLpc9fVSMVSxfPsa/F9uPxx4xSHYRRnU/iRCD0N
	 JgJdj+XNcTaihzCY0yYWcpAmL65gfcICoI+0oKpRtpjFL5IGTpOzz3u8i5HaXo0lCd
	 37xtaaP7B5+KlUNCK5l1zTaUif0WdlXLth2w5rg8yiJlQPDbFHAYRPIBUf8LcvkcPt
	 ax1xaR6mTHxNpXiPkLtgUQSG1jtjV5qFaHryQ25ZBruF6aQJMWkYg3nLrpoVuUR1gX
	 8PThTjc1sKwiZ6FJWXsaaG77VPsvvotXTDE8C52oju5l+JSN1Lc+570jPII7gojpTp
	 0EEGZPLfeVPXQ==
Date: Tue, 13 Jan 2026 17:05:35 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Nanzhe Zhao <nzzhao@126.com>, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add 'folio_in_bio' to handle
 readahead folios with no BIO submission
Message-ID: <aWZ7X9yig5TK2yNN@google.com>
References: <20260111100941.119765-1-nzzhao@126.com>
 <20260111100941.119765-2-nzzhao@126.com>
 <0aca7d1f-b323-4e14-b33c-8e2f0b9e63ea@kernel.org>
 <13c7c3ce.71fa.19bb1687da1.Coremail.nzzhao@126.com>
 <5158ff31-bd7b-4071-b2b1-12cb75c858dd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5158ff31-bd7b-4071-b2b1-12cb75c858dd@kernel.org>

On 01/12, Chao Yu wrote:
> On 1/12/2026 4:52 PM, Nanzhe Zhao wrote:
> > 
> > At 2026-01-12 09:02:48, "Chao Yu" <chao@kernel.org> wrote:
> > > > @@ -2545,6 +2548,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
> > > >    	}
> > > >    	trace_f2fs_read_folio(folio, DATA);
> > > >    	if (rac) {
> > > > +		if (!folio_in_bio) {
> > > > +			if (!ret)
> > > 
> > > ret should never be true here?
> > > 
> > > Thanks,
> > Yes.Need I send a v3 patch to remove the redundant check?
> 
> Yes, I think so.

Applied in dev-test with it.

> 
> Thanks,
> 
> > 
> > Thanks,
> > Nanzhe Zhao

