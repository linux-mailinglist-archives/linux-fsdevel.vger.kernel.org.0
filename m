Return-Path: <linux-fsdevel+bounces-8633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8EB839D5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 00:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98EA8B26089
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 23:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A1154BD0;
	Tue, 23 Jan 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqRLCez+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1513E53E19;
	Tue, 23 Jan 2024 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053705; cv=none; b=pFiaNBf7Ajwlv06nEy8020/zZrv8bJjiF7zLG8Td41dTonIp9vNtr2XowanB6uyVUaOpq4yqaOxglAPsuGUGA88yBgQkkTBayKzschtp0og2zeE/EvkYrCk2yCkTAxnf6htD+xUehVvPW5WA9hDFJPVXpfPsdlsIXDqxXE9vGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053705; c=relaxed/simple;
	bh=i63/EC9fEJXjHPLnbbq9ocf9k1RadXlh45rjwcwdi9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buW5YfZTF4jUxdWZWI2BOa8BJ2X+NwecpyoZ76jLp6KvGNHpkqldN3BS0H5t0dZv21Diw/SUHrIPHTK3HXvQIKa5mA0Gnk75Oy2HctTOrEYgcU7ONS7ZyYorsmc/x95uB1g0iGZrEHqSbIDnRYGXTzAwDzCJLnBVuimJiU1IGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqRLCez+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0564EC433C7;
	Tue, 23 Jan 2024 23:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706053704;
	bh=i63/EC9fEJXjHPLnbbq9ocf9k1RadXlh45rjwcwdi9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HqRLCez+mvchaidw6s0c8ECBZQ1+ikxin7uAVGGodRKX+6digk8OFGscHpNc6DVWF
	 +m4PlkozX0QWdDoKqYc/67FhWpx8UCRlIZ0//+2wdKfaAUNHE/0qMCBcMFB3gzQL37
	 GcaR6nb0TRIGR5zOCMs198pIGdm2sKCSwwOeeSe+KXTKzCWMZ9/0UESs6cwgtyXJaC
	 Ry3eDD6KejRN8Nw3kLbLDIYkRtrsSoexC7YUNvUagu3l6fZLMIYim7evnJQQt36idP
	 ZDfUT1sKDHPuH+3V1kwmPflLtlZ+DwWDxexzIGyATH+8okJ0E3ItCSLu7LLCD1nMGD
	 fHvpvNL5Af0dA==
From: SeongJae Park <sj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	dchinner@redhat.com,
	casey@schaufler-ca.com,
	ben.wolsieffer@hefring.com,
	paulmck@kernel.org,
	david@redhat.com,
	avagin@google.com,
	usama.anjum@collabora.com,
	peterx@redhat.com,
	hughd@google.com,
	ryan.roberts@arm.com,
	wangkefeng.wang@huawei.com,
	Liam.Howlett@oracle.com,
	yuzhao@google.com,
	axelrasmussen@google.com,
	lstoakes@gmail.com,
	talumbau@google.com,
	willy@infradead.org,
	vbabka@suse.cz,
	mgorman@techsingularity.net,
	jhubbard@nvidia.com,
	vishal.moola@gmail.com,
	mathieu.desnoyers@efficios.com,
	dhowells@redhat.com,
	jgg@ziepe.ca,
	sidhartha.kumar@oracle.com,
	andriy.shevchenko@linux.intel.com,
	yangxingui@huawei.com,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@android.com
Subject: Re: [PATCH 3/3] mm/maps: read proc/pid/maps under RCU
Date: Tue, 23 Jan 2024 15:48:19 -0800
Message-Id: <20240123234819.125576-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAJuCfpHgScS4tud7yLn24RGMMwTaM=G4THOCgBZKGEoYkNPvtg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren,

On Tue, 23 Jan 2024 15:12:44 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> On Mon, Jan 22, 2024 at 10:07 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Mon, Jan 22, 2024 at 9:36 PM SeongJae Park <sj@kernel.org> wrote:
> > >
> > > Hi Suren,
> > >
> > > On Sun, 21 Jan 2024 23:13:24 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > >
[...]
> > > From today updated mm-unstable which containing this patch, I'm getting below
> > > build error when CONFIG_ANON_VMA_NAME is not set.  Seems this patch needs to
> > > handle the case?
> >
> > Hi SeongJae,
> > Thanks for reporting! I'll post an updated version fixing this config.
> 
> Fix is posted at
> https://lore.kernel.org/all/20240123231014.3801041-3-surenb@google.com/
> as part of v2 of this patchset.

I confirmed the new version fixes the build error.  Thank you for the kind and
nice fix!


Thanks,
SJ

[...]

