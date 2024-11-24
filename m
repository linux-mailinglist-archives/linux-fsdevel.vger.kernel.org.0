Return-Path: <linux-fsdevel+bounces-35709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779FB9D762C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 17:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A6616503D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF3118B460;
	Sun, 24 Nov 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFTPN0cP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17AD2500DC
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732467244; cv=none; b=PVXiuyiiEqk++Wqs+Kzk/WP5/9y+tXPYxbgr9eeYan8qVCdjsdej13FxwjGltbkaUY0zErPPzeBRWpJUlwTfPTWH9vOwMbYvf16Eg+u7xTpm4VmEtpwNYmCaZpmE64D+24OdEBzK/FKs/c3wzPmiq0gfchMUvyqKyb/1qJpi3+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732467244; c=relaxed/simple;
	bh=lQw6qbfeSuIFp1VgZ+y1Pb6nsEXKRdeDNyilF55naII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuP1k5jM3DnabdmeASiZPKIapudTBNCZiXpkC4Ec6BZYBmP054ABWMSfhBcgH1vtZh9ak26bX5fQ2CwvjB2ny88x3j43HIWFMZiOfwifh/v+eEp1j5sbJxgAcmvUbyl5Fdhk/5Fdy3eun0f2RMPrff16rrY/gl6NUIZA3JUNhSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFTPN0cP; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4aefcb3242aso488075137.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 08:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732467241; x=1733072041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQw6qbfeSuIFp1VgZ+y1Pb6nsEXKRdeDNyilF55naII=;
        b=IFTPN0cPgOarHx4vcQw2yKgfgdb9ZC1EnH7UFpW9lfUjZK5qB3GwTol72bNSsgLB3a
         PMNgFVGy/K0HXfURYIZK/rJwwj059iSbfZ90AObcmmJvRaXouHbpIsCcTQ1P2CnndsBY
         Zmh3I2IAtyFRy/GhE9fdmV5pOYoMWtAtgnyp4UE5vTBJofbglhhYSTvMAxPPQMoBHCmq
         Y2McAPV+yEelQh9bO5S44Pyq9H5OEoillDdnNSvfPRjEQUUqqnHE6fXbOurggurYe8rc
         xnUZq+lypdtRiS1OW/fFO/t0CafIBrPCgBK1O+EZMTcrhypopyZl/ycHu67DTGl5e3cg
         2SQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732467241; x=1733072041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQw6qbfeSuIFp1VgZ+y1Pb6nsEXKRdeDNyilF55naII=;
        b=W6m03q6Q7ATXiAYJEwTFSQV4ETNd69MWjFvAczWdmR/N7gZANaH/HgJPHz9v0LPNMH
         RGELqCczTCcx8i299pv9Tu8ZeUfPZz3RAbG8iHyM3rPknijoDj6yIaZk1/9QN7dv4yC6
         oWiRnuTmiibhiJBcItdjKLQib2dFB/hNdruJDsIyo9NjXUsm8uDme11uovtHCD+bIL1/
         WuAKbQM4QdqWeqdkr/cnvVDq7DFEM7H/jyEYu2arNKDHglway5b8kBXRJ/28yT3Dr8sb
         COhIzH4J+aHGtxpD8Eh5mS4we+zjdbu71ILxcZ0h+j/ooDgIb534QUpibKe1hc2dz2iZ
         ixYg==
X-Gm-Message-State: AOJu0YydlQGe6OvrKixz2rKgWgFuX2LlRAG24JabiBnhPpCQLsHH1rAe
	lvDDOnxafW2JvMHyGJlbf3utjIJGKbLEsHgQavrTRJKOlMCrHKFmheKfYABVobVZiiR/eDE32wb
	DcJ4Bsi23cJuyq6WIgQOXX/aGZPE=
X-Gm-Gg: ASbGncsAK9NEWXR66xcDBtIACa66hg4rhnvvpXiSiOx9LzeGbVo91sfiIdYrBm6JtgB
	1tsYYS4KBKVDOV0piFJG6BvaNZi1CFhGFI1dnTi3NaqJKegqkgllOeAQhH6jnDhEB6Q==
X-Google-Smtp-Source: AGHT+IELxHAI7b2PNNusQtJiryVZsN+1KNWFWUlmjUwuWsI2NaUxNSNtSTOHrQiMFYT85yM0dCIlnhiwQU86Eo1CyVU=
X-Received: by 2002:a05:6102:3712:b0:4a3:ab95:9637 with SMTP id
 ada2fe7eead31-4addcbe66a4mr10161939137.12.1732467241528; Sun, 24 Nov 2024
 08:54:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122203830.2381905-1-btabatabai@wisc.edu> <b33f00ed-9c63-48b3-943d-50f517644486@lucifer.local>
In-Reply-To: <b33f00ed-9c63-48b3-943d-50f517644486@lucifer.local>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Sun, 24 Nov 2024 10:53:50 -0600
Message-ID: <CAMvvPS4nPawexGND2YCc_a2CPA6fCb31xS-+1Ng54fVB6h9hig@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Add support for File Based Memory Management
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	BIJAN TABATABAI <btabatabai@wisc.edu>, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, mingo@redhat.com, Liam Howlett <liam.howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 6:23=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> + VMA guys, it's important to run scripts/get_maintainers.pl on your
> changes so the right people are pinged :)

Sorry about that. I'll be more mindful of this next time I send a patch.

> While it's a cool project, I don't think it's upstreamable in its current
> form - it essentially bypasses core mm functionality and 'does mm'
> somewhere else (which strikes me, in effect, as the entire purpose of the
> series).

Understandable.
Thank you for spending the time to review the patches and giving a
thorough reply!

Bijan

