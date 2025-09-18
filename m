Return-Path: <linux-fsdevel+bounces-62149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47508B85CE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 17:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30525176039
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358C9314D2F;
	Thu, 18 Sep 2025 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZvZSrDz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A72E30FC3A;
	Thu, 18 Sep 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210668; cv=none; b=k/VrtlFq771ysUmxq65RaYHCRPyMAWtO0iA/7KlAaBKmuUHncF/NBO+Rpv3WFzoZmid97bdh4huKqD/VSaGLgU63HrMiL9VwUklS9947Q166jXvgpgyVWh+cs03O3yIoRT26x4S4nhWBRhQXs23UgWtkyuhyI4gCn1PDnSWzLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210668; c=relaxed/simple;
	bh=PerYjtPj0PNRwhq5JdCQoYaEhEmyo+RY4FkRjuvzbfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu1iH3gReuVPox+2Zmo3nqCY40vg4jvYcnfyQg0FT5WlKLKxk/ssGPYt+FfiRCwksSu2sJFvIkJvUnP+Utiaumbs2FB2zeZZcVI/cfNYYvcNyi5qNrVN+CdXh3CUG9X+MKYOmAUINmwByaAtCDeYOiwfagx2sKI2pBsHFVitB3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZvZSrDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0270FC4CEE7;
	Thu, 18 Sep 2025 15:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758210668;
	bh=PerYjtPj0PNRwhq5JdCQoYaEhEmyo+RY4FkRjuvzbfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZvZSrDzYcN+9wjKtVuOfqyN7dr5xWVjXg243irOw1rUX7nZXwP5SCpp/IDb8bX6c
	 uIpFC92GXlYgM6H6qKJClOTtcGE7P57AFxsieanOg2FxAo0vhykexIwd3mIzLQ5szF
	 4dzyyOZnHF8+LlbmcFbiS3soubDkqttKxYnWQFefIwuS1HSWCi3A2+8+ZI0W2eGk1+
	 0HAlDUaGL9I7q2HUczg3NFr9SqrVBnqGEFqOEKdlIP0Wcr7eiUgr+1W5lHNuZ2C0ja
	 k/9pKGJIpMIYJ3m6ucA1X2eJJaNj9SMV/eyMuy6h9NEZCSzgEShab/P4+IsgUaXPcL
	 IS+6pXtfgrk7g==
Date: Thu, 18 Sep 2025 05:51:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 03/14] cgroup: port to ns_ref_*() helpers
Message-ID: <aMwqaxFUTFh6knNV@slm.duckdns.org>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
 <20250918-work-namespace-ns_ref-v1-3-1b0a98ee041e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-work-namespace-ns_ref-v1-3-1b0a98ee041e@kernel.org>

On Thu, Sep 18, 2025 at 12:11:48PM +0200, Christian Brauner wrote:
> Stop accessing ns.count directly.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

