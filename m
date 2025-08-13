Return-Path: <linux-fsdevel+bounces-57793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D69B25544
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 23:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16AE1C84565
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 21:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5970D2F28FC;
	Wed, 13 Aug 2025 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaKQ7cOC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B15B2ED16F
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120217; cv=none; b=Y57ffWUcvfWpHAg/a168UAkoqVWfI8nmccmyQiCBluPcyxcic7TIBq9DH9wjr4Q2XEAqeblaDIcgfYskrxMxsp8wzdcFDw80imB6cs1Qzl1B9OpWA6NZVr10uEynPUtTTYyhaLnhBYNFeeCKivAE/+rc3OciIDB0Z0h2cM6UP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120217; c=relaxed/simple;
	bh=f4ESDAn8qtDMkZThP5iUivKJtwhNex/DYGUIvEV+7Fs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jS90TKcE56hxuGTV6F2bNPTpnNk0Hij+rl4Ukg0JAjKp48eUrDkhQn1NDmHBR0q0fMvKURZvhovN/1asz8kgxjVTYvF1Ufa9eyc4EgNscVOJ76lXr8Rw83SgOy2GRtGGQg3t/4ahNsq2A/OjZlpWX2CC/MrrFXTqs8kxpxWzjso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaKQ7cOC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755120215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Br3wJERUE5eXA2wwtj1Flm2QypuyAGNLKB8PyN7fbI=;
	b=XaKQ7cOCT2G1gEZ8QUO121cPFr+YGO6YfYRrs4L+hJTlMLe+hPN8xVl9/lXotPV7oO6sva
	gASbzofAboL38DEQDgB7JKRSSOGohVqQqejUwMZvR64HWMq9aSraKY1bqclFToZNQfvOyu
	NLUUdhVvmBB+YulP53OPRXvf5UUJgJY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-mHn1fXZOOJCjxWMbEYvFlw-1; Wed,
 13 Aug 2025 17:23:30 -0400
X-MC-Unique: mHn1fXZOOJCjxWMbEYvFlw-1
X-Mimecast-MFC-AGG-ID: mHn1fXZOOJCjxWMbEYvFlw_1755120209
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B2671955D4B;
	Wed, 13 Aug 2025 21:23:29 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.43])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34BFD30001A1;
	Wed, 13 Aug 2025 21:23:26 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>,  linux-fsdevel@vger.kernel.org,
  Bernd Schubert <bschubert@ddn.com>,  Amir Goldstein <amir73il@gmail.com>,
  Chunsheng Luo <luochunsheng@ustc.edu>
Subject: Re: [PATCH v2 3/3] fuse: add COPY_FILE_RANGE_64 that allows large
 copies
In-Reply-To: <CAJnrk1ZpG5RHQEaBu3vnK80fLyXRBTQj0-K2PzG2pZk18om7cQ@mail.gmail.com>
	(Joanne Koong's message of "Wed, 13 Aug 2025 13:35:02 -0700")
References: <20250813152014.100048-1-mszeredi@redhat.com>
	<20250813152014.100048-4-mszeredi@redhat.com>
	<CAJnrk1bfoumJHwc5p-WASXYxWG8tzz91LfzpiEkPTSOoTDK1ig@mail.gmail.com>
	<lhuwm776n92.fsf@oldenburg.str.redhat.com>
	<CAJnrk1ZpG5RHQEaBu3vnK80fLyXRBTQj0-K2PzG2pZk18om7cQ@mail.gmail.com>
Date: Wed, 13 Aug 2025 23:23:23 +0200
Message-ID: <lhuo6si7w6s.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Joanne Koong:

> On Wed, Aug 13, 2025 at 12:21=E2=80=AFPM Florian Weimer <fweimer@redhat.c=
om> wrote:
>>
>> * Joanne Koong:
>>
>> > On Wed, Aug 13, 2025 at 8:24=E2=80=AFAM Miklos Szeredi <mszeredi@redha=
t.com> wrote:
>> >>
>> >> The FUSE protocol uses struct fuse_write_out to convey the return val=
ue of
>> >> copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_=
RANGE
>> >> interface supports a 64-bit size copies and there's no reason why cop=
ies
>> >> should be limited to 32-bit.
>> >>
>> >> Introduce a new op COPY_FILE_RANGE_64, which is identical, except the
>> >> number of bytes copied is returned in a 64-bit value.
>> >>
>> >> If the fuse server does not support COPY_FILE_RANGE_64, fall back to
>> >> COPY_FILE_RANGE.
>> >
>> > Is it unacceptable to add a union in struct fuse_write_out that
>> > accepts a uint64_t bytes_copied?
>> > struct fuse_write_out {
>> >     union {
>> >         struct {
>> >             uint32_t size;
>> >             uint32_t padding;
>> >         };
>> >         uint64_t bytes_copied;
>> >     };
>> > };
>> >
>> > Maybe a little ugly but that seems backwards-compatible to me and
>> > would prevent needing a new FUSE_COPY_FILE_RANGE64.
>>
>> Even with a capability flag, it encourages the presence of bugs that
>> manifest only on big-endian systems.
>
> Interesting, can you explain how? size would always be accessed
> directly through write_out->size (instead of extracted from the upper
> 32 bits of bytes_copied), so wouldn't the compiler handle the correct
> memory access?

Incorrectly using the size member when bytes_copied is intended and vice
versa would mostly work on little-endian architectures (so hard to spot
during testing), but break spectacularly on big-endian architectures.

Thanks,
Florian


