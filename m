Return-Path: <linux-fsdevel+bounces-57784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B850DB253DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 21:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E691C84F90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 19:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7D2F998D;
	Wed, 13 Aug 2025 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vr+EM78u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ACE2F9985
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112916; cv=none; b=Fhvf9xea1km9xthxMDshuOBpLpt6JHkd6GxcvqV6mjNCsvnaAK5LItJQ9GVCbWM5bKmMCJjgh6TSPQLV22GBY/30gLomktYcRiysl+7zQ9yinNY9ZKyk/O4msMqt2w9THdCDzbmsyt5eri2ZWUwiBcZbrfFnG8WKLWDldcCdW5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112916; c=relaxed/simple;
	bh=nWNJkGrHSPyV504xLCPLtNotpVgYBeg9PerzmCKCctU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uyJydxjpc49aoXMl3hU/vpzPij4XHfEKuP7woUNRXymhvjHj3sfo5DHuPbkQYGoZ0sH4pE13nbY5Iq7cR2qWj20tnfTUPgF2hGrDBVUxSjjPzIGfLjYQcjKeJ+d2f5RbRuqdGcD4Dcg+jJDJizcLmiQJU+VHrD7wiQxZnSy4AsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vr+EM78u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755112913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHqldPQUMECoePfd5d4I3FK/R8rPHFii064gY9Sldzk=;
	b=Vr+EM78ungtw7ZUXSDF5KmQeors1TvQAoiirSLnCKJaAQenefm8yxHa4sjZYMgHSXE8LvP
	Z7R7SrbCvUNP4RWy1sddZr9fa/keM3JXxiFAX8lXVwol25f1gM0tHp850VJV6VISSqXzTC
	8RAofGFAdgjnb4pUNk2oRICJzRrzSDQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-NLmj8ECQO4qc5e3XSo2TAg-1; Wed,
 13 Aug 2025 15:21:52 -0400
X-MC-Unique: NLmj8ECQO4qc5e3XSo2TAg-1
X-Mimecast-MFC-AGG-ID: NLmj8ECQO4qc5e3XSo2TAg_1755112911
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9675F1956050;
	Wed, 13 Aug 2025 19:21:50 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.43])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AD46195608F;
	Wed, 13 Aug 2025 19:21:48 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>,  linux-fsdevel@vger.kernel.org,
  Bernd Schubert <bschubert@ddn.com>,  Amir Goldstein <amir73il@gmail.com>,
  Chunsheng Luo <luochunsheng@ustc.edu>
Subject: Re: [PATCH v2 3/3] fuse: add COPY_FILE_RANGE_64 that allows large
 copies
In-Reply-To: <CAJnrk1bfoumJHwc5p-WASXYxWG8tzz91LfzpiEkPTSOoTDK1ig@mail.gmail.com>
	(Joanne Koong's message of "Wed, 13 Aug 2025 10:03:17 -0700")
References: <20250813152014.100048-1-mszeredi@redhat.com>
	<20250813152014.100048-4-mszeredi@redhat.com>
	<CAJnrk1bfoumJHwc5p-WASXYxWG8tzz91LfzpiEkPTSOoTDK1ig@mail.gmail.com>
Date: Wed, 13 Aug 2025 21:21:45 +0200
Message-ID: <lhuwm776n92.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Joanne Koong:

> On Wed, Aug 13, 2025 at 8:24=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.c=
om> wrote:
>>
>> The FUSE protocol uses struct fuse_write_out to convey the return value =
of
>> copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_RAN=
GE
>> interface supports a 64-bit size copies and there's no reason why copies
>> should be limited to 32-bit.
>>
>> Introduce a new op COPY_FILE_RANGE_64, which is identical, except the
>> number of bytes copied is returned in a 64-bit value.
>>
>> If the fuse server does not support COPY_FILE_RANGE_64, fall back to
>> COPY_FILE_RANGE.
>
> Is it unacceptable to add a union in struct fuse_write_out that
> accepts a uint64_t bytes_copied?
> struct fuse_write_out {
>     union {
>         struct {
>             uint32_t size;
>             uint32_t padding;
>         };
>         uint64_t bytes_copied;
>     };
> };
>
> Maybe a little ugly but that seems backwards-compatible to me and
> would prevent needing a new FUSE_COPY_FILE_RANGE64.

Even with a capability flag, it encourages the presence of bugs that
manifest only on big-endian systems.

Thanks,
Florian


