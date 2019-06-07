Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37DC39073
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 17:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbfFGPwK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 7 Jun 2019 11:52:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730266AbfFGPwI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:52:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1E209B3B7;
        Fri,  7 Jun 2019 15:52:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6A1160D7C;
        Fri,  7 Jun 2019 15:52:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190607151228.GA1872258@magnolia>
References: <20190607151228.GA1872258@magnolia> <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk> <155991706083.15579.16359443779582362339.stgit@warthog.procyon.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] uapi: General notification ring definitions [ver #4]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29221.1559922719.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 07 Jun 2019 16:51:59 +0100
Message-ID: <29222.1559922719@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 07 Jun 2019 15:52:08 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick J. Wong <darrick.wong@oracle.com> wrote:

> > +enum watch_notification_type {
> > +	WATCH_TYPE_META		= 0,	/* Special record */
> > +	WATCH_TYPE_MOUNT_NOTIFY	= 1,	/* Mount notification record */
> > +	WATCH_TYPE_SB_NOTIFY	= 2,	/* Superblock notification */
> > +	WATCH_TYPE_KEY_NOTIFY	= 3,	/* Key/keyring change notification */
> > +	WATCH_TYPE_BLOCK_NOTIFY	= 4,	/* Block layer notifications */
> > +#define WATCH_TYPE___NR 5
> 
> Given the way enums work I think you can just make WATCH_TYPE___NR the
> last element in the enum?

Yeah.  I've a feeling I'd been asked not to do that, but I don't remember who
by.

> > +struct watch_notification {
> 
> Kind of a long name...

*shrug*.  Try to avoid conflicts with userspace symbols.

> > +	__u32			type:24;	/* enum watch_notification_type */
> > +	__u32			subtype:8;	/* Type-specific subtype (filterable) */
> 
> 16777216 diferent types and 256 different subtypes?  My gut instinct
> wants a better balance, though I don't know where I'd draw the line.
> Probably 12 bits for type and 10 for subtype?  OTOH I don't have a good
> sense of how many distinct notification types an XFS would want to send
> back to userspace, and maybe 256 subtypes is fine.  We could always
> reserve another watch_notification_type if we need > 256.
> 
> Ok, no objections. :)

If a source wants more than 256 subtypes, it can always allocate an additional
type.  Note that the greater the number of subtypes, the larger the filter
structure (added in patch 5).

> > +	__u32			info;
> > +#define WATCH_INFO_OVERRUN	0x00000001	/* Event(s) lost due to overrun */
> > +#define WATCH_INFO_ENOMEM	0x00000002	/* Event(s) lost due to ENOMEM */
> > +#define WATCH_INFO_RECURSIVE	0x00000004	/* Change was recursive */
> > +#define WATCH_INFO_LENGTH	0x000001f8	/* Length of record / sizeof(watch_notification) */
> 
> This is a mask, isn't it?  Could we perhaps have some helpers here?
> Something along the lines of...
> 
> #define WATCH_INFO_LENGTH_MASK	0x000001f8
> #define WATCH_INFO_LENGTH_SHIFT	3
> 
> static inline size_t watch_notification_length(struct watch_notification *wn)
> {
> 	return (wn->info & WATCH_INFO_LENGTH_MASK) >> WATCH_INFO_LENGTH_SHIFT *
> 			sizeof(struct watch_notification);
> }
> 
> static inline struct watch_notification *watch_notification_next(
> 		struct watch_notification *wn)
> {
> 	return wn + ((wn->info & WATCH_INFO_LENGTH_MASK) >>
> 			WATCH_INFO_LENGTH_SHIFT);
> }

No inline functions in UAPI headers, please.  I'd love to kill off the ones
that we have, but that would break things.

> ...so that we don't have to opencode all of the ring buffer walking
> magic and stuff?

There'll end up being a small userspace library, I think.

> (I might also shorten the namespace from WATCH_INFO_ to WNI_ ...)

I'd rather not do that.  WNI_ could mean all sorts of things - at a first
glance, it sounds like something to do with Windows or windowing.

> Hmm so the length field is 6 bits and therefore the maximum size of a
> notification record is ... 63 * (sizeof(u32)  * 2) = 504 bytes?  Which
> means that kernel users can send back a maximum payload of 496 bytes?
> That's probably big enough for random fs notifications (bad metadata
> detected, media errors, etc.)

Yep.  The ring buffer is limited in capacity since it has to be unswappable so
that notifications can be written into it from softirq context or under lock.

> Judging from the sample program I guess all that userspace does is
> allocate a memory buffer and toss it into the kernel, which then
> initializes the ring management variables, and from there we just scan
> around the ring buffer every time poll(watch_fd) says there's something
> to do?

Yes.  Further, if head == tail, then it's empty.  Note that since head and
tail will go up to 4G, but the buffer is limited to less than that, there's no
need for a requisite unusable slot in the ring as head != tail when the ring
is full.

> How does userspace tell the kernel the size of the ring buffer?

If you looked in the sample program, you might have noticed this in the main()
function:

	if (ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE) == -1) {

The chardev allocates the buffer and then userspace mmaps it.

I need to steal the locked-page accounting from the epoll patches to stop
someone from using this to lock away all memory.

> Does (watch_notification->info & WATCH_INFO_LENGTH) == 0 have any
> meaning besides apparently "stop looking at me"?

That's an illegal value, indicating a kernel bug.

> > +#define WATCH_INFO_IN_SUBTREE	0x00000200	/* Change was not at watched root */
> > +#define WATCH_INFO_TYPE_FLAGS	0x00ff0000	/* Type-specific flags */
> 
> WATCH_INFO_FLAG_MASK ?

Yeah.

> > +#define WATCH_INFO_FLAG_0	0x00010000
> > +#define WATCH_INFO_FLAG_1	0x00020000
> > +#define WATCH_INFO_FLAG_2	0x00040000
> > +#define WATCH_INFO_FLAG_3	0x00080000
> > +#define WATCH_INFO_FLAG_4	0x00100000
> > +#define WATCH_INFO_FLAG_5	0x00200000
> > +#define WATCH_INFO_FLAG_6	0x00400000
> > +#define WATCH_INFO_FLAG_7	0x00800000
> > +#define WATCH_INFO_ID		0xff000000	/* ID of watchpoint */
> 
> WATCH_INFO_ID_MASK ?

Sure.

> > +#define WATCH_INFO_ID__SHIFT	24
> 
> Why double underscore here?

Because it's related to WATCH_INFO_ID, but isn't a mask on ->info.

> > +};
> > +
> > +#define WATCH_LENGTH_SHIFT	3
> > +
> > +struct watch_queue_buffer {
> > +	union {
> > +		/* The first few entries are special, containing the
> > +		 * ring management variables.
> 
> The first /two/ entries, correct?

Currently two.

> Also, weird multiline comment style.

Not really.

> > +		 */
> > +		struct {
> > +			struct watch_notification watch; /* WATCH_TYPE_META */
> 
> Do these structures have to be cache-aligned for the atomic reads and
> writes to work?

I hope not, otherwise we're screwed all over the kernel, particularly with
structure randomisation.

Further, what alignment is "cache aligned"?  It can vary by CPU for a single
arch.

David
