Return-Path: <linux-fsdevel+bounces-66287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56830C1A813
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05BA85842EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24053596E0;
	Wed, 29 Oct 2025 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQVzvhI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB34A3590CC;
	Wed, 29 Oct 2025 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741593; cv=none; b=I2YQf2h4ihtqiFd58C6b/JxgWZ93JX27pl4eR5qE9j5oitRBslSEk2FPReUMRb7IOlwRyX/vg6RtBkq3OvvTjzBd3ywxh9e2tpY30erLViT9lyiETP6UciZfNb+8YW171N9ykBGh5YEptwOiSVldG9GAekM6er+pXn+z14YoVhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741593; c=relaxed/simple;
	bh=oItGI3gaeX0LbA7f+lmtznbanR9gHvj7um23N51MZD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUJtdf90N1b73mYusuCJD0NG3NJfimAwC7o1zJ+V3p9YWcJauNA84SUPnsW596ZEN3JLfsDG+dhM0siampN5CFdPzN/FZFg7fJICgHZpuA1zjTMW890rqU59ZLdkqxC7t5qw59oH1u8YgH6LEm9GTm28ZYlLeA7Ont95oM7/NVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQVzvhI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C08DC4CEF7;
	Wed, 29 Oct 2025 12:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761741591;
	bh=oItGI3gaeX0LbA7f+lmtznbanR9gHvj7um23N51MZD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQVzvhI4br2EUD6cJ6INSkNPzmq/N0lp1dCm1XyG2KSN5m7FVqFc8hVygLWZFAAFB
	 j2/mcCNv9Na9WPoeVd+OHn85jkvfIu+pCDyJbUXWCxDJf7mjIrj88GvmZXJOP7t6QJ
	 krgIT/KwdKIsXqTb7dmZ4DV+tbU6mXGCP9QjnqccHdKREbu/OndEC+REoYiAogTZPM
	 Mb6Hdq3uFLURgMsRN/nsB7ZlDuqtBK5DDa7Fm9ex7A564KwI51ftFiE6LL+re8lD1F
	 6SW/g35xF/FtTGUlqPwa5r46HWaG4QTZrk6QJia0ICHD5mQc4HCF33wC8yeCnL2rAH
	 pcbKlTK/B+bcA==
Date: Wed, 29 Oct 2025 13:39:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <christian@brauner.io>, Marc Dionne <marc.dionne@auristor.com>, 
	Jeffrey Altman <jaltman@auristor.com>, Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org, 
	openafs-devel@openafs.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Etienne Champetier <champetier.etienne@gmail.com>, Chet Ramey <chet.ramey@case.edu>, 
	Cheyenne Wills <cwills@sinenomine.net>, Mimi Zohar <zohar@linux.ibm.com>, 
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/2] vfs: Allow filesystems with foreign owner IDs to
 override UID checks
Message-ID: <20251029-brust-reden-b61f1a55dc3b@brauner>
References: <20251021-agieren-spruch-65c107748c09@brauner>
 <20251014133551.82642-1-dhowells@redhat.com>
 <20251014133551.82642-2-dhowells@redhat.com>
 <1523597.1761052821@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523597.1761052821@warthog.procyon.org.uk>

On Tue, Oct 21, 2025 at 02:20:21PM +0100, David Howells wrote:
> Christian Brauner <brauner@kernel.org> wrote:
> 
> > > +	if (unlikely(inode->i_op->have_same_owner)) {
> > 
> > Same, as above: similar to IOP_FASTPERM this should use a flag to avoid pointer derefs.
> 
> Can we do these IOP_* flags better?  Surely we can determine at the point the
> inode has its ->i_op assigned that these things are provided?  This optimises
> the case where they don't exist at the expense of the case where they do (we
> still have to check the pointer every time).
> 
> > > +	if (unlikely(inode->i_op->have_same_owner)) {

I think I mentioned this off-list. It looks like we can but I don't know
if there was any history behind not doing it that way. But please try.

