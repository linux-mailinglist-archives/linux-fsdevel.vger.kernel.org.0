Return-Path: <linux-fsdevel+bounces-8265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2B7831D8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 17:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002881F246D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 16:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC2C28E3A;
	Thu, 18 Jan 2024 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Z2APFrSa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A091E4A3
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705595442; cv=none; b=q+LUca8KI74Z8AA4aRlpoEXRhKLDMgU7m8Vx3SlZUKCYN1kqMCiQRjMum3EwWyE/jPQOssnoSOCD2ATOMIurXxebgTQfimmVFE4tQOQOQfInBQuLDf+rzEN6xpZxN35HS+J90yBvGHt8knZOSM6JW8kgtyiwSbmL5A1HrA6MGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705595442; c=relaxed/simple;
	bh=fbTolin+rDkiD0RIfv47IiL38YL0flqqLROv06u9W6E=;
	h=Received:DKIM-Signature:Received:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:X-Google-Smtp-Source:X-Received:
	 MIME-Version:From:Date:Message-ID:Subject:To:Content-Type:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=uRef9q6OlGZ0ZZ6JTX9Ym7oHHIAi4yqXMKQkcu4Chd9UDwadmF4HNL1bhK3m/wjD3n4eiJ0WIpA6CvAORpcUAGfF4it7T0HiKGtoQ8qZbS1RmkBjCU3VV/rDHSkxgU0IuqJFw4ICpwDuxt9EU+ZJL8HkcfHC6sBqZLKqlA3TsYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Z2APFrSa; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40IFjBWj002769
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 11:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version : from
 : date : message-id : subject : to : content-type; s=pps01;
 bh=fbTolin+rDkiD0RIfv47IiL38YL0flqqLROv06u9W6E=;
 b=Z2APFrSam1Dqm8iKHtHhCwQWrvfcfmpcWQhm46+v8eXnQ02tlMj+HSzpnvheAZu6iH57
 Wyv/lL8rDxk7NSs1C6YpLj2TKM8q/tT4DbtcEYeufaAlQ1FjX+zEGRFMJDGpgijRL4L2
 cYkcyeSyysXbejAQp23HOToZfJo4pVLaYrnTAdsXOr9JNAtpSUKD+gRoThQfd/kntBGF
 Fqur1s+HPHgX/al59R1Onla4qkYBYt6vA5nYH1P4p5L9AV5NPn+P23/7gewPPnuZauSr
 XfF3hUOEa2q7f6pAqs9a4BPTDrsZw+UUMJu+pormMv4VweZdF6jhO9y8HIMBLN5pb4uS MQ== 
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 3vpkyqr8xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 11:30:39 -0500
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-210b4eb9f65so724882fac.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 08:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705595438; x=1706200238;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fbTolin+rDkiD0RIfv47IiL38YL0flqqLROv06u9W6E=;
        b=UINvrHjBzqPrfAouI6GUG8ZNTZ5H4GZhqoTUP8q/OF9jjjO5I6FUF/57LO/+dVdg8/
         RNp/+katIstAD3UtnYNpSFS5BZ8CrsLThrOXXJG66fgkTFAtzuU1toaNthh0n6PwlbN7
         kIHAW5jlz+nJ6svWE72HTfqZXYXU6tOtRN1ypW4mjYF6DgTjv7Tc72jlcOArcnKLWRNX
         upZ8HkvGYq8HLg5CvAhizf9Nhv01eFrCbx8Hb86DqpfBrpgSXqa+pNwvH0yEnR1wZ/SK
         KEDQxs6jo8WpcJEUoumGGXpnthn3PqG9iWRXR5GOIbRPGuNQZavtAznCQ4WyoacSvPBN
         ixOg==
X-Gm-Message-State: AOJu0Yz6bOzCNBErGtvHqEA87JT4By91yUBYHQvP0x/yvNjx79m/22dF
	Hv9puXk0/wnIoej3n9ePo5f4bgcnMdAHKcWadi8X/u35MT/38v38V3wvEKfdwcXgi6+o+C6K5gM
	+2Yh4wp0u52rPtSPN4hMRGcBmQLg0cP5X3+F/qRLpUSU0kBFQ2B3f4sQ9zGmXLyNyKVAESkNxLQ
	iI35+xuSltLxgK6wVSiZyLfjtNImpYJboQIQ==
X-Received: by 2002:a05:6871:7424:b0:205:abaa:7cad with SMTP id nw36-20020a056871742400b00205abaa7cadmr1086891oac.8.1705595438521;
        Thu, 18 Jan 2024 08:30:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIaR8JgY6ceL1LEf8pcnw6hykbxZNDIgO8biYhKbsu0pHEzbefAMi1uBBsLVyQygrgt5i2dWVQAuZ2Mg0i+1o=
X-Received: by 2002:a05:6871:7424:b0:205:abaa:7cad with SMTP id
 nw36-20020a056871742400b00205abaa7cadmr1086888oac.8.1705595438313; Thu, 18
 Jan 2024 08:30:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gabriel Ryan <gabe@cs.columbia.edu>
Date: Thu, 18 Jan 2024 11:30:29 -0500
Message-ID: <CALbthtcSSJig8dzTT0LNkhYOFEZCWZR1fvX8UCN2Z57_78oWnA@mail.gmail.com>
Subject: Race in fs/posix_acl.c posix_acl_update_mode and related checks on
 inode->i_mode in kernel v6.6
To: viro@zeniv.linux.org.uk, Christian Brauner <brauner@kernel.org>,
        jack@suse.cz, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: BPRZsuF9Uf1EDsYucregetCOlgcoZ2QZ
X-Proofpoint-ORIG-GUID: BPRZsuF9Uf1EDsYucregetCOlgcoZ2QZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=10 bulkscore=10
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=914 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=10 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180120

We found races in the fs subsystem in kernel v6.6 using a race testing
tool we are developing based on modified KCSAN. We are reporting the
races because they appear to be a potential bug. The races occur on
inode->i_mode, which is updated in

fs/posix_acl.c:722 posix_acl_update_mode

and can race with reads in the following locations:

security/selinux/hooks.c:3087 selinux_inode_permission
include/linux/fsnotify.h:65 fsnotify_parent
include/linux/device_cgroup.h:24 devcgroup_inode_permission
fs/open.c:923,931 do_dentry_open
fs/namei.c:342 acl_permission_check
fs/namei.c:3242 may_open


In cases where multiple threads are updating and accessing a single
inode simultaneously, it seems like this could potentially lead to
undefined behavior, if for example an access check is passed based on
one i_mode setting, and then the inode->imode is modified by another
thread.

Best,
Gabe

