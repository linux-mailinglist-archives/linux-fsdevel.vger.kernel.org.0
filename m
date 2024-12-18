Return-Path: <linux-fsdevel+bounces-37700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F24E9F5E36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 06:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A664B1885BDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 05:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5C1547C8;
	Wed, 18 Dec 2024 05:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+EsTW84"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0321531F0
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 05:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498812; cv=none; b=LsD3CW1hb/5LIvoWwEUTrRKqVDQRL4UCuzzJDk0QQYwjsRgN/f9eiM09tzV5gfRf+woSeuZ6CXFnevT7g7OyrxZH4Sv/mZMPkV/mN1oOir3v4jFzACrOoOjxAnR0nMHKXL8r5E1qW8dOtXVgU2jD5aiINgaN5OVNSDbyXdrQaxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498812; c=relaxed/simple;
	bh=VPTtFnOKIaVkSJH4d+mJXyyCMDm4PV2Y6+2mcEZO76E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZELBqq/FsKw0MKE6oiWWlHY2VF8oU1INnIvcIOILMZ6hvLT2/b82FHj5sHDJo77ggVUOdDD+sasV96Ho6hfJK6H51XJ8YRN/BRsm6o7H1uPaQ259Z0acWLmhVaeFHetXwlLu23ECKaFTWdj5mz1ukLb2sPaXsN9xypxMLAXuLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+EsTW84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4EBC4CED0;
	Wed, 18 Dec 2024 05:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734498812;
	bh=VPTtFnOKIaVkSJH4d+mJXyyCMDm4PV2Y6+2mcEZO76E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+EsTW84x8keIwUTvkRWbYosyLbTo2I6umG0mVCEyDCeegk2KQjQyHtZQ5oRJnCgC
	 yNChtyIr674JyBKPoJLDWldDB/JdJIF8/xB47vAIPHom3J84T5GThkEvHsFZ4Hjypu
	 1VcI5yKbK2uR84tBs9yULm2AzxBuYopTCT5V6Bwp0yFQheF7v6iDaO7wkzApOXScgX
	 tLgEDapvz5RnDH8MTiauHNSr5eqbVgxisHp1FGdWFzpOX5XUyBGrTC0Frrzt4g44FB
	 PkcWEWKdmOeMWtY2aKQvIPl0j1H2btJPIHtSNdxp0QtQ7zDPizKXLPL0j4dcGXfaqG
	 76ewPadvNMJKQ==
Date: Tue, 17 Dec 2024 21:13:29 -0800
From: Kees Cook <kees@kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
	Liam.Howlett@oracle.com, Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 02/13] x86/um: nommu: elf loader for fdpic
Message-ID: <202412172113.21E002F0@keescook>
References: <cover.1733998168.git.thehajime@gmail.com>
 <d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>

On Thu, Dec 12, 2024 at 07:12:09PM +0900, Hajime Tazaki wrote:
> As UML supports CONFIG_MMU=n case, it has to use an alternate ELF
> loader, FDPIC ELF loader.  In this commit, we added necessary
> definitions in the arch, as UML has not been used so far.  It also
> updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.
> 
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>

Acked-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

