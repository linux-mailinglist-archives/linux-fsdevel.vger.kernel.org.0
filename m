Return-Path: <linux-fsdevel+bounces-29890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8C197F0B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 20:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A76CB22544
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 18:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB991A0705;
	Mon, 23 Sep 2024 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="db4b+/fH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27439FC0B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727116523; cv=none; b=FCO13ijyv01Um12Ja+Eh2TBPlzjNs3+Fcs0KP/aVM1+7a+ssXdVfTESLjplpdb83rb1799dI86lyIgkAoPLSxz8rrWi1GgWppHnB/XOqoOiKHO7hMgbIR0A8kpk5PwypF5THjGDTbLleGjeFHSQBaH2muRsf1vOFqJGkW3MSTRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727116523; c=relaxed/simple;
	bh=bwKRCg+aP9T6zO2Ie/7WKjZMIfPjESguBBWGJLZejO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJnANjLflP0Ubz80kKjyO9YafbNjy+IDagILydMhjlH7uXQ+7wYyNU0rW8fUsKZSVya7CK7u605/0HJ1Mg2KU5bBo79CyaO19J9tp1X0ZNF++oOBHpQUUW8DXCRwdOPfL/dSHsL3wOKQbwUhbWheT6KS7fSxNIwZYBXSHAEJJkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=db4b+/fH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d29b7edc2so705532466b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727116519; x=1727721319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JMHpSSP2p1/s64pyzSuk9VhdckGA7XV6OQbz+MnGuEo=;
        b=db4b+/fHi5vdF9atsVNd2ovqJOMvICuY3AFgjZlWJyXkg736xFp3dK13ue2C3iVHwF
         WWWqQVoty9eNMaL3wrjgsiTsVEMydXqugPZOWx/tVarBKraTryUh2K1WFLykXdX0PKNx
         o9vAsw/y/q4otSlZ+Jruox+Rtd03tVPM/so6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727116519; x=1727721319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMHpSSP2p1/s64pyzSuk9VhdckGA7XV6OQbz+MnGuEo=;
        b=tAGUcd5/QiHQ63gUq8tu3peyAHW1xKj5JhFdHXo2+FLYG9YZpfikGxr9j0ot7SQi2F
         naVtX5Nlm/N0q8TT3/G5e+Jaoqh0cYsd+o3Zw/qzoJSCw0HP8RtuBAzXCdMoYeCzOR4O
         ns1qugMlzqzfbCOt96mh6tP2IB+ue09pJ51WcvWUlgTSMWdFjCJbMtKtWyRKvhL5Tkc8
         SMQ4rAfVKzS2pX1/6iF7eg5qABOlW8ZP/2Rb+kaO2FmV6DWN8XbxfhIwRMyh4c30KKyl
         q/6Lz08QHomPtCBEbgQhU/4fvxmffeaf2PR14j75cqWl15ig3CMshCqeXE1NveAc3V85
         U5Jw==
X-Gm-Message-State: AOJu0YxGqXG/OWBivZWIt3NQNmfmvgORF2peSefM2CVMy9cpC+3DykM/
	E2b9f9QkWk6E4zt8cHK2rL6wgxjDP877T+OE93rd7uYjWc/EvEtP5naP9ioiwNKtCxJ35H50eGt
	/h+g=
X-Google-Smtp-Source: AGHT+IHXAebnBuzY2C5iXnZekPPlTbZrKt68Mg7SlBTBIQ0bUPT6f8CgiXzmmu43qC5iSzKKEk6wIw==
X-Received: by 2002:a17:907:7da1:b0:a86:9ba1:639e with SMTP id a640c23a62f3a-a90d5614d1bmr1243586166b.26.1727116518889;
        Mon, 23 Sep 2024 11:35:18 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b38b2sm1258173466b.126.2024.09.23.11.35.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 11:35:18 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so576442566b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 11:35:18 -0700 (PDT)
X-Received: by 2002:a17:906:7949:b0:a8d:128a:cc49 with SMTP id
 a640c23a62f3a-a90d57793f4mr1189115866b.52.1727116517712; Mon, 23 Sep 2024
 11:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923110348.tbwihs42dxxltabc@quack3>
In-Reply-To: <20240923110348.tbwihs42dxxltabc@quack3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 11:35:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiE1QQ-_kTKSf4Ur6JEjMtieu7twcLqu_CH4r1daTBiCw@mail.gmail.com>
Message-ID: <CAHk-=wiE1QQ-_kTKSf4Ur6JEjMtieu7twcLqu_CH4r1daTBiCw@mail.gmail.com>
Subject: Re: [GIT PULL] Fsnotify changes for 6.12-rc1
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 04:03, Jan Kara <jack@suse.cz> wrote:
>
>   * The implementation of the pre-content fanotify events. T

I pulled this, and then I decided to unpull.

I don't see what the permissions for this thing are, and without
explanations for why this isn't a huge security issue, I'm not pulling
it.

Maybe those explanations exist elsewhere, but they sure aren't in the
pull request.

IOW, I want to know where the code is that says "you can't block root
processes doing accesses to your files" etc. Or things like "oh, the
kernel took a page fault while holding some lock, what protects this
from being misused"?

And if that code doesn't exist, there's no way in hell we're pulling this. Ever.

IOW, where is the "we don't allow unprivileged groups to do this" code?

Because:

>   These events are
>  sent before read / write / page fault and the execution is paused until
>  event listener replies similarly to current fanotify permission events.

Permission events aren't allowed for unprivileged users. I want to
make sure people have thought about this, and I need to actually see
this talked about in the pull request.

              Linus

