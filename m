Return-Path: <linux-fsdevel+bounces-1480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4517DA786
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 16:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DBA28220C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ABC156FF;
	Sat, 28 Oct 2023 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLxKN153"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF669479
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 14:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B24C433C7;
	Sat, 28 Oct 2023 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698502618;
	bh=LMluMM37x5/WCOZzNMoon8iPuNJBI0Msy/UMZwDezlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CLxKN153rAa33+bumUre1oWn7p7aVbr5X+6QVmF8Z9hIiIbvgm7ww6QzuZpFYSfdo
	 ZTfjFp8OHp3bVrlXdo2sW6pV1JllNmAPVzVA3lO3LWZPwrI2kkWkgWUTAf/cyaO53m
	 TPMKBhFFGopV/S0l8QbP3mS57zK4chJVkEHm5OeVo7xxYFq+8DSciz/x9lTkkmNvxs
	 7SSzOopVqDDPdrUQhfCnfuyojuVesgUD3RRx87z3EuDRPFhyXpk3J6NJ8hF/Yp70p7
	 uFBzLNXSqBV+uR1msGkotV2MBiyq8sk0ltyrmhsVYTN1GGETpnJ9oSm2zamMSe1OxS
	 iOa5P5xZezyjA==
Date: Sat, 28 Oct 2023 16:16:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Dave Kleikamp <shaggy@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Altaparmakov <anton@tuxera.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Steve French <sfrench@samba.org>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	Evgeniy Dushistov <dushistov@mail.ru>
Subject: Re: [PATCH v2 2/4] exportfs: make ->encode_fh() a mandatory method
 for NFS export
Message-ID: <20231028-zonen-gasbetrieben-47ed8e61adb0@brauner>
References: <20231023180801.2953446-1-amir73il@gmail.com>
 <20231023180801.2953446-3-amir73il@gmail.com>
 <ZTtSrfBgioyrbWDH@infradead.org>
 <CAOQ4uxj_T9+0yTN1nFX+yzFUyLqeeO5n2mpKORf_NKf3Da8j-Q@mail.gmail.com>
 <CAOQ4uxgeCAi77biCVLQR6iHQT1TAWjWAhJv5_y6i=nWVbdhAWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgeCAi77biCVLQR6iHQT1TAWjWAhJv5_y6i=nWVbdhAWA@mail.gmail.com>

> Actually, Christian, since you already picked up the build fix and
> MAINTAINERS patch, cloud I bother you to fixup the commit
> message of this patch according to Christoph's request:
> 
>     exportfs: make ->encode_fh() a mandatory method for NFS export
> 
>     Rename the default helper for encoding FILEID_INO32_GEN* file handles
>     to generic_encode_ino32_fh() and convert the filesystems that used the
>     default implementation to use the generic helper explicitly.
> 
>     After this change, exportfs_encode_inode_fh() no longer has a default
>     implementation to encode FILEID_INO32_GEN* file handles.
> 
>     This is a step towards allowing filesystems to encode non-decodeable file
>     handles for fanotify without having to implement any export_operations.
> 
> 
> Might as well add hch RVB on patch #1 while at it.

Done, please check in vfs.f_fsid and yell if something is wrong.

