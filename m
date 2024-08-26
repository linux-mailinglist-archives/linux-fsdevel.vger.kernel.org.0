Return-Path: <linux-fsdevel+bounces-27202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55F595F7A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B4EB22246
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 17:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE30198A28;
	Mon, 26 Aug 2024 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kACi0uut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A44E19409E
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692457; cv=none; b=Mbl7p7PvhNoOyxX0LxVeqJ3uRXviAGCYG6XNZbWTAf/HRBy7iUs2Ol/BGkB+WQ/2FxBEBL9PVnWD2cyEhVpiaFKkFbpt9mmmwOvl2qV0yOOncLC1tJ4HTsWB2FQ8C8Pawn0YUZq5LHlpBnlzJUft5GsP7Ko3S6UVPMwMkqMKLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692457; c=relaxed/simple;
	bh=kal5xydGPETFQwQvqncim45a19u2XhkRTCYUkp7F6HA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=WorTcVYr92Ygj9P9gIq6QdkEs4Ql5DoYYe18yy0kpg1FSJTncux8YqdvaAaBkkq9iSwQANwD7I+M2hKbSpEHwlpsyhcKyXA970k5v2soiCirRqPr2+NrsPbmT73h69t3bUtFaIIGmN2xCGFNKwXYuFBTE23F1vP7/dHrWGnOsyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kACi0uut; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240826171412epoutp0403032eea4115c92d0b29b69e36d36911~vVqXqyHtI0751607516epoutp04M
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 17:14:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240826171412epoutp0403032eea4115c92d0b29b69e36d36911~vVqXqyHtI0751607516epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724692452;
	bh=Po2gU7Tj1IXZMxwPWnpQrOZ+vFEA/kofumpkR30jMIU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=kACi0uutz/JVECZ5teosHI8WGM9SKa0OHvbP5bdqcnS1XsN5DvIQH7gv/VushIqJo
	 fXe0I076oDp1ZjrTkUMy9dq0vVHHdqcwahrhEx8Yl9jDOon1H9PqRTzow2XXug8ynU
	 msRrbYBTgssUDczi3ZNyDeVvEHKoVogvD5q5c6hc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240826171412epcas5p3131af6d126d29e121f88274b259a5d35~vVqW6MHli2946129461epcas5p3h;
	Mon, 26 Aug 2024 17:14:12 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Wsy2V308wz4x9Pt; Mon, 26 Aug
	2024 17:14:10 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0D.A3.09642.2E7BCC66; Tue, 27 Aug 2024 02:14:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240826171409epcas5p306ba210a9815e202556778a4c105b440~vVqUt5c6C2946129461epcas5p3f;
	Mon, 26 Aug 2024 17:14:09 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240826171409epsmtrp21dff6590920e7f62967e1b0cd6fa8b5f~vVqUs0lps3048030480epsmtrp2V;
	Mon, 26 Aug 2024 17:14:09 +0000 (GMT)
X-AuditID: b6c32a4b-613ff700000025aa-42-66ccb7e27d64
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	95.B2.07567.1E7BCC66; Tue, 27 Aug 2024 02:14:09 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240826171405epsmtip2435567b12708596c83fb75f46f239673~vVqRFnxQu0040200402epsmtip2b;
	Mon, 26 Aug 2024 17:14:05 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, jack@suse.cz, jaegeuk@kernel.org, jlayton@kernel.org,
	chuck.lever@oracle.com, bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v4 0/5] Write-placement hints and FDP
