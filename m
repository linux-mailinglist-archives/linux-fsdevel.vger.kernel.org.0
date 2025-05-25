Return-Path: <linux-fsdevel+bounces-49830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB04AC3746
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 00:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213643B64B0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 22:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC37319ABAC;
	Sun, 25 May 2025 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fo99h9Sv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00FD163
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748210776; cv=none; b=Wd7e1kkHZl9/putYREL2B3Roh7tJidb4W2JccsFFOiZ/oZqyIQFbwUeMil7CD+gPdu8X8kv7dzQ4vqPxrNOmuLSq4tx08sukQa2BpKoGCgeL1X1S7KEBAePExPKR1fRQ9Ho0anZ8yFZnXohNlVtb6HB/5XTU4b8f1m+pKh5D46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748210776; c=relaxed/simple;
	bh=drBYIXao4n2OLz31nca1PGmY9vMhdKA/yxFzkIzjevs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9KNM8ZTrAlBb30DG9aGk3nuiCdiDQ5PxI1zU6Vm7UjnuimzeW4t2RHQURddlZwpuSM+DTZ4ZvfDui/lycJrbhuelUsK86pRe/HxeJlFUM5FqhrTnSJ5k0llEwbgjfOUpB3QIDaLEH1wGvCwfko27MU+ApqmJdmJeQXxUDnBFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fo99h9Sv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-604630fcd3aso908523a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748210771; x=1748815571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pfiz8+dxBBRT2DE5cNKPsKLH1ZvHcClUeQZGYjiTl60=;
        b=fo99h9SvoZ+QCU0+Sxh4QA6forfB7aTS+m4RKWUjYBb8Z1rfvm3iXdE8zLvV7zuFKn
         bklY17jX2H12YY+qGZlM3O4oemZIAjyLIiXR6EzJ6OTdAkEAXE05BwzuipyrpGE5bTCI
         D3yTnz7ve8oG2b+1Wy6alXeXWa18i8Ed53yFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748210771; x=1748815571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfiz8+dxBBRT2DE5cNKPsKLH1ZvHcClUeQZGYjiTl60=;
        b=QORQvyCRqN+AQUHnAUm143smvYisJNMUmLlaNkzfGARb9ZPZCcv4WuMTFhN8Q8TQ6A
         sGLl6XDKJ8kZYrrMAz/Ic1+pG53JpMUpUTD52jj9kZh9hHCQW4ju4qvcXwuz+iSMhhtJ
         yHRMzz9yEilDqESKDVfhN5QxX6oAJOYB4k9b2QioqNKCUXMgofaerqrjlJdAlODYeoLF
         mf3jv0jNUciIy78wGNqSIT38X7HFNNIJiMp74obnArBeJQ44TUNvD7znGfv53P2e/UQx
         4be1ZnevJ4ON8V/q5LrgmB6WwyQBHnZDMj54oegWrEe6+TzLwUGXEXbylXYnj4b22vDH
         ySdA==
X-Forwarded-Encrypted: i=1; AJvYcCXJWDkhsdMD4YBfv0MQ11K2SGRIy+ELW4vtd247fU+CMQeikgV86sVouoLHiLoZT6+G6agASIjKiWIFksYo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/u+wLXL5d40+WVvY2jg393NPTzFDqb1Pupg5tSfw8xkSG6ZgK
	Y2ZQF1rcMgpJEJPcBF6XzVo0JoFUzPOh4ymA85NjIBl7x4fLUhfNsAQtSsIsKhOrQXJ6e0DMaRo
	cOFEU7As=
X-Gm-Gg: ASbGncvgXl9OGLE9YqP9Z7mpuTlz0XnsPj7E67vKlBOMQHGIK88mMbeAvTfbuUnM9FE
	kcwCi/h9/rPBtrx3rFiJD2hV7Am4sT4Edu7e/YRVhWDys2cfquxd+MjnlhlFWi3T55Xq4uepiey
	OZIs9uNbN2KkT74qZXbChCQ7F4eUuxXuVEWN+E2XJPKVdkgNbPLiBtZWgV88xKfs0hT/OPMhVTU
	oj/2E25Pv4Oh6rV6wainBh8DloKS5e505KyJFkKxJCn/ybamqNEA4Uu/IYA+MbCteXRd9mV5cl4
	Q764LTbPngUwG6WR0Uj5kz3bqwqAy6VBOQKkE/lAHexy7nkLlzLVdtNlaW2V1By2jPCOdKKOz2i
	xS3bL7RoHzsR5QL+DSwY6/UR0GQ==
X-Google-Smtp-Source: AGHT+IHSkS+9Jjyh0FieViDOlT57e2E3MyfmOksKqo+4S80Ntig+yzChu+HDJiTU196x/m4GAoCbNQ==
X-Received: by 2002:a17:907:2688:b0:ad5:a29c:efed with SMTP id a640c23a62f3a-ad85b1de649mr570657866b.33.1748210771582;
        Sun, 25 May 2025 15:06:11 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad5b192cb0asm802961166b.170.2025.05.25.15.06.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 15:06:10 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-604630fcd3aso908509a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 15:06:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWOV9D37FYcMmwsVGhaTVw7NiaCgo0oqN5sjfsCS4Rksg6AZBUfzvrn+zr/NOPk2LoGdmUX6fTuyGXdUu1@vger.kernel.org
X-Received: by 2002:a05:6402:847:b0:5fd:ef5d:cfc4 with SMTP id
 4fb4d7f45d1cf-602da5f8453mr5260550a12.32.1748210770332; Sun, 25 May 2025
 15:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525083209.GS2023217@ZenIV> <20250525180632.GU2023217@ZenIV>
 <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz> <CAHk-=wjh0XVmJWEF-F8tjyz6ebdy=9COnp6sDBCXtQNAaJ0TQA@mail.gmail.com>
 <aDOCLQTaYqYIvtxb@casper.infradead.org> <20250525214939.GW2023217@ZenIV>
In-Reply-To: <20250525214939.GW2023217@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 May 2025 15:05:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6gy_EXWfaNF4ee1XTGfhFFTfNkvMbJUmab+Xs8kNAfw@mail.gmail.com>
X-Gm-Features: AX0GCFukz7S2mvxAbYp9oUzmI_wPzhrn8Q9ZrgMizdYhBa2rr8QE_I1ab_1NEtU
Message-ID: <CAHk-=wj6gy_EXWfaNF4ee1XTGfhFFTfNkvMbJUmab+Xs8kNAfw@mail.gmail.com>
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 May 2025 at 14:49, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Perhaps
>
> -#define FOP_DONTCACHE           ((__force fop_flags_t)(1 << 7)) when shit gets fixed
> +#define FOP_DONTCACHE           0 // ((__force fop_flags_t)(1 << 7)) when shit gets fixed
>
> instead?

Yeah, I think that ends up being prettier than an extra error return
in the middle of code.

Will do. Thanks for noticing this, even if the timing is awkward.

              Linus

