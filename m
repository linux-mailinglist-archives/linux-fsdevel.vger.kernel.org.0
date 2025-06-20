Return-Path: <linux-fsdevel+bounces-52298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD552AE1360
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 07:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1373BFE8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 05:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280F219A70;
	Fri, 20 Jun 2025 05:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UNNNhMuV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF452185AA
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398535; cv=none; b=D+4H7l9frVjjLO9k6/9Re9oHpb7DN3fQolM6KK8YU0jWJfyyM3E126wVXCndKyzVPmwaeUr0N2Liz02ocuAlAoj1LL5b0toywJ4pF8/rJXhvbPvG/ta8SgSBsXIwqVh350kfb3mIC6TKteBoMaEsBAJCNZQ/3fpmqv9gYXtnlKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398535; c=relaxed/simple;
	bh=V8QkqaxQAQuLib4lqq1N57Z30hykUI80qoFkT3dO3vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlhSvhdJmoldw06FOq9VJe0allmUhl448y8OOQowsA/XhnJ9RKkONeuTuPeHlyun3/cI1j/QCYLkUliEdJctJFHKgk8L7K1w5LQb75s+YCyo67Xww2Xipt2yOIBKPmOTn8SpuPNlgpM739XS3v+vCM2r8tSoO3rtP5p2CIwL2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UNNNhMuV; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7426c44e014so1190691b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 22:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750398532; x=1751003332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+lBZelaHP5PPmkOntc4jTfDIo6tAIeer+XpixIir8SA=;
        b=UNNNhMuVDZ+We/cFGC69fE5rQ05UsYm1OrhWL+/LBlYdnwlC2uEJn4ws4MzxoLk2EE
         u/hKR+z5wHJ8sQumcLX9igKUut2iFA7LsBPL/TZkSTlEMtCURzf7xcV1vSEy71UkClOu
         o5EN21lxxn8FLhfrfekR0jse5DRfzBoxBbit4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750398532; x=1751003332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lBZelaHP5PPmkOntc4jTfDIo6tAIeer+XpixIir8SA=;
        b=ZMB0t8/66zPI8zBmVlr87Zete3+zEVDd2a0j05zN0eYBwgqryCN4rCp43M4T0b9PvY
         Gi/BZP5g40TOPbZHtxGSx1ghIBA8qdCAn4CXHnYSvw2+tcFLAxQT1MAbLEWBOEmZrUZ7
         2xp7RoCHGGQnpIkwwd3YJRvp/IA8RTGpeASKRY96MmfEjbvdX2mGB6DylaiLV9Z5xiS3
         jj8t8U6h34yjU0n60AcpAwEFosnNvTFIQJkuolUdaNOFUj8ZRkSstN/P0YQ9Vy9GyzZ9
         0OZPJky9DXB9Fde/8XENJEyHe3h1ExbpvjVu30X6KzF02ffrbpSkOmo2mlnD04GcgwFr
         mrRA==
X-Forwarded-Encrypted: i=1; AJvYcCXLWkTjrmclz8/TBXKxPxP0MqJNe+i4VsWzIo1W5QV3sCR8tfIqTk4dix55heD31HqaZVDFkuzt0UjsVC6P@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3B7TRfoHiU63xdMF303/KATFbjING5c+0OGJJJlU9v2IbNJi
	orLGcFhixI4egBaqBdUGqOvyaxE325pmFPstNlnf/yu8sUq0w0VRnrsmFOb8RSiCUA==
X-Gm-Gg: ASbGncuiPvpxzEXgE6xSY9niK3qg1AKRPNKlY1qgi4za9qqnd3rBXPa9yonSBi4HnIn
	3AH8DLFzRTKnzpyxzSE1SkSeKlLqE+rR2JCF8MRtzI9f3i9vA4dSYMZGkVCFJjPkptG7pOhoYNB
	ELKiubfQVaAtbXWihJPYI+wL6a4HmQoeY2szc8CZ8eii/kO4yMCUyD3mCeCFw5xihxjzSgYDKCD
	56UZtUwMT4cc+m+upyqf1Z3uW6r7LuUcXGOfi0ELkdFcH4cuwV2HaVPH8/HTvoe7cm8xcS2lt/C
	klxztGglQfclZEPpP7ZdrhycjQiLWDfTZ9Mm9PZjXt6COKFpbESboP3haoK1EA7hcY9rz07XM3/
	O
X-Google-Smtp-Source: AGHT+IFnwY3Uttwxpg43v/GRn75nmvSevZmO5+9GhZLPDpi3uUpewN6wR/MISTt/iaWqRSujZovrjw==
X-Received: by 2002:a05:6a20:7f8d:b0:21a:de8e:44b1 with SMTP id adf61e73a8af0-22026e6bde2mr3126942637.34.1750398531939;
        Thu, 19 Jun 2025 22:48:51 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e574:cc97:5a5d:2a87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a626333sm1142575b3a.73.2025.06.19.22.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 22:48:51 -0700 (PDT)
Date: Fri, 20 Jun 2025 14:48:47 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH] fanotify: wake-up all waiters on release
Message-ID: <osoyo6valq3slgx5snl4dqw5bc23aogqoqmjdt7zct4izuie3e@pjmakfrsgjgm>
References: <3p5hvygkgdhrpbhphtjm55vnvprrgguk46gic547jlwdhjonw3@nz54h4fjnjkm>
 <20250520123544.4087208-1-senozhatsky@chromium.org>
 <bsji6w5ytunjt5vlgj6t53rrksqc7lp5fukwi2sbettzuzvnmg@fna73sxftrak>
 <ccdghhd5ldpqc3nps5dur5ceqa2dgbteux2y6qddvlfuq3ar4g@m42fp4q5ne7n>
 <xlbmnncnw6swdtf74nlbqkn57sxpt5f3bylpvhezdwgavx5h2r@boz7f5kg3x2q>
 <yo2mrodmg32xw3v3pezwreqtncamn2kvr5feae6jlzxajxzf6s@dclplmsehqct>
 <76mwzuvqxrpml7zm3ebqaqcoimjwjda27xfyqracb7zp4cf5qv@ykpy5yabmegu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76mwzuvqxrpml7zm3ebqaqcoimjwjda27xfyqracb7zp4cf5qv@ykpy5yabmegu>

On (25/06/20 13:53), Sergey Senozhatsky wrote:
> On (25/05/26 23:12), Sergey Senozhatsky wrote:
[..]
> Surprisingly enough, this did not help.
> 
> Jan, one more silly question:
> 
> fsnotify_get_mark_safe() and fsnotify_put_mark_wake() can be called on
> NULL mark.  Is it possible that between fsnotify_prepare_user_wait(iter_info)
> and fsnotify_finish_user_wait(iter_info) iter_info->marks[type] changes in
> such a way that creates imbalance?  That is, fsnotify_finish_user_wait() sees
> more NULL marks and hence does not rollback all the group->user_waits
> increments that fsnotify_prepare_user_wait() did?

No, that doesn't seem to be possible.  Sorry for the noise.

My another silly idea was, fsnotify_put_mark_wake() is called in a loop
and it tests group->shutdown locklessly, as far as I can tell, so maybe
there is a speculative load and we use stale/"cached" group->shutdown
value w/o ever waking up ->notification_waitq.  Am running out of ideas.

