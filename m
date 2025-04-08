Return-Path: <linux-fsdevel+bounces-46019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B92A81525
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 20:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49FFC3A5141
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 18:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB80923E358;
	Tue,  8 Apr 2025 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mRYkk7r9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979512356CC
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138526; cv=none; b=BFSmZcZUDexFp9vDlHicLj9CXW5egwYypjUXa+tnQOZlsV7/RIQZB4WhYJOhZFdftg8h9VXBLrZ+7Qinb9vIwuj3j7k++hsZDDcLIBVO/P6sTr6Q4MPin6x/bMdu1RBCtmYkP+ugXIdY9tLTDBzqw3/VmL5AyJmaxrmqINvUfRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138526; c=relaxed/simple;
	bh=5mk9OHeKHep5++btiOCh6pKsmBzgcl+wRvXPzlPxd1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhVY2yfFwAomAPSmUKDAFkuK6u01AJkAwXODJwoFnaumKH32d51TeX054lYj3VI9gE99ywgMHjLoAHO1vhb1b2KJ51HhBFKt1sL/fv6khqLnEbA5M4pyptUv2Zft9DF6tL6OpODSiUfhGw3Ok5VtPecHG6bzvYtyvUIwcOQ0GHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mRYkk7r9; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538HaRCc028205
	for <linux-fsdevel@vger.kernel.org>; Tue, 8 Apr 2025 11:55:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=5mk9OHeKHep5++btiOCh6pKsmBzgcl+wRvXPzlPxd1Y=; b=mRYkk7r9Nl8Q
	PO/KfV9zsSA5Ffo9gqKbA0DjF5Jsnqr1bs1G6enokBTQIW1IgZiAjkDa/PwGNP1v
	TZWdr5jN0grTEcwrfRlhMXjMWVVSzTFhtI9m4fixgbEh35LO5mFi4nj7jej7ShyM
	3ZEWDj+3g90VM0vemR70iSRq/pdB9e0r+6bgS8jfPvC9cZM/SaDTg2EQKkE/UPkw
	GAYHlVoI2XYSCQ2eIrdDPwqsBOMnG5fTZQstOXQG8ZT+Z2QvbvgMtykEw4NNZZQb
	9nvRzpnB+8ka2vtENbK/vx/TuxkhVW+6vm2gK5ILroVwW6Q9SWS6tmfqBsOoyp7Q
	419zbzF1TA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45vts366f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 08 Apr 2025 11:55:23 -0700 (PDT)
Received: from twshared11388.16.prn3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 8 Apr 2025 18:55:22 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id EBF71267C9312; Tue,  8 Apr 2025 11:55:08 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <amir73il@gmail.com>
CC: <ibrahimjirdeh@meta.com>, <jack@suse.cz>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: Re: Reseting pending fanotify events
Date: Tue, 8 Apr 2025 11:55:06 -0700
Message-ID: <20250408185506.3692124-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAOQ4uxgXO0XJzYmijXu=3yDF_hq3E1yPUxHqhwka19-_jeaNFA@mail.gmail.com>
References: <CAOQ4uxgXO0XJzYmijXu=3yDF_hq3E1yPUxHqhwka19-_jeaNFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iTG2xnNUl_Ywoub8i_CMIWksCrXd8Bxc
X-Proofpoint-GUID: iTG2xnNUl_Ywoub8i_CMIWksCrXd8Bxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_08,2025-04-08_04,2024-11-22_01

> 1. Start a new server instance
> 2. Set default response in case of new instance crash
> 3. Hand over a ref of the existing group fd to the new instance if the
> old instance is running
> 4. Start handling events in new instance (*)
> 5. Stop handling new events in old instance, but complete pending event=
s
> 6. Shutdown old instance

I think this should work for our case, we will only need to reconstruct
the group/interested mask in case of crash. I can help add the feature fo=
r
setting different default responses.

> Doing this for the mount level would be possible, but TBH, it does not =
look
> like the right object to be setting the moderation on, because even if =
we did
> set a default mask on a mount, it would have been easy to escape it by
> creating a bind mount, cloning a new mount namespace, etc.
>=20
> What is the reason that you are marking the mount?
> Is it so that you could have another "unmoderated" mount to
> populate the file conten?
> In that case you can opt-in for permission events on sb
> and opt-out from permission events on the "unmoderated" mount
> and you can also populate the file content with the FMODE_NONOTIFY
> fd provided in the permission event.

Yes, essentially we surface and monitor read-only bind mounts of specific=
=20
directories. The current setup opts-in for events per mount (via FAN_MARK=
_MOUNT),
and initial access populates file contents. If theres a way to do this wi=
th
sb marks we can switch to that, it would simplify things. I saw theres so=
me=20
discussion of similar use-cases in this thread on sb views:
https://lore.kernel.org/linux-fsdevel/20201109180016.80059-1-amir73il@gma=
il.com/

> I might have had some patches similar to this floating around.
> If you are interested in this feature, I could write and test a proper =
patch.

That would be appreciated if its not too much trouble, the approach outli=
ned
in sketch should be enough for our use-case (pending the sb vs mount moni=
toring
point you've raised).



