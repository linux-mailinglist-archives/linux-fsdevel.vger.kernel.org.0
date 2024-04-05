Return-Path: <linux-fsdevel+bounces-16174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344D3899B80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 13:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CD728505E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 11:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBA016C424;
	Fri,  5 Apr 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXbRoe7j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA75718659;
	Fri,  5 Apr 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314960; cv=none; b=pC0IwWc/0U9gVjCoE1zdoZmSsbmzPEuz6/evRA2e+g6aW0m5DreTwkitYQNs9mpcbvkW8VNuvGBgUSzZBROcL1gUxm5+uIHErVG4i+HoCRBKP71lCxr4vdfUoBT+Gf6zCSX7XAjIxmV1R4yCzZVrrqY58NuQXjFDdHRh49CvfME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314960; c=relaxed/simple;
	bh=Kh+e3Gjte9yHrK6vDtLniZ8dgoPXI8Ym0HS2EnIP5E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH+2HLrALzVmRjsyPk1gp0LUHGob43OJ5A0qg2BkmuDLHeros5yA0i9HpA6OESJXRqfgccNHFMryPwyPd7m8dLCnDrWdi3YpDF7gvMZhZWB7XhpTYz8LTL6lAbFnAyz7hIHurY/ypU+oM5J/QHud7zB/8kgg7kXonFug1JrCyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXbRoe7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F43C433F1;
	Fri,  5 Apr 2024 11:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314960;
	bh=Kh+e3Gjte9yHrK6vDtLniZ8dgoPXI8Ym0HS2EnIP5E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXbRoe7jCb6iqesz2gyzBZLYJh2T2zzqQ5AQIFxbUQdTCZDlOm/8ySHJIN3OOs6NJ
	 FE51q02sIX6EVvtrEoBchYS6nrI3pmD4z92UXM7FbHhfSKYsH+qZ2kGaCG3LIiL5zr
	 3zrWBuAOkxE4Dm40D3oKs40OHmY+IymKfeRzYLr8s2JtR4y/xQ+w3LHmn1wS+BGggv
	 b2MyASUUXjCZExDTiGCdRqlPXpq9TQJZC2AjwavX9YqENdtmkMKGOz9SAKWFQv1LS2
	 H6AkQCw2wNFJYDO90ujKmactJJDid7SEtur+WDY7Tk8b+EH+1x26VWAsmPhktIC5fH
	 apWmWwBmZiUkw==
Date: Fri, 5 Apr 2024 13:02:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/4] Use folio APIs in procfs
Message-ID: <20240405-ziert-sektflaschen-2a8233165ec3@brauner>
References: <20240403171456.1445117-1-willy@infradead.org>
 <20240403121650.d0959d09add5e2066761844b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240403121650.d0959d09add5e2066761844b@linux-foundation.org>

On Wed, Apr 03, 2024 at 12:16:50PM -0700, Andrew Morton wrote:
> On Wed,  3 Apr 2024 18:14:51 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > Not sure whether Andrew or Christian will want to take this set of
> > fixes.
> 
> This set has dependencies upon your series "Remove page_idle and

Fine by me in this case.

