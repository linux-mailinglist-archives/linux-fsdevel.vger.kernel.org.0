Return-Path: <linux-fsdevel+bounces-16617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D6C89FF67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 20:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1142FB275B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 18:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929BA17F38D;
	Wed, 10 Apr 2024 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgJ3+Gdy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB66168DC
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772487; cv=none; b=KLP5i5PGveKFGx9/uSYW3JO70fRHBQfb7eTUgfgGjLAZtj7PGHzxtoV/3p8jci/nHxMx6Mjc2ERkcyrYrN8xIpW4CQ9RmnoNNs+FErn//dMNxg94EF4z1qTl88wEkTP1fhtMN6zrRjXGFPHIEWt2RKN7yHZTHBIcU+InD/io/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772487; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lsFd8yiRRDIs/9NPkS2NVHYyTfpzp39irFW9NLy8abVdRMZTwfLUjOr/FHWl/GnSu0pXjAXFmQk4xS6IDA1SOzGEXkhUQaYhXaiF3EseXq4u/bYz/SbMOVVa8bnb8CWkewQIAVvW6qOHVA6QbSD+2FXvQu9Zr+2jfz4MDyaB6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgJ3+Gdy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so16401266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 11:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712772484; x=1713377284; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=YgJ3+GdyqDTOsjnoFvzXnOfKCsvvZ6m3onJG/FIkWqszRRdI2uno2v9vD9jt34XU7i
         bNmjxoHcLbZpTFiaJttDBeGiBq1VGQ4ImLfevtN305DT2Qr43T0TUt1PDefyB7ozXLgB
         2woMJkweKD6p9TRO5yWfpCyGuLC+oADmw5zH5ksENWfObqUERlcddq0qDYglrrbIHKCH
         k+mNkutATjNI0qoORYWeNO3kcUBnOKi6t22stfv9gAHxvv/G0WKUfliso6yzQPtC7Q7v
         GKqETTKDENiHmtvCJITFkNGiTul8X5U9yohNK84EM3HzAn6qopc6aS/noYTGUZcvTdr1
         wwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712772484; x=1713377284;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=PSGws0U4GAOSNaUUvzQt6R+ki4HbvgskGMZxPthfh5QasUjrEe+fQ7b2flG2nstHz1
         KoSZa9fnAbypJ++DfdEJbHrAdB5B2zbgdKxTLwVWOHwHqDs+4CuUExXYKMjHdH/3xqsV
         cQGwowfxBV6xmKyCgGLmtfKi9v3VJIAnDFep69apWX8TNE84Yuwl1cEepl0ybEiTXr/a
         HEmsqI7WnVoKhp4Hy6S4Ley0vRohE9kmY9mtDJAP/dI0SJPiaoxGZzm/7X5PCFu7yQbt
         Irxwfl3fuGvfQIX0nqXbSeApzAhIMJcHa/mWhemMmjiOA8vQHNZqXWLFl+i+C5KAO/6y
         1tEg==
X-Forwarded-Encrypted: i=1; AJvYcCWp6IJ5d0HW4cv8EUWbvVkNQRvAwak5ier7PVno9tRn6xkk03ZkZHAGpNJ5xGgTXmeHMBTLSI+iv26A/GVrKnY5OejcHpuJQDY0mVtljg==
X-Gm-Message-State: AOJu0YzZ9DnWRyYayLiZtciKiHqJt9jE9XBuVLFd6r9VtZ2X4O+FO4cK
	+XXBc/bziQnjZRwP5tC8YjLzd2/crJiiUa61rlp1qQpZMbpzOVvtyaWVR/Q=
X-Google-Smtp-Source: AGHT+IH/2sTqvlOFwbJu05lZhpRYB1JnOaZyKWMHrW6tpvB1XapN5+FJ36jw/ODBttt4YwHQEtNL8w==
X-Received: by 2002:a17:906:c79a:b0:a51:e188:bced with SMTP id cw26-20020a170906c79a00b00a51e188bcedmr218837ejb.37.1712772483557;
        Wed, 10 Apr 2024 11:08:03 -0700 (PDT)
Received: from p183 ([46.53.251.6])
        by smtp.gmail.com with ESMTPSA id jy15-20020a170907762f00b00a4e26570581sm7218454ejc.108.2024.04.10.11.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 11:08:02 -0700 (PDT)
Date: Wed, 10 Apr 2024 21:08:01 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: [PATCH] vfs: compile out IS_SWAPFILE() on swapless configs
Message-ID: <39a1479a-054a-4cb9-92c8-e9a2ed77c9f0@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline


