Return-Path: <linux-fsdevel+bounces-26149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A1A9550CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 20:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB5B1F23BB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 18:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9541B1C3F2B;
	Fri, 16 Aug 2024 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pbny/DJ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127B1C3F21
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832793; cv=none; b=oszbW4DLtiWoCmHKjfY/oAJ3n1LuevDSUrjiTyw9U/kMH8Ow7ZBGc9E+6EVvNJF93bEcKVQng6YEPjfVx6vDm/9aelMMri0rflIvrGz/A06i0imbRwuydfkTRf64juDbNn/l1AWpbSI+wv95F2OxPwS/d4h7W42GoBiOirlgLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832793; c=relaxed/simple;
	bh=4VRY6Ev0EMB8vEEfu632WJ4VdJ2u8YfCKsflPPcloDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TELEEO+9fWkhCq4syPop19M3ZA1B98FguQ6/GAiUYrV3gfqBq+9myIpEknRDaw43LyoLltsV9bnfLaMcS4z0hOFZ4F8dK4gzJGTURFxZCXgf0wD95crkIIFjqpbCGuJNPFr1VPWm75hd4uiG6MxvfMcMP9sw0Cm4+fEBu4+5HTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Pbny/DJ9; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f189a2a841so22324171fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723832788; x=1724437588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lMjEIJUKp6awmOAjCbdVEe7k1/FANrERf50MN76C80I=;
        b=Pbny/DJ9Iib8wZyt+HB61rRssFbFvescu/HZapymdTdbt6eAlsYnkPkGu1usQqFBau
         lGu4ktRBrnL0MyAMKP9O4LP6Mxk18uGR0MOPemYyDNJL7Z15qi5/vHHn3MnRo1yvdUdD
         zhaGgwIUl6AwEGPubLBIiU3AVFScKPHvmxAIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723832788; x=1724437588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMjEIJUKp6awmOAjCbdVEe7k1/FANrERf50MN76C80I=;
        b=tgOtdduUVp9TpW55mhpUXksxNIEI6Iai9qgLm2j8f1J/aaAc4LEAfW096AnKGE7lop
         9UGiY2e+WqCbCsQn/47YoNPuAIRqwOLYk+jN4/Jy0pDcZuG5Jm79JyeIsemN3rbr11X+
         H/vKz69nknifjL6L1tK6AXrtFkgaSDOUgB6rD+7MnTP66Y+46Wix1dzuCbLyRUjGO2MU
         HpovX6At4Wo7PHyJcMIbuM7a/mGgQbVGL+6ohvBQZxX26juG1rcVrlC+MVnVdeU9suGS
         6fzNNs+FJnjHUHZ1JDNS9NDUKoBNNOvb9ONhmRw5mKFr4re77TBEHhVV+cFNf0nmIXR4
         rKzw==
X-Gm-Message-State: AOJu0Yx+hHTDRoYNVzgUkamiAKFrUfVBPoiu7xU6lUp1av6iX+4NQp6e
	wYY85Z6yJoEy+drz7VPODatE4e9hXiPq8KzImopnAIR3HQPoTYHa5Ixg5hZdDsGrWZcPftKKxmg
	NPeFFFA==
X-Google-Smtp-Source: AGHT+IGksA73I84vQALtTbEYJpe3sMlTtK5V08Q4wrMbkTTD2PPe5n7R9VJ2NNSNJMLihaOFgWCQXQ==
X-Received: by 2002:a2e:a582:0:b0:2f1:9a3d:88ea with SMTP id 38308e7fff4ca-2f3be5f4f1emr30253821fa.31.1723832787968;
        Fri, 16 Aug 2024 11:26:27 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3b771ee9csm6359631fa.122.2024.08.16.11.26.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 11:26:27 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so32373001fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 11:26:27 -0700 (PDT)
X-Received: by 2002:a2e:8705:0:b0:2f1:a5bb:b5ae with SMTP id
 38308e7fff4ca-2f3be5899admr24325091fa.15.1723832787024; Fri, 16 Aug 2024
 11:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816030341.GW13701@ZenIV> <CAHk-=wh_K+qj=gmTjiUqr8R3x9Tco31FSBZ5qkikKN02bL4y7A@mail.gmail.com>
 <20240816171925.GB504335@ZenIV> <CAHk-=wh7NJnJeKroRhZsSRxWGM4uYTgONWX7Ad8V9suO=t777w@mail.gmail.com>
 <20240816181545.GD504335@ZenIV>
In-Reply-To: <20240816181545.GD504335@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Aug 2024 11:26:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiawf_fuA8E45Qo6hjf8VB5Tb49_6=Sjvo6zefMEsTxZA@mail.gmail.com>
Message-ID: <CAHk-=wiawf_fuA8E45Qo6hjf8VB5Tb49_6=Sjvo6zefMEsTxZA@mail.gmail.com>
Subject: Re: [RFC] more close_range() fun
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 11:15, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> As in https://lore.kernel.org/all/20240812064427.240190-11-viro@zeniv.linux.org.uk/?

Heh. Ack.

           Linus

