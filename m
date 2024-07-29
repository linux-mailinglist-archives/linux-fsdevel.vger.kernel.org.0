Return-Path: <linux-fsdevel+bounces-24419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FABF93F352
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 12:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44DE1C21F17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 10:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80C2145340;
	Mon, 29 Jul 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REvGOu+1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAAD28399;
	Mon, 29 Jul 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250620; cv=none; b=rRhpnhhFnabcnvEGnRbQH+KETYoSv8YHg6Je8XLohUKoteYJdHdBaUDrAHlWqhHp5Zwj1ceIqfmZmAwCGqeN1GhHMVUkhi/Jt82NETd8VeLwEeqfVcmR0flvJ4mA8cu+4O2IDhQV4oasHOvm+TCNh9MQ+EjNsWjNjYpTLAS8E9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250620; c=relaxed/simple;
	bh=sTLrMb+etcNwOXXHJCJVEq2VhI3nqdl0hwkFTsoLOHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXvMl67izfUEiI3EZto6xCxtNrIn0r7QdQT+hUCceyE2WWyBk+++w4TuJakrdfXPRbgpW0bHmBXDgJx9ax8ByPclDles8IlFgkqDyyp2QHdR3A5mljWgurzxYrtZN6wzJD6IisUMsEOdFGBhkmGiRKc9P21h7ULJoNp/vaeYwjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REvGOu+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7557DC32786;
	Mon, 29 Jul 2024 10:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722250620;
	bh=sTLrMb+etcNwOXXHJCJVEq2VhI3nqdl0hwkFTsoLOHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=REvGOu+1SGl7rEF5VBeNHzzfqJlF1VKD+M4u18vs+Qv8CB+aNHkVHwOeqVZAt1weH
	 RuhQfFn9p4FlCx3cMjazJJA73cHI1HDTAAa71u2zX229w81miSw8Ldy2SItXXfLWmn
	 8XL1wS8dx2+7zBwwXvDTYn0gPdpgAsj86BSXCG0nxEe5Q4811dj0qckaERJRJnDCP7
	 mSko60V5twIXHk2d8FIiEFRqACIHBTeEJVmxFfSRdqktCAED4HZewTHtMZW0RRzBOG
	 4mBFwVYQLa3N9WUt7zah4bQm/lk0eu2iNJwXTZtQfTPUekHISiFshPgnuRA/SvhQi6
	 LWb8wjUYP4HAw==
Date: Mon, 29 Jul 2024 12:56:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	kpsingh@kernel.org, andrii@kernel.org, jannh@google.com, 
	linux-fsdevel@vger.kernel.org, jolsa@kernel.org, daniel@iogearbox.net, memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
Message-ID: <20240729-haselnuss-meerrettich-accf4d27ee9f@brauner>
References: <20240726085604.2369469-1-mattbobrowski@google.com>
 <20240726085604.2369469-2-mattbobrowski@google.com>
 <CAPhsuW7fOvLM+LUf11+iYQH1vAiC0wUonXhq3ewrEvb40eYMdQ@mail.gmail.com>
 <ZqQZ7EBooVcv0_hm@google.com>
 <CAPhsuW4i_+xoWXKcPvmUidNBuN7f1rLzfvn7uCSpyk9bbZb67A@mail.gmail.com>
 <ZqaqKc1fCLPTOxim@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqaqKc1fCLPTOxim@google.com>

> think it's OK, but I'd also like someone like Christian to confirm
> that d_path() can't actually end up sleeping. Glancing over it, I

We annotated ->d_dname() as non-sleepable in locking.rst so even
->d_dname() shouldn't and curently doesn't sleep. There's a few
codepaths that end up calling d_path() under spinlocks but none of them
should end up calling anything related to ->d_name() and so wouldn't be
affected even if it did sleep.

