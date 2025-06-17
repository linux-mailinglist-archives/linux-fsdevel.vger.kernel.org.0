Return-Path: <linux-fsdevel+bounces-51979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD94ADDE47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 23:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E8F167F1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 21:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C066291873;
	Tue, 17 Jun 2025 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uafN8n/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B92F5302;
	Tue, 17 Jun 2025 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750197238; cv=none; b=Ke6Er8B0TVBDMqpyiPyWd/bCfZAsWVEF6mP1SbW8RF1OsqpeE6rc2Cfieqcc8wL8MeQxH914ai10LIQVRoYAoVeQFQKiS/vlqskB0CellxWohaCAP3X4h0YuHUuUpE+Ouro3xM5dEIwrKwYwP1VjDPgb/WShEyEwl5AhvOqy8Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750197238; c=relaxed/simple;
	bh=PtLj67abZ/KpL9Q3IuYBJ2w7BRwkhJvJp6IyhNrFUDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA/dgWudTKwF6jWy6n4AJYHbIrYCIOGT5N1QmGYsJDExZpkUVlOtnCQUlF7IsPXOQ5Itx6uyQFv7uuiDEZOnqROAXldMLj55FQ3p29z63ijgFoG9Ebndzc/AekDW1iEwn5ideK1/0ba4ZzLkWBNAoCdqZb7R4E2mjuyxGBAsJV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uafN8n/s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=X9nuhrnuhTJv89xV+YDRP7ivaD79L39PJPrFNaVU358=; b=uafN8n/sx5ZNoR23yFmryBANkf
	vUqhQCF/ySFd4A8Kk033nLTALmJVSKaG4FhWxEgvbKyGoYPCl0hfq4ZPrGt1ifbnS68J+vI36/fEw
	ACNYIjn5zQaFLx+WN/L9e61l8tM+a5J2HXr349dh/MRpE5LvvdwVt5oid5ZkFeCtHVRy6kQh2ySg3
	U5GuItB9sWJncIdj7fsevcy8nTnRhO/rUSNfrihnWEKNxzvhxIKwMG6gVByftBcYez65Ij0cmEfWh
	JRjooHrMc+befh2a0DmatA17FLxKHXiJpiUHPGHCfkUlttuLnL5RHfGAh2z6yV562I8sExabpTUK4
	h/RZ55AA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uReFd-00000001L6l-3jKq;
	Tue, 17 Jun 2025 21:53:54 +0000
Date: Tue, 17 Jun 2025 22:53:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [bpf_iter] get rid of redundant 3rd argument of
 prepare_seq_file()
Message-ID: <20250617215353.GL1880847@ZenIV>
References: <20250615003011.GD1880847@ZenIV>
 <20250615003110.GA3011112@ZenIV>
 <20250615003216.GB3011112@ZenIV>
 <20250615003321.GC3011112@ZenIV>
 <20250615003507.GD3011112@ZenIV>
 <20250615004719.GE3011112@ZenIV>
 <CAADnVQLB3viNyMzndwZbfZrpwLNAMcVE+ffwWPqEt5YVa3QaVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLB3viNyMzndwZbfZrpwLNAMcVE+ffwWPqEt5YVa3QaVA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 17, 2025 at 10:31:37AM -0700, Alexei Starovoitov wrote:
> On Sat, Jun 14, 2025 at 5:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > [don't really care which tree that goes through; right now it's
> > in viro/vfs.git #work.misc, but if somebody prefers to grab it
> > through a different tree, just say so]
> > always equal to __get_seq_info(2nd argument)
> 
> We'll take it through bpf-next,
> but it needs a proper commit log that explains the motivation.
> Just to clean up the code a bit ?
> or something else?

Umm...  It had been sitting around for a couple of years, but IIRC
that was from doing data flow analysis for bpf_iter_seq_info.
I really don't remember details of that code audit, so just chalk
it up to cleaning the code up a bit.

