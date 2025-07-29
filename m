Return-Path: <linux-fsdevel+bounces-56231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A3DB1493C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 09:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F31542EF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8587264627;
	Tue, 29 Jul 2025 07:37:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D3263C8E;
	Tue, 29 Jul 2025 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753774637; cv=none; b=FePKkkaEi9ja80yttS+rdVtsSeGWI3ywdKjKl8npo+PVJzdyWteN038VlG4Fh0Jo6d12BI8fAWh41UysOY4bkUQTJlffCU7zdVjst0sSD+x6a/NeQ5UgdEF9D4iQ2zP4AmbZMSKpdx/qP+FoApXrvpBEhz3MYByEsg+wr9wkElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753774637; c=relaxed/simple;
	bh=IRL+AIb+PgL86fQmIw3gkXVr2HFb4vgb5D10T6r0CC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPuCXGGcTjEWofm+xZzhBZKsgOmvWFAnBcYn7PUC55BbCM0W02BMRrAwIrf+Z2GxfgfiyjkqZJ6LGZwX9a5s0163zicJ6FzcVD8yDllGOJayU3CrjPSedy4xOhoTYfNCek7LeWwnO8cGJGEtQXcGNa8HqOBntHDEkHhwpBzLAPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 072BF68BFE; Tue, 29 Jul 2025 09:37:02 +0200 (CEST)
Date: Tue, 29 Jul 2025 09:37:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>,
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
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] umd: Remove usermode driver framework
Message-ID: <20250729073701.GA23423@lst.de>
References: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de> <20250721-remove-usermode-driver-v1-2-0d0083334382@linutronix.de> <20250722063411.GC15403@lst.de> <20250723090039-b619abd2-ecd2-4e40-aef9-d0bbb1e5875e@linutronix.de> <20250724072918.GA29512@lst.de> <20250724103305-c034585a-d090-4998-a40e-af3b5cca5ef6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250724103305-c034585a-d090-4998-a40e-af3b5cca5ef6@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 24, 2025 at 10:38:19AM +0200, Thomas Weißschuh wrote:
> Documentation/process/submitting-patches.rst:
> 
> 	The canonical patch message body contains the following:
> 
> 	  (...)
> 
> 	  - The body of the explanation, line wrapped at 75 columns, which will
> 	    be copied to the permanent changelog to describe this patch.

Hmm, weird.  I always through we stuck to the usual email length,
because in the end that's what commit messages actually are.

But I guess I was wrong, at least since people added this.

