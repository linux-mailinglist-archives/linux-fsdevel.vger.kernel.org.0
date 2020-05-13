Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A361D1D01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 20:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389975AbgEMSIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 14:08:12 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:38403 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732488AbgEMSIM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 14:08:12 -0400
Received: from localhost (unknown [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7129A240006;
        Wed, 13 May 2020 18:07:50 +0000 (UTC)
Date:   Wed, 13 May 2020 11:07:46 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, jeyu@kernel.org, jmorris@namei.org,
        keescook@chromium.org, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        nayna@linux.ibm.com, zohar@linux.ibm.com,
        scott.branden@broadcom.com, dan.carpenter@oracle.com,
        skhan@linuxfoundation.org, geert@linux-m68k.org,
        tglx@linutronix.de, bauerman@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] security: add symbol namespace for reading file data
Message-ID: <20200513180746.GA75734@localhost>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513152108.25669-3-mcgrof@kernel.org>
 <87k11fonbk.fsf@x220.int.ebiederm.org>
 <20200513161622.GS11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513161622.GS11244@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 04:16:22PM +0000, Luis Chamberlain wrote:
> On Wed, May 13, 2020 at 10:40:31AM -0500, Eric W. Biederman wrote:
> > Luis Chamberlain <mcgrof@kernel.org> writes:
> > 
> > > Certain symbols are not meant to be used by everybody, the security
> > > helpers for reading files directly is one such case. Use a symbol
> > > namespace for them.
> > >
> > > This will prevent abuse of use of these symbols in places they were
> > > not inteded to be used, and provides an easy way to audit where these
> > > types of operations happen as a whole.
> > 
> > Why not just remove the ability for the firmware loader to be a module?
> > 
> > Is there some important use case that requires the firmware loader
> > to be a module?
> > 
> > We already compile the code in by default.  So it is probably just
> > easier to remove the modular support all together.  Which would allow
> > the export of the security hooks to be removed as well.
> 
> Yeah, that's a better solution. The only constaint I am aware of is
> we *cannot* change the name of the module from firmware_class since the
> old fallback sysfs loader depends on the module name. So, so long as we
> take care with that on built-in and document this very well, I think
> we should be good.
> 
> I checked the commit logs and this was tristate since the code was added
> upstream, so I cannot see any good reason it was enabled as modular.
> 
> Speaking with a *backports experience* hat on, we did have a use case
> to use a module for it in case a new feature was added upstream which
> was not present on older kernels. However I think that using a separate
> symbol prefix would help with that.
> 
> Would any Android stakeholders / small / embedded folks whave any issue
> with this?

As long as you can still *completely* compile out firmware loading, I
don't think there's a huge use case for making it modular. y/n seems
fine.
