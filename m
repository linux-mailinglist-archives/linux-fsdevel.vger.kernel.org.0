Return-Path: <linux-fsdevel+bounces-60007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D40EB40C66
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 19:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2114D7B43AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 17:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF258310654;
	Tue,  2 Sep 2025 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LD9/t4by"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A03332F761
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835301; cv=none; b=BI0FrsGQjzX4FwpI2kkJ/VJq+p8zje8oZA/EZJpyKx08GeqXSwtk8O3H8kVQj3sGqz5ZpF6f+cV5Hn/moLVr6ObUmNUbT6X9bH1zS8bJ8Cli03Fuj7NDvPyir0PwtFs5M6fhvdr+vXlXUel+6i0/jWPXAaETTYVQwS+cTCBcYVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835301; c=relaxed/simple;
	bh=+ZOl+ulpgIj6k5dtR9VW93PRihwtRTM5xi0pDg5SIHY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=NjfY/yJYucI0ZJB2MQf3HIeFH7Okrkrgpcel0hrTHkpAR2dJ/LrczgMfaTzowzBp672SywSjRyewyZuDZrMkqe1x1yFoLxIMjV4tA5j5cxFIG/7afgQiSHXYVW/GLj9/6KAQj5wLPqESusCsmOEAqIGeqiXOnj/4m3Wzr5qz6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LD9/t4by; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756835298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qq6st+qbX7M8TtuYrDJJKK62DN+QLpUTuVf4eLxsP1E=;
	b=LD9/t4by6I/xikIE9WHnaaHaMPNbAEBPRSv7O2w15XdsYGK5TEOKYRAyAUiE32qZIBUtm2
	nhqwreCbF7MvnyThpsbKGPgMZmW3OEDfFhE1HjgEuygkr3idounHGLIzhK3+NgEUn7o8Y/
	dzVl809jQETT02uTRuMuBRS39n1hJBs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-5LO__cpjNjybfmxR8jB2Jw-1; Tue,
 02 Sep 2025 13:48:15 -0400
X-MC-Unique: 5LO__cpjNjybfmxR8jB2Jw-1
X-Mimecast-MFC-AGG-ID: 5LO__cpjNjybfmxR8jB2Jw_1756835293
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3076180035F;
	Tue,  2 Sep 2025 17:48:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBFD918004D4;
	Tue,  2 Sep 2025 17:48:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=whb6Jpj-w4GKkY2XccG2DQ4a2thSH=bVNXhbTG8-V+FSQ@mail.gmail.com>
References: <CAHk-=whb6Jpj-w4GKkY2XccG2DQ4a2thSH=bVNXhbTG8-V+FSQ@mail.gmail.com> <20250828230806.3582485-1-viro@zeniv.linux.org.uk> <20250828230806.3582485-61-viro@zeniv.linux.org.uk> <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com> <20250829001109.GB39973@ZenIV> <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com> <20250829060306.GC39973@ZenIV> <20250829060522.GB659926@ZenIV> <20250829-achthundert-kollabieren-ee721905a753@brauner> <20250829163717.GD39973@ZenIV> <20250830043624.GE39973@ZenIV> <20250830073325.GF39973@ZenIV> <CAHk-=wiSNJ4yBYoLoMgF1M2VRrGfjqJZzem=RAjKhK8W=KohzQ@mail.gmail.com> <ed70bad5-c1a8-409f-981e-5ca7678a3f08@gotplt.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Siddhesh Poyarekar <siddhesh@gotplt.org>,
    Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
    jack@suse.cz, Ian Kent <raven@themaw.net>,
    Christian Brauner <brauner@kernel.org>,
    Jeffrey Altman <jaltman@auristor.com>, linux-afs@lists.infradead.org
Subject: Re: [RFC] does # really need to be escaped in devnames?
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <663879.1756835288.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Sep 2025 18:48:08 +0100
Message-ID: <663880.1756835288@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 2 Sept 2025 at 08:03, Siddhesh Poyarekar <siddhesh@gotplt.org> w=
rote:
> >
> > This was actually the original issue I had tried to address, escaping
> > '#' in the beginning of the devname because it ends up in the beginnin=
g
> > of the line, thus masking out the entire line in mounts.  I don't
> > remember at what point I concluded that escaping '#' always was the
> > answer (maybe to protect against any future instances where userspace
> > ends up ignoring the rest of the line following the '#'), but it appea=
rs
> > to be wrong.
> =

> I wonder if instead of escaping hash-marks we could just disallow them
> as the first character in devname.

The problem with that is that it appears that people are making use of thi=
s.

Mount /afs with "-o dynroot" isn't a problem as that shouldn't be given a
device name - and that's the main way people access AFS.  With OpenAFS I d=
on't
think you can do this at all since it has a single superblock that it cram=
s
everything under.  For AuriStor, I think you can mount individual volumes,=
 but
I'm not sure how it works.  For Linux's AFS, I made every volume have its =
own
superblock.

The standard format of AFS volume names is [%#][<cell>:]<volume-name-or-id=
>
but I could make it an option to stick something on the front and use that
internally and display that in /proc/mounts, e.g.:

	mount afs:#openafs.org:afs.root /mnt

which would at least mean that sh and bash wouldn't need the "#" escaping.

The problem is that the # and the % have specific documented meanings, so =
if I
was to get rid of the '#' entirely, I would need some other marker.  Maybe=
 it
would be sufficient to just go on the presence or not of a '%'.

Maybe I could go with something like:

	openafs.org:root.cell:ro
	openafs.org:root.cell:rw
	openafs.org:root.cell:bak

rather than use #/%.

I don't think there should be a problem with still accepting lines beginni=
ng
with '#' in mount() if I display them with an appropriate prefix.  That wo=
uld
at least permit backward compatibility.

David


