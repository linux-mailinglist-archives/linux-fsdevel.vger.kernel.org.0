Return-Path: <linux-fsdevel+bounces-40085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A69A1BDA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 21:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52943ACD93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC141DB940;
	Fri, 24 Jan 2025 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="d2xFcyIi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFA71D63D9
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737751809; cv=none; b=Opp1fVbm0eAmjQsBGGCkCLhRskjlRQ0PaEV3zBFJULcvUQs442ObVR3+0asm0Mec5xDjXodpPz9rwXnJWvUzEaZptYiqQSzr3xytQD6WDxGtULTmfI3jmc1SvXbbXQYFIuAD3/ilGIKNSgKAcNffCkuAdinn/NTy+tBflkePC1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737751809; c=relaxed/simple;
	bh=Z9IDo22gawFne4VR0MFG06ikkPKkdl66ZpiP1JxWIgE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eaBKDyrqRjonCSKFUy3ztEEcEiVxmS1GvFhKkElaz7GkPvamyDsVWSKrMsjWgo9M9vuaKihDeth9xeJVR4Ok7SO8TAsivyd5NsuuTNtdSp9PAEqq1bej4THNkPi3bzUoTHmWw5R72oQD4SzFVd6hke86vq//shzWG+7k2Uf67iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=d2xFcyIi; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737751808; x=1769287808;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=Z9IDo22gawFne4VR0MFG06ikkPKkdl66ZpiP1JxWIgE=;
  b=d2xFcyIirBo5g7P+p2XE2ulehozJYrAS53bkQ7WD48A1to5QlSP7MoCb
   ym1dLirWcm6TsF/ahyRfTdj65r/epgsHKMnJWJO8LR+vzubawd1iLNHkJ
   eDiZamrFgWHUb48Rs/+26mUFQAi0Y+7THfYwosh8s3mPBeRncW4/BCPsX
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,232,1732579200"; 
   d="scan'208";a="403319229"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 20:50:07 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.44.209:57562]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.10.122:2525] with esmtp (Farcaster)
 id 4fcc9799-d070-456f-bf19-470b48de2935; Fri, 24 Jan 2025 20:50:06 +0000 (UTC)
X-Farcaster-Flow-ID: 4fcc9799-d070-456f-bf19-470b48de2935
Received: from EX19D017UEA002.ant.amazon.com (10.252.134.77) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 24 Jan 2025 20:50:02 +0000
Received: from EX19D017UEA001.ant.amazon.com (10.252.134.93) by
 EX19D017UEA002.ant.amazon.com (10.252.134.77) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 24 Jan 2025 20:50:02 +0000
Received: from EX19D017UEA001.ant.amazon.com ([fe80::bffb:623f:af5e:ebed]) by
 EX19D017UEA001.ant.amazon.com ([fe80::bffb:623f:af5e:ebed%3]) with mapi id
 15.02.1258.039; Fri, 24 Jan 2025 20:50:02 +0000
From: "Day, Timothy" <timday@amazon.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jsimmons@infradead.org" <jsimmons@infradead.org>, Andreas Dilger
	<adilger@ddn.com>, "neilb@suse.de" <neilb@suse.de>
Subject: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Thread-Topic: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Thread-Index: AQHbbqGKPQGkNCnWmkGOpAnSPDKrXw==
Date: Fri, 24 Jan 2025 20:50:02 +0000
Message-ID: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <F22AF8A4D6DD6A4E958295B1736F3C94@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

