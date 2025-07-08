Return-Path: <linux-fsdevel+bounces-54220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDC9AFC38E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 09:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758EA17DE88
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A55223DF5;
	Tue,  8 Jul 2025 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="A28G1Ljo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-63-194.mail.qq.com (out162-62-63-194.mail.qq.com [162.62.63.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354321CA0E;
	Tue,  8 Jul 2025 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.63.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958240; cv=none; b=puYfhHhKX0kwbmTxmiHtkLDa+RqXSoSKfHr5zi/D+oKZYJou2FIDm9ep8m7kGH4muuvv5SegLMx3vaPGbz69G/L0aelzZ/Q5N43AUtl9lITOlEAaJLh/EJVvZ5mbaOvTYQU1LwIxOuSsLJW/1Hk7x8CzoyRinya+DFySk7Aevwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958240; c=relaxed/simple;
	bh=OM6K+jZaBXAoTLY0N4NnW3rs077RdjL2OSQEQtpSYZc=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=VPyZqG3/gRHrrh6IiqwyFUMjJTKc2vVtczRKd+AZtqqtJXjVAZ+wQ+DLTB/67EJV2S/qCUxmi07wu+V76BniTDY5LoH0WTpRCNCcoORQIu8ohSnTsb2AHBNN0vj5bNJishIYf/pmEpKGcEBqHoiSWJt3vjX7JYP81HbzxivcTWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=A28G1Ljo; arc=none smtp.client-ip=162.62.63.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1751957925;
	bh=OM6K+jZaBXAoTLY0N4NnW3rs077RdjL2OSQEQtpSYZc=;
	h=From:To:Cc:Subject:Date;
	b=A28G1LjoZ3HwbAgyXYEvP5rNEuaFQZGqHOmhNsGNpGA2MvIqkYXL3+Yeo8vTaN1+T
	 4hB9cZ5wul0OC/kjW5F+gmKoVMpQ7gVExHcYJzXYQhCltKQsfSu9P2jSEFA02Q71r9
	 Dchj7N/pxnynDFj/dmMAjPYeuDKtnnwH/ga+AccE=
X-QQ-FEAT: 3C1WcPM5lQ4i+tGOZHPx80amo8TvG3to
X-QQ-SSF: 0000000000000010000000000000
X-QQ-SPAM: true
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-XMAILINFO: M4kijGgdg8XvD6nB9qq3P51A2cCWZU8jZqnGM52RIwpXp1g0uc2MbUDM5iQFuM
	 5RTLQjQiV/ny1SMNK6BiXkkbwONwK4byfFEUARK0XYXRx4aUON8oSwOfzVSXR9sk+IEY7DAK1wevk
	 ik4UzdFQrQdG+cRd3XzZ17I7tMPwMJ3ItGCE8tFguM6UB5W1EIOJvZIXtsSiJJba3LzLiVrPlqhnS
	 +uuW0FiWmXgKQgVeiGO4OOxQij4erJvlfzDgfZHK1uMEHn4VYCjfkz+xCgQG3I41KMuPclqGg3uyd
	 Y0P3AClqAjg3qEk12DGHKBUTaZr2ZCt4CJFNrEmPAWQEbjv+go51HUO8yGxt4e7Ezh1NF7sAAuFoK
	 3WCWXuJj2poDKjBe5mHqvviGnZSVnqkfRK9D9hswqxk9vP0kDv4oA3EuuS2UNZB6/PUpceS4ZEGCK
	 vhhNMy8QQTbjJIZ2Uwyws3aKu3VQxchJpEcOFh+ey68Hs2FC8Ueg1K1i3t2OfDe+TS0NtPrJW1ixb
	 KNW26RYYr2mtTfAViOI8VV/g5T1DpJpVLpEgYIdgeg4eaiJI+NPeULdjo9wU1jscTJMDAYhyqqYvM
	 fRyIRbQT8NFxRcpacleYPGI68v6pRTH1GULo9kKlCDEe40Ac3KgOZY8ssl9SYtXlt6e7iLzJyqbw3
	 a4DJVjQLYq+6yImHIFikYkIAXFqoqlKdW0Nl/HCNprh84Lz2V8DQRunV/2K8EfvQO65OA0Lg7dtvh
	 qYcYBdQIMfvld5PK2ed9zfIRa8OvT1R8YGWRY9/bGOydjVcH8nLc35dRYlxjmDyjfayGc8OsWGBAk
	 fRmdmwonXrSlGEU0PFdngoIma4Z2oE0pNfof71n75llqVsWtX21y4awb+KJkGn0chpiC0kQQLZnGz
	 7fXukotVuxcuubhYKpiEEOCiWzuQOVp76tZY52j0IviZK1VeeN/0qKnVVr9iZ1Ybid6zIn8TCABer
	 q8SXzxozxJtwXgielC7qSX3uwlJT8I8cqEPM1mJV/gpSt6tLQ+bh2Gvbafv803AzdVwqw0HBFGd5/
	 dPzp3OdXaLrx1tuaAUgW+DNhQBBR7H7fwJ6ogu0CeLtzKGcj10h99QO8EXSDyrOJDtWNtifqQvG7w
	 7KDsg4Zi4BzIGuHix+TBEUMV8c+QidhFfio=
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail632t1751957538t2012164
From: "=?ISO-8859-1?B?eXdlbi5jaGVu?=" <ywen.chen@foxmail.com>
To: "=?ISO-8859-1?B?Q2hyaXN0b3BoIEhlbGx3aWc=?=" <hch@infradead.org>, "=?ISO-8859-1?B?RXJpYyBCaWdnZXJz?=" <ebiggers@kernel.org>
Cc: "=?ISO-8859-1?B?Q2hyaXN0b3BoIEhlbGx3aWc=?=" <hch@infradead.org>, "=?ISO-8859-1?B?YnJhdW5lcg==?=" <brauner@kernel.org>, "=?ISO-8859-1?B?dHl0c28=?=" <tytso@mit.edu>, "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?ISO-8859-1?B?bGludXgtZjJmcy1kZXZlbA==?=" <linux-f2fs-devel@lists.sourceforge.net>, "=?ISO-8859-1?B?YWRpbGdlci5rZXJuZWw=?=" <adilger.kernel@dilger.ca>, "=?ISO-8859-1?B?dmlybw==?=" <viro@zeniv.linux.org.uk>, "=?ISO-8859-1?B?bGludXgtZnNkZXZlbA==?=" <linux-fsdevel@vger.kernel.org>, "=?ISO-8859-1?B?amFlZ2V1aw==?=" <jaegeuk@kernel.org>, "=?ISO-8859-1?B?bGludXgtZXh0NA==?=" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] libfs: reduce the number of memory allocations in generic_ci_match
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Tue, 8 Jul 2025 14:52:17 +0800
X-Priority: 3
Message-ID: <tencent_FCCBB98BA5E88F7B6DFCDC55EC9C23CFF105@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x

