Return-Path: <linux-fsdevel+bounces-26689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D5E95B0A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 10:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A31D1F218E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 08:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1786A16DEDF;
	Thu, 22 Aug 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MmrIqdAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD31802E
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315878; cv=none; b=hinN3wozn3RZb6LX6ATp8QJMgigxbFigLui4k1aIllYcwg6FzPoklMfbDrQkkZfn4/GBFoMJr5V9vpxFN0vtSoXRWQwMtndMq1yH+t/R6gzR+UryJ/DP7qhsWT5yQPMCz55mGfrvhSgAJPDZvjYAjW/G7CHrPrTXcMnHkd3bDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315878; c=relaxed/simple;
	bh=YK/wY0Q8c8fFlOEwN89OKeq0aWqtxZjc5L8ppeE02v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5FHw9zBkKnf4U7gQnyYa2ips8elr1PZU+VXXCBQI8PDozh0Vomxqx7PYZZxuwunEpQ0GemGW5T7Z45+6E/gp5GlNw2taTfB+Em2oZxkIbD3rflpCsiWYiYwZEJIe0DEXyAsWs1wOkoQ7YZAZZAWUcs6qX6d1fYNRqwF9JCw5Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MmrIqdAD; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5334c018913so514188e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724315874; x=1724920674; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yjVJ54tHR/P4TxpjR1xroRokFa0pGOROHMnQbJkAz5U=;
        b=MmrIqdADm8m6bICz7A6MZ6kTC7ecDYZOeSYSsSMtzROQOrrRf4bD+bFQjt2a6v+Eu6
         /32qkJ+aCHP9AHB0rvLzVl92Nkn8pXc/Ma6jfUrUiijv5phrwwf75SQvdWgP9KJ0QSZV
         JERhMfv8DviJP8yWdwsUCu9/x8ya2+h/We0lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315874; x=1724920674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjVJ54tHR/P4TxpjR1xroRokFa0pGOROHMnQbJkAz5U=;
        b=ae8lsfnaCiuSqkUztr3/qAQSNYZObkoaLMf2pAHSfdwK/ffdbuOUHig1fCqXe7r9Lv
         dTwbwL69v5WJFv6AArqzvDct/gplNMOi9HIkLlMJWHA85plFZ2qFHGKyOObD7sVy+Vtt
         uy3/b9BGMHG9t7bOQcVmst3jjeuEDrhhH2yU52Jhz8SOiGzYg8O2hDB91Cl/zC9kEjfY
         onrp37wv94nvWdciMiESXc6a53YRy+5g3znAW8UvTP5e3yz06B8b2ezLchG8Xb/QrLki
         vSA/4S16tGzKoPcvwlZvWfXtWt1OHfX+4PQXOH4dHeoCK06aXa0Pg/hfM8de+z12Z5Qw
         LQZg==
X-Forwarded-Encrypted: i=1; AJvYcCUcX2niqW2825WlSgOExzfbbzOp0TZuwskvRMIU2yI5DuBXkaMrdHJzHdf/2Z6GU6IGjLqqEGE2K3gjS9ou@vger.kernel.org
X-Gm-Message-State: AOJu0YxQMHxQ3eJKyBz4AaGhHMBkklEqH1x1HJEh+rQ6qyFlKUibfVsi
	TV80d/CHz6RJJGGrHmtfCoUE39gXAl1x9mbf2aWEmZV/dq+PqjOXnfNUBozCCErm65oCr8SsggG
	+i/6T6g==
X-Google-Smtp-Source: AGHT+IHCJCO4hwo3ozhi9hR+4TD/qJ9zR7Nvi0cR++wKLNuAX5YnD4PngOKT0aPmDDROrrTxuX9BMg==
X-Received: by 2002:a05:6512:3b23:b0:52e:934f:bda5 with SMTP id 2adb3069b0e04-5334faeb6aamr692167e87.21.1724315873544;
        Thu, 22 Aug 2024 01:37:53 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea593desm162406e87.140.2024.08.22.01.37.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 01:37:53 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso4698671fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 01:37:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIvICZH5sC7QjrEdAEvEVD28Dzy7Vc/cSzPg71mlWaAOwUJapEe8j31ZiZLM4KJ8yDHd3xrl+vl2GBwJCp@vger.kernel.org
X-Received: by 2002:a05:651c:2121:b0:2ef:20ae:d116 with SMTP id
 38308e7fff4ca-2f4059c7a35mr7968631fa.0.1724315872472; Thu, 22 Aug 2024
 01:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-1-67244769f102@kernel.org> <172427833589.6062.8614016543522604940@noble.neil.brown.name>
 <20240822-knipsen-bebildert-b6f94efcb429@brauner>
In-Reply-To: <20240822-knipsen-bebildert-b6f94efcb429@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Aug 2024 16:37:35 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjTODh1p9X5gTTBBESzdJSOR77gamvOk-KQ5MCv-5A87Q@mail.gmail.com>
Message-ID: <CAHk-=wjTODh1p9X5gTTBBESzdJSOR77gamvOk-KQ5MCv-5A87Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/6] fs: add i_state helpers
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 16:27, Christian Brauner <brauner@kernel.org> wrote:
>
> >
> >    /* no barrier needs as both waker and waiter are in spin-locked regions */
>
> Thanks for the analysis. I was under the impression that wait_on_inode()
> was called in contexts where no barrier is guaranteed and the bit isn't
> checked with spin_lock() held.

Yes, it does look like the barrier is needed, because the waiter does
not hold the lock indeed.

                Linus

