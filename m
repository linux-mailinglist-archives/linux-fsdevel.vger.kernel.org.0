Return-Path: <linux-fsdevel+bounces-16817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D8F8A3291
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CADF81C245D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999B4148308;
	Fri, 12 Apr 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bvaTy03D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8F13C9B9
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936187; cv=none; b=rSw0sKTcO5f8/kVpSAV1BAi6uSKIf08O4LUNz4t/hegVb/HGEza13rizvpX41e4Mz8Ku9m1UMDQJ3vR5tmreyFVb3KQYyBKoKsjD9/IAhTMXvVQj2vDNCKlgNHbK7NueXStPSgyi4xbVsCaNGr0QT9n2VDbPFI/s8YFt1zPh7eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936187; c=relaxed/simple;
	bh=zk6vSbvVLABQPy9qvih4/WpwqnOU2palNUl7YmxTXoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwTxaxkUN3tca3RIO63D9ow6o8msDQH3kqPNpcxXRC7904TLlbnCtmX80VSbGIHSpeCp/kJklzQ6imt/o150JuChYA8xjmWbYtRPHo5rhymA5+PcV1iEu7hl4qM8+UwKFT/0GJtEWGV13MXjdB7af3rylDEKTWZjIOmSlNLWV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bvaTy03D; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516d536f6f2so1174728e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712936183; x=1713540983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KVn7Thh2jHUPFYoXLOH9HKjtBO3lIRg/yTLKB6jzC4g=;
        b=bvaTy03DMYBuQtOdnYMsMppbIEQqDGZelylmuXqB2viW9iRz1eoARf2UNhHHh9zObL
         v6NMzSsA03ksrKv2NNVczfqQLoIr0SW7MFLOWUJuqWQwckZ+WB8w8bMVMFgTX1msBvXo
         kmQUhGjfn6BYDtbiSvpVlvTX2L059oxajkGCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712936183; x=1713540983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVn7Thh2jHUPFYoXLOH9HKjtBO3lIRg/yTLKB6jzC4g=;
        b=enHg0slt6bIhVqnCJTN0gPxsphtRt2uGy11gIbNW34LAXV8GDQ5qY5NWFeWhshv1PZ
         zNh8LR5wVPQmyLxDDPRFiW9DkGbbIjujW4v+fizFzCeCZMWF9fLwoXOOBpsP3vDF0D4+
         GBXlg9lfmUmOLRF4MzxuudoVHKHXryVF4Vj7uTh2cvzllxu2LAs11XPxL+cHeATUpHFc
         KZPQG/HFay2fi8gUaudorDMZuSXDfmkCYQxh4bhhqTa/2PGNunaDrsmJ8qkbZ2K9D0mF
         6/AY5S0/81QaSHl9LILddU3nKlxvoc6JvR27u3t5ouSp989CELWOJ0VMww5QxtIWXBnD
         b49w==
X-Forwarded-Encrypted: i=1; AJvYcCXG5DNKj6yE1plaW/n+/0BQKfT81+Vur2zyQIv04cgJPEiT4sm2435eWfuXzOZQAUQYpJ+89TeH446dZS4C/BKwJDW2q2gdl7kgjncspw==
X-Gm-Message-State: AOJu0Yytk3LjrcEi1LspTyuqh14ievzMH2G0cUh/6fDbbIOqWGHQA5iQ
	jHmR9iEXp4b+OfTMQ9UORVnfmKa7t8L1hscgDmKJhgh3vrETtImJpyMPzZrMQU9i6ltkCRV/BMv
	72qOEaw==
X-Google-Smtp-Source: AGHT+IFHj8noFbfIBCgcHROUA66bKxHllSpmizMOvd5XUsX9qQecVE5r/V1Qs9IrdU3RXX2tdRddIw==
X-Received: by 2002:a05:6512:312b:b0:516:d2b9:d112 with SMTP id p11-20020a056512312b00b00516d2b9d112mr2244184lfd.40.1712936182999;
        Fri, 12 Apr 2024 08:36:22 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id h26-20020a19ca5a000000b00516beafacbcsm545319lfj.157.2024.04.12.08.36.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 08:36:22 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516d2600569so1341576e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 08:36:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9XHzAebtycVr5+rswWJS60f5/G6yir7AXGd3F7dU/TSiqTKiWGMAT3RJRPyj/wxPmuO9mTOeTeR7xddW7zfzQqupptEYZVNO65oyMHA==
X-Received: by 2002:a05:6512:3a85:b0:516:d06b:4c5d with SMTP id
 q5-20020a0565123a8500b00516d06b4c5dmr3115635lfu.37.1712936181752; Fri, 12 Apr
 2024 08:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner> <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
 <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com>
 <CABe3_aGGf7kb97gE4FdGmT79Kh5OhbB_2Hqt898WZ+4XGg6j4Q@mail.gmail.com>
 <CABe3_aE_quPE0zKe-p11DF1rBx-+ecJKORY=96WyJ_b+dbxL9A@mail.gmail.com>
 <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>
 <CAHk-=wgEdyUeiu=94iuJsf2vEfeyjqTXa+dSpUD6F4jvJ=87cw@mail.gmail.com> <20240412-labeln-filmabend-42422ec453d7@brauner>
In-Reply-To: <20240412-labeln-filmabend-42422ec453d7@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Apr 2024 08:36:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuHY26QgDHp7yM5hVPOzVKO2FDwSHgNEu_jN9d2B_G0g@mail.gmail.com>
Message-ID: <CAHk-=wjuHY26QgDHp7yM5hVPOzVKO2FDwSHgNEu_jN9d2B_G0g@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Christian Brauner <brauner@kernel.org>
Cc: Charles Mirabile <cmirabil@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Apr 2024 at 00:46, Christian Brauner <brauner@kernel.org> wrote:
>
> Hm, I would like to avoid adding an exception for O_PATH.

Ack. It's not the important or really relevant part.

             Linus

