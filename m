Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C93D140F36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 17:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgAQQn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 11:43:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726970AbgAQQn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579279435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ywZah/acU88OdI0elxdfP2wlFAEGYbYZ2X9Wl0Y+ps=;
        b=aPONDv90XNmbxI3XjQCdAGwZTtIDrtRA9Q0T72fYp+mdaEnn8imbL7tTgheeHPMfkJt2OT
        s77r75OsSZkYkLphG+JFZ9Az5m3JWc/KcMMVMyxyJjYy8hriYMTh8802fxzF64aZ/u/dpS
        aCfw7gMeKiYcC7nNmoJZoneHrxc/d3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-LeC-d3cZMfmN1hLN6_W0bg-1; Fri, 17 Jan 2020 11:43:49 -0500
X-MC-Unique: LeC-d3cZMfmN1hLN6_W0bg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DDF66125B;
        Fri, 17 Jan 2020 16:43:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDA115C54A;
        Fri, 17 Jan 2020 16:43:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200116101344.GA16435@lst.de>
References: <20200116101344.GA16435@lst.de> <20200115144839.GA30301@lst.de> <20200115133101.GA28583@lst.de> <4467.1579020509@warthog.procyon.org.uk> <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com> <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca> <afa71c13-4f99-747a-54ec-579f11f066a0@gmx.com> <26093.1579098922@warthog.procyon.org.uk> <28755.1579100378@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with determining data presence by examining extents?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <469987.1579279418.1@warthog.procyon.org.uk>
Date:   Fri, 17 Jan 2020 16:43:38 +0000
Message-ID: <469988.1579279418@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> File systems usually pad zeroes where they have to, typically for
> sub-blocksize writes.   Disabling this would break data integrity.

I understand that.  I can, however, round up the netfs I/O granule size and
alignment to a multiple of the cachefile I/O block size.  Also, I'm doing DIO,
so I have to use block size multiples.

But if the filesystem can avoid bridging large, appropriately sized and
aligned blocks, then I can use it.

David

