Return-Path: <linux-fsdevel+bounces-29376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A679790FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 15:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B971C217E8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 13:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE2E1CFEA9;
	Sat, 14 Sep 2024 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzjWpVK1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E343ABD;
	Sat, 14 Sep 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726320589; cv=none; b=paIdI5+/mLWSc/t5DA+xxP1qOs7uUJeWKm+RQMotOh+EHHhQHHunHnki6Uh+my7hz0flTsVLdyWeNQp9ijfaQk3JlPTi6kLl1UX2gDnr1++3P//ntzFYdH9V3Y5ArQG0XU58M+WqAsHRfdMX6au55vCEPyt2w4KNXvqgaYkehLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726320589; c=relaxed/simple;
	bh=ENS4d4cBqvHMS4kIgC6CuenSU8fTI9WWXBs8vM2d6ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfefLIQ5mrzNABtlrgyKiiMmQuvtyvljcKOotcQSlujIHLEalVjyoC7rJ6BxMmK2TzlsHvXhVSy0ohwk5gkFa6HwKxyIjWH9uab3+RcA2UC/MHI9tkmvrxgg5dcRRWOBw508iNeHzgn/AeNbvnfTNJ+mcFWFB+ESgDXNlnbOwG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzjWpVK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F4AC4CEC0;
	Sat, 14 Sep 2024 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726320588;
	bh=ENS4d4cBqvHMS4kIgC6CuenSU8fTI9WWXBs8vM2d6ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzjWpVK1yXxkliKL/M5G51lind0Oepjslbqrkk0BjXrSelRw7+TSziaqII9maQF9l
	 hHvFMrPYOlXSd2bn4Ky9urZO5ayqTCwUJ9wQc7A+jf6N5jZd7EjviT59+sD+JOHsIx
	 cisM+srUui55e8ei+XYZhG48/aITB4P0IFJynHw8z9JYJVDnUgufZFYDS0bphb8SZg
	 yxgO9MfOGBpbV+Zjdq//HgjWHGURnTfGTM+/VFzaR6JLUqiGej+N48guCq2itdejCV
	 tZAGkgRoxIc3cCfa1mzBrXOlZZ2sgJGHcmmyjTCmHp+88ZkOgF3ehb/NUFxxc6iITN
	 8MK88dvLNUnHQ==
Date: Sat, 14 Sep 2024 15:29:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 00/11] fs: multigrain timestamp redux
Message-ID: <20240914-umfang-kojen-e9bf965393bd@brauner>
References: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>

On Fri, Sep 13, 2024 at 09:54:09AM GMT, Jeff Layton wrote:
> Once more into the breach, dear friends!

I think this will have to be the v6.13 breach. :/

