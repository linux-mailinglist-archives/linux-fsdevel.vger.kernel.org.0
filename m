Return-Path: <linux-fsdevel+bounces-37200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994AA9EF798
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A83F28DFEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D496223313;
	Thu, 12 Dec 2024 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0ti2l9g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEBA222D67
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024904; cv=none; b=pQmb20lFwBUjT5ryIBqPIcUVEjIAfSVvy0DYZu6gIZ1QKnQA4V1usGZgiQwAMNlC4TDVSsHRtxUIcYpVkqrOB8QYMq3FKchZkwP/kTDeI14ureHwmr2srAa3qE5JWvTUfwdnzVVE+1w0BQbJ9fV/1DT2OzDPp3LM/zF0e76aj+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024904; c=relaxed/simple;
	bh=Wy6qwQTD5jMjw0HYKs6S7D9RHfE/r0n5Z+VUonQxvB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJUnU7utsNdAvf3B+qj+md3mcoNN9C6xXrKSOgKG9cdUbRoeTexMbzOhF2ra0u6IUvG6+CN3YVejX34PKA37oV6IT6bRBHRYYSnCa3yvotPnqcaXlmjjF+Aa23m3S6vneLok8m86soZHhUQ7q2t0tjizc4p17dy1ssfn2VJwBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0ti2l9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5921C4CED0;
	Thu, 12 Dec 2024 17:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734024904;
	bh=Wy6qwQTD5jMjw0HYKs6S7D9RHfE/r0n5Z+VUonQxvB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0ti2l9gfdUWZTNt/egFe8kBTrCQcvY1MNWvN9cgODPXT9q//Y9Lv/rScM85+9zCL
	 ZJRT8PRuXibIzW8oZNW8Fjs62j+oNK27bUr2WaZyAY9d7wtW4dPBLnqRIiVwfUjA77
	 aZVXDzYYKIuSW/pBl+1+5TpFcV6TSdJdrbstArtU6OHsfT3s58JlnhSERE1+addd6c
	 Z7OHCVn67mXHvSY3CsAr8De1srcKuVxoVdg/gSKuGovKht29JRAvWkmY8Pb57EYuoI
	 /+iu8Xtm9cPPjoHrQBS0Gmth6WjD6wEMGkyjU664dLHAkfynUSK6mHOCLa6q3H1IRC
	 7tRbvFzBGnvZQ==
Date: Thu, 12 Dec 2024 18:34:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Ziljstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] fs: lockless mntns rbtree lookup
Message-ID: <20241212-blinken-diavortrag-22c66c644365@brauner>
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
 <20241212-work-mount-rbtree-lockless-v2-3-4fe6cef02534@kernel.org>
 <01b7d0df19957da6d628dbe4390e086c51bf5a12.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01b7d0df19957da6d628dbe4390e086c51bf5a12.camel@kernel.org>

> > +	guard(rcu)();
> > +	do {
> > +		seq = read_seqcount_begin(&mnt_ns_tree_seqcount);
> > +		node = rb_find_rcu(&mnt_ns_id, &mnt_ns_tree, mnt_ns_find);
> > +		if (node)
> > +			break;
> > +	} while (read_seqcount_retry(&mnt_ns_tree_seqcount, seq));
> 
> I don't really get the need for a seqcount here. Typically we use those
> when you could potentially find an object that's in some sort of
> inconsistent state.
> 
> Is that the case here? It seems like you'd either find the object or
> not. It seems like either outcome is OK without the need to retry the
> search?

The sequence count is to detect concurrent changes to the rbtree. As a
change to the rbtree might cause us to miss whole subtrees as it could
be rotated. So it's not about the object but about the rbtree.

