Return-Path: <linux-fsdevel+bounces-22490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6121A9180EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928131C21A9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101C7181BAA;
	Wed, 26 Jun 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IYj8FloU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548417E911
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404651; cv=none; b=g/hgYWnpbsckUOsEhRxmuDrMek2ILN9eIAuZwRBgn6IZ9Q70kxWrgnLpEx6uvHbSQAdPP6xY7Df7XRlSZBVpabnMIEMWJQvw+tXqPxeDBIn1NuXrG9gWol/coFC/bwEOyyvjJBmQ+6UZpDVIESOSnSUrBpz5uuDwdKZUDTo+To4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404651; c=relaxed/simple;
	bh=viqxdMdfo94SqfGX64WmLQYLi8Z3AXHJxr+3qOZJ+Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O74EFsrWrhdCN9w8yeiFCIHkEkrDlC2ks2lW0tKAw1NkgSfTQrAEnClgl4qD34hVI5TlTMVNTeuP7UN/nIELtlFdyXrcRao1i6ED+A2BfFXDBHpJZQI+rLzn6ILNhrqSTkdO1mTlISxRmC2w52kgAaPvDf8sRBSYtb34AzbdFJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=IYj8FloU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a72510ebc3fso512261566b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 05:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1719404647; x=1720009447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cdt3At8ssrBW3x+Nsi7LnJS/NlghzsKLR9lv35sJCoU=;
        b=IYj8FloUEsEm3/msPcsf+LDEhg49nMIDnWrlD9SB4/LzUnsVevxG4FRnqb6J93NWgS
         avIGIJzF8bSawZBq4wwBnxpsCbvhqos3GzTE37LKTfGkRhCRhTovvY34n8jdmxGhLtI/
         nUMmZKZBjJlHlzwoF7+JfIM+YzFmDFNxjXXdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719404647; x=1720009447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cdt3At8ssrBW3x+Nsi7LnJS/NlghzsKLR9lv35sJCoU=;
        b=Pi2Bbp5z3mOT+k/MBfRrW4+1bWVC6sJeNYE09YNVJtyGZQuIQtdA6Jh/bx8QReZsIK
         UJh5vTQC0laU+cl4FhwlAdpQ359TaK1RvCTPuiRoiA1CGJbem5uUK8mPEnYVDcF7PyO+
         RPtpg3Ol5myH4LnFAZCu8XILcmi7K+fYE3TaEqmVQfGIOqhEsvjrXvZiK32T6J76hl2e
         qIwEtUjmYUF6rzwV7ERKdnQVtfecwizcgCv3IJcI3W2Q7RyomwlyxorRKXehxtqLFvbO
         UbVBha3lBVzz2bZccH/QOji34LqFo3Vy71Cwqg0OK+4d4mZu7pTVmB8rahCrPyiPMBWY
         uvjg==
X-Forwarded-Encrypted: i=1; AJvYcCUzxb4leuq5OtQ5uYQcceCu9zQs0sWDduf2HIWYJ2RRqQAWbW6Zjlnn7iPqIuW8D91RnaPus+3lxx4Bn9JGrZYXeNHgMWhDl3L0oK87ng==
X-Gm-Message-State: AOJu0Yx621jZZnEL+Kwo3OSryUw2nd7dQm+s+O2muJMO3Ie8qUihQuTL
	EZmtKwI57l5V6RdkSTTcgLgWX7HbWJ4b/sZ5qbDnuMAkelTlaz0Dt3cfQPXJFIlKt1WNvnUDHsh
	mZMAixo7aLjMzAK0XXtZ+aNYD8IMQhAAaVPXtkg==
X-Google-Smtp-Source: AGHT+IHrLUG0ibxcO7qjZMNyI2rnLL6EoZieJfL2ts6ePWq8XJ/5YIOqylm0DjgSD9aggxRlSrKNF2uLQR05f8aqgPI=
X-Received: by 2002:a17:906:ca14:b0:a6f:b75f:3d46 with SMTP id
 a640c23a62f3a-a7242c4b89fmr883367266b.43.1719404646834; Wed, 26 Jun 2024
 05:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719257716.git.josef@toxicpanda.com> <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
 <20240625130008.GA2945924@perftesting> <CAJfpeguAarrLmXq+54Tj3Bf3+5uhq4kXOfVytEAOmh8RpUDE6w@mail.gmail.com>
 <20240625-beackern-bahnstation-290299dade30@brauner> <5j2codcdntgdt4wpvzgbadg4r5obckor37kk4sglora2qv5kwu@wsezhlieuduj>
 <20240625141756.GA2946846@perftesting>
In-Reply-To: <20240625141756.GA2946846@perftesting>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 26 Jun 2024 14:23:55 +0200
Message-ID: <CAJfpegs1zq+wsmhntdFBYGDqQAACWV+ywhAWdZFetdDxcL3Mow@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
To: Josef Bacik <josef@toxicpanda.com>
Cc: Karel Zak <kzak@redhat.com>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 16:18, Josef Bacik <josef@toxicpanda.com> wrote:

> But that means getting the buffer, and going back through it and replacing every
> ',' with a '\0', because I'm sure as hell not going and changing all of our
> ->show_options() callbacks to not put in a ','.
>
> Is this the direction we want to go?

IMO yes.  Having a clean interface is much more important than doing
slightly less processing on the kernel side (which would likely be
done anyway on the user side).

Thanks,
Miklos

