Return-Path: <linux-fsdevel+bounces-27622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB4B962DCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 18:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D201F2138A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C2F1A38DE;
	Wed, 28 Aug 2024 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="c+PgQnGO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02B188013
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724863087; cv=none; b=j5319U/leZMGFiLkpX2KyuJMAQ1nuLOK7XBT7fHbfimlKwSl4zpjBF0hPD4BkkEfvI371XEyQBikZCSAUqZI7tXMKjzmHMGjYt9aXHKeYpN8tOohAZ/ycBkzJqB73GXiB2TYlUwcxHD5ux9+JFSdrJP6YEERXrVkmiaOLWMRbsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724863087; c=relaxed/simple;
	bh=A8OB7f+0hauV+1MttJFYkyDlKvN3pdgN6XtcT7tx4RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1G5gn1oGgJ6V0ZXQP1dXWtASVwB83nFJq1aVA7Uk5ccjNfSvrHMKRB1q4VUmnf/8p91YlUMWi04tpDS6phgbDG1C78EMDZXcb4GICAwU9xAdP4nBhm7/UpYRMa6GOXIXNu+FOibcdhkey5SISP2MRebBDkG5IJwF2gyC3fIwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=c+PgQnGO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a869332c2c2so144542666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724863083; x=1725467883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A8OB7f+0hauV+1MttJFYkyDlKvN3pdgN6XtcT7tx4RU=;
        b=c+PgQnGOrU9ZZ4SIL2Un4alX9tgIMPWoay0EsdMWKXrJ1fxQWfyQ73CVgAxXyum4F5
         aRa8qM3jo3c4tjM9CTSuiZHm+uv3PAfTl+pEdZjj/VWNQPMFkTDB8vvfYKbkPEUjj5wU
         J1MDumQ2MdjxAWHFJsK3bhvp0+uxzScovzn6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724863083; x=1725467883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8OB7f+0hauV+1MttJFYkyDlKvN3pdgN6XtcT7tx4RU=;
        b=C5mYYCfm5U37RsBaTXWy1XmRT59gzSMmLZJejy89TcI9pQ4phgmMyhSJjf63nEcNEC
         /jUZCzgfoLa9xdWgUFM/HeKdd5TiwTm877JTWFIhut37tgG5heYp2A88ZChZov2E1ruq
         w/cvUpU6n1JrR8JwETCpCplbCrJvzt2TdXHgZlBF12abvQmIfIcsduUazO5zuUHuf/0q
         6efpLtiDzXe9kmoZ2xmLujaAGOrFaEX9PvSO73cUWIHfgLr65Oa9STcFF0WQp12sIomo
         2emCGzev7OSKPiBXV5rgqCkcnSs8KY7NK3FMuwnf4a/l0XNKVQFwhDsI3pTi4QdEYrqR
         9VSg==
X-Gm-Message-State: AOJu0YzZ9VZ2kdBkg6gS99PrynnuR3cGxP7s9neFusTRwnN3WK/CfCuH
	85Fezy+OXPIC1cDJcZmPnAsWqwYUSKw0pRJYlZvE/F4EoCFCCnDN5XzAGnl0aBBhVm1QWJYjP7P
	kIt0GvQZeRsnfgPkPHZ3iCNRw/aRqAezlIVc5PFIRj6docWiH
X-Google-Smtp-Source: AGHT+IGGc2YD+ool/n4JfDkgWuGUqLBmU6R1+PsNgJBHr8RNoX9PYJ/MdZMB81GWhok3UCsuUQC0ZtFZeLN5w8NNGRQ=
X-Received: by 2002:a17:906:eec2:b0:a86:9ff9:6768 with SMTP id
 a640c23a62f3a-a870aaddfa3mr305056766b.22.1724863083519; Wed, 28 Aug 2024
 09:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703173020.623069-1-bschubert@ddn.com>
In-Reply-To: <20240703173020.623069-1-bschubert@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Aug 2024 18:37:51 +0200
Message-ID: <CAJfpegskAht-B7_eF6o3_hQaGBe8CB11COGdpe-=5=XQ60ObOw@mail.gmail.com>
Subject: Re: [PATCH] fuse: Disable the combination of passthrough and
 writeback cache
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	amir73il@gmail.com, drosen@google.com, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 19:31, Bernd Schubert <bschubert@ddn.com> wrote:
>
> Current design and handling of passthrough is without fuse
> caching and with that FUSE_WRITEBACK_CACHE is conflicting.
>
> Fixes: 7dc4e97a4f9a ("fuse: introduce FUSE_PASSTHROUGH capability")
> Cc: stable@kernel.org
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Applied, thanks.

Miklos

