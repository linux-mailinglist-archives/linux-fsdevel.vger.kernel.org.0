Return-Path: <linux-fsdevel+bounces-53088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF45AE9EEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 15:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B93562320
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5B42E6D36;
	Thu, 26 Jun 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1ZAJ98E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6962E54AF;
	Thu, 26 Jun 2025 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944950; cv=none; b=Lh3xUH1IM5HgeneTpuFzwu/7LtdsgLsE63VLUPzXBheeRHBSaJZYsSHihHWQDUIxgcFJ457j35NG6GFTPcXR2MBjEQTDcinM4nS3sFFSDikWW8MO1iBogFh+i2hK0foqwQSyFvg/0XoE9oW1uJ7ksFWLJbAXoXxB1xj/7tohNcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944950; c=relaxed/simple;
	bh=rdIz5xXm5ngXP00Ob9tXBkL/GKcoEcsNS9qsuE+RcA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH8BV7METuGsUknhBZpU5Cvu3Trp/vkETK1AcOAQQXFpOfo8abdQLbe4MJylWCMgeMFhHmF3aj0GELjvP53/hN+nViuOVq5/C9yIpD/r6/9ytkpPkIGz1ZZmvqcJk+6nhCQiiVIQ92VLwLRW/k4gj7svQ+iC2cdYurcZj+a7Xo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1ZAJ98E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB201C4CEF2;
	Thu, 26 Jun 2025 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750944950;
	bh=rdIz5xXm5ngXP00Ob9tXBkL/GKcoEcsNS9qsuE+RcA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1ZAJ98Ego3DmGDITHwQtcAiWL4EuAuaFMn/MquM93z/Z5kLe388/ZsvN5qoONJe7
	 FJjGNZfphQUGsbUjBGLW5I/iBxKWYJsFe+PTgUlwQoWZVnCmBvmQnWzdje8r02xlI6
	 0MzMCZ5Tfq/Bcg+r3CZ9+AKi5e91KpZifkG/MH4g6zbsp35cXAv8QL24ZzRr4VFsiE
	 Bn7GcDUHcbYNwcM1BUKpVDZctjLV2x3PKjOiq14ABfwxYzImsMMBA4Hedm3/qNAWb2
	 KcTu6Ho4alz3m6QVqJxEl3Ofk4V12tCqIojwPY2GeM1mw/2mRTkfBtCyQA4ppsorId
	 /VXBrvAMN4GqQ==
Date: Thu, 26 Jun 2025 15:35:47 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, Nam Cao <namcao@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
Message-ID: <aF1MszYwYhUt0Mjy@localhost.localdomain>
References: <20250527090836.1290532-1-namcao@linutronix.de>
 <20250530-definieren-minze-7be7a10b4354@brauner>
 <20250625153519.4QpnajiI@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625153519.4QpnajiI@linutronix.de>

Le Wed, Jun 25, 2025 at 05:35:19PM +0200, Sebastian Andrzej Siewior a écrit :
> On 2025-05-30 07:08:45 [+0200], Christian Brauner wrote:
> > Care to review this, Frederic?
> 
> Frederic, may I summon you?

I can't review the guts and details but it looks like a sane
approach to me. Also the numbers are nice:

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

