Return-Path: <linux-fsdevel+bounces-7457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7479825221
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 11:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AF01C21175
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 10:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE67286B5;
	Fri,  5 Jan 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0U9IsNP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1568A2E3EB;
	Fri,  5 Jan 2024 10:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FFAC433C8;
	Fri,  5 Jan 2024 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704450846;
	bh=EsAKavy0GWz3zQK8s9XKK/HXklGdoTstOd7k03h30lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0U9IsNPozZgYWWC8Y3pbxdtD0bUsBDufoSawIQnDL4EB5ojEjF8Jth3vzIS13Ugc
	 8oDY8Ljk/3UxhiGPHI4WgL28Kq9jwbpzPbHwFXm4b46X8qrKc7emGM8HHEBcWG4/Bo
	 +RnrQJiWywula2Z1OaxnuocVUH/UEExziaBKPociI2OLHYUz0s+4nRRIn/L0e2Ywhs
	 LInWrA0njjtH1PnP5nAU8yaKSPpufnb5xjukJ8xApXi7v5fCErk+w3EQxsQlRnz24K
	 I3eIzBsYCbep9plLJghK6w6UOMSuRxr9SfQtKGughxU3wcO2fpVXi2MLdjjbfJWYfe
	 mfVRRk6+CS6Pw==
Date: Fri, 5 Jan 2024 11:33:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] netfs, cachefiles, 9p: Additional patches
Message-ID: <20240105-packen-inspektion-71fac65bf899@brauner>
References: <20240103145935.384404-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103145935.384404-1-dhowells@redhat.com>

On Wed, Jan 03, 2024 at 02:59:24PM +0000, David Howells wrote:
> Hi Christian, Jeff, Gao, Dominique,
> 
> Here are some additional patches for my netfs-lib tree:
> 
>  (1) Fix __cachefiles_prepare_write() to correctly validate against the DIO
>      alignment.
> 
>  (2) 9p: Fix initialisation of the netfs_inode so that i_size is set before
>      netfs_inode_init() is called.
> 
>  (3) 9p: Do a couple of cleanups (remove a couple of unused vars and turn a
>      BUG_ON() into a warning).
> 
>  (4) 9p: Always update remote_i_size, even if we're asked not to update
>      i_size in stat2inode.
> 
>  (5) 9p: Return the amount written in preference to an error if we wrote
>      something.
> 
> David
> 
> The netfslib postings:
> Link: https://lore.kernel.org/r/20231013160423.2218093-1-dhowells@redhat.com/ # v1
> Link: https://lore.kernel.org/r/20231117211544.1740466-1-dhowells@redhat.com/ # v2
> Link: https://lore.kernel.org/r/20231207212206.1379128-1-dhowells@redhat.com/ # v3
> Link: https://lore.kernel.org/r/20231213152350.431591-1-dhowells@redhat.com/ # v4
> Link: https://lore.kernel.org/r/20231221132400.1601991-1-dhowells@redhat.com/ # v5

Pulled this into vfs.netfs. Thanks, David.

