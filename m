Return-Path: <linux-fsdevel+bounces-56380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EAFB16F60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A36F1AA79C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0172B2BE044;
	Thu, 31 Jul 2025 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxhnobS4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF529B8E0;
	Thu, 31 Jul 2025 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957358; cv=none; b=ewYA6OUuPv2+g/ICPc/346HJffB9YAbQK0DfLQmW+Toqj8lui7VTzID289ZFaR3b7rRIbAMvL/mU8tE9MC6Moi3op/WkB7VdZNLhzoRI+/2zNqmWwnrdYgTngG38YjzpIViHAtyutHQxEl12srWvsLZu7i5CoIzMR2ZbNr++LKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957358; c=relaxed/simple;
	bh=LsAVB4URHYUtUc9wzp9DbpjAeZ9WpNGB0M83y8BWXS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/ON8F8JaAc5mFmoiiySOT3UO0nOSKdR72oQsvIfi7kJ5WNR4PBARJIRuNg0WIkEebIYuEvFeBlFu0B89d36/I3slfBH6l4XlcNa3rd+oEREHApgpq7nK5qwkTqWstuUGH7f1HTgAW8hzfTRBNA2T55ROnSxG0/F7i6wtJDTd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxhnobS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70053C4CEEF;
	Thu, 31 Jul 2025 10:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753957357;
	bh=LsAVB4URHYUtUc9wzp9DbpjAeZ9WpNGB0M83y8BWXS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxhnobS4XO6hJmQMUhCSaw2g3fu1nK1app29c4wkaDKKckB7p1U8DXdOzgzc+6mBX
	 pAaugCkxPFl4chtEinKicYOMZOT+lrW0AQPVXArEsNHHbxJKvkySUD6KT+rqOOE730
	 86HbikIwGTc4lHhz6plbQCFn4s+uOSbjuhlakv3SCAzIx03pvkZzZKpx99EuNTKNgB
	 ncPTRD0YqzYynWo/9oamNv7yiBYZf/scY8PQg+NU3WUFuZPeBUzc6FY+zWOYmffyoh
	 mGOr6u5FqKWOtUvWfYvldDkOvuA6UUBTHbav3bdAdMx06VfT/W2WHnwCpZLtlG+Dun
	 x9vdpAxptjMAA==
Date: Thu, 31 Jul 2025 12:22:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] umd: Remove usermode driver framework
Message-ID: <20250731-kavaliersdelikt-geprobt-eb7e802ba673@brauner>
References: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de>
 <20250721-remove-usermode-driver-v1-2-0d0083334382@linutronix.de>
 <20250722063411.GC15403@lst.de>
 <20250723-heuballen-episch-f2b25d1f61a6@brauner>
 <CAADnVQKDwEPa0hQFqdoPUGt9bsx6V1xt_HJ=uhxWACoy4+KvQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKDwEPa0hQFqdoPUGt9bsx6V1xt_HJ=uhxWACoy4+KvQQ@mail.gmail.com>

On Wed, Jul 23, 2025 at 10:27:42AM -0600, Alexei Starovoitov wrote:
> On Wed, Jul 23, 2025 at 5:49 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Jul 22, 2025 at 08:34:11AM +0200, Christoph Hellwig wrote:
> > > On Mon, Jul 21, 2025 at 11:04:42AM +0200, Thomas Weißschuh wrote:
> > > > The code is unused since commit 98e20e5e13d2 ("bpfilter: remove bpfilter"),
> > >
> > > Overly long commit message here.
> > >
> > > > remove it.
> > >
> > > Otherwise looks good:
> > >
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> >
> > Reviewed-by: Christian Brauner <brauner@kernel.org>
> 
> Fair enough. Democracy wins.
> Will apply once I'm back from pto.

Fwiw, I honestly don't care that much. I think the removal makes sense
precisely because having unused code is usually not a good idea. If you
really want that infra you can always reintroduce it once someone
actually ends up using it.

