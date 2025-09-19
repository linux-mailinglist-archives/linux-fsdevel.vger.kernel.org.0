Return-Path: <linux-fsdevel+bounces-62221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5820CB89333
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 13:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6AF168F38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 11:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C86309EE7;
	Fri, 19 Sep 2025 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYGhYpfb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E8E230BE9
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758280193; cv=none; b=I5PSXhoBfObLuPp0+xPl1CEDHDG3du2oGCCgKpsxFU6r9e5Cq7/ye9CRmC4wLJLEYA1VeEAxcRysPcYxVGGqmomvgl4wdzaNjGxU25tBemyNH2M58/Gek3V3xpslrwSHyed41kdo7kRe8cU1cwntjVo8Jn6CggUTkz07gwJo7R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758280193; c=relaxed/simple;
	bh=9V5JuC/QY+dZ/6yL6Vvi8OQJKj941u01kou8dQy50NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nULpcePbiODc3qTbbDDFZYnC2gPJS8J/9eOEGhs+e1o5oLFs4wCBJAtUENdUApAH0bqM3KLnitbQ5pqY2iEPTRdsKDuFaRTlFZ4M7abiMWnY1kfFd1cq8DEZqmmic9IlOoIH7mC616/ECkQcuDYensieyPu57cjIvUXeQgBPca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYGhYpfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637B1C4CEF0;
	Fri, 19 Sep 2025 11:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758280193;
	bh=9V5JuC/QY+dZ/6yL6Vvi8OQJKj941u01kou8dQy50NU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYGhYpfb1bDmntmusSkyGi7l+Re6mDrNw1KyR/IUqBl4owNEfWP7iHbQxibdJmulx
	 UbhSQ5xM5ei/JkNiTBXJJemRHN2V6BsPBsdQNzitq7ypcXwO7V7dlJW5+VPXJ2XOY7
	 Uy0P6YvufMhs8s5UAG80KUID0uGZYT6t49TW1d5eB+jJYovbOnrfE2MCCRDoBeP0zV
	 16h9S4nffYkU91zJ7EB6fyO/nrcP741rbyPoAHPJKQcEgaiONZ6eDeuoQ0NSLG0GPT
	 4OGe2iM6fxWA7O+qIdLDHlUvnthpaM9sF6e6HrcHhnWfNaiza0jPtfHH69bfTD/x80
	 h0nT6fY2UFKGQ==
Date: Fri, 19 Sep 2025 13:09:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/4] writeback: Avoid lockups when switching inodes
Message-ID: <20250919-ausnimmt-etliche-3e5cd3c3f074@brauner>
References: <20250912103522.2935-1-jack@suse.cz>
 <20250915-anlegen-biegung-546ecc3b96a5@brauner>
 <3jfmu376jyk75l3jl5aopygfslbjj4omieavbtyugivxoe5kex@cv34s24fuzae>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3jfmu376jyk75l3jl5aopygfslbjj4omieavbtyugivxoe5kex@cv34s24fuzae>

On Mon, Sep 15, 2025 at 05:13:17PM +0200, Jan Kara wrote:
> On Mon 15-09-25 14:50:46, Christian Brauner wrote:
> > On Fri, 12 Sep 2025 12:38:34 +0200, Jan Kara wrote:
> > > This patch series addresses lockups reported by users when systemd unit reading
> > > lots of files from a filesystem mounted with lazytime mount option exits. See
> > > patch 3 for more details about the reproducer.
> > > 
> > > There are two main issues why switching many inodes between wbs:
> > > 
> > > 1) Multiple workers will be spawned to do the switching but they all contend
> > > on the same wb->list_lock making all the parallelism pointless and just
> > > wasting time.
> > > 
> > > [...]
> > 
> > Applied to the vfs-6.18.writeback branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.18.writeback branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> 
> Thanks Christian! I'm attaching a new version of the patch 1/4 which
> addresses Tejun's minor comments. It would be nice if you can replace it in
> your tree. Thanks.

Absolutely! No problem.

