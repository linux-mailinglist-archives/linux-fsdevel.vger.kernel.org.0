Return-Path: <linux-fsdevel+bounces-25680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90CD94ED92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC381C21780
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5673D17BB3D;
	Mon, 12 Aug 2024 13:02:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05864D8D1;
	Mon, 12 Aug 2024 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467726; cv=none; b=AhCW2rRYTEEpjX99hTG1q/v83EftL/tbe6mYcEczH4z4OBFgPZ0j1o6W59A97l08dIAyuPmvW2TZo2nlWuW3Py2j1KTude+G4rjyMtMCBnD7OcXPioUmomS++2j28dP9GsbwCSSwj50hPrGI2rrTn/S8ckEWox3tXT8mIZBnaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467726; c=relaxed/simple;
	bh=as8kn+c7p1Dq/fpAWxsQXzGWdCzINA9p7OO4grgDg74=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZYUyE/uPaoMerS67FvXPyY1Fe19/VtQETWzvz3XTtldNd/Q/5KhER6kvv3FxSjIQUlCBjH5N/MGHJ2fuv2MqIXN2E6fZKIkx1IKPkLpUguO3o0bKzkp9uG7D0GJqMriteoadkscutx5LeJxpC+2QnRjOSWDBQvJ00cXxj8Qhsis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 35255464CE;
	Mon, 12 Aug 2024 15:01:55 +0200 (CEST)
Message-ID: <db686d0c-2f27-47c8-8c14-26969433b13b@proxmox.com>
Date: Mon, 12 Aug 2024 15:01:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/40] netfs: Add iov_iters to (sub)requests to
 describe various buffers
From: Christian Ebner <c.ebner@proxmox.com>
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
 <d0ada96d-1805-44d2-b02c-eff64ec0c7d6@proxmox.com>
Content-Language: en-US, de-DE
In-Reply-To: <d0ada96d-1805-44d2-b02c-eff64ec0c7d6@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 10:07, Christian Ebner wrote:
> Hi,
> 
> recently some of our (Proxmox VE) users report issues with file 
> corruptions when accessing contents located on CephFS via the in-kernel 
> ceph client [0,1]. According to these reports, our kernels based on 
> (Ubuntu) v6.8 do show these corruptions, using the FUSE client or the 
> in-kernel ceph client with kernels based on v6.5 does not show these.
> Unfortunately the corruption is hard to reproduce.
> 
> After a further report of file corruption [2] with a completely 
> unrelated code path, we managed to reproduce the corruption for one file 
> by sheer chance on one of our ceph test clusters. We were able to narrow 
> it down to be possibly an issue with reading of the contents via the 
> in-kernel ceph client. Note that we can exclude the file contents itself 
> being corrupt, as any not affected kernel version or the FUSE client 
> gives the correct contents.
> 
> The issue is present also in the current mainline kernel 6.11-rc2.
> 
> Bisection with the reproducer points to this commit:
> 
> "92b6cc5d: netfs: Add iov_iters to (sub)requests to describe various 
> buffers"
> 
> Description of the issue:
> 
> * file copied from local filesystem to cephfs via:
> `cp /tmp/proxmox-backup-server_3.2-1.iso 
> /mnt/pve/cephfs/proxmox-backup-server_3.2-1.iso`
> * sha256sum on local filesystem:
> `1d19698e8f7e769cf0a0dcc7ba0018ef5416c5ec495d5e61313f9c84a4237607 
> /tmp/proxmox-backup-server_3.2-1.iso`
> * sha256sum on cephfs with kernel up to above commit:
> `1d19698e8f7e769cf0a0dcc7ba0018ef5416c5ec495d5e61313f9c84a4237607 
> /mnt/pve/cephfs/proxmox-backup-server_3.2-1.iso`
> * sha256sum on cephfs with kernel after above commit:
> `89ad3620bf7b1e0913b534516cfbe48580efbaec944b79951e2c14e5e551f736 
> /mnt/pve/cephfs/proxmox-backup-server_3.2-1.iso`
> * removing and/or recopying the file does not change the issue, the 
> corrupt checksum remains the same.
> * Only this one particular file has been observed to show the issue, for 
> others the checksums match.
> * Accessing the same file from different clients results in the same 
> output: The one with above patch applied do show the incorrect checksum, 
> ones without the patch show the correct checksum.
> * The issue persists even across reboot of the ceph cluster and/or clients.
> * The file is indeed corrupt after reading, as verified by a `cmp -b`.
> 
> Does anyone have an idea what could be the cause of this issue, or how 
> to further debug this? Happy to provide more information or a dynamic 
> debug output if needed.
> 
> Best regards,
> 
> Chris
> 
> [0] https://forum.proxmox.com/threads/78340/post-676129
> [1] https://forum.proxmox.com/threads/149249/
> [2] https://forum.proxmox.com/threads/151291/

Hi,

please allow me to send a followup regarding this:

Thanks to a suggestion by my colleague Friedrich Weber we have some 
further interesting findings.

The issue is related to the readahead size passed to `mount.ceph`, when 
mounting the filesystem [0].

Passing an `rasize` in the range of [0..1k] leads to the correct 
checksum, independent of the bisected patch being applied or not.
Ranges from (1k..1M] lead to corrupt, but different checksums for 
different `rasize` values, and finally `rasize` values above 1M lead to 
a corrupt, but constant checksum value. Again, without the bisected 
patch, the issue is not present.

Please let me know if I can provide further information or debug outputs 
in order to narrow down the issue.

Best regards,
Chris

[0] https://docs.ceph.com/en/reef/man/8/mount.ceph/#advanced


