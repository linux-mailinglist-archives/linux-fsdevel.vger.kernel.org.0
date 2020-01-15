Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1357C13CE57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 21:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgAOUzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 15:55:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51237 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729045AbgAOUzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579121711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sya8hiKE3seQ7JhwAaYjNxPWsTZ5VsWtEdoIS+CdCAk=;
        b=NZk0qML9cKEAJvP99gMHmL46K2Gb7WgviYEW5uGeT37/duWLiLlStTjbLxvkSTEIsVk/tn
        joRH2gruSTyrI8RHu0kF5NgXakgEw5MIqImJowTxmMFOxZEttbW33d0sD8LcIdWXQ8+Vpk
        DqfM2CEt/bio7qWNhRWxlme4KmmQhX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-1MIDawWYPTKnKF8DxbpAWA-1; Wed, 15 Jan 2020 15:55:08 -0500
X-MC-Unique: 1MIDawWYPTKnKF8DxbpAWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCFD81800D48;
        Wed, 15 Jan 2020 20:55:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E8B9166B1;
        Wed, 15 Jan 2020 20:55:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <C0F67EC5-7B5D-4179-9F28-95B84D9CC326@dilger.ca>
References: <C0F67EC5-7B5D-4179-9F28-95B84D9CC326@dilger.ca> <4467.1579020509@warthog.procyon.org.uk> <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com> <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca> <afa71c13-4f99-747a-54ec-579f11f066a0@gmx.com> <20200115133101.GA28583@lst.de>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
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
Content-ID: <23761.1579121702.1@warthog.procyon.org.uk>
Date:   Wed, 15 Jan 2020 20:55:02 +0000
Message-ID: <23762.1579121702@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andreas Dilger <adilger@dilger.ca> wrote:

> I think what is needed here is an fadvise/ioctl that tells the filesystem
> "don't allocate blocks unless actually written" for that file.

Yeah - and it would probably need to find its way onto disk so that its effect
is persistent and visible to out-of-kernel tools.

It would also have to say that blocks of zeros shouldn't be optimised away.

David

