Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E7346E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 14:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfFDMdT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 08:33:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfFDMdS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:33:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7E3B8E3C6;
        Tue,  4 Jun 2019 12:33:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D87DB648D6;
        Tue,  4 Jun 2019 12:33:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOQ4uxjLzURf8c1UH_xCJKkuD2es8i-=P-ZNM=t3aFcZLMwXEg@mail.gmail.com>
References: <CAOQ4uxjLzURf8c1UH_xCJKkuD2es8i-=P-ZNM=t3aFcZLMwXEg@mail.gmail.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <CAOQ4uxjC1M7jwjd9zSaSa6UW2dbEjc+ZbFSo7j9F1YHAQxQ8LQ@mail.gmail.com> <20190529142504.GC32147@quack2.suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     dhowells@redhat.com, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/7] Mount, FS, Block and Keyrings notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16166.1559651581.1@warthog.procyon.org.uk>
Date:   Tue, 04 Jun 2019 13:33:01 +0100
Message-ID: <16167.1559651581@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 04 Jun 2019 12:33:17 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> wrote:

> Well I am sure that ring buffer for fanotify events would be useful, so
> seeing that David is proposing a generic notification mechanism, I wanted
> to know how that mechanism could best share infrastructure with fsnotify.
>
> But apart from that I foresee the questions from users about why the
> mount notification API and filesystem events API do not have better
> integration.
>
> The way I see it, the notification queue can serve several classes
> of notifications and fsnotify could be one of those classes
> (at least FAN_CLASS_NOTIF fits nicely to the model).

It could be done; the main thing that concerns me is that the buffer is of
limited capacity.

However, I could take this:

	struct fanotify_event_metadata {
		__u32 event_len;
		__u8 vers;
		__u8 reserved;
		__u16 metadata_len;
		__aligned_u64 mask;
		__s32 fd;
		__s32 pid;
	};

and map it to:

	struct fanotify_notification {
		struct watch_notification watch; /* WATCH_TYPE_FANOTIFY */
		__aligned_u64	mask;
		__u16		metadata_len;
		__u8		vers;
		__u8		reserved;
		__u32		reserved2;
		__s32		fd;
		__s32		pid;
	};

and some of the watch::info bit could be used:

	n->watch.info & WATCH_INFO_OVERRUN	watch queue overran
	n->watch.info & WATCH_INFO_LENGTH	event_len
	n->watch.info & WATCH_INFO_RECURSIVE	FAN_EVENT_ON_CHILD
	n->watch.info & WATCH_INFO_FLAG_0	FAN_*_PERM
	n->watch.info & WATCH_INFO_FLAG_1	FAN_Q_OVERFLOW
	n->watch.info & WATCH_INFO_FLAG_2	FAN_ON_DIR
	n->subtype				ffs(n->mask)

Ideally, I'd dispense with metadata_len, vers, reserved* and set the version
when setting the watch.

	fanotify_watch(int watchfd, unsigned int flags, u64 *mask,
		       int dirfd, const char *pathname, unsigned int at_flags);

We might also want to extend the watch_filter to allow you to, say, filter on
the first __u64 after the watch member so that you could filter on specific
events:

	struct watch_notification_type_filter {
		__u32	type;
		__u32	info_filter;
		__u32	info_mask;
		__u32	subtype_filter[8];
		__u64	payload_mask[1];
		__u64	payload_set[1];
	};

So, in this case, it would require:

	n->mask & wf->payload_mask[0] == wf->payload_set[0]

to be true to record the message.

David
