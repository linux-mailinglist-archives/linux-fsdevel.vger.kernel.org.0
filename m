Return-Path: <linux-fsdevel+bounces-50247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D494FAC97ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 01:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D145F1BC05A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 23:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8C128C2C8;
	Fri, 30 May 2025 23:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gsD/5gpP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C819219313;
	Fri, 30 May 2025 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748646036; cv=none; b=LMiIt296j62MorUcfPkgVVhmCNF1LyUlD9secRBvFKQMDq8hic6/nj9PUEVIPuOvddhkYgpzNQ/lvDu7gIgvskfPncp7dGO46rTPTruXKBHz5VmFAvEU/BWrpaED4jtGDQb7B6Xox6UQiwoCrl/h3BAPQCu18RufbdCHQNnBx0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748646036; c=relaxed/simple;
	bh=ABuVgwbuFCM6uuCeVrqEI3bOQFqSk/ajBEIr7MnpHKw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DdxEYb2dVYaKi8Uy4+zL49jfQEGuD2xxcMRcaCHvJAqoUTkAoBkr71HSrVKh4i57KxNi0nvYHykId0kWEIz5yGuSCAo5AmPxk0tYdo6epey6eQyIhb+hSn+q6B2e6FIc1ykSsp+EomMiDIJCv5He187hOhIZUdGgdRPsE6zd6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gsD/5gpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CE8C4CEEF;
	Fri, 30 May 2025 23:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1748646035;
	bh=ABuVgwbuFCM6uuCeVrqEI3bOQFqSk/ajBEIr7MnpHKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gsD/5gpPPJA7kNbAGwVznyjd5QCqyBQmeIODvPYxNx/51ADx8GZ5xPFYfOfua4CWP
	 x7RzCADGmbh9lU3oXeO8m9OckSXLv2icFbgOWViJ9zRv+D6b/fRAabmv0uMItYPrPj
	 McW0M2l+SXzAHspHnZiqrXfHagDiLtHjPKzXIfi8=
Date: Fri, 30 May 2025 16:00:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, david@redhat.com,
 shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, donettom@linux.ibm.com, aboorvad@linux.ibm.com,
 sj@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix the inaccurate memory statistics issue for
 users
Message-Id: <20250530160034.94c8aee421266afe6a0b8f9a@linux-foundation.org>
In-Reply-To: <aDm1GCV8yToFG1cq@tiehlicka>
References: <4f0fd51eb4f48c1a34226456b7a8b4ebff11bf72.1748051851.git.baolin.wang@linux.alibaba.com>
	<20250529205313.a1285b431bbec2c54d80266d@linux-foundation.org>
	<aDm1GCV8yToFG1cq@tiehlicka>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 15:39:36 +0200 Michal Hocko <mhocko@suse.com> wrote:

> > > Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
> > 
> > Three years ago.
> > 
> > > Tested-by Donet Tom <donettom@linux.ibm.com>
> > > Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > > Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Acked-by: SeongJae Park <sj@kernel.org>
> > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > 
> > Thanks, I added cc:stable to this.
> 
> I have only noticed this new posting now. I do not think this is a
> stable material. I am also not convinced that the impact of the pcp lock
> exposure to the userspace has been properly analyzed and documented in
> the changelog. I am not nacking the patch (yet) but I would like to see
> a serious analyses that this has been properly thought through.

Thanks.  I'll move this into the mm-new branch while we work through
these things.