Date: Mon, 26 Aug 2024 22:36:01 +0530
Message-Id: <20240826170606.255718-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwTZxz2vTuuh7HkVjS+I4p4zj9gAi3SciyA6Mi8rcvS7DMj2eBWjo8A
	bddrJ5NNccxNuglSFBUlVkLYLONTQLTDOCo6HA5CkQmIVCwsk4lAtyFCYC2Hm/89v+f9Pb/n
	eb8IVDKABxAZGgOn17BZFL4aa7EHB4eOXuhKlfaeI+nq4SKcnrDPALp0ag6ll4Z/R+iBKxcR
	+lx1B0KfOp6P0K66MpRuKCLo+3fcInquyiqiO5Ye4rS5vR/QbYMv0r0Vu+kf2zox+kzVmIj+
	5rdWnP7u+iJC1048wujustOi+HWMo0/JdN9twJhS8w2ccdw0Mo3WApw5X7mfsVncCGMbyMOZ
	6bFBjClssgKmy3JVxLgbA1VrEjNj0jk2hdMHcRq1NiVDkxZLKd9KejlJrpDKQmXRdBQVpGGz
	uVgq4XVV6CsZWZ6dUkGfsFlGD6VieZ4Kj4vRa40GLihdyxtiKU6XkqWL1IXxbDZv1KSFaTjD
	SzKpNELuaUzOTL+89IuPbprMqXFYRXmgQGwCvgQkI+GR232YCawmJKQNQGf5GBCKGQB76gp8
	hOIfAO8tTGJPJbVFXSJhoQ3A2YqJFb0bwD+s3R49QeBkMOwpMXr5tWQ+AhtqnuDeAiXNCJx2
	1uDeUf6kHNrHzyJejJFbYeeXZtSLxWQ0HKipRAW7TfBk76xI4J+DnSddyzFQD5/ffGqlx0XA
	vkXeawzJBHihWC/Q/vDB9SaRgAOge7INF3AmdI46V3bzGWw9X+gj4B0wb+G2j3cM6slfdylc
	cPKDh+ddiDBdDA99JRG6N8O75rEV5Xp470TlCmbgoO2vZScJ+QH8YngRPQICy57JX/ZM/rL/
	zSwAtYLnOR2fncbxct12Dbfnv7tUa7MbwfIbD1G2glHnVFg7QAjQDiCBUmvFgY7OVIk4hf10
	L6fXJumNWRzfDuSeQy1GA9aptZ5PojEkySKjpZEKhSIyertCRq0XTxwsT5GQaayBy+Q4Had/
	qkMI34A8pCOnxIb4F2+7LN21Z2jT25c67TbTqqFjlTuZWccPGfLkgzm/qgpZ3TZ13EN3/BVd
	XGq1wpKLDcms4b0not7YWJi8+YUHrfWHFvubtab63MHTt/oiSlw3+qnivY9JaPlTShlqs0M2
	+IN9Be+9uiHqnZCRuUeSKHXV8TW6ucF5v6uHvw3rOfN1d8SHd8a79zsyZ/cl6L93XsttPjo3
	Mr7lLPB9zYx8fPFne+JUUKEzUfXurpjP9cc0t1bV41aVEhnFipw77PL50q2TpqGbse+bp3ya
	cn5amn1T2accQVuu7VY/ue93IH96p+ujOuPjlvhp00KERBp3YHzLjOXoxih3+d8VfhTGp7Oy
	EFTPs/8CWXJOt2wEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvO7D7WfSDHa/VLZYfbefzeL14U+M
	FtM+/GS2+H/3OZPFzQM7mSxWrj7KZDF7ejOTxZP1s5gtNvZzWDy+85nd4ueyVewWR/+/ZbOY
	dOgao8XeW9oWlxa5W+zZe5LFYv6yp+wW3dd3sFksP/6PyWLd6/csFudnzWF3EPW4fMXb4/y9
	jSwe0yadYvO4fLbUY9OqTjaPzUvqPXYv+MzksftmA5vHx6e3WDz6tqxi9Diz4Ai7x+dNcgE8
	UVw2Kak5mWWpRfp2CVwZ+/6fZi34KFCx9vIq9gbGTt4uRk4OCQETiXX9Z9i7GLk4hAR2M0o8
	+PCaCSIhLtF87Qc7hC0ssfLfc6iij4wSO56vBHI4ONgENCUuTC4FiYsITGaSaHq4hQXEYRaY
	wySxvHM7M0i3sICpxOFnC8GmsgioSpxsmQQW5xWwlLi5dgkzxAZ5iZmXvrNDxAUlTs58wgJi
	MwPFm7fOZp7AyDcLSWoWktQCRqZVjJKpBcW56bnJhgWGeanlesWJucWleel6yfm5mxjB8aal
	sYPx3vx/eocYmTgYDzFKcDArifDKXT6ZJsSbklhZlVqUH19UmpNafIhRmoNFSZzXcMbsFCGB
	9MSS1OzU1ILUIpgsEwenVANT+JdsVgHpuo6Uf37BDWufbE2P5Sy227qyK0nWbO4x1qvfvt/e
	HaWXL2dXdFfvMNv0jAlWt2OLRO0WfqlcJX5VTfvRq7JtqvdijB6eKK79vuXHp82JAdN7fpzc
	9sf+mbzlrzKpgI4SZu0djevmiTocEd67XfiIRbaerFSlbMemdYW8HzLWrNAwPKayblnpfJ7F
	okmz55TyiOqblz4wcdgiPX2br+RMnWmtDyq3cuTNFhd/6PxESX3uqRa5T6EvDNc+32kToLI7
	QOJWUM7u+VGnKh83Hanui5E+VOQvkhq5eSu/6vtgn866PkblELf/quzsLlO8gzUO3u6dkpHq
	elpvReI/adbq+E/H9+lc71BiKc5INNRiLipOBADy+3UfJgMAAA==
