Return-Path: <linux-fsdevel+bounces-4706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC5780256B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 17:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB2228060B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9619315AE2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="At/6BHR4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D796ED;
	Sun,  3 Dec 2023 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701617821;
	bh=TTuJ6Udpup4SD2uOIIkzQFANYG602HzCvVFlx6oIxmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=At/6BHR4M88kALlZGhzJHgia2zi9meV3s9btRZolmf8OfDUgm5k8rRxnOtxj0P4P5
	 KpQGfIGWnRTO31UjJlE/Z036mRD981Bn6ML6JFK4fFtqyeJXvz5cmKFUvcbP9GGfAK
	 o8jTs+2NLEMimrtxexKppnkD1zETQnrWpwkluJ3E=
Date: Sun, 3 Dec 2023 16:37:01 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Iurii Zaikin <yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/7] sysctl: constify sysctl ctl_tables
Message-ID: <e3932680-d284-4e13-9c0c-f202d588bf60@t-8ch.de>
References: <CGME20231125125305eucas1p2ebdf870dd8ef46ea9d346f727b832439@eucas1p2.samsung.com>
 <20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
 <20231127101323.sdnibmf7c3d5ovye@localhost>
 <475cd5fa-f0cc-4b8b-9e04-458f6d143178@t-8ch.de>
 <20231201163120.depfyngsxdiuchvc@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201163120.depfyngsxdiuchvc@localhost>

Hi Joel,

On 2023-12-01 17:31:20+0100, Joel Granados wrote:
> Hey Thomas.
> 
> Thx for the clarifications. I did more of a deep dive into your set and
> have additional comments (in line). I think const-ing all this is a good
> approach. The way forward is to be able to see the entire patch set of
> changes in a V1 or a shared repo somewhere to have a better picture of
> what is going on. By the "entire patchset" I mean all the changes that
> you described in the "full process".

All the changes will be a lot. I don't think the incremental value to
migrate all proc_handlers versus the work is useful for the discussion.
I can however write up my proposed changes for the sysctl core properly
and submit them as part of the next revision.

> On Tue, Nov 28, 2023 at 09:18:30AM +0100, Thomas Weißschuh wrote:
> > Hi Joel,
> > 
> > On 2023-11-27 11:13:23+0100, Joel Granados wrote:
> > > In general I would like to see more clarity with the motivation and I
> > > would also expect some system testing. My comments inline:
> > 
> > Thanks for your feedback, response are below.
> > 
> > > On Sat, Nov 25, 2023 at 01:52:49PM +0100, Thomas Weißschuh wrote:
> > > > Problem description:
> > > > 
> > > > The kernel contains a lot of struct ctl_table throught the tree.
> > > > These are very often 'static' definitions.
> > > > It would be good to mark these tables const to avoid accidental or
> > > > malicious modifications.
> > 
> > > It is unclear to me what you mean here with accidental or malicious
> > > modifications. Do you have a specific attack vector in mind? Do you
> > > have an example of how this could happen maliciously? With
> > > accidental, do you mean in proc/sysctl.c? Can you expand more on the
> > > accidental part?
> > 
> > There is no specific attack vector I have in mind. The goal is to remove
> > mutable data, especially if it contains pointers, that could be used by
> > an attacker as a step in an exploit. See for example [0], [1].

> I think you should work "remove mutable data" as part of you main
> motivation when you send the non-RFC patch. I would also including [0]
> and [1] (and any other previous work) to help contextualize.

Ack.

> 
> > 
> > Accidental can be any out-of-bounds write throughout the kernel.
> > 
> > > What happens with the code that modifies these outside the sysctl core?
> > > Like for example in sysctl_route_net_init where the table is modified
> > > depending on the net->user_ns? Would these non-const ctl_table pointers
> > > be ok? would they be handled differently?
> > 
> > It is still completely fine to modify the tables before registering,
> > like sysctl_route_net_init is doing. That code should not need any
> > changes.
> > 
> > Modifying the table inside the handler function would bypass the
> > validation done when registering so sounds like a bad idea in general.

> This is done before registering. So the approach *is* sound.

Absolutely. Though, I wouldn't be surprised if some other subsystem is
doing this stuff in the handler.

> > It would still be possible however for a subsystem to do so by just not
> > making their sysctl table const and then modifying the table directly.

> Indeed. Which might be intended or migth be someone that just forgets to
> put const. I think you mentioned that there would be some sort of static
> check for this (coccinelle or smach, or something else)? 

My intention was to put the struct into scripts/const_structs.checkpatch
so checkpatch.pl warns about non-const instances.

