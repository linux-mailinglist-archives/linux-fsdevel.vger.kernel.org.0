Return-Path: <linux-fsdevel+bounces-27583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2BB9628CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE13D1C2173E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE138187857;
	Wed, 28 Aug 2024 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izPSZ7ol"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424A1D554;
	Wed, 28 Aug 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852241; cv=none; b=fmVF2OMeboeRF2W1VJMxoedLsTxL7o0NarG7B3Njrvu20wOc7AEG54as3JXdoPXjf8Cp59JCp0SY6FPQiM9xKsCyznP+Ko6L60HuOaH0xzxxi6qCUqkF5s9+dASGOCEcEhlSkoLapcpPBaWWgIkHsLhZz50YLsP0H8uJLEV4WIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852241; c=relaxed/simple;
	bh=Nwfs3yfaGGyfcG5dJ5lnEqC4M+ztIXz0KzLCPLezTec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ5A0a/oXGcbC5rJ/qZFZXEOhTKDGM6ZJw8W3H+vfIqb7yzesCiUwvFBg7Y+OkLbT6D9gD0pUIva8FNekinC2MsqESxy7vTAWlDE/XyLuKwbGornLXFhZvIi6eyqsAmv0hUKpvCAthngtG6VS/GQ6LiCmJuiXMA98GOWN62LHBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izPSZ7ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E87C55DF2;
	Wed, 28 Aug 2024 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724852240;
	bh=Nwfs3yfaGGyfcG5dJ5lnEqC4M+ztIXz0KzLCPLezTec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izPSZ7ol/PohfSmOweUqSXMko8ZTEPHGZfHXUIsi2RP3lpEVM/G+vFKV/ACwpkaS5
	 hFE08LtePrNuFEshcL9aIbQslaCjTwVecGwp2xUVrUwSbBRf1q+iSB8S8uGnGuOnYN
	 icXCLbFhXRF2UaWeVtojUd345KHrrfY/dPbzCbMbvvbJUc+oVVWjWzfM51/dsNapP5
	 MtH0GBOuRLnB3UE/60ci9ZKpIOjCUyUDHgZ148q18YRVitmP2YM0mA7uFp75JaM7L0
	 sQ72IgHlgZt9Dztnc/o8mdexjEKbuQfSTvJVBhRgwmjyDA0occw2qHMKfmDrRaLdEt
	 EvXvFOgLiANTw==
Date: Wed, 28 Aug 2024 15:37:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev, 
	jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com, 
	wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>, stable@kernel.org, 
	Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module
 exits
Message-ID: <20240828-federn-testreihe-97c4f6ec5772@brauner>
References: <20240826113404.3214786-1-libaokun@huaweicloud.com>
 <20240828-fuhren-platzen-fc6210881103@brauner>
 <b003bb7c-7af0-484f-a6d9-da15b09e3a96@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b003bb7c-7af0-484f-a6d9-da15b09e3a96@huaweicloud.com>

On Wed, Aug 28, 2024 at 08:13:54PM GMT, Baokun Li wrote:
> On 2024/8/28 19:22, Christian Brauner wrote:
> > On Mon, 26 Aug 2024 19:34:04 +0800, libaokun@huaweicloud.com wrote:
> > > In netfs_init() or fscache_proc_init(), we create dentry under 'fs/netfs',
> > > but in netfs_exit(), we only delete the proc entry of 'fs/netfs' without
> > > deleting its subtree. This triggers the following WARNING:
> > > 
> > > ==================================================================
> > > remove_proc_entry: removing non-empty directory 'fs/netfs', leaking at least 'requests'
> > > WARNING: CPU: 4 PID: 566 at fs/proc/generic.c:717 remove_proc_entry+0x160/0x1c0
> > > Modules linked in: netfs(-)
> > > CPU: 4 UID: 0 PID: 566 Comm: rmmod Not tainted 6.11.0-rc3 #860
> > > RIP: 0010:remove_proc_entry+0x160/0x1c0
> > > Call Trace:
> > >   <TASK>
> > >   netfs_exit+0x12/0x620 [netfs]
> > >   __do_sys_delete_module.isra.0+0x14c/0x2e0
> > >   do_syscall_64+0x4b/0x110
> > >   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > ==================================================================
> 
> Hi Christian,
> 
> 
> Thank you for applying this patch!
> 
> I just realized that the parentheses are in the wrong place here,
> could you please help me correct them?
> > > Therefore use remove_proc_subtree instead() of remove_proc_entry() to
> ^^ remove_proc_subtree() instead

Sure, done.

