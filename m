Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3526FA7023
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 18:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbfICQhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 12:37:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730717AbfICQhO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:37:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08C61308FC22;
        Tue,  3 Sep 2019 16:37:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EED7E608AB;
        Tue,  3 Sep 2019 16:37:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190903085706.7700-1-hdanton@sina.com>
References: <20190903085706.7700-1-hdanton@sina.com> <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] General notification queue with user mmap()'able ring buffer [ver #7]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27532.1567528630.1@warthog.procyon.org.uk>
Date:   Tue, 03 Sep 2019 17:37:10 +0100
Message-ID: <27533.1567528630@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 03 Sep 2019 16:37:14 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hillf Danton <hdanton@sina.com> wrote:

> > +	for (i = 0; i < wf->nr_filters; i++) {
> > +		wt = &wf->filters[i];
> > +		if (n->type == wt->type &&
> > +		    (wt->subtype_filter[n->subtype >> 5] &
> > +		     (1U << (n->subtype & 31))) &&
> 
> Replace the pure numbers with something easier to understand.

How about the following:

static bool filter_watch_notification(const struct watch_filter *wf,
				      const struct watch_notification *n)
{
	const struct watch_type_filter *wt;
	unsigned int st_bits = sizeof(wt->subtype_filter[0]) * 8;
	unsigned int st_index = n->subtype / st_bits;
	unsigned int st_bit = 1U << (n->subtype % st_bits);
	int i;

	if (!test_bit(n->type, wf->type_filter))
		return false;

	for (i = 0; i < wf->nr_filters; i++) {
		wt = &wf->filters[i];
		if (n->type == wt->type &&
		    (wt->subtype_filter[st_index] & st_bit) &&
		    (n->info & wt->info_mask) == wt->info_filter)
			return true;
	}

	return false; /* If there is a filter, the default is to reject. */
}

David
