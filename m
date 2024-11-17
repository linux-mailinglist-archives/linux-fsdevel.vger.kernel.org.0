Return-Path: <linux-fsdevel+bounces-35044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28A29D065C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 22:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938B8282519
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 21:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D4E1DDC08;
	Sun, 17 Nov 2024 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Q526gACL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5521DDA16
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Nov 2024 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731879749; cv=none; b=e84KrIPq2MV0q7YkXz03x/cFmT7RvQuQlGr1sLzHqWTxE6jUYYsjJJvtQOuckmhT7uVtrZRTliEHNPF/cCnWzpipL7a2L7HPXJH92UeQShp17VWDs/ELuTfjX6pjJp0iXmXx39pmJO1lPdE1N/5P8L9rxvuxNcF3nstqorZf6Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731879749; c=relaxed/simple;
	bh=fbnwBa/ZpueSh9SqikfHGUoxX6deXqluvSX6WSJQJJs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q7hUJcRYdKb3vzzQcUNRHREen7jgCHfMFlGhTU0oTCVJkwjGxuI+5x4NV9XdGpHvFybMi2Oi7FQiZvGRuUI7jrXIs89cKVNbKtOhWlkuVkceIbbDY5CNyxTbJENaHZMoyx+IY8QFlvM9koVxPA7P2ftD6N0Nk0Si0ccz+lz/5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Q526gACL; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38233152c8fso94693f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Nov 2024 13:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1731879746; x=1732484546; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zr6CSSq+yYWOM7mVKH3wNw8lI+twmShT9Ch+V8e8Hus=;
        b=Q526gACLPCDOWLLrEoYKBrLLfdC2d05mdnCg98TDFXNH4uNAPiZX3ZrYW4cbl4WhtJ
         +awuTdVmtIafCxljL7oloVn+ArbH2XE2nrt/Hdki5eVxHmvQmwGy2yutJ1b/1/aQ7VrU
         6atrZNHPfLsNTDX5ArB9AZ1dinbNjWly+mejJif4Bywlr7K9G5kIQEscS2UOJnXCa6T/
         VsukXHbfzwnnrwgw+ctEv+bBF72BG/jcn60CovYszlmbcBzhQCyP/q71E6v4Jww9zJaS
         LGUxWMiQ7AAkEcdp/HbN1hUb+oIQcGBhthHb0+9OeKns2vQPyzaZlZPM/IDzhRX5ghXN
         8NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731879746; x=1732484546;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zr6CSSq+yYWOM7mVKH3wNw8lI+twmShT9Ch+V8e8Hus=;
        b=WmSqVdRPTdnBJi+9NH5HhZgGfeZXfUEQ0SJjJ7OEx228MGNoWRDdecNyYuBAuzAR7b
         5/GW9hKQWAYPTDMWWi3qp3d9/k4ENuL5Qh+6TxjEL10+31dARzOyJsK8BVHmpfRcVH21
         ectSQDk+VIUkIF5EBnAoxwwENQwphJ4FbLdr4SPvoD6nv8E7cMb7yjl3vb8BjP2H6y8S
         QQUHy9g5WToEAAAhcKJyvTFr/THPsBFqleoO8eNTvhy0VOx0/ZsBlH1nOLeLOn+Zo4vY
         QBVFP6vlwuxHm34cLbfGUSc5yXD7Ja8p6UiAg48ad9sEEXQhVJaJKdDX5C1vVdkMXE+S
         APOw==
X-Forwarded-Encrypted: i=1; AJvYcCW2yYgt4YfgUGxviFtePtIMQEUvKM2DxvfHJnxZOea/Pva5o/6cDzZ2+QslmZve4M+RH24JLuR6WrwUBwkz@vger.kernel.org
X-Gm-Message-State: AOJu0YwpkspiQ8t4MY7+alfDGHca6wH3Oix/6xzrkzjeSczZMKtLF4Mi
	pHeYZMbzFXxQsD4Sr1o0d5CoZEpltB3O8kK0WZIrLsbYyoxgCs5uAPX5d7FR2cc=
