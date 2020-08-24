Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A399325011D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgHXP2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727835AbgHXP1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598282865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pi1uzJfERgfFWmgM6UYAK6ASgLDYuQWOOL3VyRC2LTU=;
        b=AZ+nwPOVJkZsuXJjxh3o5FQu6Blke2KKNUWn7vbjRGM5oIhQAdhAAdViaZslABCXDd5rlC
        a9rW83/aPmkdU0U/dN/GNVA/4zkzKlVYZxM9h7znxK/a/+v4wvE0qAbo81Z8Hs3Psr8CyV
        UuFzayhJSzoYvuisCgH+0LNq9CvHlTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-zNVOyuFhNP-iiZLLTEszfQ-1; Mon, 24 Aug 2020 11:27:41 -0400
X-MC-Unique: zNVOyuFhNP-iiZLLTEszfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB26D18BFEF8;
        Mon, 24 Aug 2020 15:27:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0139E5F206;
        Mon, 24 Aug 2020 15:27:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200807160531.GA1345000@erythro.dev.benboeckel.internal>
References: <20200807160531.GA1345000@erythro.dev.benboeckel.internal> <159681277616.35436.11229310534842613599.stgit@warthog.procyon.org.uk>
To:     me@benboeckel.net
Cc:     dhowells@redhat.com, mtk.manpages@gmail.com,
        torvalds@linux-foundation.org, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Add a manpage for watch_queue(7)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <329585.1598282852.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 24 Aug 2020 16:27:32 +0100
Message-ID: <329586.1598282852@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ben Boeckel <me@benboeckel.net> wrote:

> > +In the case of message loss,
> > +.BR read (2)
> > +will fabricate a loss message and pass that to userspace immediately =
after the
> > +point at which the loss occurred.
> =

> If multiple messages are dropped in a row, is there one loss message per
> loss message or per loss event?

One loss message.  I set a flag on the last slot in the pipe ring to say t=
hat
message loss occurred, but there's insufficient space to store a counter
without making the slot larger (and I really don't want to do that).

Note that every slot in the pipe ring has such a flag, so you could,
theoretically, get a loss message after every normal message that you read
out.

> > +A notification pipe allocates a certain amount of locked kernel memor=
y (so that
> > +the kernel can write a notification into it from contexts where alloc=
ation is
> > +restricted), and so is subject to pipe resource limit restrictions.
> =

> A reference to the relevant manpage for resource limitations would be
> nice here. I'd assume `setrlimit(2)`, but I don't see anything
> pipe-specific there.

I can change that to:

	... and so is subject to pipe resource limit restrictions - see
	.BR pipe (7),
	in the section on
	.BR "/proc files" .

> > +of interest to the watcher, a filter can be set on a queue to determi=
ne whether
> =

> "a filter can be set"? If multiple filters are allowed, "filters can be
> added" might work better here to indicate that multiple filters are
> allowed. Otherwise, "a single filter" would make it clearer that only
> one is supported.

How about:

	Because a source can produce a lot of different events, not all of
	which may be of interest to the watcher, a single set of filters can
	be set on a queue to determine whether a particular event will get
	inserted in a queue at the point of posting inside the kernel.

> Are there macros for extracting these fields available?

WATCH_INFO_LENGTH, WATCH_INFO_ID and WATCH_INFO_TYPE_INFO are masks.  Ther=
e
are also shift macros (you add __SHIFT to the mask macro name).  I'm not s=
ure
how best to do this in troff.

> Why not also have bitfields for these?

It makes it a lot simpler to filter.

> Or is there some ABI issues with
> non-power-of-2 bitfield sizes? For clarity, which bit is bit 0? Low addr=
ess
> or LSB? Is this documented in some other manpage?

bit 0 is 2^0 in this case.  I'm not sure how better to describe it.

> Also, bit 7 is unused (for alignment I assume)? Is it always 0, 1, or
> indeterminate?

It's reserved and should always be 0 - but that's solely at the kernel's
discretion (ie. userspace doesn't gets to set it).

> > +This is used to set filters on the notifications that get written int=
o the
> =

> "set" -> "add"? If I call this multiple times, is only the last call
> effective or do I need to keep a list of all filters myself so I can
> append in the future (since I see no analogous GET_FILTER call)?

"Set".  You cannot add filters, you can only set/replace/remove the whole =
set.

Also, I didn't provide a GET_FILTER, assuming that you could probably keep
track of them yourself.

> Does this have implications for criu restoring a process?

Maybe?

> > +	unsigned char buf[128];
> =

> Is 128 the maximum message size?

127 actually.  This is specified earlier in the manual page.

> Do we have a macro for this? If it isn't, shouldn't there be code for
> detecting ENOBUFS and using a bigger buffer? Or at least not rolling wit=
h a
> busted buffer.

WATCH_INFO_LENGTH can be used for this.  I'll make the example say:

	unsigned char buf[WATCH_INFO_LENGTH];

> > +	case WATCH_TYPE_META:
> =

> From above, if a filter is added, all messages not matching a filter are
> dropped. Are WATCH_TYPE_META messages special in this case?

Yes.  They only do two things at the moment: Tell you that something you w=
ere
watching went away and tell you that messages were lost.  I've amended the
filter section to note that this cannot be filtered.

> The Rust developer in me wants to see:

I don't touch Rust ;-)

> 	default:
> 		/* Subtypes may be added in future kernel versions. */
> 		printf("unrecognized meta subtype: %d\n", n->subtype);
> 		break;
> =

> unless we're guaranteeing that no other subtypes exist for this type
> (updating the docs with new types doesn't help those who copy/paste from
> here as a seed).

I'm trying to keep the example small.  It's pseudo-code rather than real c=
ode.
I *could* expand it to a fully working program, but that would make it a l=
ot
bigger and harder to read.  As you pointed out, I haven't bothered with th=
e
error checking, for example.

David

