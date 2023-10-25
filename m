Return-Path: <linux-fsdevel+bounces-1161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB957D6CFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A694281994
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 13:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB2227ECE;
	Wed, 25 Oct 2023 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOgBGR4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AA61380
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 13:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4054FC433C7;
	Wed, 25 Oct 2023 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698240070;
	bh=8vLhBvr2tVHxadSC5x/WT5qol0TJXzRMDHQHjQ5cVuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KOgBGR4KpD3Abqqwbcjo9AnIHXu2miqEGYhGfAQg17E+gDgrDrGl6bASRKclArwJl
	 EoVpvVyVO//+DgyOWSYJhrU9o4U6g3MabVtNGDfxrU+1MDiZMVnQqikEstoQKXDfMm
	 dfO2LVlvVxWoCIsQwsOWi6ttaoLoJ8o8DpCpVpPaos2GG0GBlMPUmf1xFmcEMng+Ns
	 7QHyWdaAB3Y3TEW5kzKPyC5sWZEZHGDVUFUSP8w7PkuVnLbcapj5SITD+QfVKJnhHe
	 mkGblXtkSvkK5RUmuek2KkN8MWhG6ou0+T4hMttJJkCBTnJW+RtVyr8tSDSGczWCW6
	 U2P26UVYJi8AA==
Date: Wed, 25 Oct 2023 15:21:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] fs: massage locking helpers
Message-ID: <20231025-ungnade-betanken-29f7b98d0265@brauner>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
 <20231024-vfs-super-freeze-v2-1-599c19f4faac@kernel.org>
 <20231025123449.sek6wu5aafztfcwy@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025123449.sek6wu5aafztfcwy@quack3>

> Here if locked == true but say !(sb->s_flags & SB_ACTIVE), we fail to
> unlock the superblock now AFAICT.

Yeah, I've already fixed that up in-tree. I realized this because I've
fixed it correctly in the last patch.

> And here if you really mean it with some kind of clean bail out, we should
> somehow get rid of the s_active reference we have. But exactly because of
> that getting super_lock_excl() failure here would be really weird...
> 
> Otherwise the patch looks good.

With the above fix folded in can I take your Ack?

