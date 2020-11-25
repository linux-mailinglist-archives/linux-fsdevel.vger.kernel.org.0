Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD712C4A41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 22:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbgKYVuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 16:50:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731816AbgKYVuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606341054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mp282Smaff5KsuS78fUxDqkB3/vyAvKvszCkJZndWus=;
        b=NApACn6q3TjOEa+LH+L7qTbsPirbUveMOh1PR3tS21YL/HRc+CeiRFFyA1X/ULVp1pYTcQ
        Ojuiz0OUzKPvpM2+mGkbQ8yyyBQhf38r83tM2u29MSXEXFrcTewmgGfomJe93h/78ctMzt
        eYUyRGxYNYilqtLdE3Gk0LXOaAH41BQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-Oo534QX4P2my8z1LdDStpA-1; Wed, 25 Nov 2020 16:50:51 -0500
X-MC-Unique: Oo534QX4P2my8z1LdDStpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B373F101AFC0;
        Wed, 25 Nov 2020 21:50:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2F1A19C46;
        Wed, 25 Nov 2020 21:50:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201125212523.GB14534@magnolia>
References: <20201125212523.GB14534@magnolia> <33d38621-b65c-b825-b053-eda8870281d1@sandeen.net>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     dhowells@redhat.com, Eric Sandeen <sandeen@sandeen.net>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Clarification of statx->attributes_mask meaning?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1942930.1606341048.1@warthog.procyon.org.uk>
Date:   Wed, 25 Nov 2020 21:50:48 +0000
Message-ID: <1942931.1606341048@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick J. Wong <darrick.wong@oracle.com> wrote:

> mask=1 bit=0: "attribute not set on this file"
> mask=1 bit=1: "attribute is set on this file"
> mask=0 bit=0: "attribute doesn't fit into the design of this fs"

Or is "not supported by the filesystem driver in this kernel version".

> mask=0 bit=1: "filesystem is lying snake"

I like your phrasing :-)

> It's up to the fs driver and not the vfs to set attributes_mask, and
> therefore (as I keep pointing out to XiaoLi Feng) xfs_vn_getattr should
> be setting the mask.

Agreed.  I think there's some confusion stemming from STATX_ATTR_MOUNT_ROOT -
but that's supported by the *vfs* not by the filesystem.

David

