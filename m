Return-Path: <linux-fsdevel+bounces-72000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8CFCDAD34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 00:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2025930262BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 23:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47562E62D9;
	Tue, 23 Dec 2025 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ9E3An7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345A289378
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766531776; cv=none; b=EryJJhyvR92eCaQXlvxwqYXqsJpnT+PA4wUFtSC2E+GkZVJzB+8LEFv21196lNP4eVSvGoKR3GXyEkUV29QbfObFHMFTKo8pidyE1pV25EZgFCj3MZsnuRw1EKk8cgwz52L7qwFwOCCLeWE7suy6pUVv5B8aOFBaV63LjQHgl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766531776; c=relaxed/simple;
	bh=7HtS3cbUYFQbR5TB4PWBGJMujtQutmHG+tQIIsV7P6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPEpU99htl35C2eGHsA5yMvl/O+P5v7obgv4ec9Id41OumHUqiaE9pheFGsYKRV+SGcShPDOa6ONV5DmQHYqCDfGtH4WD/lS8sDstfPEyrRXbP8zJ2ZRN0b8cmIErBZwlIFED5cdQmzUxByQEs9EKPRlR7zeOfcSEzdf+IQbCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ9E3An7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee1939e70bso53662941cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 15:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766531773; x=1767136573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSoAl7bmkFBWbm2lzvgR/QrN7sSc2bfGq/BBEr14rkI=;
        b=DZ9E3An71ibSXHvY6p9b+YchjNxya4WJDTF0wWpwe2885Lk2n4ix/YBRllf3QdOUfg
         GW0w8Wk5UWct0X51+sy/60/ndfHf492YIj+yQC6LS/JA1zZ+K55vgDOZAxtfYZaL7kef
         GozEzlMvHHgZxeYaSBRbTrBREGMTnG79sd662OBGKL0WIjhhHKoP/q3tJpS+luCQBZ8C
         KGchkX4OMjlfTuCme/zaHM7bstPfyCctz5N9BPwMD/Sh56yIFvO38casWmLqXvh4Rb/B
         JOVwY7v2gEEhY6ObYiKXfOD4lN+C0mkVqCQzqguI0j7q6GcIzihYe+YxBy8xfJP1Rmoq
         Ns4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766531773; x=1767136573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSoAl7bmkFBWbm2lzvgR/QrN7sSc2bfGq/BBEr14rkI=;
        b=Ub5laizPOczrsTzqByQCIAycXu/4/eo5DE33ta9857P6+Is1IHQM1cmQP0rsbGFS8w
         9w5PO0/hIbiW9fTTW2Q4Koo8J2QNFVl8cHC84s75OQQWAm7kD99TU7P2bWN0TXNAKRug
         iQdxEZ4kYQrfmiKPaPVdqlTtJMkmmrmtufsFckCdOQh1RvHqqDkJ6Rqqi7ucIllmSPZ6
         xJcjdRF8j9rlX3fl4NqhEb8cPKMAXOx3qVdO935aEmd1iDrE3Lv4eMZYzTReZ/O4UkzN
         j2nNsXukZvaQNhTRSwumZ8M5hE480velP3kKwsjp4oggQNvqN0z+cjHcSpkGoCKpS6Q6
         f6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOMIAgxvkIt0sffYeQ8aIkCMYWTdZH9EG4Kwlch7rXnxwlJFqJOyaLsnUVtAB4IYxfhIssmDZabRXU4mTD@vger.kernel.org
X-Gm-Message-State: AOJu0YylvnYLWzTbQ8bwzdKIM2yYjYIp0hPFC1qoEcwEZYYtoxL7Rgia
	V4sB6Hwymd4NVNdivwG0A5e2yJpGuHTQqkTGIc+2AhuA+dYDaiU8RK/Wx+4/qYs8OeYqj3vK0TP
	G/oB7nOX9CZxP68C4KfQkSfXtazD+hSY=
X-Gm-Gg: AY/fxX49jfagRuhbcf3sJ6xGpb3NuQoFxpm97DuTh43GyzK/K+1yQsysJzAITtzFOhB
	ufctamXw2Rs/Cn+fsDPi03131J83ppglLQaDEzYHU++9/YR3H2VcUUWBPUdRbLbfv2nzPQC11G+
	lJnvrUR2k17iTqaQASFn9h8uWwAiSodn570Ow6T4N/F8J6RBmbUalVq2ZIRAdIEv9wiMJoUogHE
	9UVeKhU8hMeH+EnCXyqt3JSObGbDcMzOse0JwTDQH0W3zhhDHL/pUgqLlvLGFAKwS0Vng==
X-Google-Smtp-Source: AGHT+IFI8Jx9SVFGrh6F5DEH5VcrmbQyslvLB/aCN8vn1DrQooovLIgGcRc3MQ4q8QEcAxqVrR/eTUiCic5peKyu0nc=
X-Received: by 2002:a05:622a:4a12:b0:4ed:6803:6189 with SMTP id
 d75a77b69052e-4f4abd799e2mr262951351cf.53.1766531773630; Tue, 23 Dec 2025
 15:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223062113.52477-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20251223062113.52477-1-zhangtianci.1997@bytedance.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 23 Dec 2025 15:16:02 -0800
X-Gm-Features: AQt7F2pl86WHzP_gbut-XIdGmOaBWfPE8iqFS3SPuDeNQ8ksgRxCzOTsKUBFGCA
Message-ID: <CAJnrk1aR=fPSXPuTBytnOPtE-0zuxfjMmFyug7fjsDa5T1djRA@mail.gmail.com>
Subject: Re: [PATCH] fuse: add hang check in request_wait_answer()
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xieyongji@bytedance.com, 
	zhujia.zj@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 10:22=E2=80=AFPM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> If the FUSEDaemon fails to respond to FUSE requests
> due to certain reasons (e.g., deadlock), the kernel
> can detect this situation and issue an alert via logging.
> Based on monitoring of such alerts in the kernel logs,
> we can configure hang event alerts for large-scale deployed
> FUSEDaemon clusters.

Hi Zhang,

Does setting a timeout on fuse requests suffice for what you need?
That will detect deadlocks and abort the connection if so.

Thanks,
Joanne
>
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> ---
>  fs/fuse/dev.c | 46 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 8 deletions(-)
>

