Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDDE856622
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 12:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfFZKDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 06:03:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZKDE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:03:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BBEC3082E25;
        Wed, 26 Jun 2019 10:03:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64EA060BF3;
        Wed, 26 Jun 2019 10:03:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190625092728.z3jn3gbyopzcg2it@brauner.io>
References: <20190625092728.z3jn3gbyopzcg2it@brauner.io> <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk> <156138535407.25627.15015993364565647650.stgit@warthog.procyon.org.uk>
To:     Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        mszeredi@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/25] vfs: Allow fsinfo() to query what's in an fs_context [ver #14]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6574.1561543379.1@warthog.procyon.org.uk>
Date:   Wed, 26 Jun 2019 11:02:59 +0100
Message-ID: <6575.1561543379@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 26 Jun 2019 10:03:04 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian@brauner.io> wrote:

> > +	ret = mutex_lock_interruptible(&fc->uapi_mutex);
> > +	if (ret == 0) {
> > +		ret = -EIO;
> 
> Why EIO when there's no root dentry?

Because I don't want to use ENODATA/EBADF and preferably not EINVAL and
because the context you're accessing isn't in the correct state for you to be
able to do that.  How about EBADFD ("File descriptor in bad state")?

David
