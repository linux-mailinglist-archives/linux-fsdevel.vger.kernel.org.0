Return-Path: <linux-fsdevel+bounces-69904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF0DC8AE41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 17:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0E83A6675
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2693A33C1AE;
	Wed, 26 Nov 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aOOaxbgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845A2C21C6
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173468; cv=none; b=IwFqd1DdtoF//dx36tpagNUv//caVRBYwFdsRKVGmDk21nPhudFzT125J4FVp3jkLUvxGDT43JrMRXi24w44fcpncFh9F/4HicaoLHQlpGE3mk6X46bELNKuoMOQhGFEW+auG+w2pYYn1GIpQx79ASg4VFXnaGTinUoSOgSH+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173468; c=relaxed/simple;
	bh=8TCt2VKJv9ZCn2N2ta8fjQhBhwbSeDmIr0s9K+x2qQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VweAn6T1hKVhGyxOru9SvcHUjFoSSICm0yZRwUTC1jI9EMTenUDXgvDHimaryISvGPkoL5Nsgd0KM1ZFaTs6y30j6YRb9S0iXMnuFM1IbxHX8Ids0K+0KNBdZ2YyNRP75boI2JdJpq1JkQa92ZeNpr9s3JGp7OQnE/fNZqk+xVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aOOaxbgZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7633027cb2so1229595966b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 08:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764173464; x=1764778264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=etshZAUpFBhKDvUbMv6LHyDLVgU9tVy7cnW6tkUXz7Y=;
        b=aOOaxbgZPcyFRcQlS8j8UGxEILrvkA+5nTThKs8/nk425x0GZ8iWQoolJJh3+XLFNS
         lOLNcqx5UA5uO072t+9k7bbzo8GtPl2aGFj+ruc4YlA4qFA5QDp2NVwIa4+4S0VWadhp
         xnlw5JyfcX1WP1rL2lrc7lIagI/1sj6tlIPn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764173464; x=1764778264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etshZAUpFBhKDvUbMv6LHyDLVgU9tVy7cnW6tkUXz7Y=;
        b=SBx3lzHtGFWx60r6AhUFbRKOIXmgKpL+pwhnh/swB38fH4V+A4P2BB8qjuaJf5/aFi
         qeJm/kUJq5QPjxEizhIxDIJm+v08bRJ29d7bPCpdxYIOWJ7BB+I76nsOt9gRnwPyrAFh
         OtWWPYhuf+Ra93KtGbfH071/j0LSzJqdrOU/F4qf8gL/1EIlVUta8ofKYfSMOMdPx8iS
         VgiOS0o8a7sr7vBfRm9XXk9iQv7oaiGl4U+8nFiyMk4lnDo9Z7sd7imfzIhSLV2zgGAt
         chvJn2/zNRykaejzMYM8v0Exi5yo6w8WKkd59TdzIT+S7c3z2JnjIfttYT3rPIG2sFwv
         YdpA==
X-Forwarded-Encrypted: i=1; AJvYcCWtgrmhVga3b0ZiTPJqdiqUwUWlKF0mWmT/ftUreqAKM+dRAt2WQXXEYwfGBsKgZcoY6wkNEiJJdOPiw4HS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4KtgqPVW1kI3ZRqarFN/Hu74F2mFFECrCbBWED49oVvupoPvs
	kCdPCTIqN7wf87dx0DYyaaEpCf9GTpE3+e/ZvAftlQUf+t92PFC6Yu56pgpndO7JjqUAaMoFnqb
	QhEbTlajNKg==
X-Gm-Gg: ASbGncs5rpSZzU2XFCqF1rbK8ifgwh9ZfDhJq7M+wvb4YzODqwlCOISkCEYVj1TgF3i
	KI7/Xa6zCyY3W2ePeQ5OrxKQOa3YcwWvnhFB8HKbAb3TXw2O3gWGPDq/FGhioz8ndgKt+PH7TjV
	ZNdcCme+SBhiZWrzhixJhks0sTzvorsRmFLlcuT2NVJqBztfI8Jhi34si86BRXEr5H0CziB5PAa
	dUFz3X1R9RgzgRqTYcvUw76UKGD29uwykNXOqQfQk8jlkyzL1y8o9nnaQImpTT3NsncJFJXE58b
	KBm0RGq+qVZfnxfMUuEm9oP+m0AK3Thl8uWaUKuVQHgpF0FOcCiI0KXB/jXImXYwV9/m+Pwo11t
	0PNjyyP9c8/LLDzr9apZ5yaF118CSho/OIM+cVB5yQ1/kGMX0TeYx0mVSaj+79z+0jE/e74Rr2E
	iGs/5NXFvxPUgT3t+ROLQGfFTfL9Rg/LscX1humQyw0D+HLcPgvtNR2OBTH+GX
X-Google-Smtp-Source: AGHT+IHNWMXb1ahJqzcm9WkcK2m+POE5anXe+M6fSAUpd8DxrebgvVx3evvlmRea0El8NUZ8YtFM/g==
X-Received: by 2002:a17:907:2d90:b0:b6d:6c1a:31ae with SMTP id a640c23a62f3a-b767183c1femr2086287266b.49.1764173464410;
        Wed, 26 Nov 2025 08:11:04 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4e51sm1932046566b.42.2025.11.26.08.11.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 08:11:02 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so12404996a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 08:11:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgw6QoYWWsQ/8vkXlz0OJUMzH2YbZ1ur9PsKjaR7Hbd/kUfcBJfqO0PxW2Uod4KWpeCXFihntSBvFROzXJ@vger.kernel.org
X-Received: by 2002:a05:6402:270b:b0:640:a356:e796 with SMTP id
 4fb4d7f45d1cf-64554339c3emr19310501a12.5.1764173462492; Wed, 26 Nov 2025
 08:11:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-22-b6efa1706cfd@kernel.org> <c41de645-8234-465f-a3be-f0385e3a163c@sirena.org.uk>
 <CAHk-=wg+So1GE7=t94ejj4kBrportn2FGzOrqETO5PHVLAzh0A@mail.gmail.com> <20251126-reagenzglas-gecko-4bb05b983db2@brauner>
In-Reply-To: <20251126-reagenzglas-gecko-4bb05b983db2@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Nov 2025 08:10:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj8YC-Kir=TA2dPG01ecF8xH0OXjuS1XZB--W9e_yNkvw@mail.gmail.com>
X-Gm-Features: AWmQ_bmboWW-TlfefqyK8nlY9IUYusmAFX6P3hW0ntLPLHKTgSE57EZDv6f0G90
Message-ID: <CAHk-=wj8YC-Kir=TA2dPG01ecF8xH0OXjuS1XZB--W9e_yNkvw@mail.gmail.com>
Subject: Re: [PATCH v4 22/47] ipc: convert do_mq_open() to FD_PREPARE()
To: Christian Brauner <brauner@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Nov 2025 at 05:21, Christian Brauner <brauner@kernel.org> wrote:
>
> Added the following which imho looks nicer as well:

Yeah, I think that's a prettier pattern to have all the open logic in
that function called by FD_ADD(). So LGTM,

           Linus

