Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E0423D11D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 21:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgHET4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 15:56:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26153 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727898AbgHEQoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596645859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ymSp4PIW1iklpKRZ7s5LPng5aoYV9shgptoEdnu23SM=;
        b=cZHcYmzE9r/tv3b5wNvyxrcDtlq/aaTlJVxzu1IOxFW+CWRiWP3lAopcjTEGuEPhkCUQLW
        LQsgFnpqaOdu+AsTu1x+NSNfFbM5+XTmb5ovbZJr2efWifiYnl+6ev1S8ei01jLcQJsGSA
        dlOjULjDpMp2wwb8Bh4H4BWtdphvFzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-4W7hKjd4NCeORz2QHj-HnQ-1; Wed, 05 Aug 2020 12:44:17 -0400
X-MC-Unique: 4W7hKjd4NCeORz2QHj-HnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4333957;
        Wed,  5 Aug 2020 16:44:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDCF65F202;
        Wed,  5 Aug 2020 16:44:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200804140558.GF32719@miu.piliscsaba.redhat.com>
References: <20200804140558.GF32719@miu.piliscsaba.redhat.com> <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk> <159646191446.1784947.11228235431863356055.stgit@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/18] fsinfo: Add an attribute that lists all the visible mounts in a namespace [ver #21]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2325154.1596645852.1@warthog.procyon.org.uk>
Date:   Wed, 05 Aug 2020 17:44:12 +0100
Message-ID: <2325155.1596645852@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> > where each element contains a once-in-a-system-lifetime unique ID, the
> > mount ID (which may get reused), the parent mount ID and sums of the
> > notification/change counters for the mount and its superblock.
> 
> The change counters are currently conditional on CONFIG_MOUNT_NOTIFICATIONS.
> Is this is intentional?

Yeah - the counters aren't driven unless CONFIG_MOUNT_NOTIFICATIONS=y.

I could perhaps make it so they're driven in both cases, but driving the
in-subtree counter is somewhat tied up in the notification posting.

This is something that can be fixed after this patchset is taken - if it is
taken since that doesn't change the UAPI.

David

