Return-Path: <linux-fsdevel+bounces-25510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 177E594CF8D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 13:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DF71F22A7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 11:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDDE193082;
	Fri,  9 Aug 2024 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtDeL9Ji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C12A17BBF;
	Fri,  9 Aug 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204288; cv=none; b=Gf7TAvo3ychgBkvR3MK3azemJej/pW0vyFuVeR85Hv99Avdt9287FI1cqq2nhwpRgEDkpP/GqpULQgEyNjfyK3/wL9+SKFG0J+q+Ry7jnkk9viEpkamVm1w5fO/vY63Laf48aYvKubZkQRiLUcl+YdWK5n77RVNFq8PrjPGC9j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204288; c=relaxed/simple;
	bh=I/TLY5OjRjrlIkJdZEkNrfGBOgeXgIW9KRKx0xrGKS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKjm6ZDv0JvgmHR3vdmPNwMlEuZir8aBH5NBhT1eWQ14lAGFC27DNiOALtDhOMMkcveP2KeNZVHRAQPA7hJepIe4zn2hZ8LjuxPagajcfHCo5GS7mx/HnHGl/myuuGx8bcxb/Uq7UgjmRjXtfzL18ClaviZwBoBOJZM56B+A20s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtDeL9Ji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BC2C32782;
	Fri,  9 Aug 2024 11:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723204287;
	bh=I/TLY5OjRjrlIkJdZEkNrfGBOgeXgIW9KRKx0xrGKS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtDeL9JiIjYNsLkYSga2YShs7M5K/Ed8GCDP9aKRNSH2+uKtZHClVYaKx0d48eomi
	 30UhWY+NFDdRXzMvtDie7H5M04rbIrOQ0cHKzBU1DT7vzEfU4BlKdCMei2ZnKq6uPn
	 f7ul9Y3Mj/VLXqT06K3KlNORd8tVt6r6703AU0j0iKGRM6UKPB8K7p/OfJ7FHX5uXe
	 InbxmQBXH/4/G9/nkbX3GjRV9o5LwUrvcSpIhTHT6sfYuBHvY5YBq+dfJbZaxXGYXi
	 4l//chX2H6V1QbMwdu+LZ3bGP70JDTgWRRyDVBwrikWF4G2OWe0xRsOkJVvSC5LUmJ
	 HTBOa6thj+1Hw==
Date: Fri, 9 Aug 2024 13:51:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 03/16] fsnotify: generate pre-content permission event
 on open
Message-ID: <20240809-vielzahl-bereuen-0f629c776e2e@brauner>
References: <cover.1723144881.git.josef@toxicpanda.com>
 <b44f4cc462c7ef6bac3ace31686dc96fac408dd9.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b44f4cc462c7ef6bac3ace31686dc96fac408dd9.1723144881.git.josef@toxicpanda.com>

On Thu, Aug 08, 2024 at 03:27:05PM GMT, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on open depending on
> file open mode.  The pre-content event will be generated in addition to
> FS_OPEN_PERM, but without sb_writers held and after file was truncated
> in case file was opened with O_CREAT and/or O_TRUNC.
> 
> The event will have a range info of (0..0) to provide an opportunity
> to fill entire file content on open.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

More magic hooks in that code...

Reviewed-by: Christian Brauner <brauner@kernel.org>

