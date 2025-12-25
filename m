Return-Path: <linux-fsdevel+bounces-72095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B320ACDDDF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 16:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E52F301B2F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCB119D8AC;
	Thu, 25 Dec 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y47mcnct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96597E0FF
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766675336; cv=none; b=X9cIhcFeh/v9H6Kl89K/MbQI4BY4jd+Sbjw87kE5w1FRpuVRPvHdasi1tK2px+Uu/p0lhCsF2WtLYRTEsLrj9EGZ/Nu/c71B8aCL59Tbz3KkcjKZW/xpUkH2KdFeLRh/5FYSPyW0GJ7T5XnMRoncv5Rn8CFkcDQlo+rCmsuoHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766675336; c=relaxed/simple;
	bh=1a8WVK/5R0u2R7uTPPcpwGnVq8+rcROVcLyIqeUBGAE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kwWLv+fK7b577EARcigw51RmIzQYMty/6aBljDoVCYmMlLRIXgiTzxBQHG9hw1L0rBEKW1LFFhXYqt7ZyPD0XNKEuHM65n4G9LJjrqWCWDMigDpZU/kOluUQ+p5450lZb53zKiX61lnmW7lW+H/DmIUBuYff34+JfQBIT0oGU38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y47mcnct; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4510974a6bbso2146914b6e.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 07:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766675334; x=1767280134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4enrxTcJXMNYO4nBPNY3Xlx1Fas4M0tOaGVZ1+UN1kM=;
        b=y47mcncthDnI769p6rGhLZVqjvRvc+lOVw1hkhnC42UnzCu7Bb9iCYZLMZxbpdFSO9
         jI/nlAsiPGZDvdY7g+cy+CJDn9g2mxe/ygo3QpYZwEsQAW7fUygMmJ5HFvqRINeEUThU
         mUtOXHqHe/erbTMOdVbuQL+X3NHcMoYzH7uWd32jFWiMhc5PGomsc9wOySFTsqn6jHSr
         M/UQbF6GDyiAPb0lEJ6iqYY/aGaTpGaqrM5BfRclKKgQBlO/ZAV+deKzQUbsoTAVMQbJ
         MqrgW8UBPenQTFJazvsjrEr/6d5ssotX6MOTbSVS9aDVIBS2Nr1/sknzo9/cHOO5QkWj
         9u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766675334; x=1767280134;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4enrxTcJXMNYO4nBPNY3Xlx1Fas4M0tOaGVZ1+UN1kM=;
        b=B2MNRGWeTU9tZIYkoP98j1POFGAeAkLN9oduIcnTJYOeJQhyRMqfygTqNLQjYckFjQ
         KhUVV4QdZKi/67ptAQXKqyt5ND2TLm/XbFeD+wExZra+QpfBHP1qan0j5yUX4HxGMM5G
         /OjiulpwG7Tg+8KljpyXLqx5w78DsJ/UhhlaNFYDLs8dX2r3vHH25dElTqvSoezczW3+
         16NY47wf0Sfqogv0oSnY+gcfkv2Tu6Eu/+VGhDyjW9AxNKEyFiurGhMNOu8O9QhCZk4Y
         TfEJ9sGXLAj2y1P4zARTupRmOvdld+MdNwWad4ZXFyOK9NeNoSZ90zufcZlq+tRdznJB
         ZJeA==
X-Forwarded-Encrypted: i=1; AJvYcCVDuKoLe+cTdVWmq0xtAF+8QO4/h1u56vKCI6//tD7GAdVhFrLSX6pJfXPyBJ85DqY0eZOUNyxj/ghMd4zA@vger.kernel.org
X-Gm-Message-State: AOJu0YwHs2p+JVsATTH28IKZ3TOb/gYSInuzpFyIRIp61HIOftA5HgHv
	IZulV2pOtPk3NK8ZVaw+rKvTedSRuzgV0oT95W+KC/9QtIkCPJXSyrpLNUxWEa2PqFQ=
X-Gm-Gg: AY/fxX771OXgQj/oFyv1RQbHAuN+j+MXytwQjmH5y3wYaWYD3i8s56jugVwJj770r23
	kfxBupYD2CF5LK/XurYZ9U46TC8jGKxXmb+fCPoVuPBj7FEVD9AcY45+ncyij4cFMIUMN70Dpjb
	S5/icO05RAFKfP8kXoGbiOAoeRMRT6iFIjDmqIu4zWdpY7aZODCC5axpWNm15kdAoBRFhT2/gCp
	Eg+avZiS3WdrdW48dXi/2qllM7RD6odwkTAP4qwYRao+QP7n4lFuJdJg7k0XUVe6MQ3msvNwX7+
	wEk4HVtf3Hsvnmzalw27jfmq2Q2+RE99ZCraDgbDUU9Tg2L54V0ppCNJcrn+xQMq7i4ae0spF1P
	Q0wmJI6x3jy9AdE/1TLoKRFubJlehJXaHSbOxLfnZgj/4SmsNqCAKNB7hSMWJ26nswc9mPKrvW5
	h8MyY=
X-Google-Smtp-Source: AGHT+IHvysv98JjOtrG/XeetHHlKyurM7jKSGEnAoF86eGaByvTJgHoycWQr3WJoF84WobCqIy6E9Q==
X-Received: by 2002:a05:6808:1b1e:b0:450:c9c3:a249 with SMTP id 5614622812f47-457b21cfc2amr10228559b6e.45.1766675333911;
        Thu, 25 Dec 2025 07:08:53 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457b3edb41fsm9481403b6e.18.2025.12.25.07.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 07:08:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Prithvi Tambewagh <activprithvi@gmail.com>
Cc: io-uring@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
 syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
In-Reply-To: <20251225072829.44646-1-activprithvi@gmail.com>
References: <20251225072829.44646-1-activprithvi@gmail.com>
Subject: Re: [PATCH v2] io_uring: fix filename leak in __io_openat_prep()
Message-Id: <176667533028.68806.11770987520631890583.b4-ty@kernel.dk>
Date: Thu, 25 Dec 2025 08:08:50 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 25 Dec 2025 12:58:29 +0530, Prithvi Tambewagh wrote:
>  __io_openat_prep() allocates a struct filename using getname(). However,
> for the condition of the file being installed in the fixed file table as
> well as having O_CLOEXEC flag set, the function returns early. At that
> point, the request doesn't have REQ_F_NEED_CLEANUP flag set. Due to this,
> the memory for the newly allocated struct filename is not cleaned up,
> causing a memory leak.
> 
> [...]

Applied, thanks!

[1/1] io_uring: fix filename leak in __io_openat_prep()
      commit: b14fad555302a2104948feaff70503b64c80ac01

Best regards,
-- 
Jens Axboe




