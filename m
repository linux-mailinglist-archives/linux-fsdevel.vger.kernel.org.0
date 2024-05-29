Return-Path: <linux-fsdevel+bounces-20459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B218D3CFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782C91F22C2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC91194C88;
	Wed, 29 May 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T1FiufcM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E3194C6D
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000709; cv=none; b=tVCRZ4gwywRzHYM+Vq1MEOuTNLplmAnhzL96W6acY1t+XUqi/YKjG53wadxDRl1AIXKolI+cVV5R5BMnVGCY5FOJtLh0sPf1gIGeb5kmkxv7RzrRcujnqjluiiGJeso6drLv/BD9fPnA5yw1amqqMZdYo96zddfYPX11TjsV7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000709; c=relaxed/simple;
	bh=n62JW954QEMEN8kU8631qHanrwdqcccUF5S3VBPtOqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bqkk10C10bwgb+Lc/XjkEixZKV4Jf11K+bX50JdSizDY2ovzcsIZLE7+Uow0PKCsPfVe+NQw5YcwZLbdPPRn391qXZVV5n98/Yb5JgAH9OSqM8w2fAwBciWCcCrKJDxqjvtrqQG3lQ7otUXHAuQ43S51Eyir293ipQk9/VhZCCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T1FiufcM; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b0d25b54eso1400648e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717000706; x=1717605506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RCN7EOEnVC70hLcRtdygQ9XQdGWocXnG58vuARKxgkQ=;
        b=T1FiufcMMm4zpzSdzPwEE3GVl58aEIJGOyc/n+g4gJh/Y7vTNkFGo+Nf9d8aa1pTY+
         COs3EkuwdTbVq7lkBgTvPOXA4KZL2EXre4QblrvUCCdPC7vUh0uHLrq7ifBLh/++betb
         SpoIZf7vhuC+CgWEL/hyV7W4m+02U7sCVBD0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717000706; x=1717605506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCN7EOEnVC70hLcRtdygQ9XQdGWocXnG58vuARKxgkQ=;
        b=V+rW4kE9YyL/zf1pJDUsF/Ka0mTW96yyHM0KjPUZw9mM8oRSaJBZOtrje8wn2aSvvD
         QUOcoWNJ29lUTHBD2/8Lz4FBfpGP8L/CxXqH30kxrp/CLErmfvMO5xDuOQoUSwd1r5Qb
         fF67V9OL6c78pPfNUZxzsresHcQkpTXy/kVOPBgrupT5R53LfMLlV+SM6+RuPLKz9yAA
         /EC6Zr2bebD8aXGRyHA2+xdPn3cpF59XSJbNTc9OcUyeucCUOnUEGotd6977UFks9qkb
         ZUW2qL3we+2OMJhlCHrwGNVmkHAIVgtQ0k6vbtFKXjaca54VJsq2i6jErRcKc1gckH57
         KY8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXerf4LTniTvKzVIVecim8JOFC2hUH8F5JJrGwNtknlcXkC3P+4BNYpl+HWiIVGMhVtx7hZpykQQjcm8E0LMSkqFO+gfCwys2tur3tSgQ==
X-Gm-Message-State: AOJu0YxM18pdIBKj2p20ssuuNt1IMngC94hU/YF2fI8pvLOGNn2HO54+
	l9EsY9c0S+VhvIg2W72egFIDMQfWVF50TQ9KcTVMfJH3viJJU2Net6+yzRD7Jb/OGlkQNh114mE
	xhClavw==
X-Google-Smtp-Source: AGHT+IHyvpvQH+PujTPLlcKBOxFiqfrFloJeopHX6BsxgEGgklLbG1CgDzXjkidwujD1GwONHWMVrg==
X-Received: by 2002:ac2:43b9:0:b0:523:ae99:b333 with SMTP id 2adb3069b0e04-52967a26df9mr10803952e87.64.1717000705989;
        Wed, 29 May 2024 09:38:25 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297085560esm1317112e87.162.2024.05.29.09.38.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 09:38:25 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b0d25b54eso1400613e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 09:38:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+lU/SNGUCCFfvpBzrWgexKk6/VVeTC9ZEV9MIDeffgO8a3mKlWBOnJb9JSaT1Kd9pyWmLJnBd3Un/ZnVqjWGOGIDSamLWHNR/Pk54Aw==
X-Received: by 2002:ac2:454e:0:b0:521:92f6:3d34 with SMTP id
 2adb3069b0e04-5296594cf46mr11225856e87.22.1717000705215; Wed, 29 May 2024
 09:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405291318.4dfbb352-oliver.sang@intel.com>
In-Reply-To: <202405291318.4dfbb352-oliver.sang@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 May 2024 09:38:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg29dKaLVo7UQ-0CWhja-XdbDmUOuN7RrY9-X-0i-wZdA@mail.gmail.com>
Message-ID: <CAHk-=wg29dKaLVo7UQ-0CWhja-XdbDmUOuN7RrY9-X-0i-wZdA@mail.gmail.com>
Subject: Re: [linus:master] [vfs] 681ce86235: filebench.sum_operations/s -7.4% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 22:52, kernel test robot <oliver.sang@intel.com> wrote:
>
> kernel test robot noticed a -7.4% regression of filebench.sum_operations/s on:
>
> commit: 681ce8623567 ("vfs: Delete the associated dentry when deleting a file")

Well, there we are. I guess I'm reverting this, and we're back to the
drawing board for some of the other alternatives to fixing Yafang's
issue.

Al, did you decide on what approach you'd prefer?

                     Linus

