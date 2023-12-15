Return-Path: <linux-fsdevel+bounces-6207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE05814FBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 19:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4BC1F252A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 18:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36E23C6AC;
	Fri, 15 Dec 2023 18:30:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E723834CDC
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-193-GwFUMuBGO92Tm---NDeWVg-1; Fri, 15 Dec 2023 18:28:53 +0000
X-MC-Unique: GwFUMuBGO92Tm---NDeWVg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 15 Dec
 2023 18:28:37 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 15 Dec 2023 18:28:37 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'NeilBrown' <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>
CC: Chuck Lever <chuck.lever@oracle.com>, Christian Brauner
	<brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, Oleg Nesterov
	<oleg@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 files.
Thread-Topic: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 files.
Thread-Index: AQHaLIC6NFPF78zqekmV13EV7pLlBLCqr+Uw
Date: Fri, 15 Dec 2023 18:28:37 +0000
Message-ID: <24cd21e4b0814dae94b9fe0a7957555a@AcuMS.aculab.com>
References: <20231208033006.5546-1-neilb@suse.de>,
 <20231208033006.5546-2-neilb@suse.de>,
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>,
 <170224845504.12910.16483736613606611138@noble.neil.brown.name>,
 <20231211191117.GD1674809@ZenIV>
 <170233343177.12910.2316815312951521227@noble.neil.brown.name>
In-Reply-To: <170233343177.12910.2316815312951521227@noble.neil.brown.name>
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

Li4NCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSBhZHZlbnQgb2Ygdm1hbGxvYyBhbGxv
Y2F0ZWQgc3RhY2tzIG1lYW5zDQo+IHRoYXQga2VybmVsIHN0YWNrIHNwYWNlIGlzIG5vdCBhbiBp
bXBvcnRhbnQgY29uc2lkZXJhdGlvbi4NCg0KVGhleSBhcmUgc3RpbGwgdGhlIHNhbWUgKHNtYWxs
KSBzaXplIC0ganVzdCBhbGxvY2F0ZWQgZGlmZmVyZW50bHkuDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


