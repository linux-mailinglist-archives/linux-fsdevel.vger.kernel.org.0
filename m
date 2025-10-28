Return-Path: <linux-fsdevel+bounces-65865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B45C12819
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 02:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFBD34E886A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 01:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D9C213E9F;
	Tue, 28 Oct 2025 01:14:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B1C72625;
	Tue, 28 Oct 2025 01:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614079; cv=none; b=CgYud5w5DDVIASS/fTS9AnxpfMgwhl3aQgBc5fh5fz/xaD5me5wQg8ZnB8AC/gm1LmuY8rblGHv6kmH7uXzHbCl9r6k7Igq4VIMaT/JuGx8TCFk4v1NbwXqnHlYw/ncKWTe2VYChQMx1zLFv8y37Ze3TShqlTEfPU78Oi2ohRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614079; c=relaxed/simple;
	bh=qE/znF2A+COkF27PSsJV89ZhuAZKpPTVplbANqYuHPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOCcwT6ph8SEIGF4JWonHxB0V//hH6T2LnyG1r/wiLWmFxKlFFqyOCnGMJBZM1X9FrUDiZNUVOr0n38l2wyrZI1ztcwmMItDcOEjImtzC1zYnNcLY8gpdhuDW73ZnEP4a7dnenWfi4T7pcr+FlGsaeGEpipFac53eC02A1zm0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 12D8A12A5E4;
	Tue, 28 Oct 2025 01:14:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id B058135;
	Tue, 28 Oct 2025 01:14:24 +0000 (UTC)
Date: Mon, 27 Oct 2025 21:15:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
 brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu,
 neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org,
 linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, paul@paul-moore.com,
 casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org,
 john.johansen@canonical.com, selinux@vger.kernel.org,
 borntraeger@linux.ibm.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 02/50] tracefs: fix a leak in
 eventfs_create_events_dir()
Message-ID: <20251027211501.1ec4940c@gandalf.local.home>
In-Reply-To: <20251028004614.393374-3-viro@zeniv.linux.org.uk>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
	<20251028004614.393374-3-viro@zeniv.linux.org.uk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: emtbj1y1cju7g4shfpg13tdhnhs4nnwe
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B058135
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19GTe7PKSAfAGlbt/zS4ZGC8rcOFjmyEK0=
X-HE-Tag: 1761614064-363610
X-HE-Meta: U2FsdGVkX1/G1h3gGfRooYvnXx3jiT0AwrBONfXuKy3eeIhUbLFRGxNdBXPDpG/5ncnLD2Wi5bI2V9h+KPnTFqly0Q7VErHQu2q25ySYnNUny7DQWnj8sQCkkGfdWbi/bua2gd1Vg0frbF65fQ9/rH9lMpLN/+yjp/Vvtw1+ic2u+9OP9IqIBCHUSVaRSxDQRiidgj30RK844jt+AK/UFlJ9gl7wzbw6jqw/OkARt4qz2ow1hPKmVkDosJyejXNCzHhjgqGnoD0TuFx88/ym7PrOpd+IGQq4/krEZ6R626JFHE2nA2hzR9aU7tXEvFNqkK/yNMiujAAkUAQ+eodxQUyFYdHjihtmjcWI+LhUwkQvR3fTh7c3F1AI5fHutu/+k5BuP5JJRzbLX4ISmbC6rhojJVMm7lNjNjOrSwZtVdzqO+33uq5OHXe7VMnZNZ5zUTeXJ7349odfYLfXhL1Dfg==

On Tue, 28 Oct 2025 00:45:21 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> If we have LOCKDOWN_TRACEFS, the function bails out - *after*
> having locked the parent directory and without bothering to
> undo that.  Just check it before tracefs_start_creating()...
> 
> Fixes: e24709454c45 "tracefs/eventfs: Add missing lockdown checks"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/tracefs/event_inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

