Return-Path: <linux-fsdevel+bounces-52741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66739AE6203
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6BF1898278
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C526225DB13;
	Tue, 24 Jun 2025 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2h6lwMx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2911526A1BE;
	Tue, 24 Jun 2025 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760168; cv=none; b=R37hhU11CTD28wXBaBI83E8Zwds6gr8WCmPaw/R/r4pg1oY6ohU2xjzYqJp4Z9vN1+NxJAuh0hmkgwDKbKKsd4ZPELxlIWOxPdEvdObKUXceWgCi0l5uWX4s1olm9UcTgwtwXDJ90HlAiaqYTcYQ62e8GqVjkgb6qUHZOozOOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760168; c=relaxed/simple;
	bh=zKIiGXl2esj9JvyCCKs2+nJbW6WmNCFI4NCVjYHnaMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlbrhSa+2sN1VOMA1e1CTSFXl6uS4/7h2+SdKZ6eYx1qEG1gNKZqmbWXvNHwinpyYBXvxCuhmRq4obCytO4JCmNPSu6dFVFEKuIUCzHrSITXwScDOZUD2PmMsKEwtdx1qmtlsiUz0+r/hHKsmdF4abWwsD64bNfXzVH5CqY0QRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2h6lwMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF86C4CEE3;
	Tue, 24 Jun 2025 10:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750760167;
	bh=zKIiGXl2esj9JvyCCKs2+nJbW6WmNCFI4NCVjYHnaMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2h6lwMxbJL1FbjW7LtlSd1ZDKtf2XTDjWCc6nXVWm/s9aNYMQykxI66JNP5ES4uv
	 O9HRR5Nl/HDfGHReXtdFRmDQlQU4kipJUV2UxqK1jqQnXGMNHyG2lVe3H8PG+2i8tb
	 3D43K+E7grgN7ZsX1UjTwURBrMBx9meQaQC+W9qANB+SCSRJUYN1FoBoIEVgQ8vKeW
	 punQkkNx4hL2jkgo6d39RUgBpLTFSrdpMRIkSf5v+R+4in24WdUJiCmTR9Z03vuXWU
	 OffXDLP2rn9IDlab0jxvmaxwXkfMvnh83DctgCbqTe3f7BoBSI0ZiZm3r9NcoeOJii
	 87hOMsiwyG0Og==
Date: Tue, 24 Jun 2025 12:16:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 09/11] fhandle: add EXPORT_OP_AUTONOMOUS_HANDLES marker
Message-ID: <20250624-papier-gehege-e7f6de1b6442@brauner>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-9-d02a04858fe3@kernel.org>
 <2j6ytfedk2bgyuegajumnxtyuqalb7wd52h7jnxtozpvf5fpmz@z4ysz7mhcajq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2j6ytfedk2bgyuegajumnxtyuqalb7wd52h7jnxtozpvf5fpmz@z4ysz7mhcajq>

On Tue, Jun 24, 2025 at 11:20:02AM +0200, Jan Kara wrote:
> On Tue 24-06-25 10:29:12, Christian Brauner wrote:
> > Allow a filesystem to indicate that it supports encoding autonomous file
> > handles that can be decoded without having to pass a filesystem for the
> > filesystem.
> 
> Forgot to mention the above phrase "to pass a filesystem for the
> filesystem" doesn't make sense :) But my reviewed-by holds.

Ah thanks! I'll fix.

