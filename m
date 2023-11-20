Return-Path: <linux-fsdevel+bounces-3217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D737B7F17C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 16:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A5B7B21985
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 15:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8F51DA50;
	Mon, 20 Nov 2023 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppz0eHQc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D373D1C299
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 15:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD520C433C7;
	Mon, 20 Nov 2023 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700495326;
	bh=nex+fKzH0+qHrxuqRWP3dqS+SUCPkXpmGhtV0jmVuQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppz0eHQc0ZY9uvj6KWerIA4dvRbY5XMkC6FENWNKzECfONigUUfPZDNl/FRvB9pcs
	 eFjNOg5osyEYLhcD4TyYKeUoYBlZlww3Scct2B8nTFLXSDP55/9ukZmQ0YH27DRXV7
	 9LJFwZ2BAcDsFVl19l293HZ6MtoIw4ukJrYXnUZVjVYssiCV1ctAKBwP9t0FqxM//k
	 6Xy+TA+70DUyd8vSM4pqOWNqNkzJt/gE0dmy80y3UwWH2XTsSS7IP7RMlzZN5mavQa
	 duko9TwoZmHuSmlviL8kbz73A3V/aL7tx6pPZEPsZA2cTPrwqmEVs+rPYEvSqyQ5Te
	 msk+GixJM0OwQ==
Date: Mon, 20 Nov 2023 16:48:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fanotify: allow "weak" fsid when watching a single
 filesystem
Message-ID: <20231120-langsam-eindecken-2cc8ba9954b6@brauner>
References: <20231118183018.2069899-1-amir73il@gmail.com>
 <20231118183018.2069899-3-amir73il@gmail.com>
 <CAOQ4uxjLVNqij3GUYrzo1ePyruPQO1S+L62kuMJCTeAVjVvm5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjLVNqij3GUYrzo1ePyruPQO1S+L62kuMJCTeAVjVvm5w@mail.gmail.com>

> OOPS, missed fsnotify_put_mark(mark);
> better add a goto target out_put_mark as this is the second case now.

I want to point out that going forward we should be able to make use of
scoped cleanup macros. Please see include/linux/cleanup.h. I think we
should start making liberal use of this. I know that Peter Ziljstra is
already doing so for kernel/sched/.

