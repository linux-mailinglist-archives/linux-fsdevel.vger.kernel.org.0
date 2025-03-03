Return-Path: <linux-fsdevel+bounces-42928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE008A4BF20
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 12:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8206F3B916E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 11:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F885200B98;
	Mon,  3 Mar 2025 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Rk04cCGJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C920010B
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001943; cv=none; b=UhfUuR2OBF6PM32htscIMPZVMAcYE7pr4+/vrr8UNA3HZhfgDNBAZWDMbrfik64WaF48RL4rPI3Lsw1c1yKA21J08Kf+F6CKsoQS5SOxwvhjwZ9AjfoBW3a9xroziXKDpyyifcePSDunngGIGnkcAxRrtj+uDLwx6F/BRA4bENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001943; c=relaxed/simple;
	bh=yFEGX/Boe5p6uLN/h7SuSezgG5jUUZIsemHHwEUPmxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHzx7xWospD7POXWkBjThWcalPLDaKpmMo575HJ7yo0nl4t0JxbHhgHvw0tPszXa+fMDGaiogQR9gzWyUdWbSYgGzphx4LeKPEQgiiUK9P1yGPpLY2OIAYA462QfErduovfugZ+LHO1KxiSptYFuAOFoUruZpg26m2R9Gs4hU90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Rk04cCGJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47201625705so51937341cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 03:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1741001940; x=1741606740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yFEGX/Boe5p6uLN/h7SuSezgG5jUUZIsemHHwEUPmxs=;
        b=Rk04cCGJyqNrbApd7n7I79aU0n2/+jtkc8AcFQLjNt1wemH5wrPg/uW5vnBrBllWHl
         3bAxbAjO173JONbom/4OsFZBKwpGVjWESMa7G99tAg2Y7rrEKhQfG44mgWY5DL5uZbm5
         q5z3RXAh1uXNBKpBAHDg2Q58SjbTpULQWxEn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001940; x=1741606740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFEGX/Boe5p6uLN/h7SuSezgG5jUUZIsemHHwEUPmxs=;
        b=eLmB7SsttaySwToeL6Ulnv/+NYMkTURoZpbnpov1I8nCgiF9r+hDMJMj8nGesl+u5k
         70zAZ2j1bOdZaLDX6F5eK7S7N1tYELqDWq/e8Y58pVP67FNDqE1TfMyLM++ZC6l/TRYx
         VgOddLdqqRm2ZbvI/sMJGU/ZGibzwgsBHhDl6YrqR9Tk7EJ+CDDCggLa0vhnAxGLIB4N
         b6uO8E4wt4FuQY55PBzWu4/k1cIhYf8UPlQNjMgebI/PQTrVAZAKf3zN35gWt+qMmVaY
         ey9+PQzigmjDTgthrayf00XSn4TiudTX3wHXnihLLb3hZdukRe4zRm6Urep1rwvSAq8y
         TmZA==
X-Forwarded-Encrypted: i=1; AJvYcCUnxGrcLAR7iBaxiCGbgK0JUmq/jgYnIKw2sVPDW/tvFp6lmUM2d7oDIwVsG1wrBA8xzucJRll8qVQnpMoR@vger.kernel.org
X-Gm-Message-State: AOJu0YyGAsTVM0zfu2tes2Z9bfPicBK7PdSHLhTMbfcZHmm8TnLqEv9H
	BPT605iTzBMQcXBoJAuHoq7UvhsCfQMHYDXGBQQEWTJtiHGqjmQmz8VMinqp9os2MfDRNTlWeuf
	kmxI0VUMVMO8g8sU7SYATGnsyOLmpIHW88khgxw==
X-Gm-Gg: ASbGncuCNbZ2oGGZhk3HGcr9lZQ+yLag7+mGarFizVeoC6u1N5wnqa+D2vg6pgD7hSv
	pa1ZzMYBf5DZhVscM/jK+vYfFlXum8xJxcC3LSskSR9ycbxBJwIsDoaCIgbEjPdrclurqdEPzTB
	iF1fxOPB07wtOFbNBxTzGdOaZD
X-Google-Smtp-Source: AGHT+IGmN26J+UNpVjGIIblS3vz57jDcK/G1jlsdOfeiAxCaJ8WzfDxfS+SreOoKs4h1hDnsa/jTRKTmw77SPOCA3x4=
X-Received: by 2002:ac8:7d44:0:b0:471:9dd6:b51a with SMTP id
 d75a77b69052e-474bb62c6b6mr210020931cf.21.1741001939812; Mon, 03 Mar 2025
 03:38:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <4hwzfe4b377vabaiu342u44ryigkkyhka3nr2kuvfsbozxcrpt@li62aw6jkp7s> <CAJnrk1YnKH2Dh2eSHXd7G64h++Z0PnHW0GFb=C60qN8N1=k+aQ@mail.gmail.com>
In-Reply-To: <CAJnrk1YnKH2Dh2eSHXd7G64h++Z0PnHW0GFb=C60qN8N1=k+aQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 3 Mar 2025 12:38:49 +0100
X-Gm-Features: AQ5f1JrehzgwGyS7hGiWtVd1AKFPPsblrNTyW1eJ6Q9j2nP_CuKy-XFyQelzvBE
Message-ID: <CAJfpegsKpHgyKMMjuzm=sQ0sAj+Fg1ZLvvqMTuVWWVvKEOXiFQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/2] fuse: add kernel-enforced request timeout option
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, tfiga@chromium.org, bgeffon@google.com, 
	etmartin4313@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 18:35, Joanne Koong <joannelkoong@gmail.com> wrote:

> but I no longer see these commits in his tree anymore.
>
> Miklos, why were these patches taken out?

Sorry, forgot to re-apply with the io-uring interaction fixed.

Done now.

Thanks,
Miklos

