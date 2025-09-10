Return-Path: <linux-fsdevel+bounces-60807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522FDB51B6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF63460969
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44A531A070;
	Wed, 10 Sep 2025 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="25I3jwM5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/Jhi00Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A192571B8;
	Wed, 10 Sep 2025 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517541; cv=none; b=D66gYkfQv+v3ZlnPe4QMwPRLpF+v/Y9DELqN6ZHd01HQz/p7dTGLVLNhETcby8VfBzwMtOxGbKaFDv8H0t9Lh8xOuBp+8Ppp4VgzaKeeasKpOakklIcpdligfy+XO07sJmwU/M1+Ut8H/CKIpGpMRRuIszWCTY1c7uhClSuShek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517541; c=relaxed/simple;
	bh=hQMOysMfMqdcPXGlHHCUUYKFgmuPBJqSNTrJZkKd9xY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hZdluzuVzGVwevB3r3KLMf54hckdechJpnadYO+fDiJp6KkKxHmcJGO0pB6KKNAOLHOAx+wWUxNsWlqJmDawnmArbv394MgqDNhtS+JjG392LciRx6IgBXCZlMdZT0LJwuP7j4tsTUFSeHJP1RbB671wKS0eDWFRD7GzZpd/Si8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=25I3jwM5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/Jhi00Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757517537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQMOysMfMqdcPXGlHHCUUYKFgmuPBJqSNTrJZkKd9xY=;
	b=25I3jwM5cfQlIQWQHxw4tpKR/Nj1FPyQtLwKkSvCIcAtbpu3ZHPEKa/L5fa9qOMR9MyqVK
	CtGSPsiROp6dHjVbLwC1mcosWodip5WCYSbANiqq4Nq4nO6/3cfY4kVSFfolEL6jHHDKe8
	UZrRI2kooMqCcFfYDGp9yVfZNvQQr5s2JASn4bRO3hyg1J1DOkuDGApnQhD1dcOXMoWvyG
	dQu4VjSg4j0iaKLEuTzg+rqiiZLxPPoiMxPvZySul1Y0yIoksF4DBjrVe3nlwEvI6eo8GS
	XyvehR1SgFLnUfv5VcGIaQSnqvQaHuYJbL75nLsICV5reOrH6ZIq8vRp5pct3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757517537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQMOysMfMqdcPXGlHHCUUYKFgmuPBJqSNTrJZkKd9xY=;
	b=T/Jhi00QXPPS0wEES91LpaUbQNQXfYGsRYv5gd8iZYjQz1AzmfP7BzsVrZUwhcWMctsVaY
	/8J4zvl2IvOujKBA==
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Amir
 Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
 Mike Yuan <me@yhndnzj.com>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, Daan De
 Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal
 =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Eric Dumazet
 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, netdev@vger.kernel.org, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [PATCH 11/32] time: use ns_common_init()
In-Reply-To: <20250910-work-namespace-v1-11-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-11-4dd56e7359d8@kernel.org>
Date: Wed, 10 Sep 2025 17:18:56 +0200
Message-ID: <87348utjxb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 10 2025 at 16:36, Christian Brauner wrote:

> Don't cargo-cult the same thing over and over.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

