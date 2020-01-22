Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF99144B9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 07:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgAVGNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 01:13:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25948 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbgAVGNC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 01:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579673580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9Qrc1hfBsH0AmAxE/zKcZWB088YD/ANA/bpl7vjqAI=;
        b=OQ8zA9MDlJg/+GLswRQJJj0MR83E+XB5HWwi9fzjwy6M8QFloSGVaUyU3zBOhYJqAq58Ri
        wOB1B2H+OXFPcqw2ITS9HNienxdPuUSeabv9xv+49+8NpmfLEJwm2ckLqe9LxMvBB0N0ga
        Ue/5VtOJqTBt0TYbW14VxzwWaaqwgg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-CsAYPkPCOL21plJ58PJWyA-1; Wed, 22 Jan 2020 01:12:56 -0500
X-MC-Unique: CsAYPkPCOL21plJ58PJWyA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BE988017CC;
        Wed, 22 Jan 2020 06:12:55 +0000 (UTC)
Received: from redhat.com (ovpn-112-7.rdu2.redhat.com [10.10.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49895860EB;
        Wed, 22 Jan 2020 06:12:53 +0000 (UTC)
Date:   Tue, 21 Jan 2020 22:09:51 -0800
From:   Jerome Glisse <jglisse@redhat.com>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Generic page write protection
Message-ID: <20200122060951.GA77704@redhat.com>
References: <20200122023222.75347-1-jglisse@redhat.com>
 <20200122042832.GA6542@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200122052118.GE76712@redhat.com>
 <20200122055219.GC6542@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200122055219.GC6542@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 01:52:26PM +0800, Gao Xiang wrote:
> On Tue, Jan 21, 2020 at 09:21:18PM -0800, Jerome Glisse wrote:
>=20
> <snip>
>=20
> >=20
> > The block device code only need the mapping on io error and they are
> > different strategy depending on individual fs. fs using buffer_head
> > can easily be updated. For other they are different solution and they
> > can be updated one at a time with tailor solution.
>=20
> If I did't misunderstand, how about post-processing fs code without
> some buffer_head but page->private used as another way rather than
> a pointer? (Yes, some alternative ways exist such as hacking struct
> bio_vec...)

The ultimate answer is that page write protection will not be allow
for some filesystem (that's how the patchset is designed in fact so
that things can be merge piecemeal). But they are many way to solve
the io error reporting and that's one of the thing i would like to get
input on.

>=20
> I wonder the final plan on this from the community, learn new rule
> and adapt my code anyway.. But in my opinion, such reserve way
> (page->mapping likewise) is helpful in many respects, I'm not sure
> we could totally get around all cases without it elegantly...

I still need to go read what it is you are trying to achieve. But i
do not see any reason to remove page->mapping

Cheers,
J=E9r=F4me

