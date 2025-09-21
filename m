Return-Path: <linux-fsdevel+bounces-62325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 371DEB8D6D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 09:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B136B7AFA80
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 07:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635872D249D;
	Sun, 21 Sep 2025 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11h5KL1V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OV2ckYfy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F71E8836;
	Sun, 21 Sep 2025 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758440196; cv=none; b=LHpSe3jBbmUVcj7iwUT3FJXabcDCqew0Zf/q4+QhZ2837vhwRFkq+u1dvVcMmkVJ6GFQWBpqUkDzYSgDDMWUAbYLHYaVIOeHja4SH0euGuFR41Hp14aSZ1jnkjK3CqRijhCZzmlQfMURzgWIeshl7l/MWF7cvWqX9hc/zP/t0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758440196; c=relaxed/simple;
	bh=stUeXoAm8LByM1FcZc/Iwv0KfZLq93DcZ37LmHah1ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lqsPzQWRcftr3Ajbqnkm+PzaIWaem3NEDMPKFcfCDpRwtAWZQEMdQqPUb1eAKNmVG6u06xkoVz/dS9Bt3JVflLFU78qgTUlXQCZehAfFX1vzKZv7TrlOvnZ0Mr7PCmfz8tz2fr3Zou6gyfOOdPPdB3fMw6Hn00f5IXWcKhlU7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11h5KL1V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OV2ckYfy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758440193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=stUeXoAm8LByM1FcZc/Iwv0KfZLq93DcZ37LmHah1ik=;
	b=11h5KL1VvvZCiNL+6UqKR003d8EztndR3UxVq7jhIFTBmMGyNgXqt+ncBikCjO9rwHhfn/
	1XJhKVB6m9zg0o8bKtQD1DZc/AAUPk8/LpNgQ+QuHtOrof26cTqTtvw2QivVaYPuYrQEi3
	uwVT/tI1R0RloSwhHpZu1AulhU6RjbmhljW7TYauw0ovxWlrDtzaodCPig5qTPKx18DDE4
	F51RmbCA9M51YWGCcEDteqBLcTDRMfSR0oTdugBOuT8yn4gR589bvSSmxMCxrXRpViWtqM
	y/lKWzwEYWpiK6+kcRVUnBs12lW6wX0RwJBFEfWgGrPCznRyYO2asmE9sEArqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758440193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=stUeXoAm8LByM1FcZc/Iwv0KfZLq93DcZ37LmHah1ik=;
	b=OV2ckYfyUMAC25bw76vxQd10mARue71nh6BSKx5peSR/2rb6DeZbvwhHOE7PZ45RVdcexl
	jY/m19CBOhnzMuBQ==
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering
 <mzxreary@0pointer.de>, Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa
 Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Jakub Kicinski
 <kuba@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic
 Weisbecker <frederic@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [PATCH 06/14] time: port to ns_ref_*() helpers
In-Reply-To: <20250918-work-namespace-ns_ref-v1-6-1b0a98ee041e@kernel.org>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
 <20250918-work-namespace-ns_ref-v1-6-1b0a98ee041e@kernel.org>
Date: Sun, 21 Sep 2025 09:36:32 +0200
Message-ID: <87wm5s6yv3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 18 2025 at 12:11, Christian Brauner wrote:
> Stop accessing ns.count directly.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

