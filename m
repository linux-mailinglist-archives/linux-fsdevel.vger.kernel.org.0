Return-Path: <linux-fsdevel+bounces-3954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24CE7FA59C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 17:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBB528189A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CD7358A0;
	Mon, 27 Nov 2023 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjTVUCOh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AF134562;
	Mon, 27 Nov 2023 16:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865E7C433C7;
	Mon, 27 Nov 2023 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701101136;
	bh=a3dPZOgLadrVfGvUrqvDctf6C+XVyQnBesre8gLOQn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjTVUCOhRq1YVBFYeHLrr2Jf9axuSgEkUD/ORdEM0/EhG0yNIn0NJ+BCAVEV+yoas
	 zDiUAtFI9BC4KKANHXRLt9cY7WgLSLsXbar9kXwnhFOhEBCYgydkccVwsvjz4XaMcE
	 Pbe/wF49wNxevIQi6OzOmTVJzhD/Ypf2bEIC9EB/VA01GzrqfniDBFiFsP4mcwdN1A
	 H5DLodEnswX8z3hj7kmur3JaMg5p+JzNyoAW0CyoS3TBvjTuf8UVoIFoholCe89IGL
	 wB8vJZqrJU0Y8n1ZDzk2jDKYSU49roDnI/emYRLRWSMWSmY0qDWo6zflXjEOhcSkc1
	 J6iER1f7853XA==
Date: Mon, 27 Nov 2023 17:05:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH v10 bpf-next 03/17] bpf: introduce BPF token object
Message-ID: <20231127-anvertrauen-geldhahn-08f009fe1af1@brauner>
References: <20231110034838.1295764-1-andrii@kernel.org>
 <20231110034838.1295764-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231110034838.1295764-4-andrii@kernel.org>

> +	if (path.mnt->mnt_root != path.dentry) {

You want to verify that you can only create tokens from the root of the
bpffs mount. So for

  sudo mount -t bpf bpf /mnt

you want bpf tokens to be creatable from:

  fd = open("/mnt")

or from bind-mounts of the fs root:

  sudo mount --bind /mnt /srv
  fd = open("/srv")

but not from

  sudo mount --bind /mnt/foo /opt
  fd = open("/opt")

But I think your current check allows for that because if you bind-mount
/mnt/foo to /opt then fd = open("/opt")

  path.mnt->mnt_root == foo and path.dentry == foo

I think

path.dentry != path.mnt->mnt_sb->s_root

should give you what you want.

