Return-Path: <linux-fsdevel+bounces-75454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGfhDp9ad2maeQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 13:14:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34D88144
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 13:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD91C30182B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0B4334C03;
	Mon, 26 Jan 2026 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Seu3Cf7v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66CC331A62
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429651; cv=none; b=kUf4mU6h3vjSjH8B3wbuAlms54LqhrYB5gOVs8aI2+lVXlPTgDXU/YBOm7YAf+80wPVkrkGJnIIXoZDFifa/lonV7aIde5f2cK9EUYiC34+fVxE2yHHL7qp4TN+AIKscGAPc+HOn8lvQko+YnhZUfv5mhUlC+dYIEAYvgk6evhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429651; c=relaxed/simple;
	bh=FG6cbyIggLsXYjbsGlnA5U9y73W/ATRQujV/E/i71Qs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hiMTAF5Xr0CKN1+ARQwnAHq0rBgZW33PX5ENzDgEWPpWTJTd5ia2k4pSaTfks8uk7UIBGx6p0GocrD0VPpZH8vmUalyMEzZgF2LDzh4ELLNYQbXP2miY4b/OA+ZN2DLSRDfXiwSHjOdDiMZSRwJnX+Rdey4TiYcqpjpy5xJ+NxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Seu3Cf7v; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mfkXle3AciDG5CzVwiuVxeDiAwO1O6nuvEJdaEwGstI=;
	b=Seu3Cf7vJTp+aCAgdm5PzpTGPIfHKOqcgnvh9q1Cg0f8gj4dtLnum5O9U1XbscgWnWaVn+QyD
	MyCmKrfLKD87PPHBbAutgeF5pgrqSSL9WfMgOXd1dhooixdNNKfvodXO7bacs7CPU2+wXo8+nUd
	cQO6rDcPItnfLOkJpa90eis=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f06mg0hC3znTVZ;
	Mon, 26 Jan 2026 20:10:11 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B82340562;
	Mon, 26 Jan 2026 20:14:06 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Jan
 2026 20:14:05 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <brauner@kernel.org>, <djwong@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hsiangkao@linux.alibaba.com>,
	<lihongbo22@huawei.com>
Subject: [PATCH 0/1] fs/iomap: Describle @private in iomap_readahead()
Date: Mon, 26 Jan 2026 12:00:19 +0000
Message-ID: <20260126120020.675179-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75454-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: DA34D88144
X-Rspamd-Action: no action

The former commit has added a new parameter @private to
iomap_readahead() and has been added in vfs-iomap branch [1],
so let's describe the parameter in this patch.

[1] https://lore.kernel.org/all/20260114-neufahrzeuge-urfassung-103f4ab953be@brauner/

Hongbo Li (1):
  fs/iomap: Describle @private in iomap_readahead()

 fs/iomap/buffered-io.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.22.0


