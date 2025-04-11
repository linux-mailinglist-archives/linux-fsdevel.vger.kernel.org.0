Return-Path: <linux-fsdevel+bounces-46292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07ECA861EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 17:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCB517D837
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CC020E026;
	Fri, 11 Apr 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gAfqA9KD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms11p00im-qufo17282001.me.com (ms11p00im-qufo17282001.me.com [17.58.38.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B69B6A33B
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385529; cv=none; b=PRFqWsCtRuQ4nZF9QNF+/HL2vSB8W0DF9ah3NWaFQaR7yxWZKsenL+RajlxmVQQaWTa82aUH4cZ/rTpJYG21aVIGNdMwTYsuhph0/65YtCBtpOzQcG9LMI/s2ekYfcQcG0VzNG58uSmRhfOXj39ERK0XaTctdkV6tPWOKpsDtfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385529; c=relaxed/simple;
	bh=LJf4cNbR+18dNf4e2tN8ZbyNLYaUlg6D4P0qVVixi9I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NCOpI6S5WylJyBRvxBLwXQDGWcX3EO9gJ7YOj7+n1ZDuaMXccbZEFXBqD901deTAnOcPr64V6qlV2JZ6+fm6MgkfS1S8I/2LoQyFmuMUHNisR8xUyLxf2VErHx72TeHJz7EhaMdylx47S/YU/R6d196lND+869XyAdWw+hESaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gAfqA9KD; arc=none smtp.client-ip=17.58.38.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=1MdNnYd5YWaOYraYVGqeVZVykkFFLwDntXLomc/V3kE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=gAfqA9KD7WkT2JKnYJMpZcty/ADqipBVcTFxS2TQ2OyHtj6eNfoePC9EoQsla2xnv
	 2LWX40b2fc0SdJjCe6mVe/vA56sl1z8MS3ljKKmLn5liXk0O8wjzPNX+eTkE+pm/Ed
	 hffdY1zVhkVyWYv7Axwio7kGqQk+IYemKwK+IVgIC28Fdv2IpkQ7ZadAqJ8nPFcOcN
	 221KtZm2GolS6hpty1lfUG1YJ+xEd6ZaivHq5ZcXDNIrtr07vDrhU9HZfcL6CaEnI5
	 Dlz3xJxxa+3jhwhB0Fgd1Tfas2GTPvZKetS2Aoa2jb4u70y/MGy5UgE4zqxmRLzL2O
	 1iWpccJog4kjw==
Received: from ms11p00im-qufo17282001.me.com (ms11p00im-qufo17282001.me.com [17.58.38.57])
	by ms11p00im-qufo17282001.me.com (Postfix) with ESMTPS id A62881E030E;
	Fri, 11 Apr 2025 15:32:05 +0000 (UTC)
Received: from [192.168.1.26] (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17282001.me.com (Postfix) with ESMTPSA id C2CF11E0050;
	Fri, 11 Apr 2025 15:32:02 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v2 0/2] fs: bug fixes
Date: Fri, 11 Apr 2025 23:31:39 +0800
Message-Id: <20250411-fix_fs-v2-0-5d3395c102e4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANs1+WcC/2WMQQ7CIBBFr9LMWgwQaq0r72Eag+NgZyFUsKSm4
 e5ity7f/y9vhUSRKcGpWSFS5sTBV9C7BnC0/kGC75VBS91Ko6RwvFxdEgeStu/QUNs7qPIUqT5
 b6DJUHjm9Q/xs3ax+618iKyFFh8og4pFu1p5fMyN73GN4wlBK+QJReG2KngAAAA==
X-Change-ID: 20250410-fix_fs-6e0a97c4e59f
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 4C9qywBCX3-HZYfhTLg7yUIxgea8hM-i
X-Proofpoint-ORIG-GUID: 4C9qywBCX3-HZYfhTLg7yUIxgea8hM-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=918 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2504110099
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Drop applied patches and remove fixes tag for remaining patches
- Remove fsparam_u32hex() instead of fixing it
- Add more comment for the NULL pointer dereference issue
- Link to v1: https://lore.kernel.org/r/20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com

---
Zijun Hu (2):
      fs/fs_parse: Delete macro fsparam_u32hex()
      fs/fs_parse: Fix 3 issues for validate_constant_table()

 Documentation/filesystems/mount_api.rst | 1 -
 fs/fs_parser.c                          | 7 +++++--
 include/linux/fs_parser.h               | 2 --
 3 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250410-fix_fs-6e0a97c4e59f

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


