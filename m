Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78A12749D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 22:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgIVUIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 16:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726583AbgIVUIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600805327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BUqDeUNyWgghD2ShMHsbcjNDrfm7KYD8nmKoVxUdP4=;
        b=H9D/eKnWHpDvsvKoS0s8BbSQUuKGoMhakVCxb92l6O/UuupebWXiTacDdGRXwr6FSHXTBz
        U7EskaKzXYqkWa8c2ZsLVC4uQy0drn+XPKPosvJzuCrB1b9SsWfdqgRnOkwDfp1Yyrqekc
        uLp1vN8b5xJUGa/sCujzlQ6TkNNjD5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-eQyTgbJUNqmDe5Pub_L3uw-1; Tue, 22 Sep 2020 16:08:44 -0400
X-MC-Unique: eQyTgbJUNqmDe5Pub_L3uw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D316C801FDA;
        Tue, 22 Sep 2020 20:08:43 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-78.rdu2.redhat.com [10.10.116.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A940F7368E;
        Tue, 22 Sep 2020 20:08:40 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 34AAB223B13; Tue, 22 Sep 2020 16:08:40 -0400 (EDT)
Date:   Tue, 22 Sep 2020 16:08:40 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [PATCH v2 4/6] fuse: Kill suid/sgid using ATTR_MODE if it is not
 truncate
Message-ID: <20200922200840.GF57620@redhat.com>
References: <20200916161737.38028-1-vgoyal@redhat.com>
 <20200916161737.38028-5-vgoyal@redhat.com>
 <CAJfpegsncAteUfTAHAttwyVQmhGoK7FCeO_z+xcB_4QkYZEzsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsncAteUfTAHAttwyVQmhGoK7FCeO_z+xcB_4QkYZEzsQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:56:47PM +0200, Miklos Szeredi wrote:
> On Wed, Sep 16, 2020 at 6:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > But if this is non-truncate setattr then server will not kill suid/sgid.
> > So continue to send ATTR_MODE to kill suid/sgid for non-truncate setattr,
> > even if ->handle_killpriv_v2 is enabled.
> 
> Sending ATTR_MODE doesn't make sense, since that is racy.   The
> refresh-recalculate makes the race window narrower, but it doesn't
> eliminate it.

Hi Miklos,

Agreed that it does not eliminate that race.

> 
> I think I suggested sending write synchronously if suid/sgid/caps are
> set.  Do you see a problem with this?

Sorry, I might have missed it. So you are saying that for the case of
->writeback_cache, force a synchronous WRITE if suid/sgid is set. But
this will only work if client sees the suid/sgid bits. If client B
set the suid/sgid which client A does not see then all the WRITEs
will be cached in client A and not clear suid/sgid bits.

Also another problem is that if client sees suid/sgid and we make
WRITE synchronous, client's suid/sgid attrs are still cached till
next refresh (both for ->writeback_cache and non writeback_cache
case). So server is clearing suid/sgid bits but client still
keeps them cached. I hope none of the code paths end up using
this stale value and refresh attrs before using suid/sgid.

Shall we refresh attrs after WRITE if suid/sgid is set and client
expects it to clear after WRITE finishes to solve this problem. Or
this is something which is actually not a real problem and I am
overdesigning.

Thanks
Vivek

> 
> Does this affect anything other than cached writes?
> 
> Thanks,
> Miklos
> 

