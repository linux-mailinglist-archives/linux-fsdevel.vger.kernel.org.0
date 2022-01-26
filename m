Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986DA49C9F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 13:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbiAZMoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 07:44:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234207AbiAZMoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643201062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lcgXnF+PwIYGfn2u5tNUBbDBAw5Do5Myjafl0JrRTE0=;
        b=I7ygIRGcqtYkFrG5oQ2KhrlpoVTz1yBtfx1ecObkZW/GsV9WJNuaxchRaROPghDZOj9ZMA
        ybtC8z6p1ToYZSZeyVYR59/gWpi58iTu7ttW+RKuV08cwTHh1tLkO9NZg2LPaJOAB3j2V/
        qFH0IV5pG9OAEB5wPJM+M7v7kvAjGPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-sNLM-IOzOQinTsbLXXQfcw-1; Wed, 26 Jan 2022 07:44:18 -0500
X-MC-Unique: sNLM-IOzOQinTsbLXXQfcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 065F51006AA0;
        Wed, 26 Jan 2022 12:44:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8A1F7B9D9;
        Wed, 26 Jan 2022 12:44:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
cc:     dhowells@redhat.com, jlayton@kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: fscrypt and potential issues from file sparseness
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <124548.1643201054.1@warthog.procyon.org.uk>
Date:   Wed, 26 Jan 2022 12:44:14 +0000
Message-ID: <124549.1643201054@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I'm looking at doing content encryption in the network filesystem support
library.  It occurs to me that if the filesystem can record sparsity in the
file, then a couple of issues may arise if we wish to use that to record
zeroed source blocks (ie. the unencrypted blocks).  It further occurs to me
that this may occur in extent-based filesystems such as ext4 that support
fscrypt and also do extent optimisation.

The issues are:

 (1) Recording source blocks that are all zeroes by not storing them and
     leaving a hole in a content is a minor security hole as someone looking
     at the file can derive information about the contents from that.  This
     probably wouldn't affect most files, but it might affect database files.

 (2) If the filesystem stores a hole for a *source* block of zeroes (not an
     encrypted block), then it has the same problems as cachefiles:

     (a) A block of zeroes written to disk (ie. an actually encrypted block)
     is very, very unlikely to represent a source block of zeroes, but the
     optimiser can punch it out to reduce an extent and recover disk space,
     thereby leaving a hole.

     (b) The optimiser could also *insert* blocks of zeroes to bridge an
     extent, thereby erasing a hole - but the zeroes would be very unlikely to
     decrypt back to a source block of zeroes.

     If either event occurs, data corruption will ensue.

     To evade this one, we have to do one of the following:

	1. Don't use sparsity to record source blocks of zeroes
	2. Disable extent optimisations of these sorts
	3. Keep a separate map of the content

Now, I don't know if fscrypt does this.  It's hard to tell.

David

