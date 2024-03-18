Return-Path: <linux-fsdevel+bounces-14716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BED787E4EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 09:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F401F21D93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01DA28DAB;
	Mon, 18 Mar 2024 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="oBxflvDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D925760;
	Mon, 18 Mar 2024 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710750344; cv=none; b=pVuEy+nVCHTxV2hqx0cSGWNJw4ZIId4njG97lxi7iuIGmtL8J9RS1Gppsmak/TS9Ge+/SDwf2RV7xd3hJ82LwozPXicwX4ZZq7PlUGoF3yahtP7BewJqEpPVcPq1WEJhZUMdYBHP3L1BDn4jK+Nsr1b4Cae3p8cuo5dU64d3P2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710750344; c=relaxed/simple;
	bh=9Gox6nr4Yw3nX20mUWVTq/8pONnShOOhZz4ItxTrQSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nU2I0CP+Vw6piFu/LKIQ44ucgSkTGAuFqIN7kLnnmvQCWH9ufk23SIxDF5Qn9eKu6znzkb5KDMT1VpBL8jUrHT7dR9ZG6vTwkNA0QvaOVV4Kahw/DQVmTzfmR87Fj3pEF9Ha5tlEzMyK0J47tRARdx4MFV6+cKv4FyYr4J6Zgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=oBxflvDV; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=5lYBvG/HYr+nZZA7Ycz+u5VrES4YL7MUIS//0G2Ymss=; b=oBxflvDVpm9F7x3AVIgIprIZjM
	D7jw1p3vzgwchZMSbqw7iBA0n6s8OElUrgZUo4gO6ntkWIBjwIYrPglb5noNTeb6Wsvuqjl0vZjkt
	sgAAKesQmGWPo8wkagDWUYzif6v+Fd5WQmvqKLiYqrx6lJHaUosRUyTMPqGkHpqmyv/9M73in9eXl
	5ZJB98fh7FOB83SGxT1f1UL1LeuUDdL1KAzt+tC5BwQhwIw/Kfv2FJiERCmCer4K/tg2qzn2LxuD6
	FCU3HoaFyb6aBISmUu/LRWDmOZydZ8FfpH276W4qvrsA2jBgvSnu/VT/EzntvUv0wOCLiHwHk+V9Y
	uDmBmiBiMH84b8hrhizZflbIgoW1BxiVI6HSOZxp+FMi0sQqD+DttRTiN6RMZzkTL7Z9qdCtaFqy6
	o2SUNzb7Go93OB1GHrEl+TH4kL9pL5EcMT1eWLCFrfODM7EJRORXDGUSvKJgprDBtdpGnTFdBDigA
	ESG8nh0AYk6H7STsYJQKmXyS;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rm8JD-001XmP-1R;
	Mon, 18 Mar 2024 08:25:27 +0000
Message-ID: <0583f4be-4c34-44de-99f2-891d673b53a9@samba.org>
Date: Mon, 18 Mar 2024 09:25:25 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/24] vfs: break parent dir delegations in open(...,
 O_CREAT) codepath
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
 Paulo Alcantara <pc@manguebit.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Howells
 <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
 <20240315-dir-deleg-v1-6-a1d6209a3654@kernel.org>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20240315-dir-deleg-v1-6-a1d6209a3654@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
> 
> Add a delegated_inode parameter to lookup_open and have it break the
> delegation. Then, open_last_lookups can wait for the delegation break
> and retry the call to lookup_open once it's done.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/namei.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index f00d8d708001..88598a62ec64 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3404,7 +3404,7 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
>    */
>   static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>   				  const struct open_flags *op,
> -				  bool got_write)
> +				  bool got_write, struct inode **delegated_inode)

Does NFS has a concept of lease keys and parent lease keys?

In SMB it's possible that the client passes a lease key (16 client chosen bytes) to a directory open,
when asking for a directory lease.

Then operations on files within that directory, take that lease key from the directory as
'parent lease keys' in addition to a unique lease key for the file.

That way a client can avoid breaking its own directory leases when creating/move/delete... files
in the directory.

metze

