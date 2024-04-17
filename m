Return-Path: <linux-fsdevel+bounces-17172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6541C8A89A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9096D1C23C8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5616171E5A;
	Wed, 17 Apr 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XxHSYhkP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12890171079;
	Wed, 17 Apr 2024 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373266; cv=none; b=KuUpTbLAhdi0bqnh3FqwQGQhfJd2IgMfekBXTwn5Q+DHwfuaYWzj6NMWV7a2cnhQQbEx69mFDbCauXSg3e5bVGzqM1v2nE9Pqx5uIoqyuwY/Cwr0bpCyO/6awHGNvIE2VXic4oPA21Rut6X1Uv1Istci53GSjLJUl/3plPRqZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373266; c=relaxed/simple;
	bh=nKeVeNgCcSI+26qQh+IsYhy1VrdQuFRSqA7SFnpQJeE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TxCixQNk0hmc2bJbvmtvX30tMrF+4DSn7knxXFsqXfstXY2czCY5fYFIFNbJm/9BDwP23oLzwM+1If+U083OduGgvEOl+/yqnXBKDyLSd+JrvrIPCFPJfF27OS53NMZfaYYnGznXA2Uyv/asaWinIjE6JIedhS8C20x0Lmmor2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XxHSYhkP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8vdoC1n4NAGT51zT+XjZG+byDRcMNbmlIj/N6lUsVwg=; b=XxHSYhkP78vnJXr5/ru9AvKGXA
	lONfc7ZJWmnQXT3d5x5ISPQdxCHO8rKYhbxpKj9pWh3ovmQdYcFg78TedrrV5/5xzTxEhqiVrBiog
	WnxvR/ra+zuLcI4ns7qg45glSwti8l0u1LSAGewJxEm3UgYi+LFYX563hQw1MJexJB6BhCkeDH9Me
	3TYfDZ4zWAA5utfC+3Ki8UzUlzi26APyPUUxj0y0X86HCnWD8+uIxoopV+hAJ9WtPvLjFhgk4Xvoq
	5JUUyAyM8wA6QfYjm1HJN5uS0DKHEc5Ofc51brgBoWOuhNzFflnOTpz5o/b9zE+BDE+vzC8ENuSWt
	2PPTNetQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx8ea-00000003KIC-220d;
	Wed, 17 Apr 2024 17:01:00 +0000
Date: Wed, 17 Apr 2024 18:01:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org
Subject: [LSF/MM/BPF TOPIC] Running BOF
Message-ID: <ZiAATJkOF-FulDyS@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As in previous years, I'll be heading out for a run each morning and I'd
be delighted to have company.  Assuming our normal start time (breakfast
at 8am, sessions at 9am), I'll aim for a 6:30am start so we can go
for an hour, have half an hour to shower etc, then get to breakfast.
We'll meet just outside the Hilton main lobby on Temple Street.

I don't know Salt Lake City at all.  I'll be arriving a few days in
advance, so I'll scout various routes then.  It seems inevitable that
we'll head up Ensign Peak one day (6 mile round trip from the Hilton
with 348m of elevation) and probably do something involving City Creek /
Bonneville Boulevard another day.  If anyone does know the various trails,
I'd be delighted to listen to your advice.

Running pace will be negotiated by whoever shows up; I'll be tapering for
the Ottawa marathon two weeks later, so I'm not going to be pushing for
a fast pace.  This is a social group run, not a training opportunity.
People who want to do more or less are welcome to start with us and
break off as they choose.

You don't need to sign up for this, but if you let me know whether you're
showing up, I might wait a few extra minutes for you if you're late ;-)

