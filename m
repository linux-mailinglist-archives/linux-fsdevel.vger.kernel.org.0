Return-Path: <linux-fsdevel+bounces-50452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0994FACC6C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C201883320
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67A222FDEC;
	Tue,  3 Jun 2025 12:38:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E21E50E;
	Tue,  3 Jun 2025 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748954314; cv=none; b=jWoermudQ2eiT/DwNrtx5zY0ixSMz6oiRkzPLT3BcPHy2sBZGsSYtJwkU2YDx1mS0rSEY68NrOb+PIQoCeac8bWZQ/PiOFcdWXFxKV6Hzxs6zzg9V9/rJw+4Wkgjbk9ruoj2ETaFXp5tx33PHBxzfSbnrby+wCIGaQKSpJKKBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748954314; c=relaxed/simple;
	bh=xcNCGepNi0U/kqcREAk+KouqL4u0p0u2zVTK3EprN1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=txoYsAE9JM9rW20L2XvUDIYIWoVrMc4R2gXmZuKGT1xHgFW5sXDr3k+vTc87onjLUuuH97ES3BREYFf82WFm/DqORIxjFG3P9gHiKAXcHisK5DxnUtbqKX88q79uPwchfYBxCGnNuf5xQYOlON/MNN7//g9PSrk0A+fNmMMwNd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4bBVZJ0VJdzYkxZg;
	Tue,  3 Jun 2025 20:36:24 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Jun
 2025 20:38:26 +0800
Received: from a010.hihonor.com (10.68.16.52) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Jun
 2025 20:38:26 +0800
Received: from a010.hihonor.com ([fe80::7127:3946:32c7:6e]) by
 a010.hihonor.com ([fe80::7127:3946:32c7:6e%14]) with mapi id 15.02.1544.011;
 Tue, 3 Jun 2025 20:38:26 +0800
From: wangtao <tao.wangtao@honor.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>, "kraxel@redhat.com"
	<kraxel@redhat.com>, "vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
	"Brian.Starkey@arm.com" <Brian.Starkey@arm.com>, "jstultz@google.com"
	<jstultz@google.com>, "tjmercier@google.com" <tjmercier@google.com>,
	"jack@suse.cz" <jack@suse.cz>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org"
	<linaro-mm-sig@lists.linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"wangbintian(BintianWang)" <bintian.wang@honor.com>, yipengxiang
	<yipengxiang@honor.com>, liulu 00013167 <liulu.liu@honor.com>, "hanfeng
 00012985" <feng.han@honor.com>
Subject: RE: [PATCH v4 1/4] fs: allow cross-FS copy_file_range for memory file
 with direct I/O
Thread-Topic: [PATCH v4 1/4] fs: allow cross-FS copy_file_range for memory
 file with direct I/O
Thread-Index: AQHb1G1oEbLXPGV3DUSDSLvy2FONdrPwvWiAgACgIIA=
Date: Tue, 3 Jun 2025 12:38:25 +0000
Message-ID: <0cb2501aea054796906e2f6a23a86390@honor.com>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <20250603095245.17478-2-tao.wangtao@honor.com>
 <CAOQ4uxgYmSLY25WtQjHxvViG0eNSSsswF77djBJZsSJCq1OyLA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgYmSLY25WtQjHxvViG0eNSSsswF77djBJZsSJCq1OyLA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW1pciBHb2xkc3RlaW4g
