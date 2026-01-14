Return-Path: <linux-fsdevel+bounces-73520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5248AD1BDB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 01:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 901F33046F9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 00:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACAC3C07A;
	Wed, 14 Jan 2026 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR8Gtqt6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD92217648
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 00:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351592; cv=none; b=dbrFBQvkxLylzRrxiZcyUJnV8O+7aO1xFfUiIUCBDhewvvzN7hjH5IO0T7Wlb7iOIjN5AhiRE0Im2EQv+uQ3vRIosZlAtHzVjMN5yt9JWm69a+sH1r4zy14jquxD/pVY0wQM6VHJVwXwzdCcZ6/+mz9YQCuWpnaF9Dd4BDrmdzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351592; c=relaxed/simple;
	bh=zkcxvaI8I2E99ca2DQiL6AIHbYg5o0RQfZEDZKQZZ9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUZr0iehBYJ0P0eLUNU5BtMjQp4wEviZpXa3TEFtWwyV3VtjSojkvTWa0lw87/LkLWaC2DFfKx0owmee7iAKyDBq70PIBbsrhdVKXdbTuQp1DOKcZ9qeBfpIJzaHTaUSZxjxD8t96uVTV1o7ADrgkpmnH7aSkkCZoHCzOqRkj74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR8Gtqt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6F2C2BCAF
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 00:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768351592;
	bh=zkcxvaI8I2E99ca2DQiL6AIHbYg5o0RQfZEDZKQZZ9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oR8Gtqt6yefBIRJt8fwEoRN0l+2PQpQ9KjBYDzYVqoBhvPlHRh68Vz8rLOI4sZVs3
	 JxVL5gEBZsKoNubnH5IvbtSsO7et/GdRrOc4xC8hKgC1gKQ6f7AB5rSENHsv3l040J
	 TlO0jlDVaeMVD7DRvmT+bxB3vOhytH+1ceGmuacyThjilq4RW18+JGwux1DSTAR3M9
	 wGTnvCflyagvNHLOWzob6vlW5GoGwdgEoIDy/3F8XORlqNYVtCU4+6ppP59r06wd/0
	 GJ0bmEZrmCPciykUgR9T7rDVc8HHIMvwazJf47bDG2oVCmypF9f+vKmzFHiGRaQbwB
	 Y6apb2eVqPXhg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b874c00a3fcso158210966b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 16:46:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXG938aItDUBl3IQWP+pKbFKb/MQEgPEeJDhmZ8s5Lvl7qF9rfcHkRpBIC824VTufpcW3pKM1Jc2QgmUAbM@vger.kernel.org
X-Gm-Message-State: AOJu0YwgJmqmsg5CkVDlCvsyuUuNSEattx6zq/Veou6RQN+zKBefXCAg
	PL7QQN4BiOERBj3I+FYvhtrcjJ3/WfrlQwsUq63P17Z+e9M823hqV1jDWpqNnh0sYX3lR9nMlUv
	dCxJ7sDgNHuu/YC33WzlcHu8gDnxsmj4=
X-Received: by 2002:a17:907:7247:b0:b87:2579:b6cc with SMTP id
 a640c23a62f3a-b876124f9b1mr84211866b.37.1768351590667; Tue, 13 Jan 2026
 16:46:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112174629.3729358-1-cel@kernel.org> <20260112174629.3729358-17-cel@kernel.org>
In-Reply-To: <20260112174629.3729358-17-cel@kernel.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 14 Jan 2026 09:46:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9kFLQmPPGsJ5rTGSqbXp2fA_Hh4-z0BDbGb2_HCQvgUw@mail.gmail.com>
X-Gm-Features: AZwV_QhgKLMAC1WJlShWVjG76Ssk-76f2CnnHyXv102pHNTEx_UlWkY-EEEsYVs
Message-ID: <CAKYAXd9kFLQmPPGsJ5rTGSqbXp2fA_Hh4-z0BDbGb2_HCQvgUw@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION
To: Chuck Lever <cel@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, 
	sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, trondmy@kernel.org, 
	anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, hansg@kernel.org, 
	senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 2:47=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> ksmbd hard-codes FILE_CASE_SENSITIVE_SEARCH and
> FILE_CASE_PRESERVED_NAMES in FS_ATTRIBUTE_INFORMATION responses,
> incorrectly indicating all exports are case-sensitive. This breaks
> clients accessing case-insensitive filesystems like exFAT or
> ext4/f2fs directories with casefold enabled.
>
> Query actual case behavior via vfs_fileattr_get() and report accurate
> attributes to SMB clients. Filesystems without ->fileattr_get continue
> reporting default POSIX behavior (case-sensitive, case-preserving).
>
> SMB's FS_ATTRIBUTE_INFORMATION reports per-share attributes from the
> share root, not per-file. Shares mixing casefold and non-casefold
> directories report the root directory's behavior.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

