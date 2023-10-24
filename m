Return-Path: <linux-fsdevel+bounces-1106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898957D567E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 17:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9ECB21078
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794A9374D6;
	Tue, 24 Oct 2023 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1CgqSaw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20337176
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 15:32:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46869128
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698161571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQkfaaCAQ1Af+7bHw1N/VdJpdUsUZ58SgOvyNNX7tVo=;
	b=Q1CgqSaw9U6hV+othpFbmjoRYiECt6QmW7PqvTxnlRtBENJ/0lp4zfLRXhvDR0FaKUxVE/
	vf+I5bs1aCrB2ZCOwZs20+fqiG33VTYtnde/oA4YGNkKesdSKwgZFAzGE6NHHuzsHcu7lW
	3bpE9FhIuB2YlivmrZFbgweKa+zJ/XQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-5Dz5rAn6PWGZtFumSm4Xyw-1; Tue,
 24 Oct 2023 11:32:49 -0400
X-MC-Unique: 5Dz5rAn6PWGZtFumSm4Xyw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EDB22812943;
	Tue, 24 Oct 2023 15:32:44 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 704912166B2A;
	Tue, 24 Oct 2023 15:32:42 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: derive f_fsid from server's fsid
Date: Tue, 24 Oct 2023 11:32:40 -0400
Message-ID: <2382DA9B-D66B-41D9-8413-1C5319C01165@redhat.com>
In-Reply-To: <CAOQ4uxhe5pH3yRxFS_8pvtCgbXspKB6r9aacRJ8FysGQE2Hu9g@mail.gmail.com>
References: <20231024110109.3007794-1-amir73il@gmail.com>
 <1CFE0178-CE91-4C99-B43E-33EF78D0BEBF@redhat.com>
 <CAOQ4uxhe5pH3yRxFS_8pvtCgbXspKB6r9aacRJ8FysGQE2Hu9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 24 Oct 2023, at 10:58, Amir Goldstein wrote:

> On Tue, Oct 24, 2023 at 5:01 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 24 Oct 2023, at 7:01, Amir Goldstein wrote:
>>
>>> Fold the server's 128bit fsid to report f_fsid in statfs(2).
>>> This is similar to how uuid is folded for f_fsid of ext2/ext4/zonefs.
>>>
>>> This allows nfs client to be monitored by fanotify filesystem watch
>>> for local client access if nfs supports re-export.
>>>
>>> For example, with inotify-tools 4.23.8.0, the following command can be
>>> used to watch local client access over entire nfs filesystem:
>>>
>>>   fsnotifywatch --filesystem /mnt/nfs
>>>
>>> Note that fanotify filesystem watch does not report remote changes on
>>> server.  It provides the same notifications as inotify, but it watches
>>> over the entire filesystem and reports file handle of objects and fsid
>>> with events.
>>
>> I think this will run into trouble where an NFSv4 will report both
>> fsid.major and fsid.minor as zero for the special root filesystem.   We can
>> expect an NFSv4 client to have one of these per server.
>>
>> Could use s_dev from nfs_server for a unique major/minor for each mount on
>> the client, but these values won't be stable against a particular server
>> export.
>>
>
> That's a good point.
> Not sure I understand the relation between mount/server/export.
>
> If the client mounts the special NFSv4 root filesystem at /mnt/nfs,
> are the rest of the server exports going to be accessible via the same
> mount/sb or via new auto mounts of different nfs sb?

If we cross into a new filesystem on the server, then the client will also
cross and leave the "root" and have a new sb with non-zero fsid.

> In any case, f_fsid does not have to be uniform across all inodes
> of the same sb. This is the case with btrfs, where the the btrfs sb
> has inodes from the root volume and from sub-volumes.
> inodes from btrfs sub-volumes have a different f_fsid than inodes
> in the root btrfs volume.

This isn't what I'm worried about.  I'm worried about the case where an nfs
client will have multiple mounts with fsid's of 0:0, and those are
distinctly different mounts of the "root" of NFSv4 on different servers.

> We try to detect this case in fanotify, which currently does not
> support watching btrfs sub-volume for that reason.
> I have a WIP branch [1] for handling non-uniform f_fsid in
> fanotify by introducing the s_op->get_fsid(inode) method.
>
> Anyway, IIUC, my proposed f_fsid change is going to be fine for
> NFSv2/3 and best effort for NFSv4:
> - For NFSv2/3 mount, f_fsid is a good identifier?

Yes, it should represent the same filesystem on the server.  You could still
get duplicates between servers. What's returned in the protocol's u64 fsid
goes into major with minor always zero.

I'm sure there was discussion about what implementations should use long
ago, but that predates me.

> - For NFSv4 mount of a specific export, f_fsid is a good identifier?

Yes, but if the specific export is on the same server's filesystem as the
"root", you'll still get zero.  There are various ways to set fsid on
exports for linux servers, but the fsid will be the same for all exports of
the same filesystem on the server.

> - For the NFSv4 root export mount, f_fsid remains zero as it is now

Yes.

> Am I understanding this correctly?

I think so.

> Do you see a reason not to make this change?
> Do you see a reason to limit this change for NFSv2/3?

I'm not familiar with fanotify enough to know if having multiple fsid 0
mounts of different filesystems on different servers will do the right
thing.  I wanted to point out that very real possibility for v4.

Ben


