Return-Path: <linux-fsdevel+bounces-43360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49653A54D41
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 15:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34114175AA9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D890155CB3;
	Thu,  6 Mar 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV+Womz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEFF1547D8
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270404; cv=none; b=PmA8NvlgiVNE8dDLJ98tOE+nNxTiQmFfDJFaeQeIcA8tSamjfmSG/1iOfGhj/WoYXu/fix7ETzL7s7BZ0AmEmKg3Dw3DnB/Df7nUsLooz3sJdVPah/EQ5xLH1JvgC7nkJ0dhPMrbVyxuapd7RwJeYFynpv8/LogMBcLfbk9CIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270404; c=relaxed/simple;
	bh=qn7pOkHFPACWC3ankALRwy8VTErHcUJ0y9sGMG7J+i4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=baWpyr7Gi7c+sZokAeBGB41bR7aHPgn80zZnLBTs+XOAWVEltwcBwMSpC15rbzRf7NFSQUsGnUekOGJgwEFSwUlCw3J2iscrrzlrzK6f1l3RkHvJ8t0JF0bKgOTJFFIhngzCa2/ZBER7qerXMqLrkdtlzzJR0aJqeRQXxfYE+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LV+Womz2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QTylQclBpCvK/bYZ/U9b8EYKj1/Me+hfjFcIR9QP8T8=;
	b=LV+Womz2Lw6rXIx6zH8cdYFN3HqpkV6FAqN+m6LIDQx2t3/n12nrI2oQP17jDDCeXsiF5H
	e/sprh0BRLzT1CeTSS9QNB6H09Sb1yIDUjay8haBBDUg9ODFBESIdhxfN3iKvVvnyBsMA/
	SgJhM4Ekudw776G2w3s1/v06xnBMYPs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-WVFCTE-iMQG4tyo6Xa0yDg-1; Thu,
 06 Mar 2025 09:13:18 -0500
X-MC-Unique: WVFCTE-iMQG4tyo6Xa0yDg-1
X-Mimecast-MFC-AGG-ID: WVFCTE-iMQG4tyo6Xa0yDg_1741270397
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19D421955F26;
	Thu,  6 Mar 2025 14:13:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CD6A18009BC;
	Thu,  6 Mar 2025 14:13:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CACPzV1mpUUnxpKQFtDzd25NzwooQLyyzdRhxEsHKtt3qfh35mA@mail.gmail.com>
References: <CACPzV1mpUUnxpKQFtDzd25NzwooQLyyzdRhxEsHKtt3qfh35mA@mail.gmail.com> <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk> <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
To: Venky Shankar <vshankar@redhat.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
    Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
    Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    Gregory Farnum <gfarnum@redhat.com>,
    Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Is EOLDSNAPC actually generated? -- Re: Ceph and Netfslib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <128443.1741270391.1@warthog.procyon.org.uk>
Date: Thu, 06 Mar 2025 14:13:11 +0000
Message-ID: <128444.1741270391@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Venky Shankar <vshankar@redhat.com> wrote:

> > That's a good point, though there is no code on the client that can
> > generate this error, I'm not convinced that this error can't be
> > received from the OSD or the MDS. I would rather some MDS experts
> > chime in, before taking any drastic measures.
> 
> The OSDs could possibly return this to the client, so I don't think it
> can be done away with.

Okay... but then I think ceph has a bug in that you're assuming that the error
codes on the wire are consistent between arches as mentioned with Alex.  I
think you need to interject a mapping table.

David


