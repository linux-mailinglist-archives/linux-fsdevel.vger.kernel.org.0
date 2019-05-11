Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 103511A730
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 10:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfEKIkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 04:40:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfEKIkb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 04:40:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FA053092654;
        Sat, 11 May 2019 08:40:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAC1F27CC9;
        Sat, 11 May 2019 08:40:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190509155801.8369-1-christian@brauner.io>
References: <20190509155801.8369-1-christian@brauner.io>
To:     Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs: make all new mount api fds cloexec by default
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9331.1557564029.1@warthog.procyon.org.uk>
Date:   Sat, 11 May 2019 09:40:29 +0100
Message-ID: <9333.1557564029@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sat, 11 May 2019 08:40:31 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian@brauner.io> wrote:

> This makes all file descriptors returned from new syscalls of the new mount
> api cloexec by default.
> 
> From a userspace perspective it is rarely the case that fds are supposed to
> be inherited across exec. Having them not cloexec by default forces
> userspace to remember to pass the <SPECIFIC>_CLOEXEC flag along or to
> invoke fcntl() on the fd to prevent leaking it. And leaking the fd is a
> much bigger issue than forgetting to remove the cloexec flag and failing to
> inherit the fd.
> For old fd types we can't break userspace. But for new ones we should
> whenever reasonable make them cloexec by default (Examples of this policy
> are the new seccomp notify fds and also pidfds.). If userspace wants to
> inherit fds across exec they can remove the O_CLOEXEC flag and so opt in to
> inheritance explicitly.
> 
> This patch also has the advantage that we can get rid of all the special
> flags per file descriptor type for the new mount api. In total this lets us
> remove 4 flags:
> - FSMOUNT_CLOEXEC
> - FSOPEN_CLOEXEC
> - FSPICK_CLOEXEC
> - OPEN_TREE_CLOEXEC
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>

Fine by me.

Reviewed-by: David Howells <dhowells@redhat.com>
