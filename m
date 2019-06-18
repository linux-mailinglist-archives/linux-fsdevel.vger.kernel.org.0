Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABFA4ADD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 00:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfFRWYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 18:24:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730519AbfFRWYe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:24:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D4D187633;
        Tue, 18 Jun 2019 22:24:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72D941001DC3;
        Tue, 18 Jun 2019 22:24:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegtkpNNOOWQ3TnLPGSm=bwL2otQp1--GjNNFiXO7imMxEQ@mail.gmail.com>
References: <CAJfpegtkpNNOOWQ3TnLPGSm=bwL2otQp1--GjNNFiXO7imMxEQ@mail.gmail.com> <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk> <155905627049.1662.17033721577309385838.stgit@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Ian Kent <raven@themaw.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 01/25] vfs: syscall: Add fsinfo() to query filesystem information [ver #13]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23582.1560896665.1@warthog.procyon.org.uk>
Date:   Tue, 18 Jun 2019 23:24:25 +0100
Message-ID: <23583.1560896665@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 18 Jun 2019 22:24:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> Please don't resurrect MS_ flags.  They are from the old API and
> shouldn't be used in the new one.  Some of them (e.g. MS_POSIXACL,
> MS_I_VERSION) are actually internal flags despite being exported on
> the old API.

That makes it harder to emulate statfs() using this interface, but ok.

I wonder if I should split the standard parameters (rw/ro, posixacl, dirsync,
sync, lazytime, mand) out of FSINFO_ATTR_PARAMETERS and stick them in their
own attribute, say FSINFO_ATTR_STD_PARAMETERS.  That would make it easier for
a filesystem to only overload them if it wants to.

> And there's SB_SILENT which is simply not a superblock flag and we might be
> better getting rid of it entirely.

Yeah.  It's a parse-time flag.

> The proper way to query mount options should be analogous to the way
> they are set on the new API: list of {key, type, value, aux} tuples.

It's not quite that simple: "aux" might be a datum that you can't recover or
is meaningless to another process (an fd, for example).

David
