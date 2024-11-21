Return-Path: <linux-fsdevel+bounces-35404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C8D9D4A7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A11D282ED4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 10:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DC71CD20B;
	Thu, 21 Nov 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6D6U00/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6C1146D7F;
	Thu, 21 Nov 2024 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732183756; cv=none; b=NxWFlcyCGjlBzLxnBPljYsfZUGL0I4/lpM+jqP68mRGZMbc+6s1hxlifk0TCyguLiJ2P4lmr9XWdzFOuNbQTHbsrnAo4ZxY3lquaCly55kX1/OvqXNcmvr1weqtjPDfB7KSkSnQGTpn8aDRk9CVsg0+4lK3fuLpy39sY2XvSqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732183756; c=relaxed/simple;
	bh=1mgyLwuEWgM7IkL9LOzZSE9vNyll+TTDQVIGefuketk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZoAgUVjmHP+Asb+m5nh7U0J5bJad0XLOOX+wt9qj5S5ATPft4tIFnFRCuhqxImAYI4T/Fss8/IHrywezgqrMuj6HlEBuVKwA9rKAr0/m6LW9HCpYcBDvbNMd0cW9nqZulkjRD5YFQNuKnKxDHCLbjJVVynkhY0AkvxfZ+c2lME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6D6U00/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C73C4CECC;
	Thu, 21 Nov 2024 10:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732183755;
	bh=1mgyLwuEWgM7IkL9LOzZSE9vNyll+TTDQVIGefuketk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6D6U00/BcdKO8qTkj4TTysr0/sF/2AYfHCq4BiYuB3xVTdO8RbJzqS6jdwHw+KQ1
	 HvtFXHGOZ+Cb3s43eJt1Tppyn5mCgomLVY0EqeSIT2oHGVmkXu6FxTggcePoid7L+z
	 m1TZE0Nxo2W3H6wpqoiKtel0VHFglzKU8hdsu1IR40V/8pSQoApQYwTkBdaSTaHazk
	 AiVW5p5TYFZzLM4JjJMeaZmyXLICh/NiSOecyDv+g/+OI01hOMStN3bZ4Qu6m8vAby
	 X52EHp9YWUDFhiD/AEmgAxZduzkTM7U1fiOzztOS1cRWHzc8B4bqYamSMZgGNL70hh
	 mxBFxyxluomaA==
Date: Thu, 21 Nov 2024 11:09:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 02/19] fsnotify: opt-in for permission events at file
 open time
Message-ID: <20241121-satirisch-siehst-5cdabde2ff67@brauner>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <5ea5f8e283d1edb55aa79c35187bfe344056af14.1731684329.git.josef@toxicpanda.com>
 <20241120155309.lecjqqhohgcgyrkf@quack3>
 <CAOQ4uxgjOZN_=BM3DuLLZ8Vzdh-q7NYKhMnF0p_NveYd=e7vdA@mail.gmail.com>
 <20241121093918.d2ml5lrfcqwknffb@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241121093918.d2ml5lrfcqwknffb@quack3>

> It is not that I object to "two bit constants". FMODE_FSNOTIFY_MASK is a
> two-bit constant and a good one. But the name clearly suggests it is not a
> single bit constant. When you have all FMODE_FOO and FMODE_BAR things
> single bit except for FMODE_BAZ which is multi-bit, then this is IMHO a
> recipe for problems and I rather prefer explicitely spelling the
> combination out as FMODE_NONOTIFY | FMODE_NONOTIFY_PERM in the few places
> that need this instead of hiding it behind some other name.

Very much agreed!

