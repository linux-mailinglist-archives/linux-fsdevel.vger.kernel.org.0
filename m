Return-Path: <linux-fsdevel+bounces-53113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12FCAEA5D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 20:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768E31C4418C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 18:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6FA2EF280;
	Thu, 26 Jun 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Y1p2BrOi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1876C2EE606
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964001; cv=none; b=SZmGC918LritjFnrzvggBQ5sgb+aD9drMXSW+K9TxPsIyJq3dq1aI52Uo+PNnOwQqRAt2Z968qHiUKSRlR/vu6AX6eJE3dbkrkBjpRlAjGpPGOHFMwan/YSYQUhDGnKM/zMFpFOCI1Je/6FGiTVP4bX05OhNaVxJcii7EnrBX4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964001; c=relaxed/simple;
	bh=xS7Oj/x8jdHfdO8x1aZf+QZX+5x0lWlMje35oSi1NjE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9e1dUIRiD7xyviX7WcudapJ8mRDmP6j7xhng18gErK6SzGWT5zMafu6KX88oIY5BxT46P4mScwg34WHvvPEj/H9Rwhn/BWVnB/ewvzzYUJEmlY3/fuUa/5snwpG+jkY2IzlaFVmfbA1CXyqpAne1iNoJucHkNRbMLsCjX0jYlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Y1p2BrOi; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QH8bEG022008
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 11:53:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xS7Oj/x8jdHfdO8x1aZf+QZX+5x0lWlMje35oSi1NjE=; b=Y1p2BrOiYOvi
	TKdGb+Qm8Ezhd4OiL6bZtelqPk/L1GoqOBoSMfMnsakZ8QhklhUWugwXg5a+5zKO
	kZTkEVrrv5ivEV+TfoM5FOEV+EdT+0fZP2e8Ugnlkn3CQBtkeiA5Tl5+uafnRXU9
	PRDqMT8Zc0mxPjKrydXFXYmB63GpVMNsfq4cMItIBdMCgNKsLfMrND9ogvP0BAnV
	T82kIdDIres26XNtTHBYkOy0Gy7NOE9v5xinvGApFTiWEfaKRSbI1KO8OeiDbxne
	OzfcAWlF4KkBcfsfr9IL0XifkVoyJdN+aGOyDMA7j0oNvee3pF/Wf4ZTTCF4m0Dc
	iKnioDd9hA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47guhne8hk-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 11:53:18 -0700 (PDT)
Received: from twshared6134.33.frc3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 26 Jun 2025 18:53:17 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id EB07130A01663; Thu, 26 Jun 2025 11:53:01 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <jack@suse.cz>
CC: <amir73il@gmail.com>, <ibrahimjirdeh@meta.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH] fanotify: selftests for fanotify permission events
Date: Thu, 26 Jun 2025 11:52:35 -0700
Message-ID: <20250626185235.1229065-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <bc4dvylqapkxdqme65cudioajevdcjvwesmgh5v6jmghosyoux@sazv6a4q3hml>
References: <bc4dvylqapkxdqme65cudioajevdcjvwesmgh5v6jmghosyoux@sazv6a4q3hml>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE2MSBTYWx0ZWRfX/O0R6GD3XnG4 zgFv5+G+h4MHm4sxSngwFLCCbfo7yCKs5bVJZmlWzYtM5l8tS1CUwc9+YQXHFHtOe4oXUc00p3B mLPUAhscm0aeThcn0zgQOyALskAH2b5OgTWwu/CYLLZTmbpAuxI8XAhePuy9PphWp5MnehOwLhd
 sgDF7pbMMThEse5ZO4+t9M+ztDD+BIH6FLMYvsjyeX8+VITz12wELvX5GfRKWzA9aZAAoadAjqu oO3gkNqkIVHOqmMAWbjjS+JirH7xC+iWPSYCk233c2mvWNpQ2swyn5vw5u6afRKBylKllsCoeHs Z4+NLkiOR/YCghw5EoD+fSWjVJktQ8LHIImJ2+7SXogc++QrKQWeGFWINcoxyRvlSaOipWfh6Cg
 xONB+u2LkrLY09ISFzyl2sddezF0OhgS/5KaYdIxM/3f5gKfk0djxJrOPWqgJGtDxYyME7Hs
X-Authority-Analysis: v=2.4 cv=Peb/hjhd c=1 sm=1 tr=0 ts=685d971e cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=VabnemYjAAAA:8 a=cFEjdifhCsChGnJ1kAoA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: cJxjVwqCJ-PXT7bmQh9idvqest4HnF8M
X-Proofpoint-GUID: cJxjVwqCJ-PXT7bmQh9idvqest4HnF8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01

> On 6/26/25, 3:49 AM, "Jan Kara" <jack@suse.cz <mailto:jack@suse.cz>> wr=
ote:
> On Tue 24-06-25 07:58:59, Amir Goldstein wrote:
> > On Mon, Jun 23, 2025 at 9:45 PM Ibrahim Jirdeh <ibrahimjirdeh@meta.co=
m <mailto:ibrahimjirdeh@meta.com>> wrote:
> > >
> > > This adds selftests which exercise generating / responding to
> > > permission events. They requre root privileges since
> > > ^^^^ require
> > > FAN_CLASS_PRE_CONTENT requires it.
> > >
> > > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com <mailto:ibrah=
imjirdeh@meta.com>>
> > > ---
> > > tools/testing/selftests/Makefile | 1 +
> > > .../selftests/filesystems/fanotify/.gitignore | 2 +
> > > .../selftests/filesystems/fanotify/Makefile | 8 +
> > > .../filesystems/fanotify/fanotify_perm_test.c | 386 +++++++++++++++=
+++
> > > 4 files changed, 397 insertions(+)
> > > create mode 100644 tools/testing/selftests/filesystems/fanotify/.gi=
tignore
> > > create mode 100644 tools/testing/selftests/filesystems/fanotify/Mak=
efile
> > > create mode 100644 tools/testing/selftests/filesystems/fanotify/fan=
otify_perm_test.c
> > >
> > >
> > > Hi Ibrahim,
> > >
> > As a general comment, I do not mind having diverse testing
> > methods, but just wanted to make sure that you know that we
> > usually write fanotify tests to new features in LTP.
> >
> > LTP vs. selftests have their pros and cons, but both bring value
> > and add test coverage.
> > selftests would not have been my first choice for this particular tes=
t,
> > because it is so similar to tests already existing in LTP, e.g.:
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kerne=
l/syscalls/fanotify/fanotify24.c <https://github.com/linux-test-project/l=
tp/blob/master/testcases/kernel/syscalls/fanotify/fanotify24.c>
>
>
> Yeah, frankly I'd prefer to keep tests in one place unless there's a go=
od
> reason not to. As you write in this case we already have very similar t=
ests
> in LTP so adding a coverage for the new functionality there seems like =
a
> no-brainer...
>
>
> > but I suppose that testing the full functionality of event listener f=
d handover
> > might be easier to implement with the selftest infrastructure.
> > Anyway, I will not require you to use one test suite or the other if =
you have
> > a preference.
>
>
> If there's some functionality that's hard to test from LTP, we can cons=
ider
> implementing that in kselftests but I'd like to hear those reasons firs=
t...

I missed the existing tests present in LTP repo. Will resubmit the test c=
ases
for new functionality to that repo rather than adding them as selftests.

