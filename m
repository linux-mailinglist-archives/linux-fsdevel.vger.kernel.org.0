Return-Path: <linux-fsdevel+bounces-61115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1F2B55516
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF9F1CC570B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6690321F40;
	Fri, 12 Sep 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGy0AQIV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ADD32145E
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695972; cv=none; b=Djw5TKU9sYffDD5DTJC841TPT9LYQBDGNtwQGsfjWKRrXkX8fGaYBmrMgJJVZym5p6Q+ELcubawycCx7v8kl1QwNT0fHSt3NXyYI9oU77mXL5A97gTQIIr4Au3c+qgj6USTA37waK+4CNBSsdEl0hgS9IMqgqSBK+kAIZY/tumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695972; c=relaxed/simple;
	bh=3ldgPlxs2wAa7FMV+1et7eHrOB+xsvR/1AU8B1WCXFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkFVgzpxqom/QIB98yX/zShzcwlwdA+pgbQ9MAWMvMwwEQcMR8uqWqlIiCTCOGkNU1QJCbcL9QusgeNFX/08+TcLe1rG7t9ybCa1wJgfLuub956tXh/hpQp+TWdTK/CHM0/w7iJmnjSowdHrx1HehCl0Kwkc/RzCFStyWP04q6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGy0AQIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068F1C4CEF1;
	Fri, 12 Sep 2025 16:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757695972;
	bh=3ldgPlxs2wAa7FMV+1et7eHrOB+xsvR/1AU8B1WCXFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGy0AQIVT3603Tprs26b0o++xvCtejh5yE5d6PsvRnO8UsRBDSQ+OJSZsXMtZJoKM
	 f1mD+EIjlP20WRixVzkC4cEzZ3Yr+MGVnV89LhKyrKGyFseNrzR+ymRKOJWEzQmwtS
	 qMwKZI7SjZCh0F73KUDdQWQ+GTm2KNoi9lsqdhqwkGDE0e++6am6ZGKIIMJl4aLIhm
	 N29dgMZw5A1iQMMFlJDKDhyqYzq9iy7Qy0iypFNXeRbnhw9E6839RumfCIN9OfUo3z
	 80VGXye/FcMMGE0bMxRNiLeRNYkntfOtPJ+XPhjASG5ZNLv31gfoEOCaqo0gFbfqhg
	 QPv37Vjw59I9w==
Date: Fri, 12 Sep 2025 06:52:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] writeback: Avoid contention on wb->list_lock when
 switching inodes
Message-ID: <aMRP4zE3DM2FvG1N@slm.duckdns.org>
References: <20250912103522.2935-1-jack@suse.cz>
 <20250912103840.4844-5-jack@suse.cz>
 <aMRHNSDV4lXSsU9U@slm.duckdns.org>
 <2nhajeaf6gs3xcpk3jyua7qle7ltmtb4qr564pj4atb7ignofv@wopqday65jgr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2nhajeaf6gs3xcpk3jyua7qle7ltmtb4qr564pj4atb7ignofv@wopqday65jgr>

On Fri, Sep 12, 2025 at 06:39:28PM +0200, Jan Kara wrote:
> > Shouldn't this ref put at the end of the function?
> 
> It is put:
> 
> > > +	while (1) {
> > > +		list = llist_del_all(&new_wb->switch_wbs_ctxs);
> > > +		/* Nothing to do? */
> > > +		if (!list) {
> > > +			wb_put(new_wb);
> 			^^^^ here
> There's no other way how to exit the function... But I can put 'break' here
> and do wb_put() at the end of the function. That will likely be less
> subtle.

Ah, sorry about missing that. Yeah, maybe better to put it ouside the loop
to make it clearer.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

