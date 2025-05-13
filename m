Return-Path: <linux-fsdevel+bounces-48817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ECFAB4E1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE2A3AA4FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 08:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AAA20DD52;
	Tue, 13 May 2025 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvFCtkWi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13671DDC04
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747125054; cv=none; b=j/EBqLmscphQ28bNNlAJOL5l5HCNXR/WEdPYdbCXm9ZGHLMwU1g4YtQ0oc/ES7uF3gtbzgojAyxUwuu3MJBp7IulE4JmVkuZopXLUmCpx1PcSX5X662SnqFCzuLykP6Luzn2Q5GqR6DM695wmxfv1iACdQi2MHFilOfMi35MOdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747125054; c=relaxed/simple;
	bh=lKCD5p78XTapKoayaaiCjdiJ6kTlhoeA/8korK3+dPI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=uuB24GdiKt4kTAr6pXz4TnR/nWlnZQSrZKbRWArm/Q/40rCK4iYTHvf5sRX0tHy6JZroJXjMWSjcQFHKGVktZ0/hhJq2aCHaNGsjPP0MV8kIfv64MsxNVocWj/Gtv83UQWqZiz6NI3DwaK5kBIMhecR6iuFbf8YbPTHS/Kv1RVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvFCtkWi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747125051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=djX5rz1QOMfyKf29sDrWfCxXgFvZbFqAZlnot23wFwY=;
	b=WvFCtkWip29WCJGFhUFpmaqUYUOp1yNTHMGcPHrXEKaXZolWDsRqNknKWdvcAryIqCDrJg
	RSFKpj9YIuopY66j4blz5l1L0L0AiCxgFrKWxuFk9UbmHkFoeCMMxd+AxSq34UFSxZxqro
	fypJzOuUDCLJC19Ow7UM+EpaAp28QCE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-0lT6ZzMhMJOpP4u8BCSH5A-1; Tue,
 13 May 2025 04:30:48 -0400
X-MC-Unique: 0lT6ZzMhMJOpP4u8BCSH5A-1
X-Mimecast-MFC-AGG-ID: 0lT6ZzMhMJOpP4u8BCSH5A_1747125046
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A36019560AA;
	Tue, 13 May 2025 08:30:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C864C1955EA0;
	Tue, 13 May 2025 08:30:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250513-dividende-kursniveau-014674876b04@brauner>
References: <20250513-dividende-kursniveau-014674876b04@brauner> <20250509-deckung-glitschig-8d27cb12f09f@brauner> <20250505-erproben-zeltlager-4c16f07b96ae@brauner> <433928.1745944651@warthog.procyon.org.uk> <1209711.1746527190@warthog.procyon.org.uk> <2086612.1747054957@warthog.procyon.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
    Etienne Champetier <champetier.etienne@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jeffrey Altman <jaltman@auristor.com>,
    Chet Ramey <chet.ramey@case.edu>, Steve French <sfrench@samba.org>,
    linux-afs@lists.infradead.org, openafs-devel@openafs.org,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] afs, bash: Fix open(O_CREAT) on an extant AFS file in a sticky dir
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2164800.1747125039.1@warthog.procyon.org.uk>
Date: Tue, 13 May 2025 09:30:39 +0100
Message-ID: <2164801.1747125039@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Christian Brauner <brauner@kernel.org> wrote:

> There's a few other places where we compare vfsuids:
> 
> * may_delete()
>   -> check_sticky()
>      -> __check_sticky()
> 
> * may_follow_link()
> 
> * may_linkat()
> 
> * fsuidgid_has_mapping()
> 
> Anyone of those need special treatment on AFS as well?

That's a good question.  I think it might be better to switch back to the v1
patch - which gives me two separate ops and provide a couple of vfs wrappers
for them and use them more widely.

So, perhaps:

	vfs_have_same_owner(inode1, inode2)

which indicates if the two inodes have the same ownership and:

	vfs_is_owned_by_me(inode)

which compares the inode's ownership to current_fsuid() by default.

The following places need to be considered for being changed:

 (*) chown_ok()
 (*) chgrp_ok()

     Should call vfs_is_owned_by_me().  Possibly these need to defer all their
     checks to the network filesystem as the interpretation of the target
     UID/GID depends on the netfs.

 (*) do_coredump()

     Should probably call vfs_is_owned_by_me() to check that the file created
     is owned by the caller - but the check that's there might be sufficient.

 (*) inode_owner_or_capable()

     Should call vfs_is_owned_by_me().  I'm not sure whether the namespace
     mapping makes sense in such a case, but it probably could be used.

 (*) vfs_setlease()

     Should call vfs_is_owned_by_me().  Actually, it should query if leasing
     is permitted.

     Also, setting locks could perhaps do with a permission call to the
     filesystem driver as AFS, for example, has a lock permission bit in the
     ACL, but since the AFS server checks that when the RPC call is made, it's
     probably unnecessary.

 (*) acl_permission_check()
 (*) posix_acl_permission()

     UIDs are part of these ACLs, so no change required.  AFS implements its
     own ACLs and evaluates them in ->permission() and on the server.

 (*) may_follow_link()

     Should call vfs_is_owned_by_me() and also vfs_have_same_owner() on the
     the link and its parent dir.  The latter only applies on world-writable
     sticky dirs.

 (*) may_create_in_sticky()

     The initial subject of this patch.  Should call vfs_is_owned_by_me() and
     also vfs_have_same_owner() both.

 (*) __check_sticky()

     Should call vfs_is_owned_by_me() on both the dir and the inode.

 (*) may_dedupe_file()

     Should call vfs_is_owned_by_me().

 (*) IMA policy ops.

     No idea.

David


