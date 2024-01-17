Return-Path: <linux-fsdevel+bounces-8199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE4A830E0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 21:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02EA0B21772
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 20:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDEB250EF;
	Wed, 17 Jan 2024 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="QgC0I5/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC3250E8
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 20:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523657; cv=none; b=F9pi28gcsSeUfDNTIPxHchHWeSg/1aWpgh0xGM2dTUiFQKfOQm7S4ljelFTRnmS2qlNy5uZZGVVda3LB1tGFPhqRggM2A7NxGeGouQj1g6vPs2vSPafN2oByfPdEFN/mKEXMLTm3A5HLVM7LsYx2AvAfxhBJZNGqvMqzWu0iVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523657; c=relaxed/simple;
	bh=u5jV/Z2JAVNUMKsv/U91M3zXK/LfaOjl6RZ1V5K+KQQ=;
	h=Received:DKIM-Signature:Received:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:X-Google-Smtp-Source:X-Received:
	 MIME-Version:From:Date:Message-ID:Subject:To:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=KQKEtFFQweHtoKumUoRaLzaCesCCOCWx2VqX05ydKuLNXG99NUxeyD2adzBhEvy3UzLXv7bTl46F2NxaLCAFy7UtrQ7q84dKZnaIB9z8Q1y5CjqVW+uecYhjQRzquM4r95iuU27acCO79uBJBn7X1eh83EWVYbofaUi3UZM3MxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=QgC0I5/d; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HK0d94020468
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 15:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version : from
 : date : message-id : subject : to : content-type; s=pps01;
 bh=lcYhwFF5EvoQXBEXPoR0fblqi9AX0FfQN8cMMY2Y0W8=;
 b=QgC0I5/dA5sOkz31cpIVZIGUUiEQ/5dEoax4FflmB0Yoob2QMqLZDxPIpdoaGBdLcTLD
 ka2WES0fNUSSC8AX3O2wN2j/HcdBez9Lgz0ISDf/j0XFALvR39ethAmOBdp1HvMP0YC/
 3wpUAr9J6e+sByp2pdNk079HpHE87KwGHK5Xo38lXQoKcR6OglDePYod33DAbJCgoDe7
 Qsk4MiUiJHwCg7Dm+ZU2LZJv5WsyotH1h+Lkxcb3HlC/K+6hmP+cGSkTK1LYk0Mn8sXm
 M85+SNG3JSwTIuPaDP3+6+xNtsyrgovbEeecKXfEAt0F4mVFPygPjA09fb8erizgPfa3 uQ== 
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 3vkrbvj641-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 15:08:54 -0500
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-21098177784so1278920fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 12:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705522133; x=1706126933;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcYhwFF5EvoQXBEXPoR0fblqi9AX0FfQN8cMMY2Y0W8=;
        b=twb55/8k/NcL+k5Nw1kOrA0z+ZOu4k11PMFjEF/t1+jnYXsIj72yoH5LJUq0UQJVIX
         7EdocfB0YXS13iX5lvlTL1XQmPx4BwJMBQdHVt2BLlVuNoYD/TmbZ6vOMa4kEL0ZppPV
         9sI5cR9aYMsulCfBoi196Vhls6sB4ziDCTnykD2jzpL4NftnBvD04/aZa6/4sKEaBDZX
         AtPJKgYV2zcPEh4NU9yBwMzkGw3eq0dTQ7BGhYqqHTaytKOuYIBjQ7ntYERXjkMXwsrO
         qjqrEVZY2D32sb/gvcyJB+B6dUwGILLwaW91Y1ExD+xtM8WWL4dqcEAfaxRAkc6zIwF4
         l31w==
X-Gm-Message-State: AOJu0YyR3ov7T41el+pd04qgkwWWzZNcZWcWmJS/sDdUl1+sihDE3UbJ
	Z8pkNiuD6xhNwPKz9DAmUwwGOsTg/ZHdx78MdjDjL+3VI7xewj0phAs7KzmQQ6CMoupUTEydByy
	fHXO66N9zBsk92V5+vzVdThN1EujJvYMnCvafMtKdU5IgYiGcK8cgQukb
X-Received: by 2002:a05:6870:d8ca:b0:210:b1ce:5546 with SMTP id of10-20020a056870d8ca00b00210b1ce5546mr565411oac.32.1705522133165;
        Wed, 17 Jan 2024 12:08:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuUTZOr/+bF2e3qagDw4tzRa0jwLepywSobVGMEXiXOe7gjyQRe16dwTtNzVMDeOQTdAU3JVBczQqns3pFVzk=
X-Received: by 2002:a05:6870:d8ca:b0:210:b1ce:5546 with SMTP id
 of10-20020a056870d8ca00b00210b1ce5546mr565405oac.32.1705522133000; Wed, 17
 Jan 2024 12:08:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gabriel Ryan <gabe@cs.columbia.edu>
Date: Wed, 17 Jan 2024 15:08:47 -0500
Message-ID: <CALbthtcbD1bDYrQC6iNk6rMgBXO8LvH0kqxFh3=0nUdqm35Lsg@mail.gmail.com>
Subject: Race in mm/readahead.c:140 file_ra_state_init / block/ioctl.c:497 blkdev_common_ioctl
To: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: jvHiNypZp1LTYj_f3T_qhT_M6I17AlJk
X-Proofpoint-GUID: jvHiNypZp1LTYj_f3T_qhT_M6I17AlJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1011 impostorscore=10
 suspectscore=0 mlxscore=0 lowpriorityscore=10 bulkscore=10 adultscore=0
 mlxlogscore=708 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170146

Hi,

We found a race in the mm subsystem in kernel version v5.18-rc5 that
appears to be potentially harmful using a race testing tool we are
developing. The race occurs between:

mm/readahead.c:140 file_ra_state_init

    ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;

block/ioctl.c:497 blkdev_common_ioctl

    bdev->bd_disk->bdi->ra_pages = (arg * 512) / PAGE_SIZE;


which both set the ra->ra_pages value. It appears this race could lead
to undefined behavior, if multiple threads set ra->ra_pages to
different values simultaneously for a single file inode.

Best,
Gabe

