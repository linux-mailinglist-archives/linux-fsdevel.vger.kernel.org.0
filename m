Return-Path: <linux-fsdevel+bounces-69570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED1DC7E46E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40FF74E221D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E508230BD5;
	Sun, 23 Nov 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J/gowLdt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F42C17A1
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763916221; cv=none; b=IPTy7s+TaiosP/0bDhPTQk0jTxfwt6+YvJYhQSBbPRvtFG7aqU97WD+2Q/QmRc2IDOTWFPFv25pB6NIVB4i8irIJDKXfls5PgmA59kjf6zJaUVSeyDSR4wYDOiDp4GRGq3U29x9H31ZftwV3LqnkU8MD1PUaYrUfd8yhJsbXScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763916221; c=relaxed/simple;
	bh=lF1yX7BPeQ+FFZvYi6KitP4igYhucBp4GAs3LR6E5wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMU91KDtGOSvuq0hXb5e9ixUPV7FLVpBrR+5GFeB+eSI2io3wyfevScUKA6I522gHH9g5zsxysj4e97H30rd8RH4kPFecUtYONJuyUKvlo8SzjA1i1UsvaxF3VcsHHkmHpfCAjbnSLmYnYiXVuNYo4PodHOCcF8KYbyGnnFTo+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J/gowLdt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b72b495aa81so426594566b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 08:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763916217; x=1764521017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yWpdlXZ259/u4pdPTnTwO5yBcdSnTTuMuoEyBfb1ZZY=;
        b=J/gowLdtwrZz5W2nCHf439OAaiPSyl+G2MdxEca3l28JJ5VS8dWYFI6Qd9tp4iNHYf
         6xXnaUpcOgrp1gE67vNHR5GBvoJULRn0wMU1KEU4eFZUBtC0NGbWSZJH5GYI3QwQab0x
         HHVSnNJY24LWgs4e9Ob8Lb0LrzUarf+rNRtOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763916217; x=1764521017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWpdlXZ259/u4pdPTnTwO5yBcdSnTTuMuoEyBfb1ZZY=;
        b=RAiSBsGN+u5l1jCU0xYs5u1G6+4zThG2f6cG7zYv3T/xTmO8P28DK7hP0ntaENdOLV
         C9P4SFoK9FxOVfkaRHlDfnHrLYuWC75TwvcECpMHJcGEzDok/iySUmAI3PIbpmrX5pDO
         ZRFy8UcK1eSO9kyjBwcVHWq5S7Oqx76sRCLAtrU/2KRYnwnD48an89lVxDGbjvjXRlLv
         p+Tn6jkmu5So93Cox58DKl4M0esFxUEAgNUHXc4N2TpPVhm38VzY5K+uBcS+tcPjTw5t
         OsReKbtMut4SKCxNXqQ/SsRUb/VVffD6D/ssScL+miINh/kog3t3uBacaLoSF5aMQk3y
         +BLw==
X-Forwarded-Encrypted: i=1; AJvYcCWUqzVTxFldV1Kn8ncWYQiYhpTh1fgxAlxlgyVXxw7a9cyRVTw2nxTYLPz4p092/dD2JvbdBe00Xc/JxR+D@vger.kernel.org
X-Gm-Message-State: AOJu0YwoM8DDbn8uaEvul9gw1ziigCmMPtZMQjSF1Kk8f3UHomlUNfDz
	8SrvCtg5faoHlj6YdEXX3baAl0a8D1MHB6gkxO2z1DKDppNDjR8+Gx8HEG0di17tOG55iLx0S6k
	gg/OmqRPd5Q==
X-Gm-Gg: ASbGncuP+JCFkcioWPxUYvHTWYmasGN2OgY+MAYL3xsGtVr56bcrvYDvsD0aPNc42g5
	Y1G/JC1WorORjbwfuQUGp5FcDGSbSbM4ZpwnIL9pu8XrytNK5EahHyoCKLlx3/yAO8SR+y8FLoJ
	A4bBhGosLfWSMQ4+kCMJaBRXuLtFGjBMp5c8xWLEa3G0y5STUW0VlP0YzMp8rGL+URkqrSrY6nW
	N7W7zEKn/WEUOmDH4oLQHafSaMYrsDjvhoDCsVHm1BD7Ef4f9esilBOd1QltAjBQAPtDG9IqaNG
	YH2esluGYVjVI/7Sk4rT/nc2MU0Pq2O38Npzm5rwg0zt8zk9soPQ5iE3GtgCZeDTGaOUBjuAPJy
	/0jBuBKQDi2O2Ab5KnBv0+0hzrT2HBgf9WoiavGuplO0gYW5yc03bQD07eo2LEXe8hiRbK3gUTu
	2ol1kIxRGBbu5R00e8tORnOp+rJNcINt7PHcssMrYd4PXWTfqWBwBuocq0r+L+
X-Google-Smtp-Source: AGHT+IEEKWUFLKjFiAkj3PYHVU9qPslG5y053Qxq6uF9IQVdT7bqrD8h2MP9MHz9SvQwhY56wdWtSg==
X-Received: by 2002:a17:907:7286:b0:b71:ea7c:e509 with SMTP id a640c23a62f3a-b767173189bmr1157799566b.41.1763916217050;
        Sun, 23 Nov 2025 08:43:37 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdab19sm1095451366b.10.2025.11.23.08.43.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 08:43:35 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso5365808a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 08:43:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4DI+wl5Yo766+IDFUJ0wd+0yrdTZO8iUHZ4DovP4Q4VnnrG28ljUcYgrdx8w210ZmGSXlH9VG27+XVU7O@vger.kernel.org
X-Received: by 2002:a17:907:3e25:b0:b73:6bd8:ebde with SMTP id
 a640c23a62f3a-b767186f34cmr1028571266b.53.1763916214684; Sun, 23 Nov 2025
 08:43:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Nov 2025 08:43:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLeBAXe+gOmv0zf+ZaD9a_gtL81349iLvfesXkUxYyWA@mail.gmail.com>
X-Gm-Features: AWmQ_bmIlEsuFv0E_0zetbVr4Que0UPUvWrFQ00e5vN6Slh9VimTszcz8-PQBOs
Message-ID: <CAHk-=wgLeBAXe+gOmv0zf+ZaD9a_gtL81349iLvfesXkUxYyWA@mail.gmail.com>
Subject: Re: [PATCH v4 00/47] file: FD_{ADD,PREPARE}()
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Nov 2025 at 08:33, Christian Brauner <brauner@kernel.org> wrote:
>
> This now removes roughly double the code that it adds.

.. and I think more importantly, I think the end result now is not
just smaller, but looks nice and straightforward too.

I particularly like your FD_ADD() macro. Good call.

So yeah, no more complaints about this from my side.

               Linus

