Return-Path: <linux-fsdevel+bounces-53769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A87AF6B21
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 09:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854893A684D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20FE298259;
	Thu,  3 Jul 2025 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="oMtxyC2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AB2298264
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751526636; cv=none; b=brS29Dl2Ns9Kw0GcUqUn7KcV6eZp+2Wd+cS23PfS/C5BLEwrjlcyZ5GwzmkxOF7VHBbBq3AL1sfdtdH7XeNiHvSsin10s4J4YhsJLhwFIt3GFtr3U/K+/tgFkGcNPNqyedPbwdX1eUIlxZN9RwNxUVxqCVeslVbSMr7+clKAadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751526636; c=relaxed/simple;
	bh=KIYAGbdT9lu7iPFojsuQSo+aKqI/K35OZzehtcE5M7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnUHRaT3atsEeu4SWEYYgN0+KC4c8rciHn9BhJgv06k7HRB8jtFHrCIj5E8BPoFclIj7/YPgDdUxFPpzov1DuqQkX8UdtPmTTdGiGcXIGPDZtgl/hBLmDwxQnCnUzfxmcCsgBHvCazGdLQwi0VE3dey+6h8JYEYUyAlbwijP0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=oMtxyC2k; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5636oibr027030
	for <linux-fsdevel@vger.kernel.org>; Thu, 3 Jul 2025 00:10:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=eS4OpkAUmU8H281tW3j+1kxOK5VHib15ufijC6s1+8I=; b=oMtxyC2kH9yP
	CTxd2fcgiciuX1RR9cu0lO8Z3R0To4ybbvVA6Z+L1BLi9HDIHaGyZcAovZx4NjZx
	+8VDIdqwsRjL0vFOPBM679dxkuxNT5l+I8g1DJ9z//czsHxeGrzpz0f1vL2TV9Rd
	ekyiptKcR3I5LLtOllP2/+ZLFML9xXtzmyboIQM9h+sr7xwoj0qmfNs+QBw4/EAh
	1uFKn3v9iGmENYPIWPCjlNpegDJAr4/cgP5lKZPPjGZ0qhSRs9pO6XI3jlJd3JHF
	BnPht1iRFHuIaJ38oHk7h46qtSA3agdf+++HN2Zf0A3+kTWsizVzy0lIAXrL5g4B
	apZDCCTWTQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47msgd29eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 00:10:33 -0700 (PDT)
Received: from twshared41381.33.frc3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 3 Jul 2025 07:10:32 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 072653158FFAC; Thu,  3 Jul 2025 00:10:23 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <amir73il@gmail.com>
CC: <ibrahimjirdeh@meta.com>, <jack@suse.cz>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: Re: [PATCH] fanotify: support custom default close response
Date: Thu, 3 Jul 2025 00:08:54 -0700
Message-ID: <20250703070916.217663-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAOQ4uxjTtyn04XC65hv2MVsRByGyvxJ0wK=-FZmb1sH1w0CFtA@mail.gmail.com>
References: <CAOQ4uxjTtyn04XC65hv2MVsRByGyvxJ0wK=-FZmb1sH1w0CFtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=ML1gmNZl c=1 sm=1 tr=0 ts=68662ce9 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=qf4gfuq51q0A:10 a=Wb1JkmetP80A:10 a=iohA272t2eL3LGJjqyAA:9 a=k40Crp0UdiQA:10
X-Proofpoint-GUID: Kk9NtK76503i6wiEj18Yu2xeTSs1VDtN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA1NiBTYWx0ZWRfXyFrh6ssjsmyh 2P3Odo7jVjwsYIndCPty2a6cte8nCO53hBovLIuyAY9b03tE1P4c4IXNlti7B9Wwdg8pO4jlUvO +mbXMJeoFI48TjiNnIoc5owuE9vu8cuNos6GcgU+P37Cst1VlMNKoKXQrd5cyCaH42BtZVKT34i
 GSp7fyVDkxVzOX2Uvi3a2M3tv7LUyjKn9iJa/jiVy8vSixKStxi8jXZHbjLkW/NreSSir9jiXSJ BVaah0WUj2Pdq/5TW4qaLufQ18WShMZuJM+KVpTv/9pHaQuDiLEwIXj6tqgz/qRTGIYACgXyLLZ 6nwllN7bXKENZ0VsAl7GlBRjv4atRiLdBJY/iqBF7P1DChXWdQNNR1rDMmYSWRzGx+hpa5IPgRb
 XyngXQoiJpY3tfaEN/DmGgKQwxhrkCVUH1EauvApqZ3737bL30Pm48K4ua915XfutGOQfXuI
X-Proofpoint-ORIG-GUID: Kk9NtK76503i6wiEj18Yu2xeTSs1VDtN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01

> On Wed, Jul 2, 2025 at 6:15=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > Eventually the new service starts and we are in the situation I descr=
ibe 3
> > paragraphs above about handling pending events.
> >
> > So if we'd implement resending of pending events after group closure,=
 I
> > don't see how default response (at least in its current form) would b=
e
> > useful for anything.
> >
> > Why I like the proposal of resending pending events:
> > a) No spurious FAN_DENY errors in case of service crash
> > b) No need for new concept (and API) for default response, just a fea=
ture
> >    flag.
> > c) With additional ioctl to trigger resending pending events without =
group
> >    closure, the newly started service can simply reuse the
> >    same notification group (even in case of old service crash) thus
> >    inheriting all placed marks (which is something Ibrahim would like=
 to
> >    have).
>

I'm also a fan of the approach of support for resending pending events. A=
s
mentioned exposing this behavior as an ioctl and thereby removing the nee=
d to
recreate fanotify group makes the usage a fair bit simpler for our case.

One basic question I have (mainly for understanding), is if the FAN_RETRY=
 flag is
set in the proposed patch, in the case where there is one existing group =
being
closed (ie no handover setup), what would be the behavior for pending eve=
nts?
Is it the same as now, events are allowed, just that they get resent once=
? I don't
think we would ever run into this with proper usage of the new functional=
ity,
just curious.

