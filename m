Return-Path: <linux-fsdevel+bounces-17281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833028AA8D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 09:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EF71F21B7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 07:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D97E3E494;
	Fri, 19 Apr 2024 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QRuMp+In"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4643B2A4
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510196; cv=none; b=Ob+sdORn/1jpfRCBeKqxHFjNpntLAS3fkRb54W4Fbe01NjcUJDTapFpbrh9upYRw0b9vSRryzoIBdjkTMB1Vj6d2FZUczafpMIQjWznL+WJvhp1qhRme+2tadTyRZFxmdGYZqvSjWeEeup2shwJ0W68l/c6So6pVgqugQmKEzm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510196; c=relaxed/simple;
	bh=1KrvB4xP70N8g9WohZTwaHNc8WTwZCpkVPlckvQf3UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtGHAbFvGg2j/RypuJOEKBpgrBMMXqhIGZvekysPJc83KSAACXlJqYkDcsIvXUDoh/WWEDs7My8y+6UL/aV/gLfPFJ6BZEPkbO7r3Vh7F4YP53paCQGdEzho99t6StGwF9EbGLw2rDDD6bxzNTulFGq3bdY2eluHqfkBm4aO6Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QRuMp+In; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-571d8607163so63824a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713510192; x=1714114992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1KrvB4xP70N8g9WohZTwaHNc8WTwZCpkVPlckvQf3UQ=;
        b=QRuMp+InEmSVlRLbshacp9Vb2Tz4uWaPjwi+g54DcyYLbjwVZR5NjNSRvhC+Mq56Lm
         RSfX0P7cg3j4t358ZI0hjCN5csrzAzZFUk2Urb4lQolkXIHlHGwC8cnEdwwmSfMWspXW
         owoKFFfxPJfjQ/iuKWVR7qgKwiniGS2NHsqYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713510192; x=1714114992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KrvB4xP70N8g9WohZTwaHNc8WTwZCpkVPlckvQf3UQ=;
        b=t31u/V00+BshZDWhXtr6++RqIpAxBwEaib+QOPilOx7gLCcLc/Hfbtjo2JmO5GdJGD
         efR7qd3f0XOjwwmPTjFte5dg/jPZrMVyUDakb8KiRMhrQHR4d7YkIrRdQVgd03rbw6Iv
         52KAbaYisbb329/LQ2+3up1xhXj08tWI8NFuSVIeR1rTt/Qldy8Siz4DQwEl7TJzGwXU
         OsvcIQKYL6ztPrC5Erk0PcGY8iGTRbMPOZkQIaG/H8+y72JCoIFPj2Z6qun69To9nW9M
         sJnujYE7YHtXHQFK39CV6RKlCTg7RUblnBGOv/ZKUEWLME8ZxJPhPtWyE2rQ/tZs1HIH
         FQBA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Z6gjVd9BS9UwWndzG2l4QMBNZSCgqSUgOfUA0mRjDFdyYE5Gotsy2fxxZJ4uo8kqbTd5uFZg1HUMEuvzsF7cVUbGIl17jUG3z1Y2DA==
X-Gm-Message-State: AOJu0Yyu8eevCYSJc+B8rvhGFrZfa9ZOQUuA8yaRFsthPBVj3yeFvFCh
	qp/vwQ5mShvIdgjNXFYVuyQgbsiFY13ZGhQN9sUgBxI2w2VcW1fO/emJHQ5wgLDmB7wgPtnT/H+
	3U11X39vyAfYvaeCb+dsFU2ENwZehp2H45iXTrQ==
X-Google-Smtp-Source: AGHT+IH3tRDQTulqCGMpfmCAFTFNH+od70SwwdrUrSA6qQtwCH3uw4FkqvfBp0PHrarTrt0l/Vxtc1TP3mMpHSe8yDo=
X-Received: by 2002:a17:906:298a:b0:a51:98df:f664 with SMTP id
 x10-20020a170906298a00b00a5198dff664mr784164eje.76.1713510191793; Fri, 19 Apr
 2024 00:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000002615fd06166c7b16@google.com>
In-Reply-To: <0000000000002615fd06166c7b16@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Apr 2024 09:03:00 +0200
Message-ID: <CAJfpegutFNPRU+L0XAyryRETL9_qbcKj7ARBuTzgR4tnK8sOiQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in ovl_nlink_start
To: syzbot <syzbot+5ad5425056304cbce654@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: possible deadlock in kernfs_fop_llseek

