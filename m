Return-Path: <linux-fsdevel+bounces-24659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F4594273D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 08:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD42FB22FBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 06:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F601A4B38;
	Wed, 31 Jul 2024 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww2YHjO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5B18A6DE
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409101; cv=none; b=DT3FLLt3Mbh4ORXpuja5yPXa6esz9ZhYGqjh1F1B8FVUbveQkve/L+pqpp974Qjx3eJRsPN6jnYiwQ03um9OrrvxqOK+vOA56BB8Q2P6fg5v0nnW3oqtPC5zfaYHYrbb2nXk4ggAM4CHTiD6yptnkdcY0KLX14NavhT5cnUC6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409101; c=relaxed/simple;
	bh=t02spNC31Vt9gurMV4aexxK3cR7k/HdZaRHCb8UlCAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3cd4BTqo3hEEjhv7ZnejZTvI55eOan0BFTVHcaN19YAB8oYCRFU0cuGXGs3CHhGAIplHrrOttaXgcXxTGtBYUAMUOVIhtXJgzDb1YrJ0gtzZTit2rXvrc1Gx3Aw/xxSpM0mQ5fw+1R0p60LZnGnnJWYZRibS01Xqxjb0lPoiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww2YHjO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE73C4AF0B;
	Wed, 31 Jul 2024 06:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722409100;
	bh=t02spNC31Vt9gurMV4aexxK3cR7k/HdZaRHCb8UlCAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ww2YHjO8ARpSOexzjoj/uuu/g2oTFq/ynFMCx5dTdlZ5tbD77EHxT2DFF/iz3gfyo
	 LY3vbnIuuKLbCfqfFlhjBIT8FIA7tqDnbq618WfKgILUdxBeuT+nY4VoTI8bB0M1Xu
	 oNvcHrxp23VHTe0Ee2ziMp4z5UDao29FKKrOku2OTGjz2mUP+43lv81CpLMB8QTmfw
	 BGAESEVrBwOpr4igrO6hGW6IMk5/RW5r9DtM5bEPEbPN0EPd4MUOK841mk5Ta/xjpt
	 JRM0VfuP3mZ3kRRDpKID1GSH1t217DUQTy7n7OceHnhuWjYkIU727IIgSSvURflHg0
	 AHt2jn1C+mVzA==
Date: Wed, 31 Jul 2024 08:58:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] why do we have lookup_fdget_rcu() and friends?
Message-ID: <20240731-donnerstag-denen-a04c12c6754a@brauner>
References: <20240731065446.GJ5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731065446.GJ5334@ZenIV>

> I might be missing something subtle here; if not, tomorrow morning I'm
> going to throw a patch pushing those rcu_read_lock() in (and killing
> {task_,}lookup_fdget_rcu()) into the rebased fdtable series from the

Ack. Seems fine to me.

