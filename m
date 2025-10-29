Return-Path: <linux-fsdevel+bounces-66184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F77DC186D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 07:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 901714F6991
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 06:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B011430276E;
	Wed, 29 Oct 2025 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk+6qLII"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF622F6599;
	Wed, 29 Oct 2025 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718734; cv=none; b=p1vj7Tj0eTCbg7tnNpMmpzi0D1pdF+YIhHOYHeqvcsMpAfvMiOc4flEf1tWqV736QSqUawqXA+Yui2MiOkxdDPs7MXyCZh07uJDzDz8Rw/ibwRkKz1GcDNMWJTITKiGoxDdwQPg7wa6eR2hPywDNyy8pY1w2VGKuASFNbmGKBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718734; c=relaxed/simple;
	bh=sNwUDE3GpjZgRRxK39FIaAoWLzOItBsyKBeQQ57qbFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rVCPJKIC0KAdiCV+gYoDrqDGI6YvvsgFUEFSMIRgcNehTbIfVvspLXGW/uYec3BpstUldfxtymNQKkO97wRq1/SvjkcxGgIXXqnHJXtOXAJUY1nhGaTa4X16WjwmFQPGHjLOgdOM7Hx3kBiolDj22xPmiUtttY1wuB6YNbhzLZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk+6qLII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92541C4CEF7;
	Wed, 29 Oct 2025 06:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761718733;
	bh=sNwUDE3GpjZgRRxK39FIaAoWLzOItBsyKBeQQ57qbFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Rk+6qLII7dhXKc90DR7x0yOEvODjOW/vGOClfgVuFKE3QWXEzLxdfMqDCeOj2aCQC
	 Af7tFpcn1bA5YqBuP1vrNitK3sm7hW3KrYUEiQ3uUVlPgDiReiQJI+4PU5WchW6eKG
	 /h6vzvh0y93wx4HdCp/Guuc6ZBoGwAMJ5nQwd9g2jF4j4MbCDnBXz63JsAb0YVujnH
	 RPaDTnOSvsJkgMOZTcApLHzlog5soPtmuQGsnj9HF4Ql6o+0V30MAVN0BZ3P8otsW+
	 JyjsA3LXvuXmXdm+mAmvjC3CctniwC/hpFVHFmdzVIxYrqzOgGJawmQ9zcv0wDagWd
	 vR1pv53KN6RGw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
 raven@themaw.net, miklos@szeredi.hu, neil@brown.name, linux-mm@kvack.org,
 linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org,
 rostedt@goodmis.org, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
 linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
 selinux@vger.kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 10/50] configfs, securityfs: kill_litter_super() not
 needed
In-Reply-To: <20251028004614.393374-11-viro@zeniv.linux.org.uk>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <iNj77i-tfrdVv9HEpIj_AzJNAUOKdPKNfNsGxMAfclR7sy-qVQBLpolv7Wgpmckad9w4QJXyH36_g88ejY-xpg==@protonmail.internalid>
 <20251028004614.393374-11-viro@zeniv.linux.org.uk>
Date: Wed, 29 Oct 2025 07:18:29 +0100
Message-ID: <87v7jyfcy2.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Al Viro" <viro@zeniv.linux.org.uk> writes:

> These are guaranteed to be empty by the time they are shut down;
> both are single-instance and there is an internal mount maintained
> for as long as there is any contents.
>
> Both have that internal mount pinned by every object in root.
>
> In other words, kill_litter_super() boils down to kill_anon_super()
> for those.
>
> Reviewed-by: Joel Becker <jlbec@evilplan.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org> (configfs)

Best regards,
Andreas Hindborg






