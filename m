Return-Path: <linux-fsdevel+bounces-51580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39787AD8875
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 11:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540F3189D8C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAC42C1597;
	Fri, 13 Jun 2025 09:50:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EB41E0DE8;
	Fri, 13 Jun 2025 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808251; cv=none; b=c0uJCFwb4OrMfeswTTAmpeJ3JMqlQC+YhmOzRuatZXZWbbNhs30FBRwuChCPaN85X9FRzdgybUPgkZJlYFNNokSIAbx/kunu1Lu1i5kzCKcuH6eR+2uxSUHvA9icBMejxWHY/qIdX1mz+I9c5hAjtXf7sYVd52qeLqBQJO5ZMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808251; c=relaxed/simple;
	bh=2SxLHN8+izHSO99LNfa9CAd7o+biTDAqyFK75kRDWk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I3gG26V5xOgV6Ilx3l2lltu+wWhu06sWW2sl8YAuuQxgm5ESYraoYfBKmnqV/gWzLtg+sKCQk+aExz/gCUQJCio/1uajzlCGIj+7GjS/ftiif9grpuauVwEGk/8chpiJvKQQxNQi4c7tQlAjIGK9wmRMCMtZOMmyd8HMfUNyIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4bJZ0q6dqXzYl4KT;
	Fri, 13 Jun 2025 17:31:55 +0800 (CST)
Received: from a017.hihonor.com (10.68.27.165) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Jun
 2025 17:33:55 +0800
Received: from a010.hihonor.com (10.68.16.52) by a017.hihonor.com
 (10.68.27.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Jun
 2025 17:33:55 +0800
Received: from a010.hihonor.com ([fe80::7127:3946:32c7:6e]) by
 a010.hihonor.com ([fe80::7127:3946:32c7:6e%14]) with mapi id 15.02.1544.011;
 Fri, 13 Jun 2025 17:33:55 +0800
From: wangtao <tao.wangtao@honor.com>
To: Christoph Hellwig <hch@infradead.org>
CC: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
	"sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, "kraxel@redhat.com"
	<kraxel@redhat.com>, "vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "amir73il@gmail.com"
	<amir73il@gmail.com>, "benjamin.gaignard@collabora.com"
	<benjamin.gaignard@collabora.com>, "Brian.Starkey@arm.com"
	<Brian.Starkey@arm.com>, "jstultz@google.com" <jstultz@google.com>,
	"tjmercier@google.com" <tjmercier@google.com>, "jack@suse.cz" <jack@suse.cz>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "wangbintian(BintianWang)"
	<bintian.wang@honor.com>, yipengxiang <yipengxiang@honor.com>, liulu 00013167
	<liulu.liu@honor.com>, hanfeng 00012985 <feng.han@honor.com>
Subject: RE: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
Thread-Topic: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
Thread-Index: AQHb1G1ol+FT389RFkuW+lwB3adoKrPw4BKAgAADywCAAAF8AIAE6kCg//+rigCABEW6AIAA1IFwgAFUd4CABPdqMA==
Date: Fri, 13 Jun 2025 09:33:55 +0000
Message-ID: <34c2dbc06d074ffbb8f920418636bafc@honor.com>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
 <aD72alIxu718uri4@infradead.org> <5d36abace6bf492aadd847f0fabc38be@honor.com>
 <a766fbf4-6cda-43a5-a1c7-61a3838f93f9@amd.com>
 <aEZkjA1L-dP_Qt3U@infradead.org> <761986ec0f404856b6f21c3feca67012@honor.com>
 <aEg0aYQJ9h_tyum9@infradead.org>
In-Reply-To: <aEg0aYQJ9h_tyum9@infradead.org>
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

DQo+IA0KPiBPbiBNb24sIEp1biAwOSwgMjAyNSBhdCAwOTozMjoyMEFNICswMDAwLCB3YW5ndGFv
IHdyb3RlOg0KPiA+IEFyZSB5b3Ugc3VnZ2VzdGluZyBhZGRpbmcgYW4gSVRFUl9ETUFCVUYgdHlw
ZSB0byBpb3ZfaXRlciwNCj4gDQo+IFllcy4NCg0KTWF5IEkgY2xhcmlmeTogRG8gYWxsIGRpc2sg
b3BlcmF0aW9ucyByZXF1aXJlIGRhdGEgdG8gcGFzcyB0aHJvdWdoDQptZW1vcnkgKHJlYWRpbmcg
aW50byBtZW1vcnkgb3Igd3JpdGluZyBmcm9tIG1lbW9yeSk/IEluIHRoZSBibG9jayBsYXllciwN
CnRoZSBiaW8gc3RydWN0dXJlIHVzZXMgYmlvX2lvdl9pdGVyX2dldF9wYWdlcyB0byBjb252ZXJ0
IGl0ZXJfdHlwZQ0Kb2JqZWN0cyBpbnRvIG1lbW9yeS1iYWNrZWQgYmlvX3ZlYyByZXByZXNlbnRh
dGlvbnMuDQpIb3dldmVyLCBzb21lIGRtYWJ1ZnMgYXJlIG5vdCBtZW1vcnktYmFzZWQsIG1ha2lu
ZyBwYWdlLXRvLWJpb192ZWMNCmNvbnZlcnNpb24gaW1wb3NzaWJsZS4gVGhpcyBzdWdnZXN0cyBh
ZGRpbmcgYSBjYWxsYmFjayBmdW5jdGlvbiBpbg0KZG1hX2J1Zl9vcHMgdG8gaGFuZGxlIGRtYWJ1
Zi0gdG8tYmlvX3ZlYyBjb252ZXJzaW9uLg0KDQpJbnRlcmVzdGluZ2x5LCBpZiBzdWNoIGEgY2Fs
bGJhY2sgZXhpc3RzLCB0aGUgbmVlZCBmb3IgYSBkZWRpY2F0ZWQNCklURVJfRE1BQlVGIHR5cGUg
bWlnaHQgZGlzYXBwZWFyLiBXb3VsZCB5b3UgbGlrZSB0byBkaXNjdXNzIHBvdGVudGlhbA0KaW1w
bGVtZW50YXRpb24gdHJhZGVvZmZzIGhlcmU/DQoNClJlZ2FyZHMsDQpXYW5ndGFvLg0K