> >  
> > > > Unfortunately the tables can not be made const because the core
> > > > registration functions expect mutable tables.
> > > > 
> > > > This is for two reasons:
> > > > 
> > > > 1) sysctl_{set,clear}_perm_empty_ctl_header in the sysctl core modify
> > > >    the table. This should be fixable by only modifying the header
> > > >    instead of the table itself.
> > > > 2) The table is passed to the handler function as a non-const pointer.
> > > > 
> > > > This series is an aproach on fixing reason 2).
> > 
> > > So number 2 will be sent in another set?

> Sorry, this was supposed to be "number 1", but you got my meaning :)

I was not entirely sure :-)
As mentioned above I do have a proposal for 1) and will submit this as
part of the next revision.
Or maybe as a standalone non-RFC patchset, because IMHO this is valuable
on its own.

> > 
> > If the initial feedback to the RFC and general process is positive, yes.

> Off the top of my head, putting  that type in the header instead of the
> ctl_table seems ok. I would include it in non-RFC version together with
> 2.
> 
> > 
> > > > 
> > > > Full process:
> > > > 
> > > > * Introduce field proc_handler_new for const handlers (this series)

> I don't understand why we need a new handler. Couldn't we just change
> the existing handler to receive `const struct ctl_table` and change all
> the `proc_do*` handlers?

The idea was that there are a lot of nonstandard proc handlers.
By doing it in steps we would avoid having to change all nonstandard
handlers in one go.
I looked a bit around and it seems that only 20% of sysctls use
nonstandard handlers.
Let's see if it's feasible to do those in one step.
It would indeed avoid a bunch of complexity all over the place.

> I'm guessing its because you want to do this in steps? if that is the
> case, it would be very helpfull to see (in some repo or V1) the steps
> to change all the handlers in the non-RFC version 
> 
> > > > * Migrate all core handlers to proc_handler_new (this series, partial)
> > > >   This can hopefully be done in a big switch, as it only involves
> > > >   functions and structures owned by the core sysctl code.
> It would be helpful to see what the "big switch" would look like. If it
> is all sysctl code and cannot be chunked up because of dependencies,
> then it should be ok to do it in one go.
> 
> > > > * Migrate all other sysctl handlers to proc_handler_new.
> > > > * Drop the old proc_handler_field.
> > > > * Fix the sysctl core to not modify the tables anymore.
> > > > * Adapt public sysctl APIs to take "const struct ctl_table *".
> > > > * Teach checkpatch.pl to warn on non-const "struct ctl_table"
> > > >   definitions.

> Have you considered how to ignore the cases where the ctl_tables are
> supposed to be non-const when they are defined (like in the network
> code that we were discussing earlier)

As it would be a checkpatch warning it can be ignore while writing the
patch and it won't trigger afterwards.

> > > > * Migrate definitions of "struct ctl_table" to "const" where applicable.
> These migrations are treewide and are usually reviewed by a wider
> audience. You might need to chunk it up to make the review more palpable
> for the other maintainers.

Ack.

> > > >  
> > > > 
> > > > Notes:
> > > > 
> > > > Just casting the function pointers around would trigger
> > > > CFI (control flow integrity) warnings.
> > > > 
> > > > The name of the new handler "proc_handler_new" is a bit too long messing
> > > > up the alignment of the table definitions.
> > > > Maybe "proc_handler2" or "proc_handler_c" for (const) would be better.
> > 
> > > indeed the name does not say much. "_new" looses its meaning quite fast
> > > :)
> > 
> > Hopefully somebody comes up with a better name!

> I would like to avoid this all together and just do add the const to the
> existing "proc_handler"

Ack.

> > 
> > > In my experience these tree wide modifications are quite tricky. Have you
> > > run any tests to see that everything is as it was? sysctl selftests and
> > > 0-day come to mind.
> > 
> > I managed to miss one change in my initial submission:
> > With the hunk below selftests and typing emails work.
> > 
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -1151,7 +1151,7 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
> >                         else
> >                                 err |= sysctl_check_table_array(path, entry);
> >                 }
> > -               if (!entry->proc_handler)
> > +               if (!entry->proc_handler && !entry->proc_handler_new)
> >                         err |= sysctl_err(path, entry, "No proc_handler");
> >  
> >                 if ((entry->mode & (S_IRUGO|S_IWUGO)) != entry->mode)
> > 
> > > [..]
> > 
> > [0] 43a7206b0963 ("driver core: class: make class_register() take a const *")
> > [1] https://lore.kernel.org/lkml/20230930050033.41174-1-wedsonaf@gmail.com/

Thanks for the feedback!

Thomas

