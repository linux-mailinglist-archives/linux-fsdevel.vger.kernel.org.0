Return-Path: <linux-fsdevel+bounces-33366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B829B8262
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 19:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048CB1C20CCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFAB1BD501;
	Thu, 31 Oct 2024 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pd2MXXf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF0B1A3A8F
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730398523; cv=none; b=tIa7f0eKm6kqUU3yNcmcIczdZPrDPAHboCbDmk3oIW3DZT9whSpk5EMR4i4a3snKHwHwh0B8/QI7mXxDoludJ9xqWA4tKEV9m3GNIsYnVuE6tXJnpPbFIcS1E2fQcb3HiDo+8EVmFfxDzzKucjxYX8kDz62uiiYegp5pvE+2AQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730398523; c=relaxed/simple;
	bh=fqVWgJOv0k4XgVLxS6Tj5qfFmrKQSFtS1+Ym5xPyhrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkEted0slDUpmEujTkd/QJaX9473wQwf8BMqZY1nM3BSZCd92uuFou65qf4vu85TGzgfubprFBiSKupuHxE6raQh6CtNiqPNh2sVfyOOpnnXM56EoyllIlyxx27bcyTsYSej8RWq58VgozhtTy0UPoSc0xkcWolQDMUM9Me8Sv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Pd2MXXf+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso186090066b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 11:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730398518; x=1731003318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1m+nKO3I8D++ZDJbn2b/ekxRG7Uqky4mghvI82yra8=;
        b=Pd2MXXf+hsjyxphvySoLB1pPxtoQNGXhK3ZWioii9Q/WZ0gp0ZhiDV3Q8YBT0EmLh7
         lAJJ0ES7UCYBU2zgsBpGGS7vphKy7uj7znvVCb9bNKxQRhn5E5iNyO4aNzybGBrMJXDH
         jvZRjaylP6O4SZWi56oDRzTw1wstl1LEtifmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730398518; x=1731003318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1m+nKO3I8D++ZDJbn2b/ekxRG7Uqky4mghvI82yra8=;
        b=jTii+lUwmEkHM+JqqtYtkzKgFMP5K1htUlxnp9VONT9ea0LajMPWfb+eomCIQMHWSi
         KAhSpUxZVweJ7mQJ14PatDkY4rbv8E6R1nzPnrw1Ai4Agc0ytYmpDlYkGPx0mbt2qrj/
         DgTlzuuThIXn3r4rbCkc4RGX3MQTngE/EHvqLRdo8A8gQcshlCaAPdTebWI1YNe+D17z
         hspzXrE8xRIJ/Wmz6HkjoqU1qVFSkAk+SkrBbRUm76yEwv7gncmYELRC7kfr1nQgZhAI
         xADmBfKwv17f32/uy+EzoWDU+hbcSp6bWFzBUNRiB7BcHomvGU2qzSFvcnI62tw/jdkL
         ekuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/47xN5bA6TtEq1SDnnr5zOkxtEnoBupuAAVvKegyZ6+tC7LPoRNctk3s1lsgG5T3CkqwPsABXPy5fSHrF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08+3xRCEohZ8Tc/xfzb4jmXjM94pkjWrvivwHDLyByyX4SNnr
	XYbgkRNuWBK9lBv8e0rHCTh1UQBf5PMV4T0HP5fnj+oXyegJPFBfbtNn0Xjcbw4TGcuouPjgK9C
	bqLw=
X-Google-Smtp-Source: AGHT+IHdQkMpZGuAw1nhLbdpu6bwBZxX9t2mXQEcGeUGi3Y+2nP2RpZ8pDORGzL/fNid9iN5Doz8dA==
X-Received: by 2002:a17:906:f597:b0:a99:ebcc:bfbe with SMTP id a640c23a62f3a-a9de5d992f1mr1994427766b.27.1730398518333;
        Thu, 31 Oct 2024 11:15:18 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565f75e7sm92538666b.142.2024.10.31.11.15.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 11:15:16 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso1472042a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 11:15:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxse/o5YVPlBub9BuIhI0rfZWOXzy+g8dTuKYNlSQJ6QAXKJgPh1q5A0Mj9p5UlecCjNgjvVhphokZkRvt@vger.kernel.org
X-Received: by 2002:a17:907:7d8b:b0:a9a:5b4:b19e with SMTP id
 a640c23a62f3a-a9de5ee15damr2147261866b.32.1730398516122; Thu, 31 Oct 2024
 11:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031060507.GJ1350452@ZenIV> <CAHk-=wh-Bom_pGKK+-=6FAnJXNZapNnd334bVcEsK2FSFKthhg@mail.gmail.com>
In-Reply-To: <CAHk-=wh-Bom_pGKK+-=6FAnJXNZapNnd334bVcEsK2FSFKthhg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 31 Oct 2024 08:14:59 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj16HKdgiBJyDnuHvTbiU-uROc3A26wdBnNSrMkde5u0w@mail.gmail.com>
Message-ID: <CAHk-=wj16HKdgiBJyDnuHvTbiU-uROc3A26wdBnNSrMkde5u0w@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 20:42, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I was kind of hoping that such cases would use 'cache_no_acl()' which
> makes that inode->i_acl be NULL. Wouldn't that be the right model
> anyway for !IS_POSIXACL()?

Alternatively, just initialize it to NULL in inode_init_always_gfp(), eg like

-       inode->i_acl = inode->i_default_acl = ACL_NOT_CACHED;
+       inode->i_acl = inode->i_default_acl =
+               (sb->s_flags & SB_POSIXACL) ? ACL_NOT_CACHED : NULL;

or similar?

            Linus

