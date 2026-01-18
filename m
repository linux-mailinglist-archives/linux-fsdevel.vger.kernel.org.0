Return-Path: <linux-fsdevel+bounces-74344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 427A7D39AC6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58EAC3014E80
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515BF1A9FA0;
	Sun, 18 Jan 2026 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="tvSOqbKF";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Fe88JFY3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-173.smtp-out.amazonses.com (a11-173.smtp-out.amazonses.com [54.240.11.173])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35825279DB1;
	Sun, 18 Jan 2026 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775692; cv=none; b=SduNLhZWLmmZ4l9L4n34uq7KgXt+delzNl+HPxCL0cJXtlhvxn7kSQPZyzhuXX103WcxyG1FUiZpxt6P0uPf/RQxHQoOpvre5FTkm5DrpIlpz1R4rvCD84LlB/VGKQSb42s+7nI/kzhu2onL14JUG3vIjSmL9Z+uDZ3u9ldXI2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775692; c=relaxed/simple;
	bh=wnb1LndmehjCJa4FwwQpapejMv/jkhhhxrPjV3K6jlg=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=CmwQOtf23BuXVR22bsKTfSqmYRHfpnT0eBBR/MJ3IAnc3VGgHjNT0uDWb7jQlXerOrDz26Ic9q36zcU8wHShTdnZ+OMP+N0uPcxp+4TiHsHWS7eIquCInCd+KsTcFYYIHcKVMwva08e1Ske5CYPNqPJunOfz1POmaGJSyP67xEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=tvSOqbKF; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Fe88JFY3; arc=none smtp.client-ip=54.240.11.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775690;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=wnb1LndmehjCJa4FwwQpapejMv/jkhhhxrPjV3K6jlg=;
	b=tvSOqbKFxybAupqhz8aG6Nn8R4JUL9KsH/RjMCQu3LLV4Yuy5jRApJejoaFXu9D1
	5HywsLPLtJt6f5ROL35GKS0o6u6RRVausOtysA2S6TC6/d0kW2+rJNDVCkj+hlzDRrx
	X22fRexRfQRCMjMyPwgPM2BOsvap3FBWTvE/7Y3E=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775690;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=wnb1LndmehjCJa4FwwQpapejMv/jkhhhxrPjV3K6jlg=;
	b=Fe88JFY3Vjo4LFNhc+tesmuz0YV5kHoonc8Qf0bCQ+onVBQk3tNUERhoMQbfyqxT
	ERI6GhVikG1YKDFuNGSKg99aylJLom8mu/anAkeY3qWJTkJN15JXo96ubraCmaLIPi9
	ALtO8OynIh7m19F158I8DYBUGWfp/ddrrArbXaVc=
Subject: [PATCH V7 0/3] libfuse: add basic famfs support to libfuse
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?John_Groves?= <John@Groves.net>, 
	=?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?Bernd_Schubert?= <bschubert@ddn.com>, 
	=?UTF-8?Q?Alison_Schofiel?= =?UTF-8?Q?d?= <alison.schofield@intel.com>
Cc: =?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@fastmail.com>, 
	=?UTF-8?Q?Jonathan_Corbet?= <corbet@lwn.net>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Matthew_Wilcox?= <willy@infradead.org>, 
	=?UTF-8?Q?Jan_Kara?= <jack@suse.cz>, 
	=?UTF-8?Q?Alexander_Viro?= <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?David_Hildenbrand?= <david@kernel.org>, 
	=?UTF-8?Q?Christian_Bra?= =?UTF-8?Q?uner?= <brauner@kernel.org>, 
	=?UTF-8?Q?Darrick_J_=2E_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?Randy_Dunlap?= <rdunlap@infradead.org>, 
	=?UTF-8?Q?Jeff_Layton?= <jlayton@kernel.org>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Stefan_Hajnoczi?= <shajnocz@redhat.com>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?Josef_Bacik?= <josef@toxicpanda.com>, 
	=?UTF-8?Q?Bagas_Sanjaya?= <bagasdotme@gmail.com>, 
	=?UTF-8?Q?James_Morse?= <james.morse@arm.com>, 
	=?UTF-8?Q?Fuad_Tabba?= <tabba@google.com>, 
	=?UTF-8?Q?Sean_Christopherson?= <seanjc@google.com>, 
	=?UTF-8?Q?Shivank_Garg?= <shivankg@amd.com>, 
	=?UTF-8?Q?Ackerley_Tng?= <ackerleytng@google.com>, 
	=?UTF-8?Q?Gregory_Pric?= =?UTF-8?Q?e?= <gourry@gourry.net>, 
	=?UTF-8?Q?Aravind_Ramesh?= <arramesh@micron.com>, 
	=?UTF-8?Q?Ajay_Joshi?= <ajayjoshi@micron.com>, 
	=?UTF-8?Q?venkataravis=40micron=2Ecom?= <venkataravis@micron.com>, 
	=?UTF-8?Q?linux-doc=40vger=2Ekernel=2Eorg?= <linux-doc@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?nvdimm=40lists=2Elinux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>, 
	=?UTF-8?Q?John_Groves?= <john@groves.net>
Date: Sun, 18 Jan 2026 22:34:50 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
In-Reply-To: 
 <0100019bd33a16b4-6da11a99-d883-4cfc-b561-97973253bc4a-000000@email.amazonses.com>
References: 
 <0100019bd33a16b4-6da11a99-d883-4cfc-b561-97973253bc4a-000000@email.amazonses.com> 
 <20260118223432.92715-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQAAMYcg
Thread-Topic: [PATCH V7 0/3] libfuse: add basic famfs support to libfuse
X-Wm-Sent-Timestamp: 1768775688
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33f2761-af1fb233-73d0-4b99-a0c0-d239266aec91-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.11.173

From: John Groves <john@groves.net>

This short series adds adds the necessary support for famfs to libfuse.

This series is also a pull request at [1].

Changes v4 -> v5 -> v6 -> v7: none, re-sending due to technical challenges

Changes v3 -> v4
- The patch "add API to set kernel mount options" has been dropped. I found
  a way to accomplish the same thing via getxattr.

References

[1] - https://github.com/libfuse/libfuse/pull/1414


John Groves (3):
  fuse_kernel.h: bring up to baseline 6.19
  fuse_kernel.h: add famfs DAX fmap protocol definitions
  fuse: add famfs DAX fmap support

 include/fuse_common.h   |  5 +++
 include/fuse_kernel.h   | 98 ++++++++++++++++++++++++++++++++++++++++-
 include/fuse_lowlevel.h | 37 ++++++++++++++++
 lib/fuse_lowlevel.c     | 31 ++++++++++++-
 patch/maintainers.txt   |  0
 5 files changed, 169 insertions(+), 2 deletions(-)
 create mode 100644 patch/maintainers.txt


base-commit: 6278995cca991978abd25ebb2c20ebd3fc9e8a13
-- 
2.52.0


