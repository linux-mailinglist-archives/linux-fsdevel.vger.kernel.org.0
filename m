Return-Path: <linux-fsdevel+bounces-74698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL6EEGTcb2n8RwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:49:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A38ED4AC05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44C0E84D403
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 17:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52432336ED1;
	Tue, 20 Jan 2026 17:01:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2467E261B91;
	Tue, 20 Jan 2026 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928511; cv=none; b=tWt35an6whDLxTU4RYRE0ogK1hRg1a3aBPa0W6KNFNVq3D3vt2Fhjg4QJtXlVlFuGBiFVIIZ6FDG3PcPVCtoxvOk1Y55YLTpbIJuwUX6lOhiTk6RA84AgjJwqSeGaYZEqjogcBpU1J/m3XxNaw3MB/zPQpPjc/AOryzKltboA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928511; c=relaxed/simple;
	bh=LHrIj1K/jnoEglxCdPdleoWP3nNJVJwxtLtp8PHTsUM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlar4O5F3MF7s7M2g12NelSRKqo3F1drpz7k7WWeQeFTd2FdnIf88G5qd1oWkvSaTzVZ0LDGd7zsVgBUvdunsYO8aS4pd3EBWI1khbzZ2iYSSgeaw0GHaqhfHn+E1PNCW9y/X7XEfYS954bbz8MsLRz3IZv4lRV4Qb1wa68zN3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dwYWL0NLwzJ46DM;
	Wed, 21 Jan 2026 01:01:18 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C1F0040570;
	Wed, 21 Jan 2026 01:01:42 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Jan
 2026 17:01:41 +0000
Date: Tue, 20 Jan 2026 17:01:35 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: John Groves <john@jagalactic.com>
CC: John Groves <John@Groves.net>, Miklos Szeredi <miklos@szeredi.hu>, "Dan
 Williams" <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>, John Groves
	<jgroves@micron.com>, John Groves <jgroves@fastmail.com>, Jonathan Corbet
	<corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand
	<david@kernel.org>, Christian Brauner <brauner@kernel.org>, "Darrick J .
 Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "Jeff
 Layton" <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi
	<shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef Bacik
	<josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, James Morse
	<james.morse@arm.com>, Fuad Tabba <tabba@google.com>, Sean Christopherson
	<seanjc@google.com>, Shivank Garg <shivankg@amd.com>, Ackerley Tng
	<ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, Aravind Ramesh
	<arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>,
	"venkataravis@micron.com" <venkataravis@micron.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V4 0/2] ndctl: Add daxctl support for the new "famfs"
 mode of devdax
Message-ID: <20260120170135.00003523.alireza.sanaee@huawei.com>
In-Reply-To: <0100019bd34040d9-0b6e9e4c-ecd4-464d-ab9d-88a251215442-000000@email.amazonses.com>
References: <0100019bd33a16b4-6da11a99-d883-4cfc-b561-97973253bc4a-000000@email.amazonses.com>
	<20260118223548.92823-1-john@jagalactic.com>
	<0100019bd34040d9-0b6e9e4c-ecd4-464d-ab9d-88a251215442-000000@email.amazonses.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Spamd-Result: default: False [1.24 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : No valid SPF, No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[Groves.net,szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-74698-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alireza.sanaee@huawei.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[famfs.org:url,groves.net:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,jagalactic.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: A38ED4AC05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 18 Jan 2026 22:36:02 +0000
John Groves <john@jagalactic.com> wrote:

Hi John,

What's the base commit for this set? I seem not be able to apply on ndctl master. Maybe I am missing something.

Thanks,
Alireza

> From: John Groves <john@groves.net>
> 
> No change since V2 - re-sending due to technical challenges.
> 
> No change since V1 - reposting as V2 to keep this with the related
> kernel (dax and fuse) patches and libfuse patches.
> 
> This short series adds support and tests to daxctl for famfs[1]. The
> famfs kernel patch series, under the same "compound cover" as this
> series, adds a new 'fsdev_dax' driver for devdax. When that driver
> is bound (instead of device_dax), the device is in 'famfs' mode rather
> than 'devdax' mode.
> 
> References
> 
> [1] - https://famfs.org
> 
> 
> John Groves (2):
>   daxctl: Add support for famfs mode
>   Add test/daxctl-famfs.sh to test famfs mode transitions:
> 
>  daxctl/device.c                | 126 ++++++++++++++--
>  daxctl/json.c                  |   6 +-
>  daxctl/lib/libdaxctl-private.h |   2 +
>  daxctl/lib/libdaxctl.c         |  77 ++++++++++
>  daxctl/lib/libdaxctl.sym       |   7 +
>  daxctl/libdaxctl.h             |   3 +
>  test/daxctl-famfs.sh           | 253 +++++++++++++++++++++++++++++++++
>  test/meson.build               |   2 +
>  8 files changed, 465 insertions(+), 11 deletions(-)
>  create mode 100755 test/daxctl-famfs.sh
> 
> 
> base-commit: 4f7a1c63b3305c97013d3c46daa6c0f76feff10d


