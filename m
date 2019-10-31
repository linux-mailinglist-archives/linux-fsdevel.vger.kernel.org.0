Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4BC8EB388
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 16:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfJaPLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 11:11:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51596 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727605AbfJaPLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572534698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VSvvKijFyEH1t8VcmSOVjO1qeKSdmMeXOa2d+3aPNU=;
        b=bF10RdFcKMbwzfOuKbcmZMbmc96bFYHLyzbuVYIQPghzHW2bkGhRf/zkwLVspTrEqxPxOH
        KsxMB8dOWhd5p0MxPAbI0vhrukYLap0QJDV29vIRNqDShzq80Sgy/OZFnkCXjc4aLWUMr/
        p9opYneY/SKjt6ol/inRREzD82gTaj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-0p8D1KgMMzyGyZWARpBKrw-1; Thu, 31 Oct 2019 11:11:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE7A51800D6B;
        Thu, 31 Oct 2019 15:11:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DED1360852;
        Thu, 31 Oct 2019 15:11:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <4892d186-8eb0-a282-e7e6-e79958431a54@rasmusvillemoes.dk>
References: <4892d186-8eb0-a282-e7e6-e79958431a54@rasmusvillemoes.dk> <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk> <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk> <CAOi1vP97DMX8zweOLfBDOFstrjC78=6RgxK3PPj_mehCOSeoaw@mail.gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     dhowells@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring, not cursor and length [ver #2]
MIME-Version: 1.0
Content-ID: <16619.1572534687.1@warthog.procyon.org.uk>
Date:   Thu, 31 Oct 2019 15:11:27 +0000
Message-ID: <16620.1572534687@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 0p8D1KgMMzyGyZWARpBKrw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

How about:

 * We use head and tail indices that aren't masked off, except at the
 * point of dereference, but rather they're allowed to wrap naturally.
 * This means there isn't a dead spot in the buffer, provided the ring
 * size is a power of two and <=3D 2^31.

David

