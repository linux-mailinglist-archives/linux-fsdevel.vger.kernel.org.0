Return-Path: <linux-fsdevel+bounces-22346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAE0916892
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C051C232CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0FA14D294;
	Tue, 25 Jun 2024 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OXQIcmwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5E41DFC5
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320697; cv=none; b=OEa9GIZkA+ZBd+iizbzH6DLz0/ihNiAwVh59uijQb2M+Vwmdo+DAvnyG7No9hrxB0XyXTVZXm4MRcRwglKmALLM/8XByPjCX+als3LC6zL3PqxQPF3LDX5bv2TE1uY8/xP+rfglghmlAyuSKUqLehbzHQyGM22Zihd9klEgwkGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320697; c=relaxed/simple;
	bh=lIfUg+VDS/cchqEdm4r4UEl/V9cCWSF7pjTIh7LTDiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3MytfxAwLfkttFv9aYbUk8YnsSIdR/n78N9FB4AP39gbYj15JwErGqFwCV6q2GHni4mvudjq702rux/8t/zElKeLyIM9LH/0PD6pNU3rU9o+sMuWW6JWAGUJl5WVOP3RKYOErFKjMg8ott4vPOVOXmNeonnQYierVG65eXZOOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OXQIcmwr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a724958f118so327636066b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 06:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1719320692; x=1719925492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K0qPtNHfGrrPgIi+Q0wkPvqlu48BcH8YJ3OvAUOUyZs=;
        b=OXQIcmwrG0JRdp9ePNKr76EI8iGp3UFIWJTQCQss/heKLcT/WvIlAUcdGO4NWaJ2Ja
         Dv+CgrwsVN89wwK9rvZ6u4KF+0o744sU+cgFumVcpFQ1H6LeUf186ydOzLjNK/Gpa0DC
         ajC6LvfPgfPVUCpFcNYKhGuWYQv0RPb6gtubo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719320692; x=1719925492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0qPtNHfGrrPgIi+Q0wkPvqlu48BcH8YJ3OvAUOUyZs=;
        b=foQ9IKTpE7Ke4HmmSQ4ZK8gLVyxYJwnPJ6lRtoeERPNHKhecTaJ7gY2J90kze9Tl1a
         g8UWKwgQ9A/q/pDO8Fkmpehev4pX9F9TCzhat9NZ5HAoEM0IV/3+ziUZnIESIjIyGJfU
         6/yxP+EwttW011OLJf1o+mdhRx5LUfx10hhQ6qc23kT9GS+6alRtmVyJT4iJYccz9AJP
         ykgq2540qOc0ozh4XLjijK2l4O3cbDxzW7eDCArtWYCCPfrZsbVn/G16hqMS+ODWmWXh
         K0bG0AqPU55kRVOXoRyUuUNzpKdXXKmgZIXTh9Fu5Ljyvb6skjgb7hsEM+oMHnMnP6kC
         MDSg==
X-Forwarded-Encrypted: i=1; AJvYcCWI+C2C4ha7V/h+++jXi/LcMzgvAVOHTfS5omtqd3fNYS/BrJtKzMe83NoCNDhw2jjCPFnEhdk3HAbIqBPVzB4gW3rFHvZ1ZyLQ+iebUQ==
X-Gm-Message-State: AOJu0YzBbKA3UkPak6gaaFKcAeVtni7ruu+mv72X5vjh0iI9zh1dFnBD
	8mhruEm9CTl1noUm1y/Zxxp+CU0q80LKM0BMyh1Aq1QthdRbUTL/yx3L2oLr6VkS5pvJ6laNgEt
	oDLMrsmpm6mNMkjhzuOBOkHpQHzUojk+4H6Yh8Q==
X-Google-Smtp-Source: AGHT+IGw/EFU70Qt9DtegI479ApTLKov+8ypGCM4Fi7wsNqw/JhvLeD4ubxfszLMdx0IJ8pFDd1F13erxA9+QHKKf64=
X-Received: by 2002:a17:907:1610:b0:a6f:6ec0:5558 with SMTP id
 a640c23a62f3a-a7242c38fccmr838611366b.21.1719320691912; Tue, 25 Jun 2024
 06:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719257716.git.josef@toxicpanda.com> <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
 <20240625130008.GA2945924@perftesting>
In-Reply-To: <20240625130008.GA2945924@perftesting>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Jun 2024 15:04:40 +0200
Message-ID: <CAJfpeguAarrLmXq+54Tj3Bf3+5uhq4kXOfVytEAOmh8RpUDE6w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 15:00, Josef Bacik <josef@toxicpanda.com> wrote:

> We could go this way I suppose, but again this is a lot of work, and honestly I
> just want to log mount options into some database so I can go looking for people
> doing weird shit on my giant fleet of machines/containers.  Would the iter thing
> make the overlayfs thing better?  Yeah for sure.  Do we care?  I don't think so,
> we just want all the options, and we can all strsep/strtok with a comma.

I think we can live with the monolithic option block.  However I'd
prefer the separator to be a null character, thus the options could be
sent unescaped.  That way the iterator will be a lot simpler to
implement.

Thanks,
Miklos

