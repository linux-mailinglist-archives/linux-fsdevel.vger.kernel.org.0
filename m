Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A03144CAE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 21:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhKJU5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 15:57:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41692 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhKJU5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 15:57:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 05BFB212C8;
        Wed, 10 Nov 2021 20:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636577662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJObDTfUExY5FRI6MpFi6mLuazgz/n5OEUDaZhA80Zg=;
        b=N7cQV6RAA2yWsfM96jv9U4y4MKlbwEJ9iObLAEjwK34oAq0bAAtepZ8V3gd4++XW1VtBHr
        WdlJMhHjc4wkCwrSisoPaPdzKLLc0aNIJPVRRh5MqZ0PXTn1QoF+5uNctU4g68WZE1GC0B
        ockRZClhLnWYgOVGLbc4c6KtZOvwxPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636577662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJObDTfUExY5FRI6MpFi6mLuazgz/n5OEUDaZhA80Zg=;
        b=3wqDYoRitG1ubH3PjZkc29nL1ksKRsImTpJ9RtNfKpbfIJnfHtVbxzkfTXVhLqoOgHp+yl
        iK9VGmQWj/ALT8Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEBB413D0F;
        Wed, 10 Nov 2021 20:54:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FqByLH0xjGFSdQAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 10 Nov 2021 20:54:21 +0000
Date:   Wed, 10 Nov 2021 21:54:20 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH v4 2/4] initramfs: print helpful cpio error on "crc"
 magic
Message-ID: <20211110215420.1ef91d86@suse.de>
In-Reply-To: <YYwBzj0isuKOjjUe@casper.infradead.org>
References: <20211110123850.24956-1-ddiss@suse.de>
        <20211110123850.24956-3-ddiss@suse.de>
        <YYwBzj0isuKOjjUe@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 10 Nov 2021 17:30:54 +0000, Matthew Wilcox wrote:

> On Wed, Nov 10, 2021 at 01:38:48PM +0100, David Disseldorp wrote:
> > Contrary to the buffer-format.rst documentation, initramfs cpio
> > extraction does not support "crc" archives, which carry "070702"
> > header magic. Make it a little clearer that "newc" (magic="070701") is
> > the only supported cpio format, by extending the POSIX.1 ASCII
> > (magic="070707") specific error message to also cover "crc" magic.  
> 
> Wouldn't it be easier to just add support?

Well, no, this patch already exists. :-)

> As far as I can tell from
> looking at documentation, the "crc" format is the same as newc, except
> that it uses some reserved bits to store the crc.  Since we ignore those
> bits, we could just check for either 070701 or 070702.

Sure, it'd be pretty straightforward to implement "crc" format support,
but I'm not sure how useful a 32-bit checksum would be... If we're going
down this route, wouldn't proper IMA/EVM support make sense via some new
cpio variant with space for the attributes (or as header/trailer like
bootconfig)?
cc'ing Jeff, as I seem to recall him mentioning some work in this area.

Cheers, David
