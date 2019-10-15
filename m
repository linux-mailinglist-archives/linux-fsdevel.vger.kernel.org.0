Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4972D83C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 00:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbfJOWdW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 18:33:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732040AbfJOWdV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:33:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 196FD10F2E82;
        Tue, 15 Oct 2019 22:33:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB0FA1001938;
        Tue, 15 Oct 2019 22:33:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=whiz1sHXu8SVZKEC2dup=r5JMrftPtEt6ff9Ea8dyH8yQ@mail.gmail.com>
References: <CAHk-=whiz1sHXu8SVZKEC2dup=r5JMrftPtEt6ff9Ea8dyH8yQ@mail.gmail.com> <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk> <157117608708.15019.1998141309054662114.stgit@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/21] Add a prelocked wake-up
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20273.1571178796.1@warthog.procyon.org.uk>
Date:   Tue, 15 Oct 2019 23:33:16 +0100
Message-ID: <20274.1571178796@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Tue, 15 Oct 2019 22:33:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > Add a wakeup call for a case whereby the caller already has the waitqueue
> > spinlock held.
> 
> That naming is crazy.

Sorry, yeah.  This is a bit hacked together at the moment and needs some more
tidying up.  I've had a lot of problems with performance regressions of up to
40% from seemingly simple changes involving moving locks around - it turns out
that the problem was that I was running with kasan enabled.

David
