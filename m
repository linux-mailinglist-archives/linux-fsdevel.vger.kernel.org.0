Return-Path: <linux-fsdevel+bounces-8604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03D18393CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972321F2333C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9276D61693;
	Tue, 23 Jan 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLZVDT65"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C8A61687;
	Tue, 23 Jan 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025071; cv=none; b=fY4jX140oEIr3AMqV+lkjHAPI2Sk5pRtvbo0RPHKlTR3nDBzUIX10DEzT20atmXsj7niTyO0x4Rr7U2mD12AE+pjRUgbxbRQvSw06SLa7mRPZvAIrJ7wQ/5+QD7rKm+aWHdAfkMRsRErl+yUs1FPfCzghat32/SrcFEBaFJBnXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025071; c=relaxed/simple;
	bh=XXx9e4K37pdWEE29adZQx1vy3J4iGIQ/NGfGGmqTeB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INanB53139M238mchA5wyvZUl18gB2DOG/MWeeKNkvDkEK1QMZkIGO7n0W4fGJy1E9S66k997utPUYGE4FMiCGUP8SJW4YMY1DXJ+JiTsB0PWFAa8chfR8pCeZlFHPOJ75b+qaLL6EfZMeRuBs6D1GoVwSuzHGxk/EnkOxftI6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLZVDT65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5964AC433C7;
	Tue, 23 Jan 2024 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706025070;
	bh=XXx9e4K37pdWEE29adZQx1vy3J4iGIQ/NGfGGmqTeB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLZVDT65D05wxBur4ieShBGEu9xhD2T+GSpjY3ZpgqMbPEkQZ6DQw7EPqQNKfeBhG
	 y3lomSxVJFt7A8Vh4ICGkY2k0jYJu5MzvFdq7C2/3OlRM2OLGf8hjTt56pwcPrqb7m
	 qMBFueqTIl3Dg13Fq74DVpGUfo27SRAOOyOftnPQy1MzfwwxmrtL3mv0Cekyl57VUY
	 Be32J5awE48Nf8hHKPmD8oQz0+Q7B2dMjCVTqQkqK3QuNnM1BbnTgunltZNzZFuxFx
	 ydJ2veIItd6CVVnyHKBCgN7SV+lbkgLAqADt59cGHNc7ENy/7jAhy6YLArbNNeBCv2
	 0OzbBKWrU868g==
Date: Tue, 23 Jan 2024 16:51:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: jlayton@redhat.com, amir73il@gmail.com, trondmy@hammerspace.com, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 0/2] fix the fallback implementation of get_name
Message-ID: <20240123-portfolio-heuschnupfen-c5f2c7aac9cc@brauner>
References: <170575895658.22911.11462120546862746092.stgit@klimt.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170575895658.22911.11462120546862746092.stgit@klimt.1015granger.net>

On Sat, Jan 20, 2024 at 08:57:40AM -0500, Chuck Lever wrote:
> Last call.
> 
> Topic branch for fs/exportfs:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> branch: exportfs-next

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