THVzdHJlIGlzIGEgaGlnaC1wZXJmb3JtYW5jZSBwYXJhbGxlbCBmaWxlc3lzdGVtIHVzZWQgZm9y
IEhQQw0KYW5kIEFJL01MIGNvbXB1dGUgY2x1c3RlcnMgYXZhaWxhYmxlIHVuZGVyIEdQTHYyLiBM
dXN0cmUgaXMNCmN1cnJlbnRseSB1c2VkIGJ5IDY1JSBvZiB0aGUgVG9wLTUwMCAoOSBvZiBUb3At
MTApIHN5c3RlbXMgaW4NCkhQQyBbN10uIE91dHNpZGUgb2YgSFBDLCBMdXN0cmUgaXMgdXNlZCBi
eSBtYW55IG9mIHRoZSBsYXJnZXN0DQpBSS9NTCBjbHVzdGVycyBpbiB0aGUgd29ybGQsIGFuZCBp
cyBjb21tZXJjaWFsbHkgc3VwcG9ydGVkIGJ5DQpudW1lcm91cyB2ZW5kb3JzIGFuZCBjbG91ZCBz
ZXJ2aWNlIHByb3ZpZGVycyBbMV0uDQoNCkFmdGVyIDIxIHllYXJzIGFuZCBhbiBpbGwtZmF0ZWQg
c3RpbnQgaW4gc3RhZ2luZywgTHVzdHJlIGlzIHN0aWxsDQptYWludGFpbmVkIGFzIGFuIG91dC1v
Zi10cmVlIG1vZHVsZSBbNl0uIFRoZSBwcmV2aW91cyB1cHN0cmVhbWluZw0KZWZmb3J0IHN1ZmZl
cmVkIGZyb20gYSBsYWNrIG9mIGRldmVsb3BlciBmb2N1cyBhbmQgdXNlciBhZG9wdGlvbiwNCndo
aWNoIGV2ZW50dWFsbHkgbGVkIHRvIEx1c3RyZSBiZWluZyByZW1vdmVkIGZyb20gc3RhZ2luZw0K
YWx0b2dldGhlciBbMl0uDQoNCkhvd2V2ZXIsIHRoZSB3b3JrIHRvIGltcHJvdmUgTHVzdHJlIGhh
cyBjb250aW51ZWQgcmVnYXJkbGVzcy4gSW4NCnRoZSBpbnRlcnZlbmluZyB5ZWFycywgdGhlIGNv
ZGUgaW1wcm92ZW1lbnRzIHRoYXQgcHJldmlvdXNseQ0KcHJldmVudGVkIGEgcmV0dXJuIHRvIG1h
aW5saW5lIGhhdmUgYmVlbiBzdGVhZGlseSBwcm9ncmVzc2luZy4gQXQNCmxlYXN0IDI1JSBvZiBw
YXRjaGVzIGFjY2VwdGVkIGZvciBMdXN0cmUgMi4xNiB3ZXJlIHJlbGF0ZWQgdG8gdGhlDQp1cHN0
cmVhbWluZyBlZmZvcnQgWzNdLiBBbmQgYWxsIG9mIHRoZSByZW1haW5pbmcgd29yayBpcw0KaW4t
ZmxpZ2h0IFs0XVs1XVs4XS4NCg0KT3VyIGV2ZW50dWFsIGdvYWwgaXMgdG8gYSBnZXQgYm90aCB0
aGUgTHVzdHJlIGNsaWVudCBhbmQgc2VydmVyDQoob24gZXh0NC9sZGlza2ZzKSBhbG9uZyB3aXRo
IGF0IGxlYXN0IFRDUC9JUCBuZXR3b3JraW5nIHRvIGFuDQphY2NlcHRhYmxlIHF1YWxpdHkgYmVm
b3JlIHN1Ym1pdHRpbmcgdG8gbWFpbmxpbmUuIFRoZSByZW1haW5pbmcNCm5ldHdvcmsgc3VwcG9y
dCB3b3VsZCBmb2xsb3cgc29vbiBhZnRlcndhcmRzLg0KDQpJIHByb3Bvc2UgdG8gZGlzY3VzczoN
Cg0KLSBBcyB3ZSBhbHRlciBvdXIgZGV2ZWxvcG1lbnQgbW9kZWwgWzhdIHRvIHN1cHBvcnQgdXBz
dHJlYW0gZGV2ZWxvcG1lbnQsDQogIHdoYXQgaXMgYSBzdWZmaWNpZW50IGRlbW9uc3RyYXRpb24g
b2YgY29tbWl0bWVudCB0aGF0IG91ciBtb2RlbCB3b3Jrcz8NCi0gU2hvdWxkIHRoZSBjbGllbnQg
YW5kIHNlcnZlciBiZSBzdWJtaXR0ZWQgdG9nZXRoZXI/IE9yIHNwbGl0Pw0KLSBFeHBlY3RhdGlv
bnMgZm9yIGEgbmV3IGZpbGVzeXN0ZW0gdG8gYmUgYWNjZXB0ZWQgdG8gbWFpbmxpbmUNCi0gSG93
IHRvIG1hbmFnZSBpbmNsdXNpb24gb2YgYSBsYXJnZSBjb2RlIGJhc2UgKHRoZSBjbGllbnQgYWxv
bmUgaXMNCiAgMjAwa0xvQykgd2l0aG91dCBpbmNyZWFzaW5nIHRoZSBidXJkZW4gb24gZnMvbmV0
IG1haW50YWluZXJzDQoNCkx1c3RyZSBoYXMgYWxyZWFkeSByZWNlaXZlZCBhIHBsZXRob3JhIG9m
IGZlZWRiYWNrIGluIHRoZSBwYXN0Lg0KV2hpbGUgbXVjaCBvZiB0aGF0IGhhcyBiZWVuIGFkZHJl
c3NlZCBzaW5jZSAtIHRoZSBrZXJuZWwgaXMgYQ0KbW92aW5nIHRhcmdldC4gU2V2ZXJhbCBmaWxl
c3lzdGVtcyBoYXZlIGJlZW4gbWVyZ2VkIChvciByZW1vdmVkKQ0Kc2luY2UgTHVzdHJlIGxlZnQg
c3RhZ2luZy4gV2UncmUgYWltaW5nIHRvIGF2b2lkIHRoZSBtaXN0YWtlcyBvZg0KdGhlIHBhc3Qg
YW5kIGhvcGUgdG8gYWRkcmVzcyBhcyBtYW55IGNvbmNlcm5zIGFzIHBvc3NpYmxlIGJlZm9yZQ0K
c3VibWl0dGluZyBmb3IgaW5jbHVzaW9uLg0KDQpUaGFua3MhDQoNClRpbW90aHkgRGF5IChBbWF6
b24gV2ViIFNlcnZpY2VzIC0gQVdTKQ0KSmFtZXMgU2ltbW9ucyAoT2FrIFJpZGdlIE5hdGlvbmFs
IExhYnMgLSBPUk5MKQ0KDQpbMV0gV2lraXBlZGlhOiBodHRwczovL2VuLndpa2lwZWRpYS5vcmcv
d2lraS9MdXN0cmVfKGZpbGVfc3lzdGVtKSNDb21tZXJjaWFsX3RlY2huaWNhbF9zdXBwb3J0DQpb
Ml0gS2lja2VkIG91dCBvZiBzdGFnaW5nOiBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvNzU2NTY1
Lw0KWzNdIFRoaXMgaXMgYSBoZXVyaXN0aWMsIGJhc2VkIG9uIHRoZSBjb21iaW5lZCBjb21taXQg
Y291bnRzIG9mDQogICAgT1JOTCwgQWVvbiwgU3VTZSwgYW5kIEFXUyAtIHdoaWNoIGhhdmUgYmVl
biBwcmltYXJpbHkgd29ya2luZw0KICAgIG9uIHVwc3RyZWFtaW5nIGlzc3VlczogaHR0cHM6Ly95
b3V0dS5iZS9CRS0teVNWUWIyTT9zaT1ZTUhpdEpmY0U0QVNXUWNFJnQ9OTYwDQpbNF0gTFVHMjQg
VXBzdHJlYW1pbmcgVXBkYXRlOiBodHRwczovL3d3dy5kZXB0cy50dHUuZWR1L2hwY2MvZXZlbnRz
L0xVRzI0L3NsaWRlcy9EYXkxL0xVR18yMDI0X1RhbGtfMDItTmF0aXZlX0xpbnV4X2NsaWVudF9z
dGF0dXMucGRmDQpbNV0gTHVzdHJlIEppcmEgVXBzdHJlYW0gUHJvZ3Jlc3M6IGh0dHBzOi8vamly
YS53aGFtY2xvdWQuY29tL2Jyb3dzZS9MVS0xMjUxMQ0KWzZdIE91dC1vZi10cmVlIGNvZGViYXNl
OiBodHRwczovL2dpdC53aGFtY2xvdWQuY29tLz9wPWZzL2x1c3RyZS1yZWxlYXNlLmdpdDthPXRy
ZWUNCls3XSBHcmFwaDogaHR0cHM6Ly84ZDExODEzNS1mNjhiLTQ3NWQtOWI2ZC1lZjg0YzBkYjFl
NzEudXNyZmlsZXMuY29tL3VnZC84ZDExODFfYmI4Zjk0MDVkNzdhNGUyYmFkNTM1MzFhYTk0ZTg4
NjgucGRmDQpbOF0gUHJvamVjdCBXaWtpOiBodHRwczovL3dpa2kubHVzdHJlLm9yZy9VcHN0cmVh
bV9jb250cmlidXRpbmcNCg0KDQo=

