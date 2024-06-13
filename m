Return-Path: <linux-fsdevel+bounces-21638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54039906B8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 13:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3EE1F22D61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 11:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B97F1442F4;
	Thu, 13 Jun 2024 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrzOmoJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107E143887;
	Thu, 13 Jun 2024 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278885; cv=none; b=RIotXltDVVtnurkWJkZEmTHBSWVrGhvPUqGmgFiaarKOwseIRWjgfo9iwd9drpQIRQEhgvmofcOsSQuiZBN6syNwAUCoUYCu+jvjThh4mdSG1iTmsc+2Kgc4GbqLRDjmZfD73ksBUg7Qhci9HUi7CW0QVU1wOyCk5YWeQExK+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278885; c=relaxed/simple;
	bh=U9ZizVspjrmeqbp//XquzwtYOP7wSDEfPDpI1joYw7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyqPa8UBNK1zUhwUtOsHYwLZu0beFRTa0WEuIhGBEuKEu3gvzIejHGx6Hkpcu3EldW+fzOFJCJoOV8iMssA9Hv6XMYaz1xms8YWc53i4/TSa/EbeHpn4n+y8QwQHW4VaU/ROTb19MmIRXcmZew1K9Vd5nhR9iCQrTGPBEDxEORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrzOmoJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD8AC32786;
	Thu, 13 Jun 2024 11:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718278885;
	bh=U9ZizVspjrmeqbp//XquzwtYOP7wSDEfPDpI1joYw7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BrzOmoJt2bHwHgtbroyTbIOgl3Y8m4N8mgClsXZkYSMxVEP3DJRm5S7e0cTxj1vqF
	 mzJe2dDiR8b5evIKpDxeYAlTqGZqiBMp1ws7Sg/oavroh6APJzEC+kMc0FwFQjLQea
	 oIpjtEIYG3JjgrAw6SWVjhOs2yY4mBaXtTClHGdnCXEZpLunesuA6/G7sKplbDt3tJ
	 mlLs6VgjQ8x7vIFpjlj6evpqgiG+xPQtgaq6ARJ61KNosi1W3DYxUDvrFoUkbuPmEn
	 XflzqGrMNm6i9Nqiw74x7v0zUu9RkHbkr94zlXeLhQ9AxQPbH2pgV66WZg4vmFdHwT
	 cg7iPT7qvINww==
Date: Thu, 13 Jun 2024 13:41:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	kent.overstreet@linux.dev, linux-xfs@vger.kernel.org, david@fromorbit.com
Subject: Re: [PATCH v2 2/4] vfs: partially sanitize i_state zeroing on inode
 creation
Message-ID: <20240613-frieden-datteln-afe55df1359b@brauner>
References: <20240611120626.513952-1-mjguzik@gmail.com>
 <20240611120626.513952-3-mjguzik@gmail.com>
 <20240612092703.u5ialfzz74pfnafk@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240612092703.u5ialfzz74pfnafk@quack3>

> This would be more logical above where inode content is initialized (and
> less errorprone just in case security_inode_alloc() grows dependency on
> i_state value) - like just after:
> 
> 	inode->i_flags = 0;

Fixed that in-tree. Thanks!

