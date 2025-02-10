Return-Path: <linux-fsdevel+bounces-41386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FA7A2EAC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 12:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7553A6001
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 11:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DC31CF5C0;
	Mon, 10 Feb 2025 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVs0UWAq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF461C5D7C
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185971; cv=none; b=ne5Zq4t1Ls7NuC406Qsy3eQ++pQhsHII/G9E7wcXdLE9onAil5oZAFODV6ClBNrnriUvXoINA9jEq127ukJUAZiGtVHkbTaw8S7uQxGvV58o6bdmlKFhlAx+ywm567dicldBJz9YetkP3HcXzZG8gkoUWlFpWwNY/uy5o+Dlufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185971; c=relaxed/simple;
	bh=kLa245Ex+g41bu7Cp8rMbIVdC/gRWBdIQ6HQlDIJzmE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=W3iU8P1/5wsz4tj8GCVWcAG2AMpNLDsawgQjuaG/wBPysOSoYT+Suvyp7gK2sQKqhZ5V6PuKG+5XH15sdozqVJA4apG+YfqjNrsEy5u66xTW1x8tsnY0W3c++TRxc8Azf3cicUxSurm3MlnFjjPH1hPaxF8zgx3W8D7M2Dr6PPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVs0UWAq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739185968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XghnrJPPKnRqzZD+n1h385B8O5oGF3rpRLFRKp+cnJM=;
	b=FVs0UWAqSwSIGogsol4T14VxzSQsxd7oZQGofvkmhQG+vGrFsV5naD+YQbnQX72pd1G+X3
	AqMxEB9r1v966u68oevkvYjx6T9ilOxjW2AKfJQqbHbW+TYu4zL32fEW1kIa+FVOFFHIcf
	MnJbt6Ynci3SgScxsIEJViBmWHbMZZ4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-lL-aKo8QNE22K11qKeSweQ-1; Mon,
 10 Feb 2025 06:12:46 -0500
X-MC-Unique: lL-aKo8QNE22K11qKeSweQ-1
X-Mimecast-MFC-AGG-ID: lL-aKo8QNE22K11qKeSweQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEA431800873;
	Mon, 10 Feb 2025 11:12:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D41DB195608D;
	Mon, 10 Feb 2025 11:12:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <335ad811ae2cf5ebdfc494c185b9f02e9ca40c3e@linux.dev>
References: <335ad811ae2cf5ebdfc494c185b9f02e9ca40c3e@linux.dev> <3173328.1738024385@warthog.procyon.org.uk> <3187377.1738056789@warthog.procyon.org.uk>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: dhowells@redhat.com, "Marc Dionne" <marc.dionne@auristor.com>,
    "Steve French" <stfrench@microsoft.com>,
    "Eric Van Hensbergen" <ericvh@kernel.org>,
    "Latchesar
 Ionkov" <lucho@ionkov.net>,
    "Dominique Martinet" <asmadeus@codewreck.org>,
    "Christian Schoenebeck" <linux_oss@crudebyte.com>,
    "Paulo Alcantara" <pc@manguebit.com>,
    "Jeff Layton" <jlayton@kernel.org>,
    "Christian Brauner" <brauner@kernel.org>, v9fs@lists.linux.dev,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    ast@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] netfs: Add retry stat counters
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2986468.1739185956.1@warthog.procyon.org.uk>
Date: Mon, 10 Feb 2025 11:12:36 +0000
Message-ID: <2986469.1739185956@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Ihor Solodrai <ihor.solodrai@linux.dev> wrote:

> Bash piece starting a process collecting /proc/fs/netfs/stats:
> 
>     function tail_netfs {
>         echo -n > /mnt/vmtest/netfs-stats.log
>         while true; do
>             echo >> /mnt/vmtest/netfs-stats.log
>             cat /proc/fs/netfs/stats >> /mnt/vmtest/netfs-stats.log
>             sleep 1
>         done
>     }
>     export -f tail_netfs
>     nohup bash -c 'tail_netfs' & disown

I'm afraid, intermediate snapshots of this file aren't particularly useful -
just the last snapshot:

> Last recored /proc/fs/netfs/stats (note 0 retries):
> 
>     Reads  : DR=0 RA=15184 RF=5 RS=0 WB=0 WBZ=0
>     Writes : BW=488 WT=0 DW=0 WP=488 2C=0
>     ZeroOps: ZR=7964 sh=0 sk=0
>     DownOps: DL=15189 ds=15189 df=0 di=0
>     CaRdOps: RD=0 rs=0 rf=0
>     UpldOps: UL=488 us=488 uf=0
>     CaWrOps: WR=0 ws=0 wf=0
>     Retries: rq=0 rs=0 wq=0 ws=0
>     Objs   : rr=2 sr=1 foq=1 wsc=0
>     WbLock : skip=0 wait=0
>     -- FS-Cache statistics --
>     Cookies: n=0 v=0 vcol=0 voom=0
>     Acquire: n=0 ok=0 oom=0
>     LRU    : n=0 exp=0 rmv=0 drp=0 at=0
>     Invals : n=0
>     Updates: n=0 rsz=0 rsn=0
>     Relinqs: n=0 rtr=0 drop=0
>     NoSpace: nwr=0 ncr=0 cull=0
>     IO     : rd=0 wr=0 mis=0

Could you collect some tracing:

echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_read/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_write/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_write_iter/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_rreq/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_rreq_ref/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_sreq/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_sreq_ref/enable
echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_failure/enable

and then collect the tracelog:

trace-cmd show | bzip2 >some_file_somewhere.bz2

And if you could collect /proc/fs/netfs/requests as well, that will show the
debug IDs of the hanging requests.  These can be used to grep the trace by
prepending "R=".  For example, if you see:

	REQUEST  OR REF FL ERR  OPS COVERAGE
	======== == === == ==== === =========
	00000043 WB   1 2120    0   0 @34000000 0/0

then:

	trace-cmd show | grep R=00000043

Thanks,
David