X-CMS-MailID: 20240826171409epcas5p306ba210a9815e202556778a4c105b440
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826171409epcas5p306ba210a9815e202556778a4c105b440
References: <CGME20240826171409epcas5p306ba210a9815e202556778a4c105b440@epcas5p3.samsung.com>

Current write-hint infrastructure supports 6 temperature-based data life
hints.
The series extends the infrastructure with a new temperature-agnostic
placement-type hint. New fcntl codes F_{SET/GET}_RW_HINT_EX allow to
send the hint type/value on file. See patch #3 commit description for
the details.

Overall this creates 128 placement hint values [*] that users can pass.
Patch #5 adds the ability to map these new hint values to nvme-specific
placement-identifiers.
Patch #4 restricts SCSI to use only life hint values.
Patch #1 and #2 are simple prep patches.

[*] While the user-interface can support more, this limit is due to the
in-kernel plumbing consideration of the inode size. Pahole showed 32-bit
hole in the inode, but the code had this comment too:

/* 32-bit hole reserved for expanding i_fsnotify_mask */

Not must, but it will be good to know if a byte (or two) can be used
here.

Changes since v3:
- 4 new patches to introduce write-placement hints
- Make nvme patch use the placement hints rather than write-life hints

Changes since v2:
- Base it on nvme-6.11 and resolve a merge conflict

Changes since v1:
- Reduce the fetched plids from 128 to 6 (Keith)
- Use struct_size for a calculation (Keith)
- Handle robot/sparse warning

Kanchan Joshi (4):
  fs, block: refactor enum rw_hint
  fcntl: rename rw_hint_* to rw_life_hint_*
  fcntl: add F_{SET/GET}_RW_HINT_EX
  nvme: enable FDP support

Nitesh Shetty (1):
  sd: limit to use write life hints

 drivers/nvme/host/core.c   | 81 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h   |  4 ++
 drivers/scsi/sd.c          |  7 ++--
 fs/buffer.c                |  4 +-
 fs/f2fs/f2fs.h             |  4 +-
 fs/f2fs/segment.c          |  4 +-
 fs/fcntl.c                 | 79 ++++++++++++++++++++++++++++++++++---
 include/linux/blk-mq.h     |  2 +-
 include/linux/blk_types.h  |  2 +-
 include/linux/fs.h         |  2 +-
 include/linux/nvme.h       | 19 +++++++++
 include/linux/rw_hint.h    | 20 +++++++---
 include/uapi/linux/fcntl.h | 14 +++++++
 13 files changed, 218 insertions(+), 24 deletions(-)

-- 
2.25.1


