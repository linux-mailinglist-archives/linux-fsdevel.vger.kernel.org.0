Return-Path: <linux-fsdevel+bounces-54873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58433B045FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 18:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357F518960CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 16:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072AA29408;
	Mon, 14 Jul 2025 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RcF1B1YR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C5262FC1
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512358; cv=none; b=oijGxRkJWeWfSJ+QfFuHVAb+eUa2zTeCYPp0yhOdZnpA8dggcpMSEhZfJRLmrMxVUZ2XppC/zeewkOxlKLxLRmtL+Z3SAy834L8J56DRHeeIQP4A2yxEIjLGSU23ExUYisIcNxjyEpRMYy1cN+5iZx3kPQBwv8QVGC4LsfKuZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512358; c=relaxed/simple;
	bh=/K7YjiSRq4Lrr6a+ZquvGb2Xyw/KJ5tQmelgwgoyAVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sL7JvHaJJgNvd8HcAxXzcJfmAM6QlyED3TdAPT92a1Hk3xk49f5neWdgqw9J+n+sFNDgc4kcZNPhueuotbDuzoxUoxg+Ioswb0hLaJE+ihqeegdxUY5b7OsScvb8mqwKvBX/BqTtm2dy4ixgkfUOFMiHJfl3kqrAfLtqzZXonvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RcF1B1YR; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGmjmv011653
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 09:59:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=/K7YjiSRq4Lrr6a+ZquvGb2Xyw/KJ5tQmelgwgoyAVI=; b=RcF1B1YRfNB7
	DWYgVpErZqHsilQkRpYKgNzNPj2osi5arIEPrnhH+W9MiG7MNZpo/tBiQ5lmxa8L
	czfKh5nPHtz6ZEU5J3VTA1MYVga2CSYIdEyszn6szlYZ9ZXEPIm046NNyGZWKWsW
	CfKKWVIMixeteGgPgRYW8sDN/7rhFr1smxI6DymBTfLLlShlQr6aKWhSO9RqjyZX
	1tvZOuFY4VwpqnVjy+ACrH47RoiEYlfEejAL4CHFKKXorT+36hjDW00Zs4qTD6Gs
	KXuEWZT3Rmi7a2SlfW4jhi8rXmlPDBrxgOyml6fcCWn5ManJM0A6dMa0h+DO79b7
	FEgSH3/XRw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47vw0bumkt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 09:59:14 -0700 (PDT)
Received: from twshared57752.46.prn1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 14 Jul 2025 16:59:13 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 854243242673B; Mon, 14 Jul 2025 09:59:04 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <amir73il@gmail.com>
CC: <ibrahimjirdeh@meta.com>, <jack@suse.cz>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: Re: [PATCH] fanotify: support custom default close response
Date: Mon, 14 Jul 2025 09:57:58 -0700
Message-ID: <20250714165758.573459-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAOQ4uxgHre+mCOka8dNgzioOShYidxgd=zkX5zcSt8cq89kTXg@mail.gmail.com>
References: <CAOQ4uxgHre+mCOka8dNgzioOShYidxgd=zkX5zcSt8cq89kTXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEwNSBTYWx0ZWRfXxQKv4YidL5st /h2q591kAvG1dO7ODcKiu94j9YozPhoHVOznv1wskGdOg9Xq+TfNImMjKSEJd/pR/8yvdJ14MJz 01yekLQeI5ygPGY5BbNBJF+Y9eDV6PF6UPJNJvZhCqmsm35JMA+9vt+iXLDIEy2nrz7wKc7GxeB
 Jfnii7uWnYT27F4sjHu+x0m2PLnMUr0VdvHcjtkgTltmh71jfMcN2GibHMH3bsW47RwwtCJpNNh rtpMxP+SREPqzJaDHRqg7gsIKbsjfBgGHP/QPE3X9XSaPuM0Zu98DfWE4ZDTcTnOqGoxgz49TBY i/FI+4xVP+6Q0UAm4Yqpuv9uyGHKhA4lbPGmJtU9xiTuWZDN/tJXrvi2obSWxZ9dLVG0SyFlPyW
 QVQCH9ErzeaAxcLyq7lCqDZWTPeJMH5mVC9kifxZSppQGyB3nT4ewcEQGLeFPmC4lUM06i/W
X-Proofpoint-GUID: ohQ83cSImz9dgpphenmkpipjEtWimkvX
X-Authority-Analysis: v=2.4 cv=K6QiHzWI c=1 sm=1 tr=0 ts=68753762 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=spLnemFhhnYcergX9NQA:9
X-Proofpoint-ORIG-GUID: ohQ83cSImz9dgpphenmkpipjEtWimkvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01

This all sounds great. I can work on the control fd API and post it
soon for further discussion.

