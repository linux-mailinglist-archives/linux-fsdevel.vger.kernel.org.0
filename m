Return-Path: <linux-fsdevel+bounces-57114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F40B1ED11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 18:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2387A7B01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1589B286D74;
	Fri,  8 Aug 2025 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2PnLtUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E528E25228C
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670934; cv=none; b=rrp1nRYkcGZ3yicE0xmmgA1eHu4lYo9J6jT8ujtB7pIx5OlRA9S29K1KG8ut1OVo/m9ZZ9MsIlxSUIp5SA4xCvPwUnrAn3DbsqAav+fOguQpG4bkdxHaP6smBLdQumwQlROSw+9cJuEWqFOL0GKm655Y15SACeL9ziDss6zbzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670934; c=relaxed/simple;
	bh=aOccXo9yYpAaxBGY/Mshh1PlyX/8uz6oGOWJ0S7XK8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CowvUl8x86sSP4r+AJzSe7XyFfsKBxw4raY0TpcpkpABg+I3jNnwTJZAXzeQ4ml/GfySOt65gede09O4kF5S3TmMr7SWux6GWTniQKFvASvCfB1NjDYGUUMv3JpFa7toSMRfoa1/8dI/buRa4lM+vPv9KIrPC/iA8L8DAyLHNP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2PnLtUX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af925cbd73aso461182366b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754670931; x=1755275731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLK7E2AgdjG9Mqu9sTUCxyiafe09MqR8lXee9lQry4Q=;
        b=J2PnLtUXxuAwmPWFC/YklSQL4j0mFG7AKBxejvohuNnbIB5u5Cg0JB4Uac5vicTUib
         YZqPkxweNWFoU3TiIiOc1Fq01njM3j3ll+wu9Wr4GaK46nT8Wpp/D8AXnJyG60uuG/Ef
         X6TyveSXYettm9rSiAZRSxUycpVgFxqejoKSCHdJDBKbthLdFyQAgPaXulETbWwMRUhD
         mhBus75pV3aGQfixTq8oqwOKZgELSlA48TeathoDBCUMbrQL3vFEQ2COQAGc/g2oWFxY
         0jYbv4ppdC3MKLWUDXedaxGA/ud1Tjfh1TLNeZJEOdmYR42auzLwQBoWi28yVfUjpA0G
         aO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754670931; x=1755275731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLK7E2AgdjG9Mqu9sTUCxyiafe09MqR8lXee9lQry4Q=;
        b=MK267/YfUMtb5vX+lmknLJE115LT/B4ojmIF7r8yBB6VcwgwbfWMAPQaDcoYQp4+3i
         ia1TgWTTT8fnxuO69TayUEBsjeem4rsEDlUNE4y3isvuDVBsaRn1plrRJM51Y2qqFp4Q
         F2IXWYikhVRtXamyRFXKc3diU6UmnjroOsILLotTlIrNeG1BVVzDlphuuYPpF8xvQeuu
         vDP1d1ZKT2hh2glijYTQ1jZ8hg5r9a4+djPRbXB5RsCvJnznvM5BGfVibwGE2egRUoU6
         jrXdOPd2gtZvcY2Es7IByHwKve+sGLFb2N62jrBzRB1B7urZKKljx1vfhk248RHxlu4M
         XDqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVvDxmZN8fF+cwLgoqOjFJLFVtvV+qGqcSi3njQndI3D+/urJWrPWqQuRA8eb7CUBxli62tK3N+ik+RwKV@vger.kernel.org
X-Gm-Message-State: AOJu0YxMz7JWayB2bxE6VhFEE/kaAvNxSAqdJ0Bhsl3T+h2BmUygHRF9
	b4xM7U0dtHAONLYYANBhfLQFIjPszHViC7WR8jsFcPL0pGM7hAhP4jrAeEukO+8U75QqDCBj5YU
	smkiZ4Zh13vhj/H5jctrct4HqsQ1TmZ8=
X-Gm-Gg: ASbGncuH8Tbg7okAUywUPXlHsDPjDINsYjnS/V/r0MlCnH88MNC0IvjQ8nmFZhwRsEh
	P2bRSu//s9Nh3YK89WsQ/Wj7ffRSC8w7b/GrlckscANg9jCIC6XDP6+zlShNwW6a/tcSx2R5/pm
	U4ihvI5jbB6gvi0f1x8OmRFMh+BEqtITVKmctsD2b1+yzuNdePSyslCff/J8wiPJKrK9ndn9EDY
	M+HnDE=
X-Google-Smtp-Source: AGHT+IE6aOHLq7RCXJk6Ln/ZdnhbJ+imkAEhmNJ80LIxgYfTuGY23xaY/pxlWlI2thH3pDVKqcin5AjwA69SaSGvdvI=
X-Received: by 2002:a17:907:6d20:b0:ae3:8c9b:bd61 with SMTP id
 a640c23a62f3a-af9c63aefaemr287563466b.12.1754670930775; Fri, 08 Aug 2025
 09:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806220516.953114-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250806220516.953114-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 Aug 2025 18:35:19 +0200
X-Gm-Features: Ac12FXwvhJPn24nENlaalZzGrByf79Fv1SSphccfreKChUurI9_tKVjHdNWL1og
Message-ID: <CAOQ4uxh++fiNg7QOimAqLTMe_Y3vbBChRH-fwhqxWHaS7SfUZQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fanotify: support restartable permission events
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 12:06=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> These patches are in order to add support for restarting permission
> events which is useful for HSM use cases which are backed by a daemon
> to respond reliably [1].
>
> In terms of testing, there is an additional LTP test attached which
> exercises releasing queue via the new api [2]
>
> [1] https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6b=
i44canfsg2aajgkialt@c3ujlrjzkppr/
> [2] https://github.com/ibrahim-jirdeh/ltp/commit/ec38a798b823954f5c5f801b=
006257ff278f523b
>

Nice test.
Gave some minor comments on github.

I would add two things:
1. Test close of control fd before queue fd -
    Read from queue of shutdown group should fail
2. Generate two events but read/restart only one of them -
    Read event after re-open queue fd should get the first event not
the second one
    Second read should get the second event

Thanks and nice work!
Amir.

