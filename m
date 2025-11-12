Return-Path: <linux-fsdevel+bounces-68027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671AAC51471
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 10:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA6E421CEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FA92FE571;
	Wed, 12 Nov 2025 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdP5jmGf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E302BE02C;
	Wed, 12 Nov 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938072; cv=none; b=IbYqAGKwh0FIc+WIaGoSRnsxDMeIwtQR++IM/bFQeC+SVB1Mv0/o1vOkvMTr6w8O6JHhYn3BODfjMQNl+yI2nd7HCQ68FH7uKHg8IiMZRZ8NDovJaaPXg8lL6liQtdl12lKZBs8kg7+LXAycG7qurliYK88PVmny8iaziEBimqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938072; c=relaxed/simple;
	bh=NmxT3e9rVD+Vk0gwGiTwEsfo+VbVQUJ9eVtsypMNXuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjIRRlg54TReeS1MKEdXqZMJlYz4sTsQ14Evn9NObmG+g9VbSGcYYnj5EgTSrPT7sDHFa8coyGKrkoem+DiMeIT6HR/0UrRv7k/L1mQ9OunOXBG7JqH6rBSM+hkTbxc577N+IxKQRVERNzGp/D/mL7fm7KeRTsxGW8obojUksYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdP5jmGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6871C4CEF5;
	Wed, 12 Nov 2025 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762938071;
	bh=NmxT3e9rVD+Vk0gwGiTwEsfo+VbVQUJ9eVtsypMNXuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdP5jmGfLM+SqEuBX/RsMGAmFa8GSx+5s3qlPF12YVUgFuFMpcff20Xhp8BQtu318
	 XA2RUpFBp4/3lodTcuJD9YOxWBHcqQMk3h0u5+ME/+CzWeA+bk0+dKlaisCTBqHd6o
	 T355kOHQKyPmjbq0GoHZQNmcLvQtYngvT4iiH2Yz4Pxoon6WrwLqGla9zLz5WNvIde
	 cx9FOyjZdSQNY97ifMj9UKI2ssD71LcFv7Xa9qcxmE1cNFEdtAm9HMRRMZLh6u0A5a
	 AD1vXlXRa/op+Ax2MTk3mKPyO0SMhntbfLDp2az621cBgWCihv3p++dBVMO0VEQrwn
	 3SDY/PgaVZE9g==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-api@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Tyler Hicks <code@tyhicks.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v6 00/17] vfs: recall-only directory delegations for knfsd
Date: Wed, 12 Nov 2025 10:00:47 +0100
Message-ID: <20251112-allesamt-ursprung-7581bf774318@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
References: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3125; i=brauner@kernel.org; h=from:subject:message-id; bh=NmxT3e9rVD+Vk0gwGiTwEsfo+VbVQUJ9eVtsypMNXuc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+Jx86vPs+ErnB/wb72nN1on3KMp9zX7dQSQ82GOlr L4T45e1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5uY/hn/2qqoNLZz+dwN+8 MaJT8c46z87PsQEvsjp28yya0xLDk8bwTylL6cEuZvNOz6YbIjsbtC63ni4K0TY9cPOZxLVsp4t dPAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 11 Nov 2025 09:12:41 -0500, Jeff Layton wrote:
> Behold, another version of the directory delegation patchset. This
> version contains support for recall-only delegations. Support for
> CB_NOTIFY will be forthcoming (once the client-side patches have caught
> up).
> 
> The main changes here are in response to Jan's comments. I also changed
> struct delegation use to fixed-with integer types.
> 
> [...]

Applied to the vfs-6.19.directory.delegations branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.directory.delegations branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.directory.delegations

[01/17] filelock: make lease_alloc() take a flags argument
        https://git.kernel.org/vfs/vfs/c/6fc5f2b19e75
[02/17] filelock: rework the __break_lease API to use flags
        https://git.kernel.org/vfs/vfs/c/4be9f3cc582a
[03/17] filelock: add struct delegated_inode
        https://git.kernel.org/vfs/vfs/c/6976ed2dd0d5
[04/17] filelock: push the S_ISREG check down to ->setlease handlers
        https://git.kernel.org/vfs/vfs/c/e6d28ebc17eb
[05/17] vfs: add try_break_deleg calls for parents to vfs_{link,rename,unlink}
        https://git.kernel.org/vfs/vfs/c/b46ebf9a768d
[06/17] vfs: allow mkdir to wait for delegation break on parent
        https://git.kernel.org/vfs/vfs/c/e12d203b8c88
[07/17] vfs: allow rmdir to wait for delegation break on parent
        https://git.kernel.org/vfs/vfs/c/4fa76319cd0c
[08/17] vfs: break parent dir delegations in open(..., O_CREAT) codepath
        https://git.kernel.org/vfs/vfs/c/134796f43a5e
[09/17] vfs: clean up argument list for vfs_create()
        https://git.kernel.org/vfs/vfs/c/85bbffcad730
[10/17] vfs: make vfs_create break delegations on parent directory
        https://git.kernel.org/vfs/vfs/c/c826229c6a82
[11/17] vfs: make vfs_mknod break delegations on parent directory
        https://git.kernel.org/vfs/vfs/c/e8960c1b2ee9
[12/17] vfs: make vfs_symlink break delegations on parent dir
        https://git.kernel.org/vfs/vfs/c/92bf53577f01
[13/17] filelock: lift the ban on directory leases in generic_setlease
        https://git.kernel.org/vfs/vfs/c/d0eab9fc1047
[14/17] nfsd: allow filecache to hold S_IFDIR files
        https://git.kernel.org/vfs/vfs/c/544a0ee152f0
[15/17] nfsd: allow DELEGRETURN on directories
        https://git.kernel.org/vfs/vfs/c/80c8afddc8b1
[16/17] nfsd: wire up GET_DIR_DELEGATION handling
        https://git.kernel.org/vfs/vfs/c/8b99f6a8c116
[17/17] vfs: expose delegation support to userland
        https://git.kernel.org/vfs/vfs/c/1602bad16d7d

