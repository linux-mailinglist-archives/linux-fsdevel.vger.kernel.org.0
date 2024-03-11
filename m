Return-Path: <linux-fsdevel+bounces-14117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87161877D88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 11:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1761F2811F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317E022064;
	Mon, 11 Mar 2024 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OOXpVH8d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E284C1B599
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151318; cv=none; b=bzTlU4oimCNorGKVmEV0Ds5LaflmzH9+vrG9mdfJRXmtu6nrj6kZpS75p23Nsdo4E2t7TAdD9zeKLEGYaawE4cW/Uwc05iIBeJomaY9Ambpvvnb5Qp+W+0sl8APOB6ofOtprcYvTIeoqPdQSKda3qh7hZ6hPrL6zegcmkW5KXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151318; c=relaxed/simple;
	bh=zyFlU1py+mKWWN0ZGbr5+d/f+u+KKqFAiY+Htpj1sa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyc5e8BF4AngzAxPYS0+sxg/nMl0xNGIa/ldWU9k+qGFDm4ycmwbDoo2ltgtIlRqjimmjx/3ug3gkVLNNZ9VbR/1BCKHUPbUZhc7BTDSs16PFRkiKMJMZldxx1/4pPdrAf1xMEaEZW4adm2AtfFi9i34Odnb357WGx7q4lShBEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OOXpVH8d; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44628725e3so455286266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710151314; x=1710756114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5iUDNAH3pq0hK6PiJNdaGQI86yqdx+ioGfJmCOgQcpQ=;
        b=OOXpVH8dyzIa/YtmI1B+m75Y/r9S5HV2ZsJk72CJs8j4AXLUAVhLUVG0d7h6Lx5Vu+
         TYYm6VMaZcD8XholFxM/W+Ombzf3TN+wo0apVjDc7dxBFzYHQR0k+zdRgFy7o+ev61e9
         241urNw6ZeLVPn6Q4Wd2jQX/6u+8+THOXhMOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710151314; x=1710756114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iUDNAH3pq0hK6PiJNdaGQI86yqdx+ioGfJmCOgQcpQ=;
        b=eQ0yKufxF0tURH7eXz+mLouKmyIaYVIt2fJLxIxsCPn+rL+0MxZi4jpLECckZD/Lqd
         1r51kANBBEpFXBK93z8A803Pri6TZmK8t3/Cxr5Cv+RhcvxUaHNbL4zBt0+gW9K6qhJR
         8COAjrdHATHus2MfAEq9u9ig1pyd3VE7vF5un+8nuHer84H5PfpkLIelLGXfssNtL7Ie
         LZTA/x/vytwvj/wFkqR0qXQ9K2ccXfbOASyGO0lf0qYFLSiToDFVdtBPC76AXppdpjrV
         d6ECnlygikFFAJUGBarynDSsXLPViqXrnHqAopRQDBIAvZWGqn8pdinaJRNv+7YSTLRd
         islQ==
X-Gm-Message-State: AOJu0YyvC6S+RBlRbBCX4ZSV8p2mzs0mUCHWptVTcbPpYLUyw5Co1cRl
	Dw/4+/U3IYLA02Xu8GXKQjkrdiWHCeJbyNZfyRPoxDK+IROpC8qZdDOkVO/SGJYtE3XxBLzHBz2
	1Djt/Yb5+rCp+5hzGPXL1ENYh4MhKjFzonvAd+w==
X-Google-Smtp-Source: AGHT+IGhwh+S+jhkNY/1uutNgC6p5kKt9+DTiGldjYiBH4HomH3CWM65ZklVI9sxKxFglABoy9HzyLqDTcef9Bghh3M=
X-Received: by 2002:a17:906:3914:b0:a45:345a:1a9d with SMTP id
 f20-20020a170906391400b00a45345a1a9dmr3392866eje.62.1710151314407; Mon, 11
 Mar 2024 03:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9d71a4fd1f1d8d4cfc28480f01e5fe3dc5a7e3f0.1709821568.git.sweettea-kernel@dorminy.me>
In-Reply-To: <9d71a4fd1f1d8d4cfc28480f01e5fe3dc5a7e3f0.1709821568.git.sweettea-kernel@dorminy.me>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Mar 2024 11:01:43 +0100
Message-ID: <CAJfpeguHZCkkY2MZjJJZ2HhvhQuMhmwqnqGoxV-+wjsKwijX6w@mail.gmail.com>
Subject: Re: [PATCH] fuse: update size attr before doing IO
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com, josef@toxicpanda.com, 
	amir73il@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 16:10, Sweet Tea Dorminy
<sweettea-kernel@dorminy.me> wrote:
>
> All calls into generic vfs functions need to make sure that the inode
> attributes used by those functions are up to date, by calling
> fuse_update_attributes() as appropriate.
>
> generic_write_checks() accesses inode size in order to get the
> appropriate file offset for files opened with O_APPEND. Currently, in
> some cases, fuse_update_attributes() is not called before
> generic_write_checks(), potentially resulting in corruption/overwrite of
> previously appended data if i_size is out of date in the cached inode.

While this all sounds good, I don't think it makes sense.

Why?  Because doing cached O_APPEND writes without any sort of
exclusion with remote writes is just not going to work.

Either the server ignores the current size and writes at the offset
that the kernel supplied (which will be the cached size of the file)
and executes the write at that position, or it appends the write to
the current EOF.  In the former case the cache will be consistent, but
append semantics are not observed, while in the latter case the append
semantics are observed, but the cache will be inconsistent.

Solution: either exclude remote writes or don't use the cache.

Updating the file size before the write does not prevent the race,
only makes the window smaller.

Thanks,
Miklos

