Return-Path: <linux-fsdevel+bounces-24461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC2C93F9AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED26F2830BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 15:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6975B15CD7F;
	Mon, 29 Jul 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoPBeSjq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0515B14C
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267583; cv=none; b=dXZAqLHRTAeSJ0ssaRGz1g4yZ6pHWJ6fnkjxfgVtE+xgOeVrEU6K5cgi0NoxCHdUuInPCyHk9MT0+k/CtRd9IbyeSBvSTvXWwBA3zXS8Mrdsq/0gb4/8gXOS/pT4B1x6TfyOyf8M1jI0omgn1i451pBq1kiz5KRuh5znvYFqZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267583; c=relaxed/simple;
	bh=Km4f0/3Vzz+8Qh1fHaeNKmN2Y2DZ97pJ0lZw8d2Z8gY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QvgR/JlOQBvmKABzVKfM0z7TRrzCtPqGuseBT9vNDpqldQ+KX/3iaih6A0IcU/KBbji56aRJp/jivFR6ILrlu+OCe0qi4464T/7d0iX2K/lpVeK7SHkcbLzStUGf/+T1PQHZ5PiTk9EmIX3YAk7gFMjTMNH0fnMf9sAF6wWyX4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GoPBeSjq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722267581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTv5CfW4HXbVM7xQU93V1CPvEqo/zJ6yCu/2thM1qdY=;
	b=GoPBeSjqP5cKIJt2Oe899fhHU1uQ596cJY4rX767Xah3iuxwGfnib0NJvheK1qOuViyvxC
	cPGzy4E7TpntDAwkeJnAV7gRRQTpgV9PKfnwbMFJQ6xu5BxfSmtuMHQcE+CBL5oURYV+sV
	IyX8gA+lh5ZlUBzUpPo5zDyUrbGKEdE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-kAsn5MPIMMm01t7Y-2XajQ-1; Mon,
 29 Jul 2024 11:39:34 -0400
X-MC-Unique: kAsn5MPIMMm01t7Y-2XajQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9617D1955D5F;
	Mon, 29 Jul 2024 15:39:33 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88EEB1955F40;
	Mon, 29 Jul 2024 15:39:31 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  Dave Chinner <dchinner@redhat.com>
Subject: Re: Testing if two open descriptors refer to the same inode
In-Reply-To: <a13bff5812cb36adf3fed80093cbe1de601ec506.camel@kernel.org> (Jeff
	Layton's message of "Mon, 29 Jul 2024 11:24:41 -0400")
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
	<a13bff5812cb36adf3fed80093cbe1de601ec506.camel@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 29 Jul 2024 17:39:28 +0200
Message-ID: <87frrsmclr.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Jeff Layton:

> On Mon, 2024-07-29 at 08:55 +0200, Florian Weimer wrote:
>> It was pointed out to me that inode numbers on Linux are no longer
>> expected to be unique per file system, even for local file systems.
>> Applications sometimes need to check if two (open) files are the
>> same.
>> For example, a program may want to use a temporary file if is invoked
>> with input and output files referring to the same file.
>>=20
>> How can we check for this?=C2=A0 The POSIX way is to compare st_ino and
>> st_dev in stat output, but if inode numbers are not unique, that will
>> result in files falsely being reported as identical.=C2=A0 It's harmless
>> in
>> the temporary file case, but it in other scenarios, it may result in
>> data loss.
>>=20
>
> I believe this is the problem that STATX_SUBVOL was intended to solve.
>
> Both bcachefs and btrfs will provide this attribute if requested. So,
> basically to uniquely ID an inode using statx, you need a tuple of:
>
> stx_dev_major/minor
> stx_subvol
> stx_ino
>
> If the filesystem doesn't provide STATX_SUBVOL, then one can (likely)
> conclude that stx_dev_* and stx_ino are enough.

Does this really work for the virtiofs case, though?  It has to pass
through all three *and* make things unique relative to the host, I
think.

Thanks,
Florian


