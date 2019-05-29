Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C6A2DB50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 13:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfE2LBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 07:01:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2LBB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 07:01:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B7E181109;
        Wed, 29 May 2019 11:01:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 894035D704;
        Wed, 29 May 2019 11:00:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com>
References: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>, casey@schaufler-ca.com
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        raven@themaw.net, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14346.1559127657.1@warthog.procyon.org.uk>
Date:   Wed, 29 May 2019 12:00:57 +0100
Message-ID: <14347.1559127657@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 29 May 2019 11:01:01 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> > +void post_mount_notification(struct mount *changed,
> > +                            struct mount_notification *notify)
> > +{
> > +       const struct cred *cred = current_cred();
> 
> This current_cred() looks bogus to me. Can't mount topology changes
> come from all sorts of places? For example, umount_mnt() from
> umount_tree() from dissolve_on_fput() from __fput(), which could
> happen pretty much anywhere depending on where the last reference gets
> dropped?

IIRC, that's what Casey argued is the right thing to do from a security PoV.
Casey?

Maybe I should pass in NULL creds in the case that an event is being generated
because an object is being destroyed due to the last usage[*] being removed.

 [*] Usage, not ref - Superblocks are a bit weird in their accounting.

David
