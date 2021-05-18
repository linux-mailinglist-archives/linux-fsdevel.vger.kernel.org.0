Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABFE387348
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 09:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347223AbhERHZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 03:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20146 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347236AbhERHZs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 03:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621322670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+q3ue0u3mbf3SfQ1ffYfx+/ezLG+XqLYumob4lCWjRE=;
        b=d5iuHsyKFcanPt2vKq/VlTIn6MwppsTDDa4tI6Ox/ro/3bPw8E3yn+CAIOFFtADstPZctu
        eKS8713/+4ZraVZd5uBp4GfMs0380QQODSOCNR3D1evOG6ESbmIeqJm3MuF371nBplZc+M
        09yrnAnjwQ3YaR42YAyef3Z1GY8cSvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-5mGOzpbxNGqXJc1lPnz6qg-1; Tue, 18 May 2021 03:24:27 -0400
X-MC-Unique: 5mGOzpbxNGqXJc1lPnz6qg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDA68107ACC7;
        Tue, 18 May 2021 07:24:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-217.rdu2.redhat.com [10.10.112.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3548B59463;
        Tue, 18 May 2021 07:24:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210517232237.GE2893@dread.disaster.area>
References: <20210517232237.GE2893@dread.disaster.area> <206078.1621264018@warthog.procyon.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     dhowells@redhat.com, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs directories?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <272938.1621322659.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 18 May 2021 08:24:19 +0100
Message-ID: <272939.1621322659@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner <david@fromorbit.com> wrote:

> > What I'd like to do is remove the fanout directories, so that for each=
 logical
> > "volume"[*] I have a single directory with all the files in it.  But t=
hat
> > means sticking massive amounts of entries into a single directory and =
hoping
> > it (a) isn't too slow and (b) doesn't hit the capacity limit.
> =

> Note that if you use a single directory, you are effectively single
> threading modifications to your file index. You still need to use
> fanout directories if you want concurrency during modification for
> the cachefiles index, but that's a different design criteria
> compared to directory capacity and modification/lookup scalability.

I knew there was something I was overlooking.  This might be a more import=
ant
criterion.  I should try benchmarking this, see what difference it makes
eliminating the extra lookup step (which is probably cheap) versus the
concurrency.

David

