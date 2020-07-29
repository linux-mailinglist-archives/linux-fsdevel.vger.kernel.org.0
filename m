Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A750232639
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 22:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgG2UhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 16:37:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43239 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726365AbgG2UhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596055028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JKV4hl15ZgHUpqQ9Lksec6wqiZBzDGUrjHq91E2NpOk=;
        b=ONeHrwZc0zLgtsmWr2tNuHtrYlWGYT3AiTxdf9cXhUSLC3LcQSzvbmUatCJcCWKbB4CA3R
        2KVX3H7MawdAagqz8MjEmMg89oaFXUfGr5svlTaGPwhbVcOPUqWVNUEd9zybpVUgT8E31J
        /oC4aW3Q04eTTbnMnTjinWfKlXabcqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-Jb_l5AyvN1uvbQWUg6XcCA-1; Wed, 29 Jul 2020 16:37:04 -0400
X-MC-Unique: Jb_l5AyvN1uvbQWUg6XcCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F19C8005B0;
        Wed, 29 Jul 2020 20:37:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8CDA5F7D8;
        Wed, 29 Jul 2020 20:36:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <0b154b9b-728f-7d57-d4c5-ec25fc9dfdf3@toxicpanda.com>
References: <0b154b9b-728f-7d57-d4c5-ec25fc9dfdf3@toxicpanda.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: Inverted mount options completely broken (iversion,relatime)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4007795.1596055016.1@warthog.procyon.org.uk>
Date:   Wed, 29 Jul 2020 21:36:56 +0100
Message-ID: <4007797.1596055016@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Josef Bacik <josef@toxicpanda.com> wrote:

> So my question is, what do we do here?

Hmmm...  As the code stands, MS_RDONLY, MS_SYNCHRONOUS, MS_MANDLOCK,
MS_I_VERSION and MS_LAZYTIME should all be masked off before the new flags are
set if called from mount(2) rather than fsconfig(2).

do_remount() gives MS_RMT_MASK to fs_context_for_reconfigure() to load into
fc->sb_flags_mask, which should achieve the desired effect in
reconfigure_super() on this line:

	WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
				 (fc->sb_flags & fc->sb_flags_mask)));

David

