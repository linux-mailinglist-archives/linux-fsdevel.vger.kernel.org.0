Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C28EF5B73F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 10:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfGAIxG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 1 Jul 2019 04:53:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfGAIxF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:53:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E43F308FC4D;
        Mon,  1 Jul 2019 08:52:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 173CA19C6A;
        Mon,  1 Jul 2019 08:52:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <7a288c2c-11a1-87df-9550-b247d6ce3010@infradead.org>
References: <7a288c2c-11a1-87df-9550-b247d6ce3010@infradead.org> <156173701358.15650.8735203424342507015.stgit@warthog.procyon.org.uk> <156173703546.15650.14319137940607993268.stgit@warthog.procyon.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] Adjust watch_queue documentation to mention mount and superblock watches. [ver #5]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8211.1561971170.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 01 Jul 2019 09:52:50 +0100
Message-ID: <8212.1561971170@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 01 Jul 2019 08:53:05 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> I'm having a little trouble parsing that sentence.
> Could you clarify it or maybe rewrite/modify it?
> Thanks.

How about:

  * ``info_filter`` and ``info_mask`` act as a filter on the info field of the
    notification record.  The notification is only written into the buffer if::

	(watch.info & info_mask) == info_filter

    This could be used, for example, to ignore events that are not exactly on
    the watched point in a mount tree by specifying NOTIFY_MOUNT_IN_SUBTREE
    must not be set, e.g.::

	{
		.type = WATCH_TYPE_MOUNT_NOTIFY,
		.info_filter = 0,
		.info_mask = NOTIFY_MOUNT_IN_SUBTREE,
		.subtype_filter = ...,
	}

    as an event would be only permissible with this filter if::

    	(watch.info & NOTIFY_MOUNT_IN_SUBTREE) == 0

David
