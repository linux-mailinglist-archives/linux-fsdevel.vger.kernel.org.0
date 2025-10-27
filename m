Return-Path: <linux-fsdevel+bounces-65738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6952AC0F623
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 893FB4F6A74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CFA319619;
	Mon, 27 Oct 2025 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ey7n90JD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xoIbsUk2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7274830AAC8;
	Mon, 27 Oct 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582990; cv=none; b=TQsRAK0ApbGR9hjH+fQW93uUhMw8UIsYUrvaRK1CSAzlDvDXwfIk3I+uZXqJYqfPnvq/K8lqOTGriXk+RyZAQ6ymJlIppLNJSdb/VuQx67MJ/X2GiZa39MIQ2dnK0wCYPaiCT5+Cq9HGryrK343KeutyRFjPGEcOHSBYbZ6T864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582990; c=relaxed/simple;
	bh=NF5bSX0dyXfyOuPerzSokt+xmjFMmp5Twg/WVnHSNyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ieuymSF2TINMxXy0pJUb6SJu5c9OF/TQJY7CAtwjvy72TLxyjQzxpxYvrplfIq2IJXpt5qiGQNKEl3QYhMt9U/ncBzQPJ/IFSlXa3kFRSihUtYy3TayC1uMx7i0mgP3rI1BfAkdYI+hdV7bZ0b8hgIhFQrjGiBaAx9yDD/L0ukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ey7n90JD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xoIbsUk2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OY0q5YKTtT4E1ub/SpSB1ESrYQ5WABlmRfW9bRPjcDE=;
	b=ey7n90JDMTUM2Zplf9hrF7CfTAUl/zYjlBdAveeVDbOc8ldRGQ5IgDRhRHEC4SjTCRCAwm
	HOCpUiOITgnmyeuHcEyYNMhcgEr0MtJAvrjVP/dp9ZcO9VnXu1MlG19lmGMZFXK8pE9byb
	qCvo2rU7soYJu5SvFyaIDcW3yws89FFOgfppQqSiXlA9smFcFvpdrpGARE1JWRzDS1xhjp
	jAg2IyMcqyMUSfceTXxqam6QPuUYKbSBaWv++3QRy+0t5LncQkdMhcgyww7vKgjLgCUjvn
	eyPFg3cyEP76bok5mJwZOa+CzK0KpYoJJm+3ZYX+aoDhkSnFpiQlm2+T2GoLEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OY0q5YKTtT4E1ub/SpSB1ESrYQ5WABlmRfW9bRPjcDE=;
	b=xoIbsUk2+vEfPCpIpLkF4GC+uw2r8MliQIR0TvsBpdisw3Dy96mpl0L1ViaoVKsVRemTKD
	kVWEc+FYaY5tk6DA==
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering
 <mzxreary@0pointer.de>, Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa
 Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 11/70] ns: add active reference count
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-11-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
 <20251024-work-namespace-nstree-listns-v3-11-b6241981b72b@kernel.org>
Date: Mon, 27 Oct 2025 17:36:27 +0100
Message-ID: <87a51cwbck.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 24 2025 at 12:52, Christian Brauner wrote:
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index ee05cad288da..2e7c110bd13f 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -106,6 +106,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
>  	ns->offsets = old_ns->offsets;
>  	ns->frozen_offsets = false;
>  	ns_tree_add(ns);
> +	ns_ref_active_get_owner(ns);

It seems all places where ns_ref_active_get_owner() is added it is
preceeded by a variant of ns_tree_add(). So why don't you stilck that
refcount thing into ns_tree_add()? I'm probably missing something here.

Thanks,

        tglx



