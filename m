Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBF013AF7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgANQef (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:34:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27432 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726495AbgANQef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579019674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A61MDN9On2l+D0CHOHwV8RQgKf/LW4H2brHB54z57mg=;
        b=VtvOr6YF8lpN48BLT7s49eylbLLaKlhlyW3033dI4WxlWPBu95K82WcwvNQcWaJmsxkSRA
        vL/pPAlLMWSVNUxfbyrjvWxE6mCtRW8zFRdRkG7KuoXMpe/dLzyjWnkStSY4HuAyCvwz5j
        4O3HiPZbjkaUbvkiDF0BP4tf/gAjKM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-0Z8kJG3eO2Csx02l0D7gRA-1; Tue, 14 Jan 2020 11:34:30 -0500
X-MC-Unique: 0Z8kJG3eO2Csx02l0D7gRA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA5A0150153;
        Tue, 14 Jan 2020 16:34:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53BA780A48;
        Tue, 14 Jan 2020 16:34:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, hch@lst.de,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
cc:     dhowells@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Making linkat() able to overwrite the target
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3325.1579019665.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 14 Jan 2020 16:34:25 +0000
Message-ID: <3326.1579019665@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With my rewrite of fscache and cachefiles:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dfscache-iter

when a file gets invalidated by the server - and, under some circumstances=
,
modified locally - I have the cache create a temporary file with vfs_tmpfi=
le()
that I'd like to just link into place over the old one - but I can't becau=
se
vfs_link() doesn't allow you to do that.  Instead I have to either unlink =
the
old one and then link the new one in or create it elsewhere and rename acr=
oss.

Would it be possible to make linkat() take a flag, say AT_LINK_REPLACE, th=
at
causes the target to be replaced and not give EEXIST?  Or make it so that
rename() can take a tmpfile as the source and replace the target with that=
.  I
presume that, either way, this would require journal changes on ext4, xfs =
and
btrfs.

Thanks,
David

