Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7107942002
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 10:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437427AbfFLIz0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 04:55:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437421AbfFLIzZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:55:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2ADC30832C8;
        Wed, 12 Jun 2019 08:55:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-109.rdu2.redhat.com [10.10.120.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 714AE46;
        Wed, 12 Jun 2019 08:55:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <cf3f4865-b6d7-7303-0212-960439e0c119@tycho.nsa.gov>
References: <cf3f4865-b6d7-7303-0212-960439e0c119@tycho.nsa.gov> <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk> <be966d9c-e38d-7a30-8d80-fad5f25ab230@tycho.nsa.gov> <0cf7a49d-85f6-fba9-62ec-a378e0b76adf@schaufler-ca.com> <CALCETrX5O18q2=dUeC=hEtK2=t5KQpGBy9XveHxFw36OqkbNOg@mail.gmail.com> <dac74580-5b48-86e4-8222-cac29a9f541d@schaufler-ca.com> <E0925E1F-E5F2-4457-8704-47B6E64FE3F3@amacapital.net> <4b7d02b2-2434-8a7c-66cc-7dbebc37efbc@schaufler-ca.com> <CALCETrU+PKVbrKQJoXj9x_5y+vTZENMczHqyM_Xb85ca5YDZuA@mail.gmail.com> <25d88489-9850-f092-205e-0a4fc292f41b@schaufler-ca.com> <97BA9EB5-4E62-4E3A-BD97-CEC34F16FCFF@amacapital.net>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     dhowells@redhat.com, Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        USB list <linux-usb@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        raven@themaw.net, Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [RFC][PATCH 00/13] Mount, FS, Block and Keyrings notifications [ver #4]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12979.1560329702.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 12 Jun 2019 09:55:02 +0100
Message-ID: <12980.1560329702@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 12 Jun 2019 08:55:25 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> 2) If notifications can be triggered by read-like operations (as in fanotify,
> for example), then a "read" can be turned into a "write" flow through a
> notification.

I don't think any of the things can be classed as "read-like" operations.  At
the moment, there are the following groups:

 (1) Addition of objects (eg. key_link, mount).

 (2) Modifications to things (eg. keyctl_write, remount).

 (3) Removal of objects (eg. key_unlink, unmount, fput+FMODE_NEED_UNMOUNT).

 (4) I/O or hardware errors (eg. USB device add/remove, EDQUOT, ENOSPC).

I have not currently defined any access events.

I've been looking at the possibility of having epoll generate events this way,
but that's not as straightforward as I'd hoped and fanotify could potentially
use it also, but in both those cases, the process is already getting the
events currently by watching for them using synchronous waiting syscalls.
Instead this would generate an event to say it had happened.

David
