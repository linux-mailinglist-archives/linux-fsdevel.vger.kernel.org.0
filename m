Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B35DA13C59D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 15:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgAOOPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 09:15:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37775 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730612AbgAOOPo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579097743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OUWgGIVsJ8NZwOLyNUY7Hd2Km2oSlO39xhYqMQdHPRE=;
        b=SBa2IZ4OujszdbTdvi6vrsZ8WupQHWa0QTj3+i1P7L91iJV9jGhD4dl+qCXsgW7+izJ+VA
        8NcDvQevfqKQUlTeo8xvcEXbLsnsj8dDG8BxB2+nihCY5gzsQAfYDeRO6X852DVrkwHyAn
        etKCTbACmZ205VmLFGDW+ysamgk6Kok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-amsWRQ3cP4KKzpO788M-xQ-1; Wed, 15 Jan 2020 09:15:39 -0500
X-MC-Unique: amsWRQ3cP4KKzpO788M-xQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A81BA801A05;
        Wed, 15 Jan 2020 14:15:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 420885C545;
        Wed, 15 Jan 2020 14:15:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200115083854.GB23039@lst.de>
References: <20200115083854.GB23039@lst.de> <4467.1579020509@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, tytso@mit.edu, adilger.kernel@dilger.ca,
        darrick.wong@oracle.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Problems with determining data presence by examining extents?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24479.1579097734.1@warthog.procyon.org.uk>
Date:   Wed, 15 Jan 2020 14:15:34 +0000
Message-ID: <24480.1579097734@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> The whole idea of an out of band interface is going to be racy and suffer
> from implementation loss.  I think what you want is something similar to
> the NFSv4.2 READ_PLUS operation - give me that if there is any and
> otherwise tell me that there is a hole.  I think this could be a new
> RWF_NOHOLE or similar flag, just how to return the hole size would be
> a little awkward.  Maybe return a specific negative error code (ENODATA?)
> and advance the iov anyway.

Just having call_iter_read() return a short read could be made to suffice...
provided the filesystem doesn't return data I haven't written in (which could
cause apparent corruption) and does return data I have written in (otherwise I
have to go back to the server).

David

