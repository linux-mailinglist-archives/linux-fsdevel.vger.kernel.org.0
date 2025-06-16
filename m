Return-Path: <linux-fsdevel+bounces-51778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A4EADB44D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 002977AB7E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B9B1FE474;
	Mon, 16 Jun 2025 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+KX6ZI8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E8717A2F7
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084990; cv=none; b=cmy1hssdBU2rWUO3+ezjzlQxCy8UIsilW0hE7mBRBuWHct2K/zA5b7Eh6SNasK3cxMhTXsojKgMkqpbEtVbXiYl8PrN5Vsf5RAYsGDT2lsGOiHwpFFSssOS46kCgsG2LvDfEloBpb9fUmEKiBv3QWMdohcKOoNTjUguV1jwsz1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084990; c=relaxed/simple;
	bh=mtgQrtvQobdtMegeGtuPQR8ADD3Bb1Xgm1U3OdRx8Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZRzFJXP5+sXy5rJbkwpkwxwsyQqkTuf1dbEZJLp20d7GwM8jEUGE/fMMUkJ/YBkaglgpUrpziSHBatGApougO7j16dFTONXMFsY7h7XXVTpk1HRvPwM/1zka7A4LrlIJDEK+TbjSLFo4F+rVEAEb80ahTz+rWQWOXfBXsWFxL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+KX6ZI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F80C4CEEA;
	Mon, 16 Jun 2025 14:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750084990;
	bh=mtgQrtvQobdtMegeGtuPQR8ADD3Bb1Xgm1U3OdRx8Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+KX6ZI8CMC+4RVa4D5wtqvKkoXgbqysqqa4f2ZVrS6yO1Ik9DDENN36HhigUsIrC
	 46j+CfcXgBa7qjq0VFaDFX3jusKqM+/1Ogt1a3+lXh1u7Vh8GClA0+DNuCy181w0aK
	 aOXcp1xS9RJH8mkeBsdvXl0vbevxOntg1WVWdSj4R+32XX+lSReKDDOQpXVWRuYPwf
	 jxtQ4d0ie4hUyvpUVQe52ydlHUBzblyhT9+bAskyEIrjDKgWUs5gefE4RxrFuqKfZM
	 MpvbFhNR2zGsEDQFC57hxpzvpBqEHaUkfmdjJbg5n9XGWKEb6VrriessCOPSLUkNs3
	 ppIsikZ5rsCLw==
Date: Mon, 16 Jun 2025 16:43:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, neil@brown.name, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 4/8] binfmt_misc: switch to locked_recursive_removal()
Message-ID: <20250616-gewidmet-parodie-bbbc15feb741@brauner>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
 <20250614060230.487463-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250614060230.487463-4-viro@zeniv.linux.org.uk>

On Sat, Jun 14, 2025 at 07:02:26AM +0100, Al Viro wrote:
> ... fixing a mount leak, strictly speaking.

Imho all those entries in binfmt_misc should probably just all be
switched to call dont_mount(). Zero reason to support this.

> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