Jmd0OyBCdXQgSSB3b25kZXIgd2h5IGdlbmVyaWNfY2lfbWF0Y2ggaXMgZXZlbiBjYWxsZWQg
dGhhdCBvZnRlbi4gIEJvdGggZXh0NA0KJmd0OyBhbmQgZjJmcyBzdXBwb3J0IGhhc2hlZCBs
b29rdXBzLCBzbyB5b3Ugc2hvdWxkIHVzdWFsbHkgb25seSBzZWUgaXQgY2FsbGVkDQomZ3Q7
IGZvciB0aGUgbWFpbiBtYXRjaCwgcGx1cyB0aGUgb2NjYXNpb25hbCBoYXNoIGZhbHNlIHBv
c2l0aXZlLCB3aGljaCBzaG91bGQNCiZndDsgYmUgcmF0ZSBpZiB0aGUgaGFzaCB3b3Jrcy4N
Cg0KDQpBdCBwcmVzZW50LCBpbiB0aGUgbGF0ZXN0IHZlcnNpb24gb2YgTGludXgsIGluIHNv
bWUgc2NlbmFyaW9zLA0KZjJmcyBzdGlsbCB1c2VzIGxpbmVhciBzZWFyY2guDQoNCg0KVGhl
IGxvZ2ljIG9mIGxpbmVhciBzZWFyY2ggd2FzIGludHJvZHVjZWQgYnkgQ29tbWl0IDkxYjU4
N2JhNzllMQ0KKGYyZnM6IEludHJvZHVjZSBsaW5lYXIgc2VhcmNoIGZvciBkZW50cmllcyku
IENvbW1pdCA5MWI1ODdiYTc5ZTENCndhcyBkZXNpZ25lZCB0byBzb2x2ZSB0aGUgcHJvYmxl
bSBvZiBpbmNvbnNpc3RlbnQgaGFzaGVzIGJlZm9yZQ0KYW5kIGFmdGVyIHRoZSByb2xsYmFj
ayBvZiBDb21taXQgNWMyNmQyZjFkM2Y1DQooInVuaWNvZGU6IERvbid0IHNwZWNpYWwgY2Fz
ZSBpZ25vcmFibGUgY29kZSBwb2ludHMiKSwNCndoaWNoIGxlZCB0byBmaWxlcyBiZWluZyBp
bmFjY2Vzc2libGUuDQoNCg0KSW4gb3JkZXIgdG8gcmVkdWNlIHRoZSBpbXBhY3Qgb2YgbGlu
ZWFyIHNlYXJjaCwgaW4gcmVsYXRpdmVseSBuZXcNCnZlcnNpb25zLCB0aGUgbG9naWMgb2Yg
dHVybmluZyBvZmYgbGluZWFyIHNlYXJjaCBoYXMgYWxzbyBiZWVuDQppbnRyb2R1Y2VkLiBI
b3dldmVyLCB0aGUgdHJpZ2dlcmluZyBjb25kaXRpb25zIGZvciB0aGlzDQp0dXJuIC0gb2Zm
IGxvZ2ljIG9uIGYyZnMgYXJlIHJhdGhlciBzdHJpY3Q6DQoNCg0KMS4gVXNlIHRoZSBsYXRl
c3QgdmVyc2lvbiBvZiB0aGUgZnNjay5mMmZzIHRvb2wgdG8gY29ycmVjdA0KdGhlIGZpbGUg
c3lzdGVtLg0KMi4gVXNlIGEgcmVsYXRpdmVseSBuZXcgdmVyc2lvbiBvZiB0aGUga2VybmVs
LiAoRm9yIGV4YW1wbGUsDQpsaW5lYXIgc2VhcmNoIGNhbm5vdCBiZSB0dXJuZWQgb2ZmIGlu
IHY2LjYpDQoNCg0KVGhlIHBlcmZvcm1hbmNlIGdhaW4gb2YgdGhpcyBjb21taXQgaXMgdmVy
eSBvYnZpb3VzIGluIHNjZW5hcmlvcw0Kd2hlcmUgbGluZWFyIHNlYXJjaCBpcyBub3QgdHVy
bmVkIG9mZi4gSW4gc2NlbmFyaW9zIHdoZXJlIGxpbmVhcg0Kc2VhcmNoIGlzIHR1cm5lZCBv
ZmYsIG5vIHBlcmZvcm1hbmNlIHByb2JsZW1zIHdpbGwgYmUgaW50cm9kdWNlZA0KZWl0aGVy
Ljxicj4=
e±

