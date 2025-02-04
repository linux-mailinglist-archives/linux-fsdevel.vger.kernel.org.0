Return-Path: <linux-fsdevel+bounces-40691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1C8A26A27
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 03:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0358A3A66D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 02:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC2E14386D;
	Tue,  4 Feb 2025 02:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTFnzIpp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAB200CB;
	Tue,  4 Feb 2025 02:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738637062; cv=none; b=K8f09+6jAWu25zJ2RqrVr6wOnc9eil+T+pUIvB21cFdMalpNzC8O/Lh89uQbpWapuw4eK9FEi8Lpi1wVD07QLJ3plKMcj7Uz7gVd2HvbGoImnSqlVlIdUPpvQFJ+2Ks768sEjS3Wq9akjh+CclWoQp4aBcB7WePkiBsibn30bWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738637062; c=relaxed/simple;
	bh=Glanpff95vQzVMip8aO/lmyFWW5870LbGQOGXLTzi7c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MPiYRM1Ixl7bgGs/DVxF4FgAqg3GhNGBMaKU9YT9RRe7gf3VxCJ6FT0MYtWA/NepkmUytAN5zFxu0tJp2QNfLwR1zhpqqeZmGwqIFC3zjklX5apkfkNVyhsBCL63/6gaEdtjsSQ7fkfRwRfUMpLo3Zv87CAvI9toHI6g7lElKIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTFnzIpp; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eb939021bfso2358393b6e.3;
        Mon, 03 Feb 2025 18:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738637060; x=1739241860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Glanpff95vQzVMip8aO/lmyFWW5870LbGQOGXLTzi7c=;
        b=NTFnzIppbDe9/q0s1V5TRvMf/59+VjqJhc0yMnSqwBO9N5pv9iNrE6gx9CAX2nFLij
         Ua3sdHfxMFBGz1sllafSRzG6Vqd+yDkX/it1GeMrx4GoTaQYZptejpY1oaP8rT0uNJic
         7N15ww+fYWxFZ0LHIdEpRZWLfpGf5x/KeBbbUVbOiz8y02I9lIc0BRWhjL8LG+kdB7wo
         GNIjOWcDRMG//x16PrWy0gXiEDqCgd09M7ULPpDNKeFfQvhaWnCCOOHY1Q89A3f6dGx/
         uAXSDMlcrlI9eQrkUoKm/oa8a9rTVgR3ejEthPLZj35UG8Jhint0+2u/gOcTVI68AG+c
         EKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738637060; x=1739241860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Glanpff95vQzVMip8aO/lmyFWW5870LbGQOGXLTzi7c=;
        b=ZRCZ5kXwbF8JU542QA+0iUCqajGYJCO4IscwA7JDeKNzzrT82vINitaOuGguUg21PT
         xePypWbCGA8QBRRY1N+c/Vb2b6pmqftJsSQ9gqNubdOcXFPm8QrxcFGrJ3H8JiKypsOK
         tFo+c8ZiBVa/iK5poLDb3Uedk4bycz0y89FNabfbq9wUV1fgOAwzBQFN7NTEwZ5iEe6b
         YbN/0NlkFCC+wRIc9DIWjrUghjjdXtiRCiOrllbps9BTNGyewj4jbyVbKHuxZlkdFVzh
         EiXYvMgza+tBLqUO0SnR26ZIx/vrsn3vVtUxLzIvmoXVOg3awZ2/qcu+tbQNoiSQy4tH
         YvUg==
X-Forwarded-Encrypted: i=1; AJvYcCW+FrEQsS4lYF2Us2mk4fXNBIUQlsQpqjVzMbNYcr/CZwIdiDo5MLtn9vwinlycKNmBtQk=@vger.kernel.org, AJvYcCXJHO1jl5XcEabsp2OICFBjxzcR9kuVMP6LQNKp5V+LY8ZVzdVPApQAcETpyi6AgWsImMSSsMp/3XTCvZweOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl6J7HppkuW+Wh8dvrRWfAuhLTfYOBxVlofh6ajf7zYbmyw7vr
	VLwmuH2RsN7I/poIeZb5RpLzDo9BU/j7L/MXl7or6pai5Qd81+1bJ6Ho+8zUS2WjmOggKrl57Uo
	evUJ3G6nAQAtkYTFQbFmQ4M8QW4k=
X-Gm-Gg: ASbGncsi7HQxdUzqvMTgAAjJrBPdvBdPXwYluM7E7Z++ENs68LGfKldL0pMNVHRk8sP
	m8jssrsY0BMo3gmkmE3MWRqzGx6nOXQ/mNsqtlTZLmHjS9pw5cgnu+53mi+uxmyxij2Uj4vBhSj
	hCQVFGER3dXt/JdeVxXMAWIWthkCW/kg==
X-Google-Smtp-Source: AGHT+IHOgQJXQSZ9jWo+h9SCRdfzLjJXoj310pYAX+1aN/PS2dRu/J1lBt9JeovhFZKSaoKeK4G1QnV6ZNzcxR2sCik=
X-Received: by 2002:a05:6808:1a2a:b0:3ea:64cc:4954 with SMTP id
 5614622812f47-3f323b2577emr17790248b6e.35.1738637060077; Mon, 03 Feb 2025
 18:44:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aryan Kaushik <aryankaushik666@gmail.com>
Date: Tue, 4 Feb 2025 02:44:08 +0000
X-Gm-Features: AWEUYZk51vUEhdDA62v6Ss40NReWsBosUWIM_FnRvrGBK40QaBymEaN9fsRTOls
Message-ID: <CAHnJ_vh6_EF-4N9ARvp9e5B2VXY-jwAnV+KhpUvfzP7j=Nx90w@mail.gmail.com>
Subject: LSF/MM + BPF ATTEND - Topic 3 for discussion
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Team

hope this email finds you well.

Topic: Integrating Persistent Memory into Existing Storage Architectures

Description: Persistent memory bridges the gap between traditional
storage and DRAM, offering high-speed, non-volatile storage.
However, its integration into existing storage architectures presents
challenges in terms of data consistency, access mechanisms, and
performance tuning.
This session would explore how to optimize storage systems to take
full advantage of persistent memory, including filesystem
modifications and hybrid memory management approaches.

My Contribution: I have been researching ways to optimize storage
performance, and I=E2=80=99m particularly interested in how persistent memo=
ry
can be effectively integrated into current Linux storage stacks.
I=E2=80=99d like to discuss potential solutions for data consistency and
performance enhancements when using persistent memory.

Please feel free to share your insight on the topic.

Best Regards
Aryan Kaushik

