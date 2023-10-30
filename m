Return-Path: <linux-fsdevel+bounces-1536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E627DB809
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 11:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302C72813EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBAD11C93;
	Mon, 30 Oct 2023 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2M5rcvD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5024D531
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 10:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24C1C433C9;
	Mon, 30 Oct 2023 10:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698661606;
	bh=rte+A2K+jSbcRVbrS+ysowBb49Lei6vykxyi/1K95rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h2M5rcvD98Btw6RcRgLl0pn8fNDURzyD9pustad0LTQHhVplKi9UqZH+5CtnaKt/1
	 eQtpJFfeXw4NqmBANWsgkHBmpZBSt6DRgCoHmVJVE7HEsZPkeIXzGzNuJAww0EO0PP
	 oGrGa1x4sNnWtUuNAvGYCWJyRxwvWCrCifCSkE2alV5thrHTHUkOMbMcda/rh6Q8we
	 t72Yk+TJ4LnAtpkt3QZQ6qctOEG9xGp55vKgJezXzraKJvBIj2MAOK5Yb1F7xHIcya
	 GPdKC7dAyESPHqWEGAkK8XvKew1VhgdE7NYJMOUpCRl68ALMATl6jJvOnWWkQ+5fSD
	 DTE2/IeyMmcPQ==
Date: Mon, 30 Oct 2023 11:26:37 +0100
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
Message-ID: <20231030-zuhalten-faktor-e22dccde22cf@brauner>
References: <20231023180801.2953446-1-amir73il@gmail.com>
 <20231023180801.2953446-3-amir73il@gmail.com>
 <ZTtSrfBgioyrbWDH@infradead.org>
 <CAOQ4uxj_T9+0yTN1nFX+yzFUyLqeeO5n2mpKORf_NKf3Da8j-Q@mail.gmail.com>
 <CAOQ4uxgeCAi77biCVLQR6iHQT1TAWjWAhJv5_y6i=nWVbdhAWA@mail.gmail.com>
 <20231028-zonen-gasbetrieben-47ed8e61adb0@brauner>
 <CAOQ4uxh3y1s90d9=Ap2s1BknVpHig7tVX58-=zn=1Ui8WcPqDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh3y1s90d9=Ap2s1BknVpHig7tVX58-=zn=1Ui8WcPqDw@mail.gmail.com>

> > Done, please check in vfs.f_fsid and yell if something is wrong.
> 
> I see no changes.
> Maybe you have forgotten to push the branch??

I fixed it all up on Saturday but then didn't push until this morning.

