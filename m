Return-Path: <linux-fsdevel+bounces-60938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 521C3B5312E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBE23AA1D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C83335BC5;
	Thu, 11 Sep 2025 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UzOLmEC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E55334367;
	Thu, 11 Sep 2025 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590678; cv=none; b=D/5xZqlhHu2l+byzpcpXjlV4xPoj3GGRnBSZa5T1UNn6JMyjxa83ScqDcg16/qhrJwWvX02CrA3XAYKZCR2EAJ7reQ2w50A7XiklLCYZpToVsCzvUKrTmRb6qNcN9OeZo8rbXghXk5Dcif0w1mAtIk5O69WRT1yrLjy1FOsB7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590678; c=relaxed/simple;
	bh=rnp8EsaMc9fWMrqdqXN4/XgyJX6op1Hcet7eQl/Xfbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjRUK8lLf44wBLok+6CJ4ItQC86vjoCi9kEergdw+TKrrYwc2WyQGyPGRmmEFV4JcJMtPoihKmcvy1mboxl77yLBHUkpUmjwvxLu7BdG7LDJrbPCAA0H9yXwd3t67ovz0M7K0QtZl0Pp5iLFwOqqVm8d2JdYZaNJCZLM8uRgnto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UzOLmEC0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y8JcLR6V6lTUkf/L1dN4cS7VInD8rNcP4lWlHUTCHcc=; b=UzOLmEC0OxawPpj5/Q0LlYCNhQ
	tqfL/EZf3cpCdOcXJO46I+ieEgX3c8LiYPTUpE2YtoK8TJ68jH5mdpySRwCCf6Nt+7ZSTSIEN0BNH
	n4o6OtSJOFUY74TKbcQJYSUxAnGd34M4N8mqNzEt4ErBo8Mo8fa0fOHJnqHvzc8rqx5F7+Yzhp/Iz
	Rq8aRWD6MemS4RPDyfnHYPxAuFKQWBz0ZPGiOGOh+hfMBEAgVjPWLivnLvC9V8Fjwhr3a6sLxAtxn
	U74x4j6KjnwagkqgBbiHdO038Xu5lL7Gj7EBJY+LC6ugoGKCQLtyqWG9V8LgMETZfRZINdNiSVoc5
	7LkYKxNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwfci-00000002jXy-14Tz;
	Thu, 11 Sep 2025 11:37:56 +0000
Date: Thu, 11 Sep 2025 04:37:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	miklos@szeredi.hu, hch@infradead.org, djwong@kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
Message-ID: <aMK0lC5iwM0GWKHq@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-14-joannelkoong@gmail.com>
 <a1529c0f-1f1a-477a-aeeb-a4f108aab26b@linux.alibaba.com>
 <CAJnrk1aCCqoOAgcPUpr+Z09DhJ5BAYoSho5dveGQKB9zincYSQ@mail.gmail.com>
 <0b33ab17-2fc0-438f-95aa-56a1d20edb38@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b33ab17-2fc0-438f-95aa-56a1d20edb38@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Sep 10, 2025 at 12:59:41PM +0800, Gao Xiang wrote:
> At least it sounds better on my side, but anyway it's just
> my own overall thought.  If other folks have different idea,
> I don't have strong opinion, I just need something for my own
> as previous said.

I already dropped my two suggestions on the earlier patch.  Not totally
happy about either my suggestions or data, but in full agreement that
it should be something else than private.


