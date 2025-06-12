Return-Path: <linux-fsdevel+bounces-51529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D221AD7E9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 00:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC437A95DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 22:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5742A236429;
	Thu, 12 Jun 2025 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB/ejbQ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9963A1FBCB0;
	Thu, 12 Jun 2025 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749768745; cv=none; b=L2yUVDVGzQ4Dy9I5gnkpx01DWgRhLFJOPs2NO1SfwxqNW+1ZaN1flaIaOkerMVk1LSmp3wSUcl5zIPtxjpuRpPnrCXi2dN7CNeI3JvkOdXL3/hItpQAFsb7eFhnW7b0+DE+irmwP2ZF6m69E8UQyuMfV5mbMZ90/dsf5nUvr0HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749768745; c=relaxed/simple;
	bh=RLb43KAcC5RaodCRSfGcH1QteKxbGALd1H/ZIPYUHiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVr1Am5v9oRQWHq0aXq0gifyWwcorpqm2Pbyeicpz+tTgHRjpOL0Sedy6ICZKVwbrPqdLfvbEYrgfObv3C/w8oqwiYFN4xQmZvkhVIG070zFWNSRsjX5E6CCGcmt2J7mODv6Q2NaxK2KQHAF24G8mENdlAN/al+PPfjbo31U3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB/ejbQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2126AC4CEF4;
	Thu, 12 Jun 2025 22:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749768745;
	bh=RLb43KAcC5RaodCRSfGcH1QteKxbGALd1H/ZIPYUHiY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mB/ejbQ3dPbzPx0vJQLYivH9v5mnXEd/scA1AhvIR8M46JK8BrlQ3eRWqz2qTDSQD
	 wK8ea7e5qdGGpWe07lybVtH9ygVLZ3/CnGesVXwcrTTYCKACviX62NCJChn1+5myGy
	 Wcr3UVwyT7wPgTKTMLBYMLZ9c7fDPsyOWIXDVs6ORTIrPzN/eOT9zfySfdldX4pB3n
	 d17SPBa6cTBPIRche12CjBCQL+o2lKS3zQ0uZb+fKv43czwAgyxIunpnMXlUdLOE70
	 RX8owW2PuuMjJnUGTUqAdMllFkuUdytAUnghgulHtsGByB/Scyzu2/1Q4JI3RGdZx9
	 MaYK5S8C2BVNw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso2664905a12.1;
        Thu, 12 Jun 2025 15:52:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+kiF7xBbEabdDb39W3IgLstzxzJKjU2JKTvizdB4etBVWEk2zRiEXDSdhbeOxjWztNybVXevWFKJ9M+klzw==@vger.kernel.org, AJvYcCUOlnUhzLnDjXpH5C71yVL2WaTIXvwy3vFGHyQCKl10rMOYOrMrlzTok5PVuSvk1JnvEJxfv4G4xEOlDzSOhw==@vger.kernel.org, AJvYcCUbrDLbK9gAc8TiBcA0rLdyER1dtB44RmnVeratRn38lWt3uT4F9i8nkNwpnukiRW7Jf60JL6TEK2pLKQ==@vger.kernel.org, AJvYcCUfYT6LMenNG3WZEGgTfEAEtnfaG3El2wObnJpyBIj2rdH3G6GSaFCeZqylAe4O2GX2j4t1LZFdPaRI@vger.kernel.org, AJvYcCUpVCPXekb3IF8vKlkjzoZibV+9hoAoPtGtKoJa9fTqQfEMamhu5c10bRy6XJ0QxkEp6WYNQ9Z7Mw==@vger.kernel.org, AJvYcCXObn0swETn89JDE5DRtTbRINVDk1X3jDBBOILrR/WAxoiEyl4xVAcv+0rxsbqn392jBzxLS86Q/0d319qQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrl0zs+UOt+7cEFWCGPeG+BipVslWzwEfn5iSNk0Cu8J5ThWbr
	/BTAudx/9Ee7123SBP7TIR0BV5GOHMUwE1VqelSzIVvFlDXm6d1PyzI7uUvPFWMc+rfXFtWzleY
	x5jFDREqyvGCMHEaa95YGlsAA8LFzXxI=
X-Google-Smtp-Source: AGHT+IFv9dGYrIOKeOZKaL0BR+0Fv0LEjei5oP/yryZdck4J+qKZtwawXs+osRG8Bg80wjBiojwFLAHZMDY7UpigbAg=
X-Received: by 2002:a17:907:9447:b0:ad8:9d9b:40f9 with SMTP id
 a640c23a62f3a-adec5bcd371mr94803066b.43.1749768743615; Thu, 12 Jun 2025
 15:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611225848.1374929-1-neil@brown.name> <20250611225848.1374929-2-neil@brown.name>
In-Reply-To: <20250611225848.1374929-2-neil@brown.name>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 13 Jun 2025 07:52:12 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_bTyobeFyX7DvGN4vrdCqEDt0V=8vt7PeRfppcVbYP-w@mail.gmail.com>
X-Gm-Features: AX0GCFsA8OY4bdVAjhiy1QgEfYRhs_gA_2LVvvqRo48JXUIIKzV2VY1ry6xZNOk
Message-ID: <CAKYAXd_bTyobeFyX7DvGN4vrdCqEDt0V=8vt7PeRfppcVbYP-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] VFS: change old_dir and new_dir in struct renamedata
 to dentrys
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Kees Cook <kees@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 7:59=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> all users of 'struct renamedata' have the dentry for the old and new
> directories, and often have no use for the inode except to store it in
> the renamedata.
>
> This patch changes struct renamedata to hold the dentry, rather than
> the inode, for the old and new directories, and changes callers to
> match.
>
> This results in the removal of several local variables and several
> dereferences of ->d_inode at the cost of adding ->d_inode dereferences
> to vfs_rename().
>
> Signed-off-by: NeilBrown <neil@brown.name>
For ksmbd part,
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

