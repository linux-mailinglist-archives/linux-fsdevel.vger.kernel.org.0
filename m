Return-Path: <linux-fsdevel+bounces-10919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 090B684F400
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A863D1F25159
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D18428DA7;
	Fri,  9 Feb 2024 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crw86jVZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7423025630;
	Fri,  9 Feb 2024 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476393; cv=none; b=b3JeSbvsy5WTKB5XI7LyXgPBg4OLeaN2FNOh9FQTYetyITuKzITpnUnUUXESe/E6peJMbtrXOX8JLlU06LSTsD7I6qi23R3fu+P+HcLRe+JHy5KAITfJKJlizRhayqaiLaIg4Ib0t2lg/zhRuQl/ADPM99vgU88ItSYQpSbWPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476393; c=relaxed/simple;
	bh=FFLWrgG2VHp3uRF0u3LiE7N3T26kky9+Tfd1oSmlI0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9q7WjOOD1dXLFsDOdvaCihYbUDqeMevDEG34g+nDgr7Yf40DM83wkQgvo9tAr197E+NDrJQ5sMMtmQBVcy2TH2uDJpFp+2RqXq5BoFt3sIiSveEhqQRMG2CJVHeHeAvVuaTtuK7cYxh8zk0tkyFB6c9ZyuDo0JP1+wTV8L24r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crw86jVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E54C433F1;
	Fri,  9 Feb 2024 10:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707476393;
	bh=FFLWrgG2VHp3uRF0u3LiE7N3T26kky9+Tfd1oSmlI0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=crw86jVZNx+OjqvNSgKMiIlh1/TuyaFkxQgr4lOvuHwA7ZCHOLYVT+QyTXRvtr8E8
	 /s7GrX5Ss4XUbblkURa43fzs05SGNFZ7inrSJ4HeSd7L7bmwXAhbd1w1yhaWt7NOpw
	 f5z1Zc6CZuPHLeBzs8rCrvIz4U8M2Jnm/Mj4JBKe8k9/KgN/uOtWTgEkjW+JqYw8IV
	 4SpzXjCDYQzlg94S1xkIFeFlgcqxu0I7gds9B/lmVVkgBqZuhMYxN5ARWrTr2xVB+9
	 XrSObopVoHJQlZGsPJkEBgToDVIebtPdh4CWv87vmMkSMXFS8QXJ2lyKZwbtNoKocc
	 TIa6PF8//FkEw==
Date: Fri, 9 Feb 2024 10:59:47 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Steve French <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: Re: [PATCH v5 09/12] cifs: Cut over to using netfslib
Message-ID: <20240209105947.GF1516992@kernel.org>
References: <20240205225726.3104808-1-dhowells@redhat.com>
 <20240205225726.3104808-10-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205225726.3104808-10-dhowells@redhat.com>

On Mon, Feb 05, 2024 at 10:57:21PM +0000, David Howells wrote:

...

> diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
> index e8e0f863e935..5cd547b7b5ea 100644
> --- a/fs/smb/client/cifsfs.h
> +++ b/fs/smb/client/cifsfs.h
> @@ -85,6 +85,7 @@ extern const struct inode_operations cifs_namespace_inode_operations;
>  
>  
>  /* Functions related to files and directories */
> +extern const struct netfs_request_ops cifs_req_ops;
>  extern const struct file_operations cifs_file_ops;
>  extern const struct file_operations cifs_file_direct_ops; /* if directio mnt */
>  extern const struct file_operations cifs_file_strict_ops; /* if strictio mnt */

Nit: this hunk would probably be better placed in the
     patch at adds cifs_req_ops to fs/smb/client/file.c

...

