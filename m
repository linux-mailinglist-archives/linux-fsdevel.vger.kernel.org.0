Return-Path: <linux-fsdevel+bounces-20811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E62D8D815F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC46286293
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9DF84D09;
	Mon,  3 Jun 2024 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFqJ7nOw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142DA84A46
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414617; cv=none; b=b1PRJxvVVhYYuFWDBfPL0tRBiBjnAISZNjCfMBzZhj1URgtbz3fPbJkwSQuGomBf+9fx9mQzBr6jbs1Fm5pdSAxAPZcHwmhTvX0W8YLvp/4GmP1qVZhstyhS+RPkxzgF4aY2ZlMxxQtjaSgwWfKfM5k2tlqbv+LOgkre7P5npFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414617; c=relaxed/simple;
	bh=leHSGBZFY/3tNnVguqx9FMBzFAs33EVxFCkg1pSt19c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QSIH8UiHOb0niamgWoBd9T7ySINqtcr/h0wzJ8kBfyr+0SNKbiqTkiYroYIoZsfuutFLtUafuTbLW+dak6OSGYrtIJlxSMsDziQ806KQM3vE36HA3x2uFCH3/WyCqidDStn+fjxVezFI4ytQfnchcgXyDrn+P22gSWmDDAkcN8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFqJ7nOw; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a68b0fbd0so522157a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717414614; x=1718019414; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RpxZ1GvjJrrp7uvwNsNOYjVUkFKyaCbzzA6LVXM95Uk=;
        b=OFqJ7nOw4ZS6QPtQE7jLwlcJ7oN2w04DKi64K4LJTorQtLn2vr59AHifUCUMBLClMn
         Np/ojvmWHxoCG6s1fMk293E/Srz0fuqUYszyvZHKyEvidAqGqCcm7X3BBDSC6YbTAW0C
         liu4u0XSsdo33XAAef55BTuOelVNncWb1pX7koOfdqulzey7VKODFsoD4jjSGdlj0X2I
         HBFOA2WYyQSVXbDNgxtbzapBnwXDpH0rM3VK8lWToS2vGejo9V4qNFYIV+ktXoKW1GWV
         YwrL64PHa91+vfN5q5y2f957dBCsYWOkqSs+BqQJsAfzIfeGwkk1GSYoP1ZgwmaeWAlo
         AQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717414614; x=1718019414;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpxZ1GvjJrrp7uvwNsNOYjVUkFKyaCbzzA6LVXM95Uk=;
        b=psjCw91FoUgqGm02DcgJox9Oxw0AOB50amYw66eKMeHaDitP3csJYAqXkHfgLfFteT
         XamPljQUipoC6GISTW+EaMUmORBrT7nJ6FF0l/46Tq+FQmdl9wLCJxDTIJPPU2f/C77t
         3Lzw53FVq3KTf2cMr5V4RZ9es5IFZNQGlxCejm/rjYmBrW1PMF1swVSIKbKvVJkRy9xQ
         eamMcne+ux8JptCCSeVuK6wvO2M9hU1fknnImz4JQr/cYdOsaqakcRp0+ArjZ6ur6w+l
         7FvC5KpA4zQGT/SPo8PfN2Y8AfrE+7A40tZX+KyDIPfgbBA94N243AHxaxosqIuHp3t8
         Fg/w==
X-Gm-Message-State: AOJu0YwUc3Q3gtrRLeYQlcWzEPmrrB1NC/EiJznsA8sW+GOPBTPZooP4
	T903D+6ngvXYOxED3Eir93dJwq55KKpb7GDza4Q8Y5vG/ouihbEqKBqXwr9tawjNE8VjEivfkJ/
	Z4y+q5zdy4Ji8+TzwPig2Agq/iyCO7w6xfDo=
X-Google-Smtp-Source: AGHT+IGuNM422X0w7C/TGNUPvE3e6/tP/rR1rVfzA1VYXeGA/7DrZxeRnmzbeQY236nU71edjEH18TLNTwALryR3u1w=
X-Received: by 2002:a50:8e59:0:b0:57a:2ab4:1c6a with SMTP id
 4fb4d7f45d1cf-57a364507d3mr6158486a12.32.1717414613766; Mon, 03 Jun 2024
 04:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Mon, 3 Jun 2024 19:36:42 +0800
Message-ID: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
Subject: Is is reasonable to support quota in fuse?
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, FUSE in the kernel part does not support quotas. If users
want to implement quota functionality with FUSE, they can only achieve
this at the user level using the underlying file system features.
However, if the underlying file system, such as btrfs, does not
support UID/GID level quotas and only support subvolume level quota,
users will need to find alternative methods to implement quota
functionality.

And consider another scenario: implementing a FUSE file system on top
of an ext4 file system, but all writes to ext4 are done as a single
user (e.g., root). In this case, ext4's UID and GID quotas are not
applicable, and users need to find other ways to implement quotas for
users or groups.

Given these challenges, I would like to inquire about the community's
perspective on implementing quota functionality at the FUSE kernel
part. Is it feasible to implement quota functionality in the FUSE
kernel module, allowing users to set quotas for FUSE just as they
would for ext4 (e.g., using commands like quotaon /mnt/fusefs or
quotaset /mnt/fusefs)?  Would the community consider accepting patches
for this feature?

I look forward to your insights on this matter.

Thank you for your time and consideration.

Best regards.

