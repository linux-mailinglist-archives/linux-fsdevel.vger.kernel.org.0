Return-Path: <linux-fsdevel+bounces-63482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB1CBBDE4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 13:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D3E3B9ED1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 11:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054D02727FD;
	Mon,  6 Oct 2025 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpA9I2lN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256012652B0;
	Mon,  6 Oct 2025 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750737; cv=none; b=IHzKyqbkX8P50sCEIimxacaZOc2Jio6kHnzZ6U97qFnLmHQz4NU+5L6GDBY3k/L3RdekS+cmgacOFrvF7G2v9CIar0+6ann0o9Jx4tN9Svkm8ks4BlEZrFiWMdE7rJaFy8+uNZKOnppU/ju9bwKr2gZt1LzS5y2u2PRlV5E7nxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750737; c=relaxed/simple;
	bh=BQj54SuWzow3A4cUupmYN72ZEMbzW/KGXnzHQtj/5/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0aaE0BpCn9JONTewF5+xObe7x9YKbgaaP/KYS0nhogI8EFAx2p9NIx7Bh/U55H73YvcOfpY2AEUSnuqreLfV3vnxnsw9e5l5fk27fDNFid0y8ETekMt/0rszXrFCE+V+nZL/ZIr7+cRbC3TbT0QP7fW9OTw5PTkCccSPuy58Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpA9I2lN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C168FC4CEF5;
	Mon,  6 Oct 2025 11:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759750736;
	bh=BQj54SuWzow3A4cUupmYN72ZEMbzW/KGXnzHQtj/5/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpA9I2lNG0BgWGyKw3qyntnw8CCChSWltPmAnbK8646ulyoOyfrsnXKA3cyRenq5J
	 bueKrGO+VIY9JLb0JPyrCPxinku9qZW0s5o6rY5XScR/Wd8GX9bk64wSVQjj4biHre
	 LQM4Du2DQDbZgB8YATlPldMdykf6eZyjS99KgfJK5qg/almvHLTu7J5sourozxgWKV
	 R7WBROU5TBHe9Ih/zwDMa6Ok7aGE2lnEToIzj3b7PvbChouP7ya0M//21zZd0Rv7Cy
	 AeuFkQnvCvyIwT3DFN6mz8akA+8nVmJqz5C8wW0G9iwR0NHyrelz4qlyKA8AunMD6J
	 QYKuvuroo44Pg==
Date: Mon, 6 Oct 2025 13:38:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v6 0/4] hide ->i_state behind accessors
Message-ID: <20251006-kernlos-etablieren-25b07b5ea9b3@brauner>
References: <20250923104710.2973493-1-mjguzik@gmail.com>
 <20250929-samstag-unkenntlich-623abeff6085@brauner>
 <CAGudoHFm9_-AuRh52-KRCADQ8suqUMmYUUsg126kmA+N8Ah+6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHFm9_-AuRh52-KRCADQ8suqUMmYUUsg126kmA+N8Ah+6g@mail.gmail.com>

On Mon, Sep 29, 2025 at 02:56:23PM +0200, Mateusz Guzik wrote:
> This was a stripped down version (no lockdep) in hopes of getting into
> 6.18. It also happens to come with some renames.

That was not obvious at all and I didn't read that anywhere in the
commit messages?

Anyway, please resend on top of vfs-6.19.inode where I applied your
other patches! Thank you!

