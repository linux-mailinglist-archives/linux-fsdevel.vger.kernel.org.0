Return-Path: <linux-fsdevel+bounces-1368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01747D9A2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 15:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805321F23710
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9A720B09;
	Fri, 27 Oct 2023 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S63DQxA8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29101F958;
	Fri, 27 Oct 2023 13:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B336C433C8;
	Fri, 27 Oct 2023 13:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698413915;
	bh=CMLPBclS/Tv85Ts9mP4O5I7Xd7BY3qYUiYpRysEd71Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=S63DQxA83PyGOhGJDn/k0OCwIu7EB0CV3E46kcYZ5FtaS1GTHppIiqiM7/JfJOZd6
	 YykOjUJ/LpEfdySAmL1WsMpWuWJoZy/TlVwrzhEamtAqufv0e81lzvdGKD06TQDMev
	 rgkglFRCwZdJCMyXVR3SAbutdPDuFvyRP9F881dyJeRsxMT/SYFuGSFw3EuOh7Nnyo
	 b/syiUTsrsvmQ6CB7WrOXy92Q/tQZuV2vhQ0PQsKxl4Ul9oPQYbImEu05Z+ANRxBRZ
	 sGqyQU3PwK1rdc27h7Gatx4OjH2NTG0ihTCdRdygEfhp8d3Vyl9UnZ1k3MR9eN0Hcr
	 Lz5Gre6HrVwlQ==
Message-ID: <2cd170b595b1313292dbac4d12edc355683b678f.camel@kernel.org>
Subject: Re: [PATCH] ceph_wait_on_conflict_unlink(): grab reference before
 dropping ->d_lock
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, Xiubo Li <xiubli@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Date: Fri, 27 Oct 2023 09:38:33 -0400
In-Reply-To: <20231026022115.GK800259@ZenIV>
References: <20231026022115.GK800259@ZenIV>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-10-26 at 03:21 +0100, Al Viro wrote:
> [at the moment in viro/vfs.git#fixes]
> Use of dget() after we'd dropped ->d_lock is too late - dentry might
> be gone by that point.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/ceph/mds_client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 615db141b6c4..293b93182955 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -861,8 +861,8 @@ int ceph_wait_on_conflict_unlink(struct dentry *dentr=
y)
>  		if (!d_same_name(udentry, pdentry, &dname))
>  			goto next;
> =20
> +		found =3D dget_dlock(udentry);
>  		spin_unlock(&udentry->d_lock);
> -		found =3D dget(udentry);
>  		break;
>  next:
>  		spin_unlock(&udentry->d_lock);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