X-Gm-Gg: ASbGncvuwpKtYOeWNAZ9YbbYqAy6y3fk+S9bxCK6OXDXY7A4jMcairHM8P8glPkKIgt
	kaBJ7dXztN7HE030ukQzQpcfn/DdILV+UUqdD19rQcuFEfQgR3CmqYnUbzdcBx2Ncxo183GtKgo
	WQnjOU9ECA/UaFmIxv4Kw8CICUSs22Pqd8doMMXfJJVG/8wxNoFC3OrIOE6nqyPM93pQ4k3apkV
	e0Wj+oSezOkPsTEQ0OmzrhDVmlj/sDFsFDOdvKUD5VZ29g1HAeKUlguezBolfhyyqqwtFLwXu4K
	E2imVw==
X-Google-Smtp-Source: AGHT+IF+9oJFbi21AiEkbm/uejQ7RsC8IrNLz23sCIY+EPlWop6ZGwOrWSuUxfNkWi1PvkVhegUgpA==
X-Received: by 2002:a05:6000:2d03:b0:382:3ef9:dfbc with SMTP id ffacd0b85a97d-3823ef9eecemr723300f8f.5.1731879746245;
        Sun, 17 Nov 2024 13:42:26 -0800 (PST)
Received: from smtpclient.apple ([2001:a61:a4f:301:d900:ed0f:882d:dc03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382491e19bdsm477489f8f.16.2024.11.17.13.42.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2024 13:42:25 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [RESEND PATCH] fscache: Remove duplicate included header
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240830-weihnachten-umtreiben-d3a9f1aee2e7@brauner>
Date: Sun, 17 Nov 2024 22:42:13 +0100
Cc: netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>,
 dhowells@redhat.com,
 jlayton@kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FE1592EE-F840-4E90-9177-FD2D03261E3B@toblux.com>
References: <20240628062329.321162-2-thorsten.blum@toblux.com>
 <20240628-dingfest-gemessen-756a29e9af0b@brauner>
 <4A2EAFA2-842F-46EF-995E-7843937E8CD5@toblux.com>
 <20240830-weihnachten-umtreiben-d3a9f1aee2e7@brauner>
To: Christian Brauner <brauner@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

On 30. Aug 2024, at 15:17, Christian Brauner wrote:
> On Thu, Aug 29, 2024 at 02:29:34PM GMT, Thorsten Blum wrote:
>> On 28. Jun 2024, at 10:44, Christian Brauner wrote:
>>> On Fri, 28 Jun 2024 08:23:30 +0200, Thorsten Blum wrote:
>>>> Remove duplicate included header file linux/uio.h
>>>> 
>>>> 
>>> 
>>> Applied to the vfs.netfs branch of the vfs/vfs.git tree.
>>> Patches in the vfs.netfs branch should appear in linux-next soon.
>>> 
>>> Please report any outstanding bugs that were missed during review in a
>>> new review to the original patch series allowing us to drop it.
>>> 
>>> It's encouraged to provide Acked-bys and Reviewed-bys even though the
>>> patch has now been applied. If possible patch trailers will be updated.
>>> 
>>> Note that commit hashes shown below are subject to change due to rebase,
>>> trailer updates or similar. If in doubt, please check the listed branch.
>>> 
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
>>> branch: vfs.netfs
>>> 
>>> [1/1] fscache: Remove duplicate included header
>>>     https://git.kernel.org/vfs/vfs/c/5094b901bedc
>> 
>> Hi Christian,
>> 
>> I just noticed that this patch never made it into linux-next and I 
>> can't find it in the vfs.netfs branch either. Any ideas?
> 
> Picked into vfs.fixes.

Hi Christian,

I just noticed that this patch (again) didn't make it into linux-next.
Any ideas why not? The link just says:

  Notice: this object is not reachable from any branch.

Obviously, this patch isn't very important, but maybe this happens with
other, more important patches too?

Thanks,
Thorsten


