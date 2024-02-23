Return-Path: <linux-fsdevel+bounces-12573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE3F8612CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB21D28332A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F987EF07;
	Fri, 23 Feb 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I3Da3PYI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B02C7AE6E
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695348; cv=none; b=Z3r0uW7g88dkfWHYqpvs7trm/yJgHVsVNLMwQmh4UXCX6NfBTL8BbKK7Kr+IArpBL46TPlYpTJq2q16w8BrDM6odKy3OWLusH9wTpOXc8HKhDf6kN0B/eVfR6wX0B+LHvle+VFylkxiuHTQNtq9kMjbsBxTPix46Z1LKKhgEaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695348; c=relaxed/simple;
	bh=OTJ7Xt7rrRT0h51MxKNk6INxdt2O58CNFDXKF9XQAeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+QdP5pYqjoc2TQlrvRNZ0WhVhkyIyFAagia9wtszk6/Aox4Cyk7HB95p9WBCzJq6K/a3dju9F+ckWaxaHqb2QLM3m7/ZAcfIgQDjjRncgDNisuX+CnKp/amq35UkpJ7Ut9sUrIib0+GKm5bLIyKn/Grp3TwMMQbmtPtnw5DpI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I3Da3PYI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NDCDex018700;
	Fri, 23 Feb 2024 13:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=phLbPYszYOhRwI5w00p7YYEeuvJ8zl+7D8r/87UrSnI=;
 b=I3Da3PYIf4qMfuPp1hEYLV1SSDL4TYFKXiS4aKuH6Sw8444s2wQ7sGcaG84wFIEwvQ20
 1oZgHL5o/LhreO3On6eAklK/Wqws9QXyXU0wacyYn0Hogm/oqSmrFzYT9u0UJAj3IGV/
 DdbCKH4EZ+iZDpCmSzDrqZa5MB6Rhz2fMo1503CqPE6BOPwfLdlJ4vTU/pc+OoEOrvx+
 FfSu22YTJevnNlhwqW2WmD+JlK5B6EBQCQqDc93fh+FNCa7m3UIYk2FiJSXx22UudUqV
 ifhyfN6Lom2PS2zwhWd2pbozbPzTCs6PU/pRDhwE2yaP1hIk4OmSWtJehOEq5TCP7J6Y EA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weukuh6uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 13:35:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NAd5QN013470;
	Fri, 23 Feb 2024 13:35:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h0wug2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 13:35:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NDZYkY40370576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 13:35:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A7F62005A;
	Fri, 23 Feb 2024 13:35:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECEB02004F;
	Fri, 23 Feb 2024 13:35:33 +0000 (GMT)
Received: from osiris (unknown [9.171.74.183])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 23 Feb 2024 13:35:33 +0000 (GMT)
Date: Fri, 23 Feb 2024 14:35:32 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240223133532.25637-A-hca@linux.ibm.com>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223-delfin-achtlos-e03fd4276a34@brauner>
 <20240223125706.23760-A-hca@linux.ibm.com>
 <20240223-ansammeln-raven-df0ae086ff4a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-ansammeln-raven-df0ae086ff4a@brauner>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -GbyAZmVhNeBCsCM6KPV0MUW5PJD4WEn
X-Proofpoint-GUID: -GbyAZmVhNeBCsCM6KPV0MUW5PJD4WEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=506 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230098

On Fri, Feb 23, 2024 at 02:27:23PM +0100, Christian Brauner wrote:
> > So you are basically saying that for now it is ok to break everybody's
> > system who tries linux-next and let them bisect, just to figure out they
> > have to disable a config option?
> 
> Let me fix that suggestive phrasing for you. You seem to struggle a bit:

Thanks for helping!

> > I think we should flip the default because this is breaking people who
> > are trying linux-next and making them bisect which can be annoying.
> 
> Yes, that was the intent. I probably should've made that clear. What I
> was trying to do is to flip the default to N and fix the policy. When
> that is done we should aim to flip back to y.

Ok, thanks.

