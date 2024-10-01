Return-Path: <linux-fsdevel+bounces-30434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C99898B441
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 08:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930DD284201
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EFA1BBBF1;
	Tue,  1 Oct 2024 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpIV/K6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0389A19046D;
	Tue,  1 Oct 2024 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727763938; cv=none; b=kF74BfEOJjuhgaERrQY4JrG+pXA/hAaTl8VckjlzR4uDPtMZbQUgt9nPpSvmQYGbO2WQyYm4il96FYqsheTH1mwodOmtU3S42G/ShO39wCUnhFY0rpl5MfFMRpAX6Gk9SxGRFO37jkFfNb4qKaPJxf/Imce/vWBh9bMQm/w1fKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727763938; c=relaxed/simple;
	bh=SDEAHsJ/f6Z17yj5MMAPVYkEKm1nbutbrgnE6edLQ1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpb6Ia6Vlgn1pUYQX1jxRUCMvU/7sedJKtELOElmKszlldoBITCgX9JnYho5E9JtNmZ4iBF+q6yHapTMKJTH9g+FqxoKBzQD3UurvTK3ApOhSBy2zucVpneOFluCgSfN1zo9ZOFZCdOAsSKNY5OqFSNG09tB0Tn6vWW7whgdX84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpIV/K6O; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e03f8ecef8so3249916b6e.1;
        Mon, 30 Sep 2024 23:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727763936; x=1728368736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMTe4WCPIbVD/SfU9sxR/iUs1Fd9iOBERyBTIj/x0eQ=;
        b=RpIV/K6O4NwmbUBTGLtd/XuphMKADfJ6vUUkZbNDh1tmMBIFtSYMpXLiDRzL5mqsh5
         wHchzsGCkhQBJWVpUd5cDQS0jnVUoXhjlYsz8brCsV5egEnztFjM9NFvkajYcHTta2LG
         fBEBnPVt8GHloP5yOBU3KQbj/A9lzZPMomMbz040f4Nhd20WjVu7JpNiLHL9uF4RQ5Cu
         zNJ0aPGP1bEV8CEF7KZ8aAQzHIDjjhmUeYC5u6rsdpGr++tr9/9/Orr8cbjnIywvIBaY
         4ZdY6BYnh5b2WDYBovlk3hWAO3YMWvIgELnpI8spo0UcIJ7lPtlGlBeR2tNaL24zIKkD
         /whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727763936; x=1728368736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMTe4WCPIbVD/SfU9sxR/iUs1Fd9iOBERyBTIj/x0eQ=;
        b=UEFWsBX20/AwFXZVFj6DnofprAFKJkTrfAUiBDG9GL8ST82JgzCgqg5VY0aACQL+K3
         T8C402tpGaeWLmnpRFF/00itEHJE4NWMT5vEYSn0jG//cRNAyOGa30hQkXG7zzs4W6Wg
         t5Rpm/YNPTleGYgH5bDf/Ld+K5N/TGRmW7jsfazxpM7UyimRbCmfLeGUHrGXOs47T6Jg
         XPuL5ASTenwTbXkIEGvoXdhoYKrZV2r0wH95y1fDcrdV94onDiwzlF+hGZIMGuyeJPAj
         ZEywi0scBBdDimAZ7yA9w9yFe9iATp0ysG9Kbf0TcpHtx24Ay9NksHw0EcWMO0vYtTjZ
         pgNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKycp2MWMpG1UsYwmCFzOD9UfezdsD6YfEgZCN053Idou6ZUkVLslW2ZocVqkC8FasOE+Z3GCrNCAiBqcT@vger.kernel.org, AJvYcCVkvm6ta5dErjfcBSlMg/8UDzfci7947Me8yzdt299tcLnGDpKAfIMgW3N/2wwlhaNBkOPg68XBYfK+3E1X@vger.kernel.org
X-Gm-Message-State: AOJu0YzYN1Y1Ew2JHhcNvPQijDgjs8m3ErpOv8zHnZerKOexRiHgul/c
	p6k/XKuOMY+06oMwbNdtAaOEN9tSoKYWnZA505KIPtc4o8YhXgV2
X-Google-Smtp-Source: AGHT+IFuiqheCF5J619VF74VTHT4R1d7m2PaCJLI4zzhZ5KjAej0T+420gSpuHK1kgES5kwtZdo19g==
X-Received: by 2002:a05:6808:19aa:b0:3e0:4076:183b with SMTP id 5614622812f47-3e3939d402dmr12736707b6e.32.1727763935978;
        Mon, 30 Sep 2024 23:25:35 -0700 (PDT)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649b0fdsm7284059b3a.40.2024.09.30.23.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:25:35 -0700 (PDT)
Date: Mon, 30 Sep 2024 23:25:33 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, jlayton@kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] netfs: Fix a KMSAN uninit-value error in
 netfs_clear_buffer
Message-ID: <ZvuV3QzwrPcC6yYo@gmail.com>
References: <Zu4doSKzXfSuVipQ@gmail.com>
 <743844.1727075543@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <743844.1727075543@warthog.procyon.org.uk>

On Mon, Sep 23, 2024 at 08:12:23AM +0100, David Howells wrote:
> Chang Yu <marcus.yu.56@gmail.com> wrote:
> 
> > Use kzalloc instead of kmalloc in netfs_buffer_append_folio to fix
> > a KMSAN uninit-value error in netfs_clear_buffer
> 
> Btw, is this a theoretical error or are you actually seeing an uninitialised
> pointer being dereferenced?
Apologies for the late reply. Yes this bug was reported by syzbot
(https://syzkaller.appspot.com/bug?extid=921873345a95f4dae7e9) and I was
able to reproduce it locally on my machine. I've just tested it with the
latest upstream and confirmed that the bug is still present. I will
send a revised patch shortly, please feel free to take a look.

Chang


