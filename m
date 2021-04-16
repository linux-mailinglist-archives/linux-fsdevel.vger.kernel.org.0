Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E21F362435
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 17:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343988AbhDPPmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 11:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343945AbhDPPmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618587701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z7hKywyh1tZwRsR88gPcT7+lcF3bjYRsTQC5tN00FOc=;
        b=K9ECu2NbUdnzrTQAgnACwOfaAI6Avbvq13Szq63Y+icrVuOIS+i+nyS2PYC9p7GQCYXKvr
        n8G/OE7w12ACu+NyGgDhXZMncEcz65liyFChOCf/UYiog7kYEj0lI0THTVIydPiwDvgKFn
        ORtbrZYiOnucSX//E750tLN0kDYphK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-f5l__WGOOmSV_y5Z4pL24A-1; Fri, 16 Apr 2021 11:41:36 -0400
X-MC-Unique: f5l__WGOOmSV_y5Z4pL24A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADB6D10054F6;
        Fri, 16 Apr 2021 15:41:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4584107D5C2;
        Fri, 16 Apr 2021 15:41:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOg9mSSxZUwZ0-OdCfb7gLgETkCJOd-9PCrpqWwzqXffwMSejA@mail.gmail.com>
References: <CAOg9mSSxZUwZ0-OdCfb7gLgETkCJOd-9PCrpqWwzqXffwMSejA@mail.gmail.com> <20210327035019.GG1719932@casper.infradead.org> <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com> <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com> <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com> <2884397.1616584210@warthog.procyon.org.uk> <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com> <1507388.1616833898@warthog.procyon.org.uk> <20210327135659.GH1719932@casper.infradead.org> <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com> <20210327155630.GJ1719932@casper.infradead.org> <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com> <CAOg9mSSaDsEEQD7cwbsCi9WA=nSAD78wSJV_5Gu=Kc778z57zA@mail.gmail.com> <1720948.1617010659@warthog.procyon.org.uk> <CAOg9mSTEepP-BjV85dOmk6hbhQXYtz2k1y5G1RbN9boN7Mw3wA@mail.gmail.com> <CAOg9mSQTRfS1Wyd_ULbN8cS7FstH9ix-um9ZeKLa
 2O=xLgF+-Q@mail.gmail.com> <1268214.1618326494@warthog.procyon.org.uk>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1612828.1618587694.1@warthog.procyon.org.uk>
Date:   Fri, 16 Apr 2021 16:41:34 +0100
Message-ID: <1612829.1618587694@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In orangefs_readahead():

	loff_t bytes_remaining = inode->i_size - readahead_pos(rac);
	loff_t pages_remaining = bytes_remaining / PAGE_SIZE;

What happens if bytes_remaining < PAGE_SIZE?  Or even what happens if
bytes_remaining % PAGE_SIZE != 0?

	if ((ret = wait_for_direct_io(ORANGEFS_IO_READ, inode,
			&offset, &iter, readahead_length(rac),
			inode->i_size, NULL, NULL, file)) < 0)

I wonder if you should use iov_length(&iter) rather than
readahead_length(rac).  They *should* be the same.

Also, should you cache inode->i_size lest it change under you due to truncate?

David

