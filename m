Return-Path: <linux-fsdevel+bounces-41753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4B4A366F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 21:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135F07A4194
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159601C861D;
	Fri, 14 Feb 2025 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuBjEFhM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7C1991B6
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739565349; cv=none; b=R38Rc2hyGgLnM/3tKzl3zWQEAPYAmiOooiPcZBQ+pU/20Sdtf7lfzpF6h8RHnlPDMIPwXr0/CowuCm+OUgCqQXQuf02fXfw0ev0CEpgy7R69DjR9DVszc0ByG0AOkiWZfe1DrDcFSnVgWryu8eiqL7/K/SbRitbRiLIdaHD1INI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739565349; c=relaxed/simple;
	bh=4b48xXYShS+dmHSIDPVQ1VXiBnPZs+XzlgcmwqIFj5c=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=jevjmQ6VZ3Bca5m1JtwGPzGtB1qMHgpMKYvF7uWDyfbvpMtK8KTJAHMFVtCGsyAM4SeQbwVc4pO3QVHqgtKlv7V4Zk1366Xdt+GMkR9K7zQ/Zd9Ml6BXyz6MbiugdhFu7aJElH6tyIu+pLJKIsJY8R6iNP8vS23K7+2DythO7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuBjEFhM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739565346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+P8vtlpWQzzSDVwGrEnmDjTutTIlWbWH7tZ146DpkA=;
	b=DuBjEFhMUrzecTtLWrla5bolPvXrWoVQwvlq/ac0qJSiQQWpeIcfydv8qDxxT2MWrTVDLG
	T2wG7LzdPz6g4/XdYxBPI/ucV5c1jIlUnLX9yLONaIGZyiRYPXM7uqhN3zwJmt1WfuKlGo
	J7osOHO9m/4LvghqMwq+gVxTbqO23Tw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-1zqweHf4O2y2HkNzstSOyQ-1; Fri,
 14 Feb 2025 15:35:42 -0500
X-MC-Unique: 1zqweHf4O2y2HkNzstSOyQ-1
X-Mimecast-MFC-AGG-ID: 1zqweHf4O2y2HkNzstSOyQ_1739565340
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C9E41801A1C;
	Fri, 14 Feb 2025 20:35:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F0DE194129B;
	Fri, 14 Feb 2025 20:35:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4e993d6ebadba1ed04261fd5590d439f382ca226.camel@ibm.com>
References: <4e993d6ebadba1ed04261fd5590d439f382ca226.camel@ibm.com> <20250205000249.123054-1-slava@dubeyko.com> <4153980.1739553567@warthog.procyon.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, "slava@dubeyko.com" <slava@dubeyko.com>,
    Alex Markuze <amarkuze@redhat.com>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [RFC PATCH 0/4] ceph: fix generic/421 test failure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Feb 2025 20:35:36 +0000
Message-ID: <18284.1739565336@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> > There's still the issue of encrypted filenames occasionally showing thr=
ough
> > which generic/397 is showing up - but I don't think your patches here f=
ix
> > that, right?
> >=20
>=20
> This patchset doesn't fix the generic/397 issue. I sent another patch ([P=
ATCH
> v2] ceph: Fix kernel crash in generic/397 test) [1] before this one with =
the
> fix.

That doesn't fix the problem either.  That seems to be fixing a crash, not:

generic/397       - output mismatch (see /root/xfstests-dev/results//generi=
c/397.out.bad)
    --- tests/generic/397.out   2024-09-12 12:36:14.167441927 +0100
    +++ /root/xfstests-dev/results//generic/397.out.bad 2025-02-14 20:34:10=
.365900035 +0000
    @@ -1,13 +1,27 @@
     QA output created by 397
    +Only in /xfstest.scratch/ref_dir: yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
    +Only in /xfstest.scratch/edir: yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDSd=EF=BF=
=BDS=EF=BF=BDe=EF=BF=BD=EF=BF=BD[=EF=BF=BD@=EF=BF=BD=EF=BF=BD=EF=BF=BD7,=EF=
=BF=BD=EF=BF=BD
                                                                           =
                 [=EF=BF=BDg=EF=BF=BD=EF=BF=BD
    +Only in /xfstest.scratch/edir: 70h6RnwpEg1PMtJp9yQ,2g
    +Only in /xfstest.scratch/edir: HHBOImQ7cdmsZKNhc5yPCX+XKu0+dn4VViEQzd0=
q3Ig
    +Only in /xfstest.scratch/edir: HXYO3UK3FrxqwSZaNnQ5zQ
    +Only in /xfstest.scratch/edir: PecH6opy8KkkB8ir8Oz0pw
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/397.out /root/xfstests-d=
ev/results//generic/397.out.bad'  to see the entire diff)


David


