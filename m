Return-Path: <linux-fsdevel+bounces-28772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C1196E1A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 20:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDBC28BBB0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 18:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83704183CD6;
	Thu,  5 Sep 2024 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgwqGNo7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96971C2E;
	Thu,  5 Sep 2024 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559805; cv=none; b=tn9YC28/gCWjKhU7wCdeVx09se2njBihJHOwqxoPuPP+PZQnKNHsHlOQ/1USS/3KSSpONZm6O4rQmfYbhZ1QT+oe6zO9FrErNIxD2n1BixBbweDWhSduk5QwLAYzAC2ml3xsvP1aLEeAt6sshxwtmkiqDbrpKxutzJVF2PbTwB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559805; c=relaxed/simple;
	bh=u8nKmNx9UeqvI8DbS4RLTw4lZnLX0PsOy6Bt6p6ccYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1hH+VxfATQwLn+WVocz+lSRzrhAILElvvNCyLh+lMiKliXuLsmsH1uqtS+VhPP02rB8ThZfzhRIR2hnsV0Q2Ff7TiVzSwXcwxQJZuz/Fhs/Ey0obEobruqFxJl8sgEGfjlykjr+gRoiU4Mhd0kiXjZ2jhk9V+5PgY+aABhx+dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgwqGNo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582FEC4CEC3;
	Thu,  5 Sep 2024 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725559804;
	bh=u8nKmNx9UeqvI8DbS4RLTw4lZnLX0PsOy6Bt6p6ccYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PgwqGNo7dnG3LvlwzFk49NWeQQCsRqr7SELJibe4/uwfHd5iepMZJDgY4FiHE346D
	 IgDoqYXlOVCRlzwoZc59YYOU7bK0ocD1LkoeKD1LUvPgTbZ4bdVhu2YVzpwMASSU4U
	 xaHnYIGXlpFwIF3kGYc+ptaf5/4V6DTybqU01rnHiwWR8hbAYb6NOTp4t81mK5m+ZJ
	 xxWANAYCMp9s11UzMI3Fz8C1/V1zzb/oTOG/dAbL3eJnoV6MMtOHxYvMoW5nxR446A
	 ilVxN5c4pHZ9D5vkW1FOWszReiGw5tojue9KaVMGwvVIE6Zy4hAcT7VXt7rtvgyYAZ
	 gajtaLAeoO9XA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Tom Haynes <loghyr@gmail.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/11] nfsd: implement the "delstid" draft
Date: Thu,  5 Sep 2024 14:09:43 -0400
Message-ID: <172555970052.5799.3415374189768431807.b4-ty@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 05 Sep 2024 08:41:44 -0400, Jeff Layton wrote:                                              
> Sorry this has taken me a bit to re-post. I've been working on some
> pynfs testcases for CB_GETATTR, and have found more bugs in our
> implementation.
> 
> This repost is based on top of Chuck's nfsd-next branch. The first two
> patches fix a couple of different bugs in how we handle the change attr.
> 
> [...]                                                                        

Dropped 9/11, applied the rest to nfsd-next for v6.12, thanks!                                                                

[01/11] nfsd: fix initial getattr on write delegation
        commit: 51158790589f1ed3a98f2d590b071ea76bd0b19d
[02/11] nfsd: drop the ncf_cb_bmap field
        commit: 95cc4b27389630394dd42a5d7e12dfc92e82e49d
[03/11] nfsd: don't request change attr in CB_GETATTR once file is modified
        commit: 4374695a6b0ffdce0c9dce1d7833f87d5cc622b4
[04/11] nfsd: drop the nfsd4_fattr_args "size" field
        commit: 6cb6bcdbdf416ad24dcf430f8b88d7c38810efc2
[05/11] nfsd: have nfsd4_deleg_getattr_conflict pass back write deleg pointer
        commit: eecc86f5e5390c64e5f85241b8872f081dd7c520
[06/11] nfs_common: make include/linux/nfs4.h include generated nfs4.h
        commit: 4443c4f509e74bb91e059123eb8b42ad6fd666fd
[07/11] nfsd: add support for FATTR4_OPEN_ARGUMENTS
        commit: 9d0b846784f084479c5beeb61458f0d38ac16f1e
[08/11] nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
        commit: 91556251507771f943c2f04b2ffbf517908bbb48
[09/11] fs: handle delegated timestamps in setattr_copy_mgtime
        (no commit info)
[10/11] nfsd: add support for delegated timestamps
        commit: 921347aabef19b4df68d25d4327091b4a0554bac
[11/11] nfsd: handle delegated timestamps in SETATTR
        commit: 8dd7cf087ba772634cba60ab922febae0b756271                                                                      

--                                                                              
Chuck Lever


