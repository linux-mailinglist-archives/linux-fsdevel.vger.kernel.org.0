Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C7B3CDA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 15:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391353AbfFKNxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 09:53:05 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:35674 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728506AbfFKNxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:53:04 -0400
Received: (qmail 1733 invoked by uid 2102); 11 Jun 2019 09:53:03 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jun 2019 09:53:03 -0400
Date:   Tue, 11 Jun 2019 09:53:03 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>, <viro@zeniv.linux.org.uk>,
        <linux-usb@vger.kernel.org>, <raven@themaw.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] usb: Add USB subsystem notifications [ver #3]
In-Reply-To: <875zpcfxfk.fsf@linux.intel.com>
Message-ID: <Pine.LNX.4.44L0.1906110950440.1535-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 Jun 2019, Felipe Balbi wrote:

> >> >> > So for "severe" issues, yes, we should do this, but perhaps not for all
> >> >> > of the "normal" things we see when a device is yanked out of the system
> >> >> > and the like.
> >> >> 
> >> >> Then what counts as a "severe" issue?  Anything besides enumeration 
> >> >> failure?
> >> >
> >> > Not that I can think of at the moment, other than the other recently
> >> > added KOBJ_CHANGE issue.  I'm sure we have other "hard failure" issues
> >> > in the USB stack that people will want exposed over time.
> >> 
> >> From an XHCI standpoint, Transaction Errors might be one thing. They
> >> happen rarely and are a strong indication that the bus itself is
> >> bad. Either bad cable, misbehaving PHYs, improper power management, etc.
> >
> > Don't you also get transaction errors if the user unplugs a device in 
> > the middle of a transfer?  That's not the sort of thing we want to sent 
> > notifications about.
> 
> Mathias, do we get Transaction Error if user removes cable during a
> transfer? I thought we would just get Port Status Change with CC bit
> cleared, no?

Even if xHCI doesn't give Transaction Errors when a cable is unplugged 
during a transfer, other host controllers do.  Sometimes quite a lot -- 
they continue to occur until the kernel polls the parent hub's 
interrupt ep and learns that the port is disconnected, which can take 
up to 250 ms.

Alan Stern

