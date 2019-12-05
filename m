Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D14D1144E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 17:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfLEQeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 11:34:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33611 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729406AbfLEQeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575563643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qxYFzUuTTdheWGBhhn3zwDRBiNCvQHjX+pYVvWctuZk=;
        b=XUtVhPujoCWCgmS4s6sLmeFgfaWvNS6S3661vl509+NEoo/f/trdn3Bn9EQQLFNfpW//ER
        rR6F+uBWvnQZAqtEOc75JdoQzFdyML8VYAbRHX1Bch42m6Jncg2Utga6O4yEZD91d7+mQW
        UJ1LU6pxFqgwWXZOMv0SHH2iMEwaKVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-PYFfFydZOzOTHH3KkbAciA-1; Thu, 05 Dec 2019 11:34:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5B85183B736;
        Thu,  5 Dec 2019 16:33:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 809039F41;
        Thu,  5 Dec 2019 16:33:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191205074539.GB3237@sol.localdomain>
References: <20191205074539.GB3237@sol.localdomain> <000000000000a6324b0598b2eb59@google.com> <000000000000d6c9870598bdf090@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk,
        syzbot <syzbot+838eb0878ffd51f27c41@syzkaller.appspotmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in pipe_write
MIME-Version: 1.0
Content-ID: <29473.1575563636.1@warthog.procyon.org.uk>
Date:   Thu, 05 Dec 2019 16:33:56 +0000
Message-ID: <29474.1575563636@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: PYFfFydZOzOTHH3KkbAciA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:

> It looks like the 'mask' variable in pipe_write() is not being updated af=
ter
> the pipe mutex was dropped in pipe_wait(), to take into account the pipe
> size possibly having been changed in the mean time.

There's that, but not only that.  Weirdness ensues if the ring size is 1 -
this may have to do with the mask then being 0.

David

