Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4C1165DD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 13:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgBTMpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 07:45:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21222 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727931AbgBTMpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582202742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=goBkqnHTe+jpLAI1tMKYh/5HXzvRmb1T4YJS1+WLtPo=;
        b=ZVWC+IKracubS3NqYTuWLvVuXihNtDEBiDwc4c+oEmxPkrZQGHsiGplnr8xt/pYA5TEeYR
        EXgYepXEFs01fX1z9w57HZseAgYpSvCzBy3948TtS3Vv/mVsvPgAIq7QhLk7BpaH95tTBC
        RCWkos22wNfhtEcCEDp+lGCZSdXORps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-nUGEn3wlO9OXKY1E6Qwh3A-1; Thu, 20 Feb 2020 07:45:38 -0500
X-MC-Unique: nUGEn3wlO9OXKY1E6Qwh3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1270107ACC5;
        Thu, 20 Feb 2020 12:45:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D99765C28E;
        Thu, 20 Feb 2020 12:45:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200219165312.GD9504@magnolia>
References: <20200219165312.GD9504@magnolia> <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk> <158204553565.3299825.3864357054582488949.stgit@warthog.procyon.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/19] vfs: Introduce a non-repeating system-unique superblock ID [ver #16]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <626758.1582202733.1@warthog.procyon.org.uk>
Date:   Thu, 20 Feb 2020 12:45:33 +0000
Message-ID: <626759.1582202733@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick J. Wong <darrick.wong@oracle.com> wrote:

> Ahah, this is what the f_sb_id field is for.  I noticed a few patches
> ago that it was in a header file but was never set.
> 
> I'm losing track of which IDs do what...
> 
> * f_fsid is that old int[2] thing that we used for statfs.  It sucks but
>   we can't remove it because it's been in statfs since the beginning of
>   time.
> 
> * f_fs_name is a string coming from s_type, which is the name of the fs
>   (e.g. "XFS")?
> 
> * f_fstype comes from s_magic, which (for XFS) is 0x58465342.
> 
> * f_sb_id is basically an incore u64 cookie that one can use with the
>   mount events thing that comes later in this patchset?
> 
> * FSINFO_ATTR_VOLUME_ID comes from s_id, which tends to be the block
>   device name (at least for local filesystems)
> 
> * FSINFO_ATTR_VOLUME_UUID comes from s_uuid, which some filesystems fill
>   in at mount time.
> 
> * FSINFO_ATTR_VOLUME_NAME is ... left to individual filesystems to
>   implement, and (AFAICT) can be the label that one uses for things
>   like: "mount LABEL=foo /home" ?
> 
> Assuming I got all of that right, can we please capture what all of
> these "IDs" mean in the documentation?

Basically, yes.  Would it help if I:

 (1) Put the ID generation into its own patch, first.

 (2) Put the notification counter patches right after that.

 (3) Renamed the fields a bit, say:

	f_fsid		-> fsid
	f_fs_name	-> filesystem_name
	f_fstype	-> filesystem_magic
	f_sb_id		-> superblock_id
	f_dev_*		-> backing_dev_*

David

