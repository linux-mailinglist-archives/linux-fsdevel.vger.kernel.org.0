Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E6A270F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 21:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfH2TMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 15:12:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42447 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfH2TMB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:12:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D94FF307D868;
        Thu, 29 Aug 2019 19:12:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1123F196B2;
        Thu, 29 Aug 2019 19:11:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <03eb0974-3996-f356-5fbe-17cf598b0e31@tycho.nsa.gov>
References: <03eb0974-3996-f356-5fbe-17cf598b0e31@tycho.nsa.gov> <156710338860.10009.12524626894838499011.stgit@warthog.procyon.org.uk> <156710348066.10009.17986469867635955040.stgit@warthog.procyon.org.uk>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] selinux: Implement the watch_key security hook [ver #6]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14148.1567105917.1@warthog.procyon.org.uk>
Date:   Thu, 29 Aug 2019 20:11:57 +0100
Message-ID: <14149.1567105917@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 29 Aug 2019 19:12:01 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Can watch->cred ever differ from current's cred here?  If not, why can't we
> just use current_sid() here

Um.  Not currently.  I'm not sure whether its ever likely to be otherwise.
Probably we could just use that and fix it up later if we do find otherwise.

> and why do we need the watch object at all?

It carries more than just the creds for the caller of keyctl_watch_key(), it
also carries information about the queue to which notifications will be
written, including the creds that were active when that was set up.

Note that there's no requirement that the process that opened /dev/watch_queue
be the one that sets the watch.  In the keyutils testsuite, I 'leak' a file
descriptor from the session wrangler into the program that it runs so that
tests running inside the test script can add watches to it.

David
