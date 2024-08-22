Return-Path: <linux-fsdevel+bounces-26784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D7B95BA0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E0528496B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE50B1CB30F;
	Thu, 22 Aug 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GOl5+j1u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F021CB12F
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340376; cv=none; b=jyASoCAcaLqzSuXQQOvfD2JUACQ+q+s1f8lQqLA4mifEgnAon2xctkTBXlRRkCe2joMXIq4uf+kyswgSeLTDlmgiSCx+KL3AXmOHIxjiT87T7Y9VK1CFKJGFG05cxMA0Szv5FKfaJxav3UhCPIR92X2zRbAbjgCom030fKuvY/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340376; c=relaxed/simple;
	bh=7G70Y1kwrug6t/zXK9CVL0QCx41TGdO9hj+d+WwvsgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKwBQINnXf/yCth5+/PxJLexou3QHVxiSsDhPa0seQNjmnn5oI2HOt4VmpjlTzTGOLSsoL7XLCS3JgXoMRzF5/rs9G5ZdUzS/YA1ltQ5/wpuSnQWjy6sJnERVLYpKG5BCnR/HG13LTGTB5NFF6hFUk3gqoDkswKDHI3TOMA4TVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GOl5+j1u; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e13cce6dc85so1005367276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724340373; x=1724945173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7G70Y1kwrug6t/zXK9CVL0QCx41TGdO9hj+d+WwvsgY=;
        b=GOl5+j1uRGLlJNIKPATQb3GlmK4rIB3cOZec4vJDFkXHYpPvbMfYBx6SaJBTCY3wH2
         mLYZoyRtiCRogc5Gm2jbIiPTxRcTGfGMgK/Gl/HsOG/FVZBwiajfaq/9erc4CU+UOScQ
         rmWuh2h7d0RwICkkTrfKWFnm5xk+iGehLeLds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724340373; x=1724945173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7G70Y1kwrug6t/zXK9CVL0QCx41TGdO9hj+d+WwvsgY=;
        b=SAfT9uC0/iXHHX4MaBsg0ieqWpmiPl1XHYelDzRcQ9sCiZg08s98KeFxnTTCj/YlJ+
         EIhkhAqMj+C5rGa4ICszYs8UwOuHdO743iv/p/BrKY3gIKuhfm+S9xo79YDSmFDULB1s
         0ikOadOaFzjAk2mcZ27Pzx1ncPqoYkT8gOug5ekVzHQGbFwoEEOqFJr080J4+bTkLgwJ
         OcqmnbAGtMvPan6WTQ58pmbd0dmUAU4ZaeS2E2MRww3qnzsH32nUDmv/jEf1hLYCA3DN
         zNOPbwkoG9uhuATXHzyqhK0N2h50lDoXaMYeoC8PzLAsawdkBK14+4HwQZ0oGk8li4wU
         U2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVCxjnAJSnNWxi2eXGeTfzUvouf0m3nmZ3tt5gcGZ08fqAcwVvHDCHCX1MoAT4G0233YSoxS1orThJnx7QX@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGFo8V5M7IISvUuwyeJqbovDZEb4CrL80xl/Cdk8R2froOr8H
	g4ObhUqNTwYnmw9BZzTzTAiRIyWvMgLSAYs1ZxCqa/Ics1aRhtSncQI2fsYT+q1h40t216Xi2o3
	484ZHxCitifVCidBT9GfOXjTBRNIRwj0JepirPw==
X-Google-Smtp-Source: AGHT+IHUZVfR6/m/APaLku+dmtsB9iZadnsoW/9YF1iuHVYaYLDkri0m8FvJv1N8YqiNcBx+Ea1hdKIYPDE/P7W1o/4=
X-Received: by 2002:a05:690c:2fc4:b0:64a:3d6c:476d with SMTP id
 00721157ae682-6c09dbc01bfmr55703217b3.25.1724340373732; Thu, 22 Aug 2024
 08:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726153908.GD3432726@perftesting> <20240727100556.1225580-1-yangyun50@huawei.com>
In-Reply-To: <20240727100556.1225580-1-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 17:26:01 +0200
Message-ID: <CAJfpegviwk5F+39Vz2D4UjLaGpsFZ-26WeDwetjL=hWV4T6S7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: replace fuse_queue_forget with
 fuse_force_forget if error
To: yangyun <yangyun50@huawei.com>
Cc: josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jul 2024 at 12:06, yangyun <yangyun50@huawei.com> wrote:
> Since forget is not necessarily synchronous (In my opinion, the pre-this patch use of
> synchronous 'fuse_force_forget' is an error case and also not necessarily synchronous),
> what about just changing the 'fuse_force_forget' to be asynchronous?

Even less impact would be to move the allocation inside
fuse_force_forget (make it GFP_NOFAIL) and still use the
fuse_queue_forget() function to send the forget as e.g. virtiofs
handles them differently from regular requests.

Thanks,
Miklos

