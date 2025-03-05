Return-Path: <linux-fsdevel+bounces-43205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9156BA4F498
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 03:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD81B3AB705
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 02:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFCE156669;
	Wed,  5 Mar 2025 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLgcHO0p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3F3B2A0;
	Wed,  5 Mar 2025 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141182; cv=none; b=qGWGs+NBlIVU7XbHC3WgK3njkREBfePlWjBlyWHEigEIxD5bSqZAnCpwp2CgquT4BW8IN1lYQv6BB8UnqPvnva/JVdt+C8GBtVBtOYIxqz1AQFdv10eWHtSD7qBpWbpiNUm4ZCYZMSRuRYMpnxFHEVNv6dgb7QA5nAibMOepWwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141182; c=relaxed/simple;
	bh=ibK40PcEpmzUvqnYdKsqui/jkg9lXZGNK2hBdoX8hb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtHzp5FVNoU6kh5WgbIs7tuuYqhCiQw4sn1TQs7/otL0qBSBzUzBZXkHu9OrVDdj3q6VaIcNIS2DWHvkaM88dxPzvCYjsaN7qh9WZ6aGjleo76vhWiUbW8XDpAy8jfJ5YN3E+lBymiFEQdnscQou2AhL47ZhkXy/rO06yJdIImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLgcHO0p; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bd45e4d91so335845e9.1;
        Tue, 04 Mar 2025 18:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741141179; x=1741745979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKNB1E4cQrYl4R1CMichtnXi9wxxGJnigveKHD0cBTM=;
        b=kLgcHO0pYRhBK9Baj8oO7Sp6FJC0/rcFQ+obwzK5DK9iqvIDfiT1kCf2lretDZ+d8G
         BGb/CwvpqrNkUprGa7aDbdI3Ht2eMkubo2nK7LgSolIBHGnV2xyTXSqwwWt0LK8pp0MC
         oMCnTYP9/aWRP6vpOwZHRUxXzpqGvLXd3qnb18ydGv6i/2Nc10w8awIMLPl1kTccXhrE
         d6ExPzookktI6rpTXaEB8/pOMKHb3e78xtuAyQzmRyyDMfh6Ts5AtMHsrt+jAOSkDuKr
         c1/yX2eLnV7cSuTtVfo26QAtSat4+/ul4ccMUCaexgiowItcBc1fte33g+oK6Df9X3Bb
         3jDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141179; x=1741745979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKNB1E4cQrYl4R1CMichtnXi9wxxGJnigveKHD0cBTM=;
        b=FRv1mQaQ6+Qh+O24eZ6zFwlbq5b8ZQ+O0uv7iLyWJn31z+AzoVOBoRlv3wRTXYgOXI
         u3JrbJODuvI/ADI9fxiVg89UQjUJ3JwiTYyqLtnJcAjWS3gr3948+5NvyiCgv+9kdoXS
         g/Jb/XelbKYlnaAv1uHZzvSaBD4BogzJhHU3Bz4+/L7OU92UWqUnHJe9U6AmlQeQNa3I
         3GGgLiW8vNhXg7WtRoPBlqdJMHL5UpMeQ+q+t2SQT4RxM1tQlru0Bz4E3Jpr8jkdPq25
         z3ZsB1KZ763Kgn4DLRL1uQCGjfcaHhb7TrO8UMqp608u1Dqpikhtwft/U4j77LeR4XGu
         cMDw==
X-Forwarded-Encrypted: i=1; AJvYcCWKS1SsvsCKD01ySuiB6Up83oXrWI1p/lBm6JK9PDfVRgZhVXf+TTcGMmnYsbrVyZnfhmMPH/0UmI2WFLEO@vger.kernel.org, AJvYcCXo+jd2VSdI/hFjNQUznIAqzJss/tq5zJ+Q3yFmXcRCv3l0Q3slbwVKdVDRhzjIqugHis9Qj8500BOrRQcs@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzj3yfi8Rnk7BMLTEDY0CJZ7PnrJQzEjDgHZ+I79O9kpPsFwYZ
	aRCtYFSyFnl/9t0cBhgZ7pAMbsYkxWEsXStaPNrL4l/rRXM7nje/
X-Gm-Gg: ASbGncuPKU1HdHHYtZCEa7FealoOzh8tTGYoyQGWPIptE13DHicSL3KT3FmaUwyyNcj
	rfY5BEhW/64Db3F9Sy2PsgT3uD9bfoIFK+4BaqkL2UmDrZHVCu6WtNqn2Id1ZoRMVKwIY4plPV7
	1Y7LKw+G3WjfJRY6EVh1vFFBNguVPhWIhzwEiEcVjqyCs8myVqHlCBWuZu71XOlYy7Z2u5xteCC
	OzzocgsVtiWqwK7/2+/1NzqjM8FrizWtRGtKJZrRaNm1eiX4/orSFq4EmSeGvsXqk8FzKY5nGfP
	mOl9ShZVWtMce2ujna7Ud60uBJ7mf2W3f9bzPc0vXfeFHcAL01yL6PDsAXR16AY9MeCEzhnHPhB
	hCCj9e1E=
X-Google-Smtp-Source: AGHT+IFXKjCab26OVx0Vm+3kBHlh/OY7oJY7zyZ04P1TMtOomnH59wZNzFQgfGRggh/lQtyQSI8TfA==
X-Received: by 2002:a05:600c:468f:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-43bd208782fmr9886755e9.3.1741141178530;
        Tue, 04 Mar 2025 18:19:38 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7a73sm19805051f8f.50.2025.03.04.18.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:19:38 -0800 (PST)
Date: Wed, 5 Mar 2025 02:19:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v v2 0/4] avoid the extra atomic on a ref when
 closing a fd
Message-ID: <20250305021936.71e837ea@pumpkin>
In-Reply-To: <20250304183506.498724-1-mjguzik@gmail.com>
References: <20250304183506.498724-1-mjguzik@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 19:35:02 +0100
Mateusz Guzik <mjguzik@gmail.com> wrote:

> The stock kernel transitioning the file to no refs held penalizes the
> caller with an extra atomic to block any increments.
> 
> For cases where the file is highly likely to be going away this is
> easily avoidable.

Have you looked at the problem caused by epoll() ?
The epoll code has a 'hidden' extra reference to the fd.
This doesn't usualy matter, but some of the driver callbacks add and
remove an extra reference - which doesn't work well if fput() has
just decremented it to zero.

The fput code might need to do a 'decrement not one' so that the
epoll tidyup can be done while the refcount is still one.

That would save the extra atomic pair that (IIRC) got added into
the epoll callback code.

Thoughts?

	David

