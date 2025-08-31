Return-Path: <linux-fsdevel+bounces-59728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D60DB3D4E2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 21:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFAD1741CD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42EF274B44;
	Sun, 31 Aug 2025 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFk/bAnP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733719D89E;
	Sun, 31 Aug 2025 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756668169; cv=none; b=Rq0SxfoC70ogITyIbAX3A/8JRI/1o1p4Xu1J4OiTbAsszT8nKBZ7WQ+P/Wa+ryJrY1KbR0+d+tLwqX5AQsJZBXLl90Pjb7umqWiKZNfPkAHAttDHlkoyQKgBax54u4akunExGNtthi8xc7qIhTBrzcw/lrR+PkEY5mG1jPu4JnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756668169; c=relaxed/simple;
	bh=HEV6dnlhIoeyc8laZOOHU1IPiRHZVj2PJOI1v6FTq2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X92kQe6+Pb8gCNJH8ki13Yxx6vBkwC1JkmEENbyXWi72tPo+RnMFA7WtQLocEAcANkSLskDOQVsj/ntATPoaunJqEaTS7VEDRmKPSX/0BzY6wvAMrXWk7HY53V4fWb0uDaSMmZv6Y3UJYU/3H5fmJwRlPUBZqvB46mw5WoaBBV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFk/bAnP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b8b02dd14so2411045e9.1;
        Sun, 31 Aug 2025 12:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756668166; x=1757272966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yg3LP6sYvMUQaD/jgzhNvNjKvQd0FCNUTRQbAPX6ik=;
        b=MFk/bAnPkHS+2WU0Zz1RSbw0+DNyjCLKs98Wi4njg/YqoK7WJM79+Z+qKuckO8k8H6
         kHHdyFfcYt7NROjQWjCSLRDH485/I4N+uFDSxzuWwqYebxglUTy0Uc/BAH9I4vZfevW9
         X4XO39pAOv35JWqGGLP1378CJxk7mOL7ZYjTKxM4RmFrK+ya1t9Feme7aKKpmSHqYc4R
         Kl9Ub2sBz+Yp5sma2xxzdmNf7blF3CZHvae9Zy0H/RjCkNA3Z9pPOdeNda1mu26//biE
         X8RlkQcRwT2lLrsq7l4BNvHiq18b9BFLYLIMtRiRafvAvHtiXHVi5wFWcSVGOWQ6482N
         uwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756668166; x=1757272966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yg3LP6sYvMUQaD/jgzhNvNjKvQd0FCNUTRQbAPX6ik=;
        b=ss5LWhSemBsIoRtgzsVwXhn/Yu7p3wEh7Onv/n6+L8ch31CSFh19wfeDIuqt0iFYhO
         U9zUcqJlYXISrFij/JcsaAflhS1j/SmLSIVzMc+l6pLrjq4zy/PhJ252aXeL/mekCxdq
         +ynlYCmmtG46QCqJmUvvpdt7VuSDgjUCA3hj22Vd09TZGR9yZHIRFfE85Jf25L6TmvnT
         RoEyyG6jySx6Kw94sOyrMCqhsVpsaaZd0MiPgr+rBzv8HEsfonIAd3sIEYJqgEnrClja
         3jG6rZO4mqG0HQ2gwjhenHR1D1TYb3RAYNWKeiKdpaMKmfLSpMPhLrtnzdJ459+MrnhD
         ZGDg==
X-Forwarded-Encrypted: i=1; AJvYcCWVs2w58FmC8kLWoqdvTkfIplaSNLIBtmM95T8MqYUwpxQET6oHblzstQ5lLyhthrZNYDwev0NetzsyVOaE@vger.kernel.org, AJvYcCXSEOzeak1867Tiq44l2FT6GD/e4MdsRv9cGaw25vD4YqRZOz+624OI9emcZ/SkCBp6GnyK/FwSvLX/1RKQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwUegoRCt8RK+IoWqJv/CtHocmYuKVSR6SsqAk+0y0DOLaiLjFA
	YvLie55VXHQlhuMoFyXd7XILlj4MSiYrf2jhAd9kpCQPN4C++OfLn3ov
X-Gm-Gg: ASbGncsTi5SykvBmvWPuQi8A62Fl4x6VQrJr4nZrKYT9gMfSKy8WbTxlUDR6JFsCuJ7
	LpvFHIKF29q3huiJEhEVhaeGfq4KIo60z/+xBZRk3cZ08MF9nksQgXAGSrWbY7HYJvsKIUwd5AB
	ytcGX80c8avKYK9yf+/kdUTq2SPMUdnnknoH5N3dVcF1EYXRzGg5dJP8RSFrs6VS6n1HjvYS2pW
	qjjnkNDIqwwHsqq4/M21e07N53YxhQ6pgMFt1CzmV9xYXTaVr6KbBKhZBjvU6+x62Sfou9RT2GM
	q/tw1/FYPxqCAGP5TLl7v0gaSwEsTjCsS8jMUxgMfXSHN+egCGfg6sTWhEYTWPFPQST7NPL7I+L
	xgVh5ViSVaBKRvV6TEo+sFDH2GlCqQswEDY4oEXZZky63U5KOrdDUrb7FiGoBlLDG
X-Google-Smtp-Source: AGHT+IGd5IkEzM8l1SwWm5ZJYvsCXOq3J4HftAYHmzCTd8sAmyihD2uxngc5poeSaVGfGnQuIB2XEw==
X-Received: by 2002:a05:600c:8b42:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-45b8558b522mr37894525e9.36.1756668165571;
        Sun, 31 Aug 2025 12:22:45 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7fec07sm122566655e9.10.2025.08.31.12.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 12:22:45 -0700 (PDT)
Date: Sun, 31 Aug 2025 20:22:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
Message-ID: <20250831202244.290823f2@pumpkin>
In-Reply-To: <6d37ce87-e6bf-bd3e-81a9-70fdf08b9c4c@ispras.ru>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
	<20250826220033.GW39973@ZenIV>
	<0a372029-9a31-54c3-4d8a-8a9597361955@ispras.ru>
	<20250827115247.GD1603531@mit.edu>
	<6d37ce87-e6bf-bd3e-81a9-70fdf08b9c4c@ispras.ru>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 16:05:51 +0300 (MSK)
Alexander Monakov <amonakov@ispras.ru> wrote:

> On Wed, 27 Aug 2025, Theodore Ts'o wrote:
> 
> > On Wed, Aug 27, 2025 at 10:22:14AM +0300, Alexander Monakov wrote:  
> > > 
> > > On Tue, 26 Aug 2025, Al Viro wrote:
> > >   
> > > > Egads...  Let me get it straight - you have a bunch of threads sharing descriptor
> > > > tables and some of them are forking (or cloning without shared descriptor tables)
> > > > while that is going on?  
> > > 
> > > I suppose if they could start a new process in a more straightforward manner,
> > > they would. But you cannot start a new process without fork. Anyway, I'm but
> > > a messenger here: the problem has been hit by various people in the Go community
> > > (and by Go team itself, at least twice). Here I'm asking about a potential
> > > shortcoming in __fput that exacerbates the problem.  
> > 
> > I'm assuming that the problem is showing up in real life when users
> > run a go problem using "go run" where the golang compiler freshly
> > writes the executable, and then fork/exec's the binary.  And using
> > multiple threads sharing descriptor tables was just to make a reliable
> > reproducer?  
> 
> You need at least two threads: while one thread does open-write-close-fork,
> there needs to be another thread that forks concurrently with the write.

Is this made worse by the code that defers fput to a worker thread?
(or am I misremembering things again?)

	David

> 
> Alexander
> 


