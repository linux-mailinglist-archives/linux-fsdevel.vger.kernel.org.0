Return-Path: <linux-fsdevel+bounces-74569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 78272D3BE61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 05:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0692346526
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 04:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5263A347FEC;
	Tue, 20 Jan 2026 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlpT91Dh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17530347BC4
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768883290; cv=none; b=AqUQZG2m3V+zg1r/iCXjs8Id3+59+7jd2DSWq15wc8fvrWoP2ubX/0pzwOBoguCN90JxFqCTgHHa3UPQoJJnX70Vcko2OjKlpRLnGNDMv62mhB1LQxR/wJYseLSP8yhFO688YYavEzg8RIBT/Dm9vYfoApQ91wRUKjcj6m20Rpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768883290; c=relaxed/simple;
	bh=qNPmRJGZ0im9Q72KFKuql+4Y7InQDN+kDuiWoba0+tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2UmBQSfyeujFsSIDe51cPJFjkk8j797a/o+9NnBkDwP36ilZTSstEdzoc9aLI1lx6P97bWGTi4yZ6yeaopnMvv9PXqCHByUNOpFqx46G2/Eg0WtcJhKwJ6nHXcaqli7aAmP1RKHdTrl2m35sHIxYdWNrvGpiO8K2T86YsDAYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlpT91Dh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD468C4AF0E
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768883288;
	bh=qNPmRJGZ0im9Q72KFKuql+4Y7InQDN+kDuiWoba0+tY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IlpT91Dh3+2fqOigRCjuXf9Kmumy2S4dNOxPQTiYuk/QjBY2GNd2+Za2Clr3IcKl2
	 8lveOeahk31VC2awQNv2Hf4ebJmM/IhiioKUky+RF4VKAjUrIlnuP8ODexaoRt0BuT
	 md9OhQM3ttFuZTgeM7CvykQ6ebauxSBfH0XF4mXligMDi9qAGvdb6qbymdTr98Jvmw
	 uVpEAET+21vZVhf38rXyvSVKgx8HmRbR9pccCfHauaActT6BI+VnRvBSnuebRlv8xU
	 UOZWpq7QNU67Iv9l9L7yXBlJdnVo11ARosQzbOZtuq0egHZc363NieSNWg4rRPmD2C
	 SRlPOSgpny03Q==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so1145416666b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 20:28:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXS7fdIVYgphmZj24jXgxCDp1BOnBFmotua4ZKGxufMG0zftlgJYxM3rk0IR/qd1eknk4vD0dhJ5bzeh2jv@vger.kernel.org
X-Gm-Message-State: AOJu0YzR0e1sEH9GHImbZl4Df10Jo3M2dIaQXBIfsDyLfoJ2b8qT/d3F
	T4SfPY6L5YLVYKLcYxdQCZBfrwKNejyAicwnXEfadtLDoBaI62e7nm80LPyzQgWzbXrAqwsvuN4
	n+IDg/EDotua0NVq4vz2f8IpXG9D+6PM=
X-Received: by 2002:a17:907:86a2:b0:b87:2579:b6cc with SMTP id
 a640c23a62f3a-b88003420c0mr49583566b.37.1768883287390; Mon, 19 Jan 2026
 20:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-3-linkinjeon@kernel.org>
 <20260116082352.GB15119@lst.de> <CAKYAXd9SeJYhBOOK6rZ+0c4G42wvFZkjJ9vGnSrythsz55WLwA@mail.gmail.com>
 <20260119070527.GB1480@lst.de>
In-Reply-To: <20260119070527.GB1480@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 20 Jan 2026 13:27:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_Kio7Xeh1SnbZtxrh8nvenQ8RZ59p9RyhE2MSSUbjnMw@mail.gmail.com>
X-Gm-Features: AZwV_QiTTeeeJelDGSYQxit8QYzj3aNmHlIy4O9-IsagCGyVNWpudUvq6AKpM9E
Message-ID: <CAKYAXd_Kio7Xeh1SnbZtxrh8nvenQ8RZ59p9RyhE2MSSUbjnMw@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] ntfs: update in-memory, on-disk structures and headers
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 4:05=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sun, Jan 18, 2026 at 01:54:06PM +0900, Namjae Jeon wrote:
> > > It seem like big_ntfs_inode is literally only used in the conversion
> > > helpers below.  Are there are a lot of these "extent inode" so that
> > > not having the vfs inode for them is an actual saving?
> > Right, In NTFS, a base MFT record (represented by the base ntfs_inode)
> > requires a struct inode to interact with the VFS. However, a single
> > file can have multiple extent MFT records to store additional
> > attributes. These extent inodes are managed internally by the base
> > inode and do not need to be visible to the VFS.
>
> What are typical numbers of the extra extent inodes?  If they are rare,
> you might be able to simplify the code a bit by just always allocating
> the vfs_inode even if it's not really used.
Regarding the typical numbers, in most cases, It will require zero or
only a few extra extent inodes. Okay, I will move vfs_inode to
ntfs_inode.
Thanks!


>
> Nothing important, though - just thinking along.
>

