Return-Path: <linux-fsdevel+bounces-62026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D13B81EB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57301C23F4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA1F242D76;
	Wed, 17 Sep 2025 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="iSOT//CT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267E523BF9E
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143979; cv=none; b=k2D/JS5YT8ryx/0YEVWD0jcvZEqRyjAPmeQj/LN0zn1uR6eNvjUfHssb1wU1va+EwgzkmQe8tNK8WJvdJ9/2y5Rg9IdJ00O0m/eglDAsqSVdtO9hNj9j0LuX9X3j6oC/OJIDBekQOOqkhM4WDtfTiaX+k415nUnOSfNLt7sttA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143979; c=relaxed/simple;
	bh=9qcl2R03KtNq+UmhO5wJsFOtjw5gkCqDNII6KYbvzuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3YNJlhUUFnA+SIR+Xgg9Uh7TvXXQRZT9QotSXNNqETAdGMu2CgvegNUedCLs2u7bJC/o/YThH7awfJITEPr/ocKiWn2jbcPuKZa6xq6u/X/Xn+SN4NAxgHNmQz/531bLcmnuwnaqjTDbjH7FJwQUcgjIH8r65XFzn2cPedPzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=iSOT//CT; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b07883a5feeso48017566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 14:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758143975; x=1758748775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djRf9vFpcYD+NIrGmvtw89De7IcIWa6+q7heNKofahc=;
        b=iSOT//CTfPGeVT+tehRDAAYmHzoYb9TdOdaGbh1rKK7J8IUw9FTXVRJ2Z2MfBbttgf
         TOFJLyfrT+FWGvZZubPkYpoW+iwQagvc6eJTp4cuDEf0BfCrt6kKt4gAEJ1i2OPeAbI9
         L1ugMKfNCY7REiTANx8AisJIFbzXlwDbdfoKCdl2aom8a3rPm2y98yUsXy8bI1JapNpw
         0CNY6ndahWo4p/Rg1pla3Uh3K6UMswAj22vmwXnigN83rgifULYGk111W1LmvDz5ZLJs
         WoWm3PXlVoIaVfDeUmXlPb0nl+tQKxOQkm2/2VqMuQM2BaYxpWvjpFH9XLuLhEb4/BWb
         eGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758143975; x=1758748775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djRf9vFpcYD+NIrGmvtw89De7IcIWa6+q7heNKofahc=;
        b=bOw8d26amrOliDS3sWYRs8g+kFy7j58iP6wiRHDo/7EQ9ojUvdtXFC5T9U5oE0kPaX
         K9UgCwwU99ItD9Y5nnddlplaconU5sklx522lB3GqMPXzTmmX6du8EFbrsqyRBtknqU2
         kifHumkda2Z3aBFwTsbibfOrxKBflpnGt1tfKhEdfmBzfa+DQgcEL83LXSKWaIHOvc6x
         7hPVDG/jCecj5bIXTBt8oJI8giam7IB6nN4CxDRA1386fL5jgM7IlbKeSfyMx7/zXbpI
         9yAhIQxSXm4RT4TQCD30vPoK16SIOSmOTxAQjeX31nk+viaaQcSzL6Cvva2AZna4jqGd
         5wHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVYoUAl6sWAS2aMcUSmDZ9kkTVqUqbj+LHiN8E7AC/1JmEPD+8DMum5ICwtmBxmNN78xuNsLCmxJctLSLr@vger.kernel.org
X-Gm-Message-State: AOJu0YxPcmAB0FhZoQeELqU45jXwwvuxXuaaH1vBK3cXwRw6Alp7aKig
	mAtNeL9N7keF9F1JMg1tTa2KlCxWi/u77aFu7dTrkDvcmDrSovnlly3hir4SYE0df94It99R6It
	e95VRkJ2WdgpWnJAvl/Qrn76L2rifD8LcJF1EhEwJLQ==
X-Gm-Gg: ASbGncuI3qvkFWnE2iAhmARTe3BsrUjZNBRtmWOgB0l1Dwttfl3Sl+z3vbXA2RgS6I4
	6JzRZLDR+++HRhaeP2MQrNZvsqCGwhN7/XqaUQh6MkEBE6EwDdIaYVCLuftMGC69xjnkfhKUqM6
	V2Bysmy8s1uO6AkaS6hYTcjG7+HRXT/QyrYLQSlFKk2/9GmDIR6Mcy3VhYFH7H7hOti4dtEBu/Y
	hOIFKxClxtSremEcti4KR+C6nNIFbsR/1gjXEOP63g6R9a+ohr8Dxg=
X-Google-Smtp-Source: AGHT+IFx0UdBWSFzYZQCS0rHKafbSNkZSpgCULmd3CeOoP1qT5yHjsnFa6vko92RxDrAUE/s9j8jFsO1c8h9Tuwiqu4=
X-Received: by 2002:a17:907:3f20:b0:b04:6858:13ce with SMTP id
 a640c23a62f3a-b1bbd49ad36mr433982366b.38.1758143975487; Wed, 17 Sep 2025
 14:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
 <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
 <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com>
 <20250917201408.GX39973@ZenIV> <CAGudoHFEE4nS_cWuc3xjmP=OaQSXMCg0eBrKCBHc3tf104er3A@mail.gmail.com>
 <20250917203435.GA39973@ZenIV> <CAKPOu+8wLezQY05ZLSd4P2OySe7qqE7CTHzYG6pobpt=xV--Jg@mail.gmail.com>
 <20250917211009.GE39973@ZenIV>
In-Reply-To: <20250917211009.GE39973@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 23:19:23 +0200
X-Gm-Features: AS18NWBuDJyrihrXYWVEdB4-Fs__rxwIrvhTfFiInfF4MuBKEbv8_ShZGxuvgzQ
Message-ID: <CAKPOu+-yOH6yzPEw1rayR1thO0OdPYCRL-CWkRTp9YFuHuRr9A@mail.gmail.com>
Subject: Re: Need advice with iput() deadlock during writeback
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:10=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> > Each filesystem (struct ceph_fs_client) has its own inode_wq.
>
> Yes, but
>          if (llist_add(&ci->async_llist, &delayed_ceph_iput_list))
>                  schedule_delayed_work(&delayed_ceph_iput_work, 1);
> won't have anything to do with that.

Mateusz did not mention that the list must be flushed on umount, but
that's what "incomplete sketch" means.

(The patch I submitted uses inode_wq, but that's a different thread.)

