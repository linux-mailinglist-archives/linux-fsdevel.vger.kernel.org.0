Return-Path: <linux-fsdevel+bounces-23737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F42893214F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 09:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705421C2199A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22023CF51;
	Tue, 16 Jul 2024 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEQi10vB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE07224D4;
	Tue, 16 Jul 2024 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721115450; cv=none; b=srNkX6lVZ/yW529soNU/zFzEqv5qYKdgPtq29a0Er4c5qC1ars/UG9GjFUqLMSkyDEb0i0ydD2oaape2meXcW/wJ2trgw4WJ+HYG03Zg6hOwt8QswhvBqSlGIknuTH713xkxxdukT7NZscBpcp0pQ29nLFt2joIhAxbGox6Jws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721115450; c=relaxed/simple;
	bh=JO3qgQV4sy0U2AaNeNeVdHcFGwZZ9gH4KsehfrW9qEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEBaMWA/vPoyv7KCkJHlyFPvPGOQmGJvGvnPfWyQVAQycOoLResNc7ALAxc6USkTVrULmQQfHY/Kb7tc3OYJ8IKCPOew6zWylwMzEWAeZId1X4n0/2bW72i8ydMsHpKxAS6Ai38fugkxeIKrA6C2DCt4t1OY5P2dRRvRTKs05KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEQi10vB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AD8C116B1;
	Tue, 16 Jul 2024 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721115449;
	bh=JO3qgQV4sy0U2AaNeNeVdHcFGwZZ9gH4KsehfrW9qEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEQi10vBr2zTt+8+q5Ijrg1zn14enr23N3t5Mf+Q3ATK9FrfwUmwEv56VRw9Kckim
	 n4y41pPCHpgM4PnaReJbhjOJEVf0LJb9qQVWL92truLKYQ3hcDUaEpqxZyHqhO9sWd
	 eZmbvlpev0t+zz5ob76vCO5il2QAEvnnGlYgA4SwL+RCuIgz86JRtUJCijofa8Ul6T
	 Wxx8XUEI3j2AY72qRNZ3dB05A3G0RZ4eoIf61KtN/LENtNSG7mjzbfddZBZhMJ1Qf3
	 kZt4tlF88NMZbRNhCeDzOk1CHtFNZw9xVR6pUTaOUpJ57izYQ3KxxofTtLXAsLfnEn
	 oLRLkdByOqrGQ==
Date: Tue, 16 Jul 2024 09:37:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Chandan Babu R <chandan.babu@oracle.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>, 
	Christoph Hellwig <hch@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 0/9] fs: multigrain timestamp redux
Message-ID: <20240716-zerlegen-haudegen-ba86a22f4322@brauner>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>

On Mon, Jul 15, 2024 at 08:48:51AM GMT, Jeff Layton wrote:
> I think this is pretty much ready for linux-next now. Since the latest
> changes are pretty minimal, I've left the Reviewed-by's intact. It would
> be nice to have acks or reviews from maintainers for ext4 and tmpfs too.
> 
> I did try to plumb this into bcachefs too, but the way it handles
> timestamps makes that pretty difficult. It keeps the active copies in an
> internal representation of the on-disk inode and periodically copies
> them to struct inode. This is backward from the way most blockdev
> filesystems do this.
> 
> Christian, would you be willing to pick these up  with an eye toward
> v6.12 after the merge window settles?

Yup. About to queue it up. I'll try to find some time to go through it
so I might have some replies later but that shouldn't hold up linux-next
at all.

