Return-Path: <linux-fsdevel+bounces-11050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A14E85045A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 13:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E204E2828B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097563E48C;
	Sat, 10 Feb 2024 12:13:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF853DBAD
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707567187; cv=none; b=WcRZMObtG8hEsy3M431VR4/Mar83eEli5l+tYPv6wzyRZO0rH+BqrsUa8QZUQ1slCkkoUp6FmfrEnK7l/i0WZJVj+hs/nI9FFGL1s6vjR1s6hnRnXi/NnDBVSS9G9VJJseKSSPqg3DOHbZVvxkox09wXRlMCAvTYgHHtFr/iyq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707567187; c=relaxed/simple;
	bh=eTKKCRVzP1Y6N+8sXUxJFdEE3i1c7vbnIzYg3l82Xh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=PfxIPtMQ1pFmbUTHmsesxQSk7lIzXIAv5qz08VSej9VyMnH2a1HSa+cePu4tGXyi8+biRDN96AYvlapxkS/jo8S+6eRu1QXOrXwwJLUcTQYNMJ9RPBtXyeqViD4ojULg2Y1t8MmmBLq/rSb+zIbIGwmvrGmZC+Qkd/AN4hHuIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-200-vIU3xCq1MRabbdi4Cu8-TQ-1; Sat, 10 Feb 2024 12:12:56 +0000
X-MC-Unique: vIU3xCq1MRabbdi4Cu8-TQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Feb
 2024 12:12:35 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Feb 2024 12:12:35 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'John Garry' <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "djwong@kernel.org" <djwong@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "dchinner@redhat.com" <dchinner@redhat.com>,
	"jack@suse.cz" <jack@suse.cz>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "tytso@mit.edu" <tytso@mit.edu>,
	"jbongio@google.com" <jbongio@google.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"ojaswin@linux.ibm.com" <ojaswin@linux.ibm.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>
Subject: RE: [PATCH v3 00/15] block atomic writes
Thread-Topic: [PATCH v3 00/15] block atomic writes
Thread-Index: AQHaWS09K2I7bFfzB0C0GPvnJtedS7EDgm/g
Date: Sat, 10 Feb 2024 12:12:35 +0000
Message-ID: <da8f0dc3475746da8f612de6f7c72ad6@AcuMS.aculab.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
 <20240129061839.GA19796@lst.de>
 <12718838-7038-4d47-9287-e699e8808143@oracle.com>
In-Reply-To: <12718838-7038-4d47-9287-e699e8808143@oracle.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

Q2FuIHNvbWVvbmUgYWRkIGEgOiBhZnRlciBibG9jaz8NCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


