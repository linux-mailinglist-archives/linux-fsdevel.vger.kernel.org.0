Return-Path: <linux-fsdevel+bounces-66418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDE2C1E6E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 06:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E91C34E619E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 05:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7CD2F39BF;
	Thu, 30 Oct 2025 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pWZ489wE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7673D1D6BB;
	Thu, 30 Oct 2025 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761802347; cv=none; b=Pj/2/lGDES0xsDnRCxn4sMD4z0kZc8PWAeTgg3TT1zT/8KD/yQfC6acoCnUsA5PR56DnxO/G8vSOMpbGmlm1f9NLuwmQ4s0/T3iZkxP9ZD4sYJZgeemsG+EIZ9nCBGxDF137MU+MWyWUxIPMQ59g71dHoA8E5WIev+M869G0rWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761802347; c=relaxed/simple;
	bh=RKZ55e/BX3Bsy8j/0XAduETGE5FWfV4zDbi6AF2gqjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tc+K2iDQSXPcvEmEQIBmDfC5mRctw6ILtjLA5lYMt1wlQQzC/R+5UncTFFhXtPcEo3jLY2lnMUmgt2yvdC92n/Db73QMD5pCqL81mBe4qt6B/kog7ZO3PZKrFNYEwKRwqNv5aRfYB9PRigSHIpP12lMdcTXPruguUeG0H4RoXqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pWZ489wE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66130C4CEF1;
	Thu, 30 Oct 2025 05:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761802347;
	bh=RKZ55e/BX3Bsy8j/0XAduETGE5FWfV4zDbi6AF2gqjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWZ489wE0/m49sWPsV/Rq7Bz2NYaTqU6b90Ymhx8VEoudj0uV9WaKuBWHmU1WM/O/
	 xHxhdceQwVt+HGjb6niSCPHuQjJXzAwL234wCbKVKiqhVjf1ULVAxCbXZwSilitsRx
	 Mpjs6IhZxNwipGykTOUfLGAGdCRTODuSqIbQP0QE=
Date: Thu, 30 Oct 2025 06:32:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH v4 01/14] debugfs: rename end_creating() to
 debugfs_end_creating()
Message-ID: <2025103013-overcome-jailhouse-538b@gregkh>
References: <20251029234353.1321957-1-neilb@ownmail.net>
 <20251029234353.1321957-2-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029234353.1321957-2-neilb@ownmail.net>

On Thu, Oct 30, 2025 at 10:31:01AM +1100, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> By not using the generic end_creating() name here we are free to use it
> more globally for a more generic function.
> This should have been done when start_creating() was renamed.
> 
> For consistency, also rename failed_creating().
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/debugfs/inode.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

