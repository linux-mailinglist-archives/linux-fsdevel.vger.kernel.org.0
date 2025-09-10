Return-Path: <linux-fsdevel+bounces-60831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6576CB51EA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 19:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA4D4803CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0402DE71B;
	Wed, 10 Sep 2025 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwZsnn84"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0FA299947
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524214; cv=none; b=Yql8OkABlSxatpKEE7vTTJfxj+HcigDEp1qgebm8ZuPSTL7y1QBBl/EniY7be3vkoI7Jc2jpRE8o6k/X//azYSLzMPkMAFSNDroFxGm+QnF2GlgRSzL/nP7Dm+5orq+26mU5e1+hXuLnN6fjxOyQ1v8YpKbvGrNuZ+fLGJ4Lahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524214; c=relaxed/simple;
	bh=HkauIcxWud12TNOCbSHwm8VIY22ftXvKxCg5/T1LK8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eyb5YGcbdOi0PMwzdve27fifDd16yw1cNF9nDtO8jVhjKRoX0Sf4yftZeQlxYwzG0KVzrwqr96SOe6ioV/Tx9iM8HRiogAwFQRWLH47aA/gq2u9CurERKfPhxJDSWOgW+yX+sbu+yWzgS8Yk1/omUCE+L1Y/oT2fW5WB16fnjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwZsnn84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676F5C4CEEB;
	Wed, 10 Sep 2025 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757524213;
	bh=HkauIcxWud12TNOCbSHwm8VIY22ftXvKxCg5/T1LK8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HwZsnn842tTTZ+TCNVQzO2DS7OWLEZ1l7qFmUobGDUJCeGXxsgpnjreF6XbZlc85A
	 1DUCAkOQ4wX/iIdqY9EAd0Hhhs3A12ugB2aXLEKHTW2WkvqsJM2OOW45JQ+fyViPYn
	 eTw8SnE8aLJKhvXSS/gpBwHkWJKADa8E3VhbP2fB82i8a/RTxd1hh+9ATHWRK8eIEP
	 pt0MwEerlFBh0Plul05UjwwLhetD6hAOHwJU+tfKEeOLy2L8YQ2lLxFh0IZn1AO5Ry
	 P8/QPj33bAwdiuz4tjId3uXKWW2tLdBYaNEByIFUr9d+yaQE+cB3Mq3Co5l+dxt5OS
	 DfwT4JNQh4ckA==
Date: Wed, 10 Sep 2025 07:10:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] writeback: Avoid contention on wb->list_lock when
 switching inodes
Message-ID: <aMGw9AjS11coqPF_@slm.duckdns.org>
References: <20250909143734.30801-1-jack@suse.cz>
 <20250909144400.2901-5-jack@suse.cz>
 <aMBbSxwwnvBvQw8C@slm.duckdns.org>
 <6wl26xqf6kvaz4527m7dy2dng5tu22qxva2uf2fi4xtzuzqxwx@l5re7vgx6zlz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6wl26xqf6kvaz4527m7dy2dng5tu22qxva2uf2fi4xtzuzqxwx@l5re7vgx6zlz>

Hello, Jan.

On Wed, Sep 10, 2025 at 10:19:36AM +0200, Jan Kara wrote:
> Well, reducing @max_active to 1 will certainly deal with the list_lock
> contention as well. But I didn't want to do that as on a busy container
> system I assume there can be switching happening between different pairs of
> cgroups. With the approach in this patch switches with different target
> cgroups can still run in parallel. I don't have any real world data to back
> that assumption so if you think this parallelism isn't really needed and we
> are fine with at most one switch happening in the system, switching
> max_active to 1 is certainly simple enough.

What bothers me is that the concurrency doesn't match between the work items
being scheduled and the actual execution and we're resolving that by early
exiting from some work items. It just feels like an roundabout way to do it
with extra code. I think there are better ways to achieve per-bdi_writeback
concurrency:

- Move work_struct from isw to bdi_writeback and schedule the work item on
  the target wb which processes isw's queued on the bdi_writeback.

- Or have a per-wb workqueue with max_active limit so that concurrency is
  regulated per-wb.

The latter is a bit simpler but does cost more memory as workqueue_struct
isn't tiny. The former is a bit more complicated but most likely less so
than the current code. What do you think?

Thanks.

-- 
tejun

