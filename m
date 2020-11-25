Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9B12C45EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 17:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbgKYQuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 11:50:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732068AbgKYQuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606323022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XZc3CPeOm1ZOxeaYmzK65nkw+8TNuZ7nhsmtRqGrSEo=;
        b=XWf3M3ZHGIWzSymrVwUA2CAOTh/FqhKon3J0/unajrGRjuYMgrgH4zDX+u8QKJ0APoNvKH
        I1fRiUhJZB0An0JupCQoqk669hX3Dr5o8FVychduv8ooN496RrVvUzl01SLZj7dvGTWw54
        R+HAODw02C/frTWN1W6tsTPPYA94+7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-bEjfIDKOOqarG3JXigFZCQ-1; Wed, 25 Nov 2020 11:50:20 -0500
X-MC-Unique: bEjfIDKOOqarG3JXigFZCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76FDD185E48A;
        Wed, 25 Nov 2020 16:50:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D604510021B3;
        Wed, 25 Nov 2020 16:50:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>
cc:     dhowells@redhat.com, sandeen@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: UAPI value collision: STATX_ATTR_MOUNT_ROOT vs STATX_ATTR_DAX
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1927369.1606323014.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 25 Nov 2020 16:50:14 +0000
Message-ID: <1927370.1606323014@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus, Miklos, Ira,

It seems that two patches that got merged in the 5.8 merge window collided=
 and
no one noticed until now:

80340fe3605c0 (Miklos Szeredi     2020-05-14 184) #define STATX_ATTR_MOUNT=
_ROOT		0x00002000 /* Root of a mount */
...
712b2698e4c02 (Ira Weiny          2020-04-30 186) #define STATX_ATTR_DAX		=
	0x00002000 /* [I] File is DAX */

The question is, what do we do about it?  Renumber one or both of the
constants?

David

