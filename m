Return-Path: <linux-fsdevel+bounces-67639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E1CC4559E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE551188F664
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 08:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A3D25A322;
	Mon, 10 Nov 2025 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyF91dT8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CFF2512FF
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762869; cv=none; b=kPkSIwM5tsQHGJu2Vw7EbGnqVCuw4D0otMQKK+r5eVz8iP9liFKxafr+QgRpdQVCjR80o6TcCMVyuP1f0tb2jBYIVK3fKdd3SnwCFebKXQsgqzIHKNmLhJ1N6ps2rLbJuHqZuLkOzTOQLzZZtPBr3nIKQpOqMnzeR/zf9g2iauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762869; c=relaxed/simple;
	bh=aTPTAQn4ouWc2CT6r9voElmkLrZutSEG0pY6gt5Y6TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5g5A3c203zGshoFI46/Xr5NAPoyupK08J9Nq1LXvGkMGgqRX08tmV0b5lBUHNGG95zr3m7AOUnRGRhgVbQt7inl2zgxMGF9G7zxQGDgP4BEs+oyWTA5ILuSUuwxi3wEhHBJBubS6wYQk36IMqy7rd6TIpppQ2HqR8/XGw682Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyF91dT8; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c28bf230feso2845423a34.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 00:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762762866; x=1763367666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aTPTAQn4ouWc2CT6r9voElmkLrZutSEG0pY6gt5Y6TQ=;
        b=cyF91dT8OWSD9ITmgg9EG/AzERMnd/7D03awpdJOhPCcWe6h7tPi29WUqjwgbV2kAj
         GLP8Afzbk2VIItrcyjQInlFpGSW1Wg363H2ayVCi49Cg2msLPIAaB5zymhuYQmRXnhBW
         b3EqHEAXkDkAj9v9Ka2UoR9u4Wbf+TmmR0eIANb3wsMVngbqJwVat6E8RjeTZx068ww3
         YsjxOJEyI1IH7inMCVObuL30MyzzpPAYKJ4REJmZYUImSwJeKVDQAlaJBx9cSnlEq3Bu
         HhFQLmmf1LXtveKDAGOM/3R/ThgnWdlYMQ7nPTnItfnZDDCt7timLvULd5SrW6kYTZcb
         xTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762762866; x=1763367666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTPTAQn4ouWc2CT6r9voElmkLrZutSEG0pY6gt5Y6TQ=;
        b=PBiOyqv94HGzPqbVc00p+WVl+jQ09ye8Nn5QbEpWPgZ1quh7Lln1kUc4O3qWeLdBWJ
         1oCx/7GEB2EDiK0g/T/sbyDJW090InecVDymJNP1DgIGRxLvTc1opo94uJ5ebrJ530rs
         gi15b+H4+jwsWzecu38wr+ZDD1ynHTVL4fFN0eOIvxeQEiyxlW7IHIHabcBAy4p5kEJ8
         Bz+mDVK291Z0JiatPO8r85PJbpPzySX6GiajfJnR0tn5Qh7JJyipx9RD4lD2CNn97WTb
         foygusVBZCeSkgFlFpA6V98o90vPneDip0HTElo92kh1tky3UtrMrJkUUsgrOv1sjtTR
         q6DQ==
X-Gm-Message-State: AOJu0YxxaxtB1/TF7/1AeCWvimZAbmSxXWs+nmevl+dNHzFA4Ct9fEIA
	pRBvpnkO+ORsBaoMAAsWFEuxQr+Hx26EFUnXeyCd6P1+sXsS8oSm3aAq4lf12WkB4u6mPbnXp0L
	UoyGAzp5bakFjwPDeUsSGZpxWe+1YnQ==
X-Gm-Gg: ASbGncufejoV8IZfZnJcnGPLu7N4pSYbQSjG6u7Y5kiYJHLLRi9423CDi8f5kz62fQm
	+0Y+nMau3YGKoEhGqB7IkSvOpVleya23FaJ2Z15eyxolQ+oeE6M7cjPG6VIxEZtKqbdeC0SAp6o
	Jljz3fFIWpzVuNyI3OvkInoV6Ra8Vyr+edaG2THOuADEl1OUdw4UHsf4LMXxGoCVK6iXXLtsH8b
	/m5xBW6aw5QQY6E9oavpWG6vB1/A9TjbLh+ANPgJgS8elKvU26wov2OA6U+STWGMcW9hg==
X-Google-Smtp-Source: AGHT+IFQRzMclK2LZrlklR3vvFXP2j5BqTAtvgOyp55NCLPMq7f051KDAWCb7+DpaAQxglIBZqcda07ETAnrgHQHU+Q=
X-Received: by 2002:a05:6808:198d:b0:44f:ddf1:f238 with SMTP id
 5614622812f47-4501c55d866mr7052892b6e.0.1762762866187; Mon, 10 Nov 2025
 00:21:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
 <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
 <20250916025341.GO1587915@frogsfrogsfrogs> <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
 <87ldkm6n5o.fsf@wotan.olymp> <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
 <7ee1e308-c58c-45a0-8ded-6694feae097f@ddn.com> <20251105224245.GP196362@frogsfrogsfrogs>
 <d57bcfc5-fc3d-4635-ab46-0b9038fb7039@ddn.com> <CAOQ4uxgKZ3Hc+fMg_azN=DWLTj4fq0hsoU4n0M8GA+DsMgJW4g@mail.gmail.com>
 <20251106154940.GF196391@frogsfrogsfrogs> <CANXojcwP2jQUpXSZAv_3z5q+=Zrn7M8ffh2_KdcZpEad+XH6_A@mail.gmail.com>
 <87ecqary82.fsf@wotan.olymp>
In-Reply-To: <87ecqary82.fsf@wotan.olymp>
From: Stef Bon <stefbon@gmail.com>
Date: Mon, 10 Nov 2025 09:20:54 +0100
X-Gm-Features: AWmQ_bmIlbt9JkhLZwQfMjVNDJSXMctgRyy-4lDufTJXjUn6s7KKYIuO3wG6_L8
Message-ID: <CANXojcxBQ5XA16DcwYR2AANR-QaBuLCsudmngp3kC9RS5N_=WA@mail.gmail.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
To: Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I see this has to do with the name to handle calls to provide clients
a reference to fs objects which remain valid over a restart right?

Stef

