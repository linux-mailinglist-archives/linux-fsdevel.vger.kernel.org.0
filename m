Return-Path: <linux-fsdevel+bounces-9860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4838455C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0827F283B25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A70C15B973;
	Thu,  1 Feb 2024 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Svh1hjqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273461552F9
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784697; cv=none; b=bjcveHoEV0ONLDmEnqAI1EhF7s2r+FHO90LXf1ppqkPqzzxGfkRsUU8/epmb5J9h3IfJvyQ2lqUKIDJZSjA72vXoTBqHTYuAwHOJcMSJp5/XmXYzjz2dITPo9laSZvyxsoxsx9MnzX7TMPRRwGb4H7kUgUUtU8qvzMHlXC8wiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784697; c=relaxed/simple;
	bh=Jh8+dMq4Ya1+otpP6yjS6LBvjZqX3DJ2Awg8005EhlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfxx8sCK9q0lCZ5hz0S1iubR78LS3fFOE5A7NZbuL4+LrWiDq4i75q9C+lxsrDESj+EdxUo/RpC3Gq4uFOIoI2J8Q94oHwWCHUBGrs+SrqLXg6/tA9ntYnpM2CkzEYGJKU0EXg/OEAOZ7TzR2TGZ4xSEyUtOtKXA96c5sRr1FIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Svh1hjqI; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26fa294e56so104891166b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 02:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706784693; x=1707389493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh8+dMq4Ya1+otpP6yjS6LBvjZqX3DJ2Awg8005EhlY=;
        b=Svh1hjqIv4B5p7FJXNgDAWT+ykodTcJipC0sPt98mgVuhUOfuvyI2kFGMXIoROmMGL
         VkXaq84AlqyuM/GOeb0Mk+LSi/TWMoMrf6Vj0oZGsQw1SoUTWGXSXWBXnw4vUXfoup2w
         nEA5kOCMXyF9a8zWhDTK35zNJwGT0YLVhhiJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706784693; x=1707389493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jh8+dMq4Ya1+otpP6yjS6LBvjZqX3DJ2Awg8005EhlY=;
        b=gKHgbEoLyH8Gc+2uTx9n1ifHG79+SXBl3nahgz0nG259Gx4m7xs0obr/rMFwO4kOjE
         bHBdNbZvGPbse9oFP8r8GtrlLeLChnR80yPkUhrWBi4lAB9iviYaKbNH8XdkZpaRLVuz
         VuJA5NUZFmICRe2HBTbkaBZNovR+ALJTKUXs/AWdSzxlXYcW+hl1PFuqRL3jq4mXr9Oz
         X7wpqKaN0lqJbT9ffL/VvAKQBcHyRX+YRjMI23KNYgEHPf/9SHLrHrJeQVnxuBrvnSeB
         mF0OyCIVIsAYLGC/pi0OCJ8QSGb0P6Zsb8fasrWWnmH2WaHtsQSNbzIa9UpvGSKt+fYL
         2fXA==
X-Gm-Message-State: AOJu0YyTkTYAuXsGVfdiAxsz5y1bcby+Pg3klMCp7HdQP+Aq3DzBz4Uk
	7kIk1a3S6kQLLt6ieTRHJ2FyBH6lsbWv8iJAPwFtD2xNJ7dxvYcTJbbfwonhDxCZHpZN7xILMOl
	AGFbsDh1vrMCLv1RdCxDlInYfPcEO14g3WzSTKQ==
X-Google-Smtp-Source: AGHT+IFiKsuymxJdLOjRgM2YI4Auv6f5OfG7AHDmSJ8NfO+Wg96gTMypvaVRh3Po7QkYKNwcFO99ZVL0gUEODywNRzY=
X-Received: by 2002:a17:906:5944:b0:a35:a017:fb37 with SMTP id
 g4-20020a170906594400b00a35a017fb37mr3516105ejr.44.1706784693305; Thu, 01 Feb
 2024 02:51:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-5-bschubert@ddn.com>
 <CAJfpeguF0ENfGJHYH5Q5o4gMZu96jjB4Ax4Q2+78DEP3jBrxCQ@mail.gmail.com>
 <CAOQ4uxgv67njK9CvbUfdqF8WV_cFzrnaHdPB6-qiQuKNEDvvwA@mail.gmail.com>
 <CAJfpegupKaeLX_-G-DqR0afC1JsT21Akm6TeMK9Ugi6MBh3fMA@mail.gmail.com> <CAOQ4uxiXEc-p7JY03RH2hJg7d+R1EtwGdBowTkOuaT9Ps_On8Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxiXEc-p7JY03RH2hJg7d+R1EtwGdBowTkOuaT9Ps_On8Q@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 1 Feb 2024 11:51:21 +0100
Message-ID: <CAJfpegs4hQg93Dariy5hz4bsxiFKoRuLsB5aRO4S6iiu6_DAKw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] fuse: prepare for failing open response
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 11:41, Amir Goldstein <amir73il@gmail.com> wrote:

> I was considering splitting fuse_finish_open() to the first part that
> can fail and the "finally" part that deals with attributes, but seeing
> that this entire chunk of atomic_o_trunc code in fuse_finish_open()
> is never relevant to atomic_open(), I'd rather just move it out
> into fuse_open_common() which has loads of other code related to
> atomic_o_trunc anyway?

Yep.

Thanks,
Miklos

