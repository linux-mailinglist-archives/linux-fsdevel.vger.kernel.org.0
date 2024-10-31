Return-Path: <linux-fsdevel+bounces-33347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C499B7B48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 14:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548371C2195A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C4919DF77;
	Thu, 31 Oct 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEgrmPY6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AF219CD1D
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379758; cv=none; b=aBgCa7bx5lkHiDx31oM85ivmO2w0mnXIO82y/8bo9AcE7Sq4xzNGo8EtAq7KUM61qenqDXNG+0b5RdV4TwWftDdLhYfozdUr00JxrPFNK7rtXTIZWs3qrU2JplfL3MsBp2ReVMF6BHGNksBhldmQn1NLxguD77tIbKv0tBsMs4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379758; c=relaxed/simple;
	bh=M0D70IamMVOUtlYaX3c1QqMzfw1QA/z6aOA3jm/EdbY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mvamyoMcQOxah+3sUiy/LNeK0WlzrCw7kd9+PcCpcFoRkqILumQtskabK1aeP2hL0Lrckqi9RNg99X5pA6SEP8Pae5IYPxtmsC4XCQVeqAYBvtq8FdE00Zr2JbKvZ8sHTjYiG7JQCd37+PtG0CB/B/LAzbnYte1c6k4fYJc422E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEgrmPY6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730379755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKUe4Pa/R9hlbyMzR4jy1hOyGYkrTgtlKEhJgNXsdu4=;
	b=YEgrmPY616MljnHkGKU999+xRhllAt1FWB2HbvHq6t2lRHu9mGiXBm1Zdars3GAojCqHnD
	YfzC8xHyIo3JFVc+5qljG79V03zEG0COc+rO2lCtXS1CuB4ZfAOSkyyVCJfqoIC3meQHFp
	dYAkm3ZpIIdUcEatj5XpLjdeXNRulOY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-Ikp4entDNiagHn3Fq2JFdw-1; Thu,
 31 Oct 2024 09:02:30 -0400
X-MC-Unique: Ikp4entDNiagHn3Fq2JFdw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D1C1195608D;
	Thu, 31 Oct 2024 13:02:28 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.64.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A76231956086;
	Thu, 31 Oct 2024 13:02:25 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Mohammed Anees <pvmohammedanees2003@gmail.com>,  willy@infradead.org,
  bcrl@kvack.org,  brauner@kernel.org,  linux-aio@kvack.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: aio: Transition from Linked List to Hash Table for
 Active Request Management in AIO
References: <ZxW3pyyfXWc6Uaqn@casper.infradead.org>
	<20241022070329.144782-1-pvmohammedanees2003@gmail.com>
	<20241031120423.5rq6uykywklkptkv@quack3>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 31 Oct 2024 09:02:23 -0400
In-Reply-To: <20241031120423.5rq6uykywklkptkv@quack3> (Jan Kara's message of
	"Thu, 31 Oct 2024 13:04:23 +0100")
Message-ID: <x491pzwtogw.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Jan Kara <jack@suse.cz> writes:

> Hi!
>
> On Tue 22-10-24 12:33:27, Mohammed Anees wrote:
>> > Benchmarks, please.  Look at what operations are done on this list.
>> > It's not at all obvious to me that what you've done here will improve
>> > performance of any operation.
>>=20
>> This patch aims to improve this operation in io_cancel() syscall,
>> currently this iterates through all the requests in the Linked list,
>> checking for a match, which could take a significant time if the=20
>> requests are high and once it finds one it deletes it. Using a hash
>> table will significant reduce the search time, which is what the comment
>> suggests as well.
>>=20
>> /* TODO: use a hash or array, this sucks. */
>> 	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
>> 		if (kiocb->ki_res.obj =3D=3D obj) {
>> 			ret =3D kiocb->ki_cancel(&kiocb->rw);
>> 			list_del_init(&kiocb->ki_list);
>> 			break;
>> 		}
>> 	}
>>=20
>> I have tested this patch and believe it doesn=E2=80=99t affect the=20
>> other functions. As for the io_cancel() syscall, please let=20
>> me know exactly how you=E2=80=99d like me to test it so I can benchmark=
=20
>> it accordingly.
>
> Well, I'd say that calling io_cancel() isn't really frequent operation. Or
> are you aware of any workload that would be regularly doing that? Hence
> optimizing performance for such operation isn't going to bring much benef=
it
> to real users. On the other hand the additional complexity of handling
> hashtable for requests in flight (although it isn't big on its own) is
> going to impact everybody using AIO. Hence I agree with Matthew that
> changes like you propose are not a clear win when looking at the bigger
> picture and need good justification.

... and cancelation is only supported by usb gadgetfs.  I'd say submit a
patch that gets rid of that todo so nobody else wastes time on it.

Cheers,
Jeff


