Return-Path: <linux-fsdevel+bounces-21377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72397902FB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 06:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247111F23B49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 04:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8055170843;
	Tue, 11 Jun 2024 04:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bw18CTVz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061EF14290;
	Tue, 11 Jun 2024 04:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718081984; cv=none; b=aIRkw8/LLqrUDyuBXbR7BPmYbdu4e9+9+xqM42QalWSK6r+iP8Og4m5hUzRBlm+7WSQpPZcnOf3CIMNClbH+0MoMxImfc6sbcAlcThat9KcxpCcy7RzwxP01KJ65uVosyI1Buh+3V09WpyYfWvkXWFEP5q8KazKSTYc2VBcVnCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718081984; c=relaxed/simple;
	bh=accUI4Ob47/mGnG38ZHmlsUndsefVIHJj7mN8QZs4oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLL54E9CvVYjQfwe+DCWatZw+YOJs3n2eluSjKKrM78Gf+rGgYtvd9JrYGi+udFhbFyqQ+6cTLjIzK1Q143kGHNiOtB0p2J/tGOOZYntdQffXz9vqQVh6qy/Pf/d/QmEe780cc88UU2TOInR6LgLjO9gjuhLBEtl6cclNLNqYyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bw18CTVz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WNevOOm63bNyWQcozMtSXtp0dk1N2fSRps5B0mWi8Lc=; b=Bw18CTVzsoMhcxtU1jfh7ZMRi2
	Uv0U4JYPI+MweNs1IG28JZ3/oBF5H8hd7n2/x5I5wo3pR5YGAzsEBDxDLLqGw2LBaI7poPBXtF+S6
	1NkopJ/GqEG3vg7qs/sxdp6y5WBwkEMm6N8WO2562gB1RP9LOaKzcG2wjznRKVqSHaks3LMhFyCGK
	JKs3qrqnUueJPxwRwB+bnoYSQO2VQeveQIw28cFtEQIRdWVf0qzCvU5JSq5k8GBO1WXJjkh9J5CSb
	+R/cneH1rywoMnVaUWQb5CDA+JwYkmlO9RjBDbbiARt1rWGtTvkfDZUNyEh/efpe3S+UbQglR6ba4
	iMlzboyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGtbe-00000007OZd-3XLk;
	Tue, 11 Jun 2024 04:59:38 +0000
Date: Mon, 10 Jun 2024 21:59:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH v2 1/2] vfs: add rcu-based find_inode variants for iget
 ops
Message-ID: <ZmfZukP3a2atzQma@infradead.org>
References: <20240610195828.474370-1-mjguzik@gmail.com>
 <20240610195828.474370-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610195828.474370-2-mjguzik@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +EXPORT_SYMBOL(iget5_locked_rcu);

EXPORT_SYMBOL_GPL for rcu APIs.

> +static void __wait_on_freeing_inode(struct inode *inode, bool locked)
>  {
>  	wait_queue_head_t *wq;
>  	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
>  	wq = bit_waitqueue(&inode->i_state, __I_NEW);
>  	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
>  	spin_unlock(&inode->i_lock);
> -	spin_unlock(&inode_hash_lock);
> +	rcu_read_unlock();
> +	if (locked)
> +		spin_unlock(&inode_hash_lock);

The conditional locking here is goign to make sparse rather unhappy.
Please try to find a way to at least annotate it, or maybe find
another way around like, like leaving the schedule in finish_wait
in the callers.

> +extern struct inode *ilookup5_nowait_rcu(struct super_block *sb,
> +		unsigned long hashval, int (*test)(struct inode *, void *),
> +		void *data);

No need for the extern here (or down below).


