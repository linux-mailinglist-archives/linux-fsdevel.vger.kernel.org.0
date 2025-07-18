Return-Path: <linux-fsdevel+bounces-55450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79827B0A92B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 19:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E475A1DBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773942E6D00;
	Fri, 18 Jul 2025 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP13R9RG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF21EB5B
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858702; cv=none; b=VEvPQEfIrAI/iuzPhH0/2dmS1jYnZo8nYs/nS7xLKT5z6quuMbivRuMg7bycsRv8m0+pusUDelN/+9XCW2vjOen3dVa2OWE6vPYJlGw883XFVtgwNYT6iKK9aE/C+SJxMwjDwge4voi+a3dKaNeNw0ZGrtcSx9tUOPnAL2czPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858702; c=relaxed/simple;
	bh=8ikPHa6/dQDADxqz6RSJEprrZAbcic+wTUDyhPJ2RwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb3Mw7MQPIYzPJMaLTLNKDkZNVUcorK2r4f712TH6AYdgKbue46G99lm+Hd/lP+7DLlNfcztt89V7FVLrL9UcQczgeuvqgb+CT0ps3ZxGgVt71AWxEgSKX28HYjjZsIC54yBg/wTDAU64HADp3dO7xikT0QmFrYcxAFsP9EV1+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP13R9RG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25791C4CEEB;
	Fri, 18 Jul 2025 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752858702;
	bh=8ikPHa6/dQDADxqz6RSJEprrZAbcic+wTUDyhPJ2RwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HP13R9RGrqlQtvOTMoeZytTqBF1TLTPgcZKC7vfUWUyUivesfx+yMlQjjvJaZVIW7
	 tt2QV4Jkh8EqjPzrULCzswNbQgsv7qv2vjzZJEg55K8NzfcRr4nd6oCOSGLUj0X4Ff
	 jOLyGHoZR5c7yuI6I5DNGtYJqnU9GAY6QBbYZAM/cwwf4DXiqH4Y8QmsD7hx7Kzxt+
	 ZtNdt6Khfl9jx4v1m1ssjwSl33t8YV92e0ApQ7JijuWojNq62Q/+w+ZL1XwhMLxqyz
	 DGrOqYavlRowLlNbFqj8lB+MGSxF4JBorUqLOjBxOR0DFIZYAi4Simjz9EQqrN4WuR
	 ak4aeHy1uiDmQ==
Date: Fri, 18 Jul 2025 10:11:40 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250718171140.GA8845@quark>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <20250718160414.GC1574@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718160414.GC1574@quark>

On Fri, Jul 18, 2025 at 09:04:14AM -0700, Eric Biggers wrote:
> Doing the dereferences to get an offset stored in the inode_operations
> (or fscrypt_operations or fsverity_operations, or maybe even super_block
> which would just need one dereference rather than two?), and then doing
> the pointer arithmetic, would be faster than an indirect call.  It won't
> be all that great either, but it would do.

Correction: due to inode::i_op, it takes just one dereference to get
from inode to inode_operations (as Jan pointed out elsewhere in the
thread).  So that would probably be best.

- Eric

