Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6686E456378
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 20:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhKRT1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 14:27:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhKRT1o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 14:27:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADB436137B;
        Thu, 18 Nov 2021 19:24:42 +0000 (UTC)
Date:   Thu, 18 Nov 2021 14:24:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     "Yordan Karadzhov \(VMware\)" <y.karadz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, James.Bottomley@HansenPartnership.com,
        akpm@linux-foundation.org, vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        Linux Containers <containers@lists.linux.dev>
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
Message-ID: <20211118142440.31da20b3@gandalf.local.home>
In-Reply-To: <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
References: <20211118181210.281359-1-y.karadz@gmail.com>
        <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Nov 2021 12:55:07 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> It is not correct to use inode numbers as the actual names for
> namespaces.
> 
> I can not see anything else you can possibly uses as names for
> namespaces.

This is why we used inode numbers.

> 
> To allow container migration between machines and similar things
> the you wind up needing a namespace for your names of namespaces.

Is this why you say inode numbers are incorrect?

There's no reason to make this into its own namespace. Ideally, this file
system should only be for privilege containers. As the entire point of this
file system is to monitor the other containers on the system. In other
words, this file system is not to be used like procfs, but instead a global
information of the containers running on the host.

At first, we were not going to let this file system be part of any
namespace but the host itself, but because we want to wrap up tooling into
a container that we can install on other machines as a way to monitor the
containers on each machine, we had to open that up.

> 
> Further you talk about hierarchy and you have not added support for the
> user namespace.  Without the user namespace there is not hierarchy with
> any namespace but the pid namespace. There is definitely no meaningful
> hierarchy without the user namespace.

Great, help us implement this.

> 
> As far as I can tell merging this will break CRIU and container
> migration in general (as the namespace of namespaces problem is not
> solved).

This is not to be a file system that is to be migrated. As the point of
this file system is to monitor the other containers, so it does not make
sense to migrate it.

> 
> Since you are not solving the problem of a namespace for namespaces,
> yet implementing something that requires it.

Why is it needed?

> 
> Since you are implementing hierarchy and ignoring the user namespace
> which gives structure and hierarchy to the namespaces.

We are not ignoring it, we are RFC'ing for advice on how to implement it.

> 
> Since this breaks existing use cases without giving a solution.

You don't understand proof-of-concepts and RFCs do you?

-- Steve
