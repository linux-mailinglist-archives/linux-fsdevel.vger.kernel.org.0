Return-Path: <linux-fsdevel+bounces-25401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B64794B894
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 10:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EDA288837
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 08:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAB2189519;
	Thu,  8 Aug 2024 08:07:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF4B15444E;
	Thu,  8 Aug 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104458; cv=none; b=KwbbQN1Qxw9e8GAzxPdr7ahI6+LYcNI59FVTN6EJnT6Jm/POZIx5Cycu+i2cN5QYN/a9AU7zlHcvBuvcI/5dYE70Z4zK025tJ9zGZGDTppugWQY2TAQRawl5iOIsuWQBKNqce/biszk4RZMtJicQGMx62PhdJKVik+RQgObL6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104458; c=relaxed/simple;
	bh=BemnLbNZnMbV3JJfddi2l5f6/qJhZOt32VGqVnE2aGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDW64NmtC6LIp6JdN2zrqYNs/wNpPvCfCguFqaPPLBPVlWm6gav6be4CsLr0wFABETNf1szxnyfL+MnXAuuxWhYn/9y6NqSwYOABiqMzikUFatrRjOcMPbztx1vQ3Evlok+OJIuHhR2a3aaO2jMI/dQs09VdBff09vbzE8Rp9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 73F0741EE1;
	Thu,  8 Aug 2024 10:07:27 +0200 (CEST)
Message-ID: <d0ada96d-1805-44d2-b02c-eff64ec0c7d6@proxmox.com>
Date: Thu, 8 Aug 2024 10:07:24 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/40] netfs: Add iov_iters to (sub)requests to
 describe various buffers
To: David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 Steve French <smfrench@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-15-dhowells@redhat.com>
Content-Language: en-US, de-DE
From: Christian Ebner <c.ebner@proxmox.com>
In-Reply-To: <20231221132400.1601991-15-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

recently some of our (Proxmox VE) users report issues with file 
corruptions when accessing contents located on CephFS via the in-kernel 
ceph client [0,1]. According to these reports, our kernels based on 
(Ubuntu) v6.8 do show these corruptions, using the FUSE client or the 
in-kernel ceph client with kernels based on v6.5 does not show these.
Unfortunately the corruption is hard to reproduce.

After a further report of file corruption [2] with a completely 
unrelated code path, we managed to reproduce the corruption for one file 
by sheer chance on one of our ceph test clusters. We were able to narrow 
it down to be possibly an issue with reading of the contents via the 
in-kernel ceph client. Note that we can exclude the file contents itself 
being corrupt, as any not affected kernel version or the FUSE client 
gives the correct contents.

The issue is present also in the current mainline kernel 6.11-rc2.

Bisection with the reproducer points to this commit:

"92b6cc5d: netfs: Add iov_iters to (sub)requests to describe various 
buffers"

Description of the issue:

* file copied from local filesystem to cephfs via:
`cp /tmp/proxmox-backup-server_3.2-1.iso 
/mnt/pve/cephfs/proxmox-backup-server_3.2-1.iso`
* sha256sum on local filesystem:
`1d19698e8f7e769cf0a0dcc7ba0018ef5416c5ec495d5e61313f9c84a4237607 
/tmp/proxmox-backup-server_3.2-1.iso`
* sha256sum on cephfs with kernel up to above commit:
`1d19698e8f7e769cf0a0dcc7ba0018ef5416c5ec495d5e61313f9c84a4237607 
/mnt/pve/cephfs/proxmox-backup-server_3.2-1.iso`
* sha256sum on cephfs with kernel after above commit:
`89ad3620bf7b1e0913b534516cfbe48580efbaec944b79951e2c14e5e551f736 
/mnt/pve/cephfs/proxmox-backup-server_3.2-1.iso`
* removing and/or recopying the file does not change the issue, the 
corrupt checksum remains the same.
* Only this one particular file has been observed to show the issue, for 
others the checksums match.
* Accessing the same file from different clients results in the same 
output: The one with above patch applied do show the incorrect checksum, 
ones without the patch show the correct checksum.
* The issue persists even across reboot of the ceph cluster and/or clients.
* The file is indeed corrupt after reading, as verified by a `cmp -b`.

Does anyone have an idea what could be the cause of this issue, or how 
to further debug this? Happy to provide more information or a dynamic 
debug output if needed.

Best regards,

Chris

[0] https://forum.proxmox.com/threads/78340/post-676129
[1] https://forum.proxmox.com/threads/149249/
[2] https://forum.proxmox.com/threads/151291/


