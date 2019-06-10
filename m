Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20CD23BA77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 19:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfFJRLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 13:11:13 -0400
Received: from ms.lwn.net ([45.79.88.28]:44806 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfFJRLM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:11:12 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C166D2BB;
        Mon, 10 Jun 2019 17:11:11 +0000 (UTC)
Date:   Mon, 10 Jun 2019 11:11:10 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] keys: Add a notification facility [ver #4]
Message-ID: <20190610111110.72468326@lwn.net>
In-Reply-To: <155991709983.15579.13232123365803197237.stgit@warthog.procyon.org.uk>
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
        <155991709983.15579.13232123365803197237.stgit@warthog.procyon.org.uk>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 07 Jun 2019 15:18:19 +0100
David Howells <dhowells@redhat.com> wrote:

> Add a key/keyring change notification facility whereby notifications about
> changes in key and keyring content and attributes can be received.
> 
> Firstly, an event queue needs to be created:
> 
> 	fd = open("/dev/event_queue", O_RDWR);
> 	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, page_size << n);
> 
> then a notification can be set up to report notifications via that queue:
> 
> 	struct watch_notification_filter filter = {
> 		.nr_filters = 1,
> 		.filters = {
> 			[0] = {
> 				.type = WATCH_TYPE_KEY_NOTIFY,
> 				.subtype_filter[0] = UINT_MAX,
> 			},
> 		},
> 	};
> 	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
> 	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01);

One little nit: it seems that keyctl_watch_key is actually spelled
keyctl(KEYCTL_WATCH_KEY, ...).

jon