PGFtaXI3M2lsQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVuZSAzLCAyMDI1IDY6NTcg
UE0NCj4gVG86IHdhbmd0YW8gPHRhby53YW5ndGFvQGhvbm9yLmNvbT4NCj4gQ2M6IHN1bWl0LnNl
bXdhbEBsaW5hcm8ub3JnOyBjaHJpc3RpYW4ua29lbmlnQGFtZC5jb207DQo+IGtyYXhlbEByZWRo
YXQuY29tOyB2aXZlay5rYXNpcmVkZHlAaW50ZWwuY29tOyB2aXJvQHplbml2LmxpbnV4Lm9yZy51
azsNCj4gYnJhdW5lckBrZXJuZWwub3JnOyBodWdoZEBnb29nbGUuY29tOyBha3BtQGxpbnV4LWZv
dW5kYXRpb24ub3JnOw0KPiBiZW5qYW1pbi5nYWlnbmFyZEBjb2xsYWJvcmEuY29tOyBCcmlhbi5T
dGFya2V5QGFybS5jb207DQo+IGpzdHVsdHpAZ29vZ2xlLmNvbTsgdGptZXJjaWVyQGdvb2dsZS5j
b207IGphY2tAc3VzZS5jejsNCj4gYmFvbGluLndhbmdAbGludXguYWxpYmFiYS5jb207IGxpbnV4
LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgZHJpLQ0KPiBkZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc7IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gbW1A
a3ZhY2sub3JnOyB3YW5nYmludGlhbihCaW50aWFuV2FuZykgPGJpbnRpYW4ud2FuZ0Bob25vci5j
b20+Ow0KPiB5aXBlbmd4aWFuZyA8eWlwZW5neGlhbmdAaG9ub3IuY29tPjsgbGl1bHUgMDAwMTMx
NjcNCj4gPGxpdWx1LmxpdUBob25vci5jb20+OyBoYW5mZW5nIDAwMDEyOTg1IDxmZW5nLmhhbkBo
b25vci5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMS80XSBmczogYWxsb3cgY3Jvc3Mt
RlMgY29weV9maWxlX3JhbmdlIGZvciBtZW1vcnkNCj4gZmlsZSB3aXRoIGRpcmVjdCBJL08NCj4g
DQo+IE9uIFR1ZSwgSnVuIDMsIDIwMjUgYXQgMTE6NTPigK9BTSB3YW5ndGFvIDx0YW8ud2FuZ3Rh
b0Bob25vci5jb20+IHdyb3RlOg0KPiA+DQo+ID4gTWVtb3J5IGZpbGVzIGNhbiBvcHRpbWl6ZSBj
b3B5IHBlcmZvcm1hbmNlIHZpYSBjb3B5X2ZpbGVfcmFuZ2UgY2FsbGJhY2tzOg0KPiA+IC1Db21w
YXJlZCB0byBtbWFwJnJlYWQ6IHJlZHVjZXMgR1VQIChnZXRfdXNlcl9wYWdlcykgb3ZlcmhlYWQN
Cj4gPiAtQ29tcGFyZWQgdG8gc2VuZGZpbGUvc3BsaWNlOiBlbGltaW5hdGVzIG9uZSBtZW1vcnkg
Y29weSAtU3VwcG9ydHMNCj4gPiBkbWEtYnVmIGRpcmVjdCBJL08gemVyby1jb3B5IGltcGxlbWVu
dGF0aW9uDQo+ID4NCj4gPiBTdWdnZXN0ZWQgYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4gU3VnZ2VzdGVkIGJ5Og0KPiA+IEFtaXIgR29sZHN0ZWluIDxhbWly
NzNpbEBnbWFpbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogd2FuZ3RhbyA8dGFvLndhbmd0YW9A
aG9ub3IuY29tPg0KPiA+IC0tLQ0KPiA+ICBmcy9yZWFkX3dyaXRlLmMgICAgfCA2NCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gLS0tLQ0KPiA+ICBpbmNsdWRl
L2xpbnV4L2ZzLmggfCAgMiArKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMo
KyksIDEyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL3JlYWRfd3JpdGUu
YyBiL2ZzL3JlYWRfd3JpdGUuYyBpbmRleA0KPiA+IGJiMGVkMjZhMGIzYS4uZWNiNGY3NTNjNjMy
IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL3JlYWRfd3JpdGUuYw0KPiA+ICsrKyBiL2ZzL3JlYWRfd3Jp
dGUuYw0KPiA+IEBAIC0xNDY5LDYgKzE0NjksMzEgQEAgQ09NUEFUX1NZU0NBTExfREVGSU5FNChz
ZW5kZmlsZTY0LCBpbnQsDQo+IG91dF9mZCwNCj4gPiBpbnQsIGluX2ZkLCAgfSAgI2VuZGlmDQo+
ID4NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgKm1lbW9yeV9jb3B5
X2ZpbGVfb3BzKA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBmaWxlICpmaWxl
X2luLCBzdHJ1Y3QgZmlsZSAqZmlsZV9vdXQpIHsNCj4gPiArICAgICAgIGlmICgoZmlsZV9pbi0+
Zl9vcC0+Zm9wX2ZsYWdzICYgRk9QX01FTU9SWV9GSUxFKSAmJg0KPiA+ICsgICAgICAgICAgIChm
aWxlX2luLT5mX21vZGUgJiBGTU9ERV9DQU5fT0RJUkVDVCkgJiYNCj4gPiArICAgICAgICAgICBm
aWxlX2luLT5mX29wLT5jb3B5X2ZpbGVfcmFuZ2UgJiYgZmlsZV9vdXQtPmZfb3AtPndyaXRlX2l0
ZXIpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBmaWxlX2luLT5mX29wOw0KPiA+ICsgICAg
ICAgZWxzZSBpZiAoKGZpbGVfb3V0LT5mX29wLT5mb3BfZmxhZ3MgJiBGT1BfTUVNT1JZX0ZJTEUp
ICYmDQo+ID4gKyAgICAgICAgICAgICAgICAoZmlsZV9vdXQtPmZfbW9kZSAmIEZNT0RFX0NBTl9P
RElSRUNUKSAmJg0KPiA+ICsgICAgICAgICAgICAgICAgZmlsZV9pbi0+Zl9vcC0+cmVhZF9pdGVy
ICYmIGZpbGVfb3V0LT5mX29wLT5jb3B5X2ZpbGVfcmFuZ2UpDQo+ID4gKyAgICAgICAgICAgICAg
IHJldHVybiBmaWxlX291dC0+Zl9vcDsNCj4gPiArICAgICAgIGVsc2UNCj4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuIE5VTEw7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgZXNzZW50
aWFsX2ZpbGVfcndfY2hlY2tzKHN0cnVjdCBmaWxlICpmaWxlX2luLCBzdHJ1Y3QgZmlsZQ0KPiA+
ICsqZmlsZV9vdXQpIHsNCj4gPiArICAgICAgIGlmICghKGZpbGVfaW4tPmZfbW9kZSAmIEZNT0RF
X1JFQUQpIHx8DQo+ID4gKyAgICAgICAgICAgIShmaWxlX291dC0+Zl9tb2RlICYgRk1PREVfV1JJ
VEUpIHx8DQo+ID4gKyAgICAgICAgICAgKGZpbGVfb3V0LT5mX2ZsYWdzICYgT19BUFBFTkQpKQ0K
PiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVCQURGOw0KPiA+ICsNCj4gPiArICAgICAgIHJl
dHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAvKg0KPiA+ICAgKiBQZXJmb3JtcyBuZWNlc3Nh
cnkgY2hlY2tzIGJlZm9yZSBkb2luZyBhIGZpbGUgY29weQ0KPiA+ICAgKg0KPiA+IEBAIC0xNDg0
LDkgKzE1MDksMTYgQEAgc3RhdGljIGludCBnZW5lcmljX2NvcHlfZmlsZV9jaGVja3Moc3RydWN0
IGZpbGUNCj4gKmZpbGVfaW4sIGxvZmZfdCBwb3NfaW4sDQo+ID4gICAgICAgICBzdHJ1Y3QgaW5v
ZGUgKmlub2RlX291dCA9IGZpbGVfaW5vZGUoZmlsZV9vdXQpOw0KPiA+ICAgICAgICAgdWludDY0
X3QgY291bnQgPSAqcmVxX2NvdW50Ow0KPiA+ICAgICAgICAgbG9mZl90IHNpemVfaW47DQo+ID4g
KyAgICAgICBib29sIHNwbGljZSA9IGZsYWdzICYgQ09QWV9GSUxFX1NQTElDRTsNCj4gPiArICAg
ICAgIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgKm1lbV9mb3BzOw0KPiA+ICAgICAgICAg
aW50IHJldDsNCj4gPg0KPiA+IC0gICAgICAgcmV0ID0gZ2VuZXJpY19maWxlX3J3X2NoZWNrcyhm
aWxlX2luLCBmaWxlX291dCk7DQo+ID4gKyAgICAgICAvKiBUaGUgZG1hLWJ1ZiBmaWxlIGlzIG5v
dCBhIHJlZ3VsYXIgZmlsZS4gKi8NCj4gPiArICAgICAgIG1lbV9mb3BzID0gbWVtb3J5X2NvcHlf
ZmlsZV9vcHMoZmlsZV9pbiwgZmlsZV9vdXQpOw0KPiA+ICsgICAgICAgaWYgKHNwbGljZSB8fCBt
ZW1fZm9wcyA9PSBOVUxMKQ0KPiANCj4gbml0OiB1c2UgIW1lbV9mb3BzIHBsZWFzZQ0KPiANCj4g
Q29uc2lkZXJpbmcgdGhhdCB0aGUgZmxhZyBDT1BZX0ZJTEVfU1BMSUNFIGlzIG5vdCBhbGxvd2Vk
IGZyb20gdXNlcnNwYWNlDQo+IGFuZCBpcyBvbmx5IGNhbGxlZCBieSBuZnNkIGFuZCBrc21iZCBJ
IHRoaW5rIHdlIHNob3VsZCBhc3NlcnQgYW5kIGRlbnkgdGhlDQo+IGNvbWJpbmF0aW9uIG9mIG1l
bV9mb3BzICYmIHNwbGljZSBiZWNhdXNlIGl0IGlzIHZlcnkgbXVjaCB1bmV4cGVjdGVkLg0KPiAN
Cj4gQWZ0ZXIgYXNzZXJ0aW5nIHRoaXMsIGl0IHdvdWxkIGJlIG5pY2VyIHRvIHdyaXRlIGFzOg0K
PiAgICAgICAgIGlmIChtZW1fZm9wcykNCj4gICAgICAgICAgICAgICAgcmV0ID0gZXNzZW50aWFs
X2ZpbGVfcndfY2hlY2tzKGZpbGVfaW4sIGZpbGVfb3V0KTsNCj4gICAgICAgICBlbHNlDQo+ICAg
ICAgICAgICAgICAgIHJldCA9IGdlbmVyaWNfZmlsZV9yd19jaGVja3MoZmlsZV9pbiwgZmlsZV9v
dXQpOw0KPiANCkdvdCBpdC4gVGhhbmtzLg0KPiA+ICsgICAgICAgZWxzZQ0KPiA+ICsgICAgICAg
ICAgICAgICByZXQgPSBlc3NlbnRpYWxfZmlsZV9yd19jaGVja3MoZmlsZV9pbiwgZmlsZV9vdXQp
Ow0KPiA+ICAgICAgICAgaWYgKHJldCkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4gPg0KPiA+IEBAIC0xNTAwLDggKzE1MzIsMTAgQEAgc3RhdGljIGludCBnZW5lcmljX2NvcHlf
ZmlsZV9jaGVja3Moc3RydWN0IGZpbGUNCj4gKmZpbGVfaW4sIGxvZmZfdCBwb3NfaW4sDQo+ID4g
ICAgICAgICAgKiBhbmQgc2V2ZXJhbCBkaWZmZXJlbnQgc2V0cyBvZiBmaWxlX29wZXJhdGlvbnMs
IGJ1dCB0aGV5IGFsbCBlbmQgdXANCj4gPiAgICAgICAgICAqIHVzaW5nIHRoZSBzYW1lIC0+Y29w
eV9maWxlX3JhbmdlKCkgZnVuY3Rpb24gcG9pbnRlci4NCj4gPiAgICAgICAgICAqLw0KPiA+IC0g
ICAgICAgaWYgKGZsYWdzICYgQ09QWV9GSUxFX1NQTElDRSkgew0KPiA+ICsgICAgICAgaWYgKHNw
bGljZSkgew0KPiA+ICAgICAgICAgICAgICAgICAvKiBjcm9zcyBzYiBzcGxpY2UgaXMgYWxsb3dl
ZCAqLw0KPiA+ICsgICAgICAgfSBlbHNlIGlmIChtZW1fZm9wcyAhPSBOVUxMKSB7DQo+IA0KPiBX
aXRoIHRoZSBhc3NlcnRpb24gdGhhdCBzcGxpY2UgJiYgbWVtX2ZvcHMgaXMgbm90IGFsbG93ZWQg
aWYgKHNwbGljZSB8fA0KPiBtZW1fZm9wcykgew0KPiANCj4gd291bGQgZ28gd2VsbCB0b2dldGhl
ciBiZWNhdXNlIHRoZXkgYm90aCBhbGxvdyBjcm9zcy1mcyBjb3B5IG5vdCBvbmx5IGNyb3NzDQo+
IHNiLg0KPiANCkdpdCBpdC4NCg0KPiA+ICsgICAgICAgICAgICAgICAvKiBjcm9zcy1mcyBjb3B5
IGlzIGFsbG93ZWQgZm9yIG1lbW9yeSBmaWxlLiAqLw0KPiA+ICAgICAgICAgfSBlbHNlIGlmIChm
aWxlX291dC0+Zl9vcC0+Y29weV9maWxlX3JhbmdlKSB7DQo+ID4gICAgICAgICAgICAgICAgIGlm
IChmaWxlX2luLT5mX29wLT5jb3B5X2ZpbGVfcmFuZ2UgIT0NCj4gPiAgICAgICAgICAgICAgICAg
ICAgIGZpbGVfb3V0LT5mX29wLT5jb3B5X2ZpbGVfcmFuZ2UpIEBAIC0xNTU0LDYNCj4gPiArMTU4
OCw3IEBAIHNzaXplX3QgdmZzX2NvcHlfZmlsZV9yYW5nZShzdHJ1Y3QgZmlsZSAqZmlsZV9pbiwg
bG9mZl90IHBvc19pbiwNCj4gPiAgICAgICAgIHNzaXplX3QgcmV0Ow0KPiA+ICAgICAgICAgYm9v
bCBzcGxpY2UgPSBmbGFncyAmIENPUFlfRklMRV9TUExJQ0U7DQo+ID4gICAgICAgICBib29sIHNh
bWVzYiA9IGZpbGVfaW5vZGUoZmlsZV9pbiktPmlfc2IgPT0NCj4gPiBmaWxlX2lub2RlKGZpbGVf
b3V0KS0+aV9zYjsNCj4gPiArICAgICAgIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgKm1l
bV9mb3BzOw0KPiA+DQo+ID4gICAgICAgICBpZiAoZmxhZ3MgJiB+Q09QWV9GSUxFX1NQTElDRSkN
Cj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gQEAgLTE1NzQsMTggKzE2
MDksMjcgQEAgc3NpemVfdCB2ZnNfY29weV9maWxlX3JhbmdlKHN0cnVjdCBmaWxlICpmaWxlX2lu
LA0KPiBsb2ZmX3QgcG9zX2luLA0KPiA+ICAgICAgICAgaWYgKGxlbiA9PSAwKQ0KPiA+ICAgICAg
ICAgICAgICAgICByZXR1cm4gMDsNCj4gPg0KPiA+ICsgICAgICAgaWYgKHNwbGljZSkNCj4gPiAr
ICAgICAgICAgICAgICAgZ290byBkb19zcGxpY2U7DQo+ID4gKw0KPiA+ICAgICAgICAgZmlsZV9z
dGFydF93cml0ZShmaWxlX291dCk7DQo+ID4NCj4gDQo+IGdvdG8gZG9fc3BsaWNlIG5lZWRzIHRv
IGJlIGFmdGVyIGZpbGVfc3RhcnRfd3JpdGUNCj4gDQo+IFBsZWFzZSB3YWl0IGZvciBmZWVkYmFj
ayBmcm9tIHZmcyBtYWludGFpbmVycyBiZWZvcmUgcG9zdGluZyBhbm90aGVyDQo+IHZlcnNpb24g
YWRkcmVzc2luZyBteSByZXZpZXcgY29tbWVudHMuDQo+IA0KQXJlIHlvdSBhc2tpbmcgd2hldGhl
ciBib3RoIHRoZSBnb3RvIGRvX3NwbGljZSBhbmQgdGhlIGRvX3NwbGljZSBsYWJlbCBzaG91bGQN
CmJlIGVuY2xvc2VkIGJldHdlZW4gZmlsZV9zdGFydF93cml0ZSBhbmQgZmlsZV9lbmRfd3JpdGU/
DQoNClJlZ2FyZHMsDQpXYW5ndGFvLg0KPiBUaGFua3MsDQo+IEFtaXIuDQo=

