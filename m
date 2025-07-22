Return-Path: <linux-fsdevel+bounces-55640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C7AB0D1E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 08:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC1E188FC44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 06:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A2B2BDC2C;
	Tue, 22 Jul 2025 06:33:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B16154BE2;
	Tue, 22 Jul 2025 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753166014; cv=none; b=cEM+RIqdyQiREpfg00er4+khjRhx2/Mx7p+TfOgJkv85d89Dj2oACymA/D/4rEowK5mCmKSDj+8nbFvt3W3Jrs8QUGpcUnF9HH1utAn+Fpxr5SZeyCkcAImsJNx9YKi7OZKXSGJPBr0z7TAu4N4SKEBVRZR4n3TKIFo7M07u2Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753166014; c=relaxed/simple;
	bh=R1pzQDmBw0mu6WXPCBpUDsWcAml8QJNVUFDGfuNsRmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Or6BbbO+97OXXUL+nfZ3Zy0/AFOdyACUlMtwi+j2WcSxQEORzhVz7ZRX+DyQBEzG6mfg9ao+cJJn6IRBz5iFYEQ+CEZrwDaC/iNBfVXysSiHga4F5S96M/jUuTrm61HyrWoHYZQ3jPqxDKcnNDQmEf9FeCNMjtmUxf0/tflkG8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 78B9E68AA6; Tue, 22 Jul 2025 08:33:28 +0200 (CEST)
Date: Tue, 22 Jul 2025 08:33:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christoph Hellwig <hch@lst.de>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] umd: Remove usermode driver framework
Message-ID: <20250722063328.GA15403@lst.de>
References: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de> <20250721-remove-usermode-driver-v1-2-0d0083334382@linutronix.de> <CAADnVQ+Mw=bG-HZ5KMMDWzr_JqcCwWNQNf-JRvRsTLZ6P7-tUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+Mw=bG-HZ5KMMDWzr_JqcCwWNQNf-JRvRsTLZ6P7-tUw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 21, 2025 at 08:51:22AM -0700, Alexei Starovoitov wrote:
> On Mon, Jul 21, 2025 at 2:05 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > The code is unused since commit 98e20e5e13d2 ("bpfilter: remove bpfilter"),
> > remove it.
> 
> Correct, but we have plans to use it.
> Since it's not causing any problems we prefer to keep it
> to avoid reverting the removal later.

Plans to eventually use something are no reason to keep code that's been
unused for almost 2 years around.  Unless the removal would conflict with
currently queued up in linux-next code it is always better to just drop
it and reinstate it when (or rather usually IFF) it is used again.

