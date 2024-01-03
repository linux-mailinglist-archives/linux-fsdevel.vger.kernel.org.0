Return-Path: <linux-fsdevel+bounces-7156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64F8227A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 04:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B97B22157
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 03:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06117984;
	Wed,  3 Jan 2024 03:52:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp87.cstnet.cn [159.226.251.87])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D111171CA;
	Wed,  3 Jan 2024 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [121.195.114.118] ) by
 ajax-webmail-APP-17 (Coremail) ; Wed, 3 Jan 2024 11:52:32 +0800 (GMT+08:00)
Date: Wed, 3 Jan 2024 11:52:32 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: iro@zeniv.linux.org.uk, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Recommendation for Capability Check Refinement in
 pipe_is_unprivileged_user()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230921(8ad33efc)
 Copyright (c) 2002-2024 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4f19e1c5.cd08.18ccd7393c4.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qgCowAB3QukA2pRlxBsDAA--.26557W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiDAYFE2WUwERSDAAAs3
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkhCgpXZSBub3RlZCBhIHBvdGVudGlhbCByZWZpbmVtZW50IGluIHRoZSBwaXBlX2lzX3VucHJp
dmlsZWdlZF91c2VyKCkgZnVuY3Rpb24gd2hlcmUgQ0FQX1NZU19BRE1JTiBhbmQgQ0FQX1NZU19S
RVNPVVJDRSBhcmUgY2hlY2tlZCB3aGVuIHBpcGUgYnVmZmVyIHNpemUgZXhjZWVkcyB0aGUgc3lz
dGVtIGxpbWl0LiBIYXZpbmcgZWl0aGVyIG9uZSB3aWxsIHBhc3MgdGhlIGNoZWNrLiBIb3dldmVy
LCB3ZSBwcm9wb3NlIGFkanVzdGluZyB0aGlzIHRvIGV4Y2x1c2l2ZWx5IHVzZSBDQVBfU1lTX1JF
U09VUkNFLiBIZXJlJ3Mgb3VyIHJhdGlvbmFsZSBmb3IgdGhpcyBzdWdnZXN0aW9uOgoKKDEpIERp
c3RpbmN0IENhcGFiaWxpdGllcyBmb3IgUmVzb3VyY2UgTGltaXRzOiBUaGUgY2FwYWJpbGl0eSBt
YW51YWwgcGFnZVsxXSBjbGVhcmx5IGRlZmluZXMgQ0FQX1NZU19SRVNPVVJDRSBhcyB0aGUgY2Fw
YWJpbGl0eSB1c2VkIHRvIGJ5cGFzcyBzeXN0ZW0gcmVzb3VyY2UgbGltaXRzLiBJbnRyb2R1Y2lu
ZyBhIGNoZWNrIGZvciBDQVBfU1lTX0FETUlOIG1pZ2h0IGJlIG1pc2xlYWRpbmcsIGFzIGl0IGlz
IGEgc2VwYXJhdGUgY2FwYWJpbGl0eSB3aXRoIGEgZGlmZmVyZW50IHNjb3BlLgogCigyKSBNYWlu
dGFpbmluZyBMZWFzdCBQcml2aWxlZ2UgUHJpbmNpcGxlOiBDQVBfU1lTX0FTTUlOIGlzIGFscmVh
ZHkgb3ZlcmxvYWRlZCBhbmQga25vd24gYXMgdGhlIG5ldyAicm9vdCJbMl0sIGJ1dCBpdCBpcyBz
dGlsbCBhbiBpbmRlcGVuZGVudCBjYXBhYmlsaXR5IGFuZCBzaG91bGQgbm90IGJlIG92ZXJsYXBw
ZWQgd2l0aCBvdGhlcnMuIEFjY29yZGluZyB0byB0aGUgbWFudWFsIHBhZ2VbMV0g4oCcRG9uJ3Qg
Y2hvb3NlIENBUF9TWVNfQURNSU4gaWYgeW91IGNhbiBwb3NzaWJseSBhdm9pZCBpdCHigJ0sIGl0
J3MgYmVuZWZpY2lhbCB0byB1c2UgdGhlIG1vc3Qgc3BlY2lmaWMgY2FwYWJpbGl0eSByZXF1aXJl
ZCBmb3IgYSBnaXZlbiB0YXNrLiBJbiB0aGlzIGNvbnRleHQsIHV0aWxpemluZyBDQVBfU1lTX1JF
U09VUkNFIGV4Y2x1c2l2ZWx5IGVuc3VyZXMgdGhhdCBvbmx5IHRoZSBuZWNlc3NhcnkgcGVybWlz
c2lvbnMgYXJlIGdyYW50ZWQgd2l0aG91dCBvdmVyLXByaXZpbGVnaW5nIHdpdGggdGhlIGJyb2Fk
ZXIgQ0FQX1NZU19BRE1JTi4KClRoaXMgaXNzdWUgZXhpc3RzIGluIHNldmVyYWwga2VybmVsIHZl
cnNpb25zIGFuZCB3ZSBoYXZlIGNoZWNrZWQgaXQgb24gdGhlIGxhdGVzdCBzdGFibGUgcmVsZWFz
ZShMaW51eCA2LjYuOSkuIAoKWW91ciB0aG91Z2h0cyBhbmQgZmVlZGJhY2sgb24gdGhpcyBwcm9w
b3NlZCBtb2RpZmljYXRpb24gd291bGQgYmUgaGlnaGx5IGFwcHJlY2lhdGVkLiBUaGFuayB5b3Ug
Zm9yIHlvdXIgdGltZSBhbmQgY29uc2lkZXJhdGlvbi4KCkJlc3QgcmVnYXJkcywKSmluZ3ppCgpy
ZWZlcmVuY2U6ClsxXSBodHRwczovL3d3dy5tYW43Lm9yZy9saW51eC9tYW4tcGFnZXMvbWFuNy9j
YXBhYmlsaXRpZXMuNy5odG1sClsyXSBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvNDg2MzA2Lw==


