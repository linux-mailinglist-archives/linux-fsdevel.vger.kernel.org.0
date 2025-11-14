Return-Path: <linux-fsdevel+bounces-68441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E504CC5C365
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD0D3BA6F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A672303A11;
	Fri, 14 Nov 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AucJZ9d2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24816301707
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111848; cv=none; b=G47emRMntSFXNC+CY7ZLVF95Lzi2W7cNzOrj9CF2nIoiVrRE9fklXzK9P0ZcLEcaRe6rF990+DSk0xbCkhubwJgV8Lmyuy74kMc7MGkKU2lBNrFbcxdj5ihl39nezM7j1qDN6x87oyzPYUlRFhrBPPGibBB0hzI2cQs30CssmVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111848; c=relaxed/simple;
	bh=yVjn14hRc0zLgUPyS7tqsP2wnw/220J2C1mbkzIbF/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNsKD2U//jXyMimfgK4t2DjglXXpG0ri+v6OqjDHtTiC8IPUEkQGHRZgiSCt0W54iRA+dayftZEYIFoXuP4CnqAqNKNIcaYf311y1UOr4xuqNCrEB0E9yQiSeKY5Zuuifd9iwi6ARWeqhkwdTbYu9GCuMuUk3gwXr0BrHpl2Br0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=AucJZ9d2; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-882399d60baso16146226d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 01:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763111846; x=1763716646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lIvYmA/du4PJt7TXtL9a+/UDS2TXYnXG/gcmvhqmkuw=;
        b=AucJZ9d2J/zMBf1tUB030PI7YBPsczcQ451pNyDbG/vGUBCI3lNcsTTvNMQHNKR2xv
         qWAHupRe5m5YznmOyum3aDzjFKa84iW5SrYbp7ibSv/YMLT50McFNSkM8uwiZtd3pZum
         VK54Z8A8m5RI72qsBgSNEFxGnYURgPh9XlA4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763111846; x=1763716646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIvYmA/du4PJt7TXtL9a+/UDS2TXYnXG/gcmvhqmkuw=;
        b=VsYE0OCy5brhy1QM5yXn7UNVw+lbm7SkiAn5mZDxj5fLy51QY+YR76/LsLX4WyNCSZ
         ztPrEyZuQ7D9D+XD7q9iU6qGC29svRxDcSWe8SU9Jsxi2dxIirdudhnBhhy6k0+mz5Qn
         JlQmqs4bEkdolJuV6zv0ju7WZU6cbs3lWCPkABWuQnwSZXLrJCv0POipaQBxsVJHIlD2
         1ZcUi0DUBX8yx4NNWWsIbUCb6easY9J4LCHBXkEaooQ3y6Rntj6EJjk0E10VGgEhGT2Z
         Piiho7ALoybDrDJvYcRJF6W52xgMzyon1KT4GmKyuVyeNlsXSj7jlaRG6bd+U2Op2smq
         1pTg==
X-Forwarded-Encrypted: i=1; AJvYcCXG7wzLf+Rp7Ttmc2UjveN5hQxXaCTGpCL2KX8dJBBPhdG792akZvClnpZb09TbZdUTEIPKkBBbg9TWMOX2@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKdx5ESm0cWPTTDfXWsBbUnpffgsh9HSQWzHX4t9RPCU91Sju
	bNoBzKSeZi3Xqhmh1MKoosHQn2r1VoR8j7UIBu+TazfdydQsojG30yr39suAjfiXEHWYkbgHubs
	l/j4im5VoXmHhWdvvOO0vgYEewWk638KUq9uuLL5bv1rtaOxGJTo4
X-Gm-Gg: ASbGncul5bHolL0+92oZzMVzeQNP4Royxy3s3eHfNOpYoKW7gmTqCIQypHP63dgXT2I
	LF4MhC3Th0mSci+dxCUQUiGxQrD9mkrtZ8X+1sApc77CEGZUtkyLdizeS4azjkFpq7wtxk/kbme
	ncQQuksyUYI1TNu/1qzoW9Jk0g7olD6XOX0y1JJv4ynd+r4nVE4jBnbGy098jgrcjPMo9+foOUH
	yZmozi3jPM2Ktsdu9r73oA88yb5yyokK+YlwGGJucM+hEJr8++dPoIjcTaNfqPpTR0swJJ6j1ZA
	Y38myADBMArNdwQoSQ==
X-Google-Smtp-Source: AGHT+IF35lQc6cvZYyTFqaULQPRQPCggm7Fe1u0lX/Pdbrb+qT6IM4P5svjEZIkD3i4lt7DqKsZWBRm6WSfKmIjTII4=
X-Received: by 2002:a05:6214:1bc6:b0:87c:2c76:62a1 with SMTP id
 6a1803df08f44-882926ea561mr26613826d6.67.1763111846113; Fri, 14 Nov 2025
 01:17:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org> <20251113-work-ovl-cred-guard-v3-34-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-34-b35ec983efc1@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Nov 2025 10:17:14 +0100
X-Gm-Features: AWmQ_bmTpzJ1seBmeJtiIFjACoOLyUexdpxjEOTaM71cwGlCVS6u5IP90qgqsi8
Message-ID: <CAJfpegsdtHgiGFi5EEjaN9but0A7VTZA4M2hSg=Q7ynAozhqAQ@mail.gmail.com>
Subject: Re: [PATCH v3 34/42] ovl: extract do_ovl_rename() helper function
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Nov 2025 at 22:33, Christian Brauner <brauner@kernel.org> wrote:
>
> Extract the code that runs under overridden credentials into a separate
> do_ovl_rename() helper function. Error handling is simplified. The

Hmm, it's getting confusing between ovl_do_rename() and
do_ovl_rename().   Also I'd prefer not to lose ovl_ as /the/ prefix
unless absolutely necessary.

