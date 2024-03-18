Return-Path: <linux-fsdevel+bounces-14769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC987F080
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 20:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85881F22503
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 19:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F168D56B77;
	Mon, 18 Mar 2024 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AfMjhp6J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A111707
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710790931; cv=none; b=Iu80P0SfPie3u3oda5AmRgpfXFaa7JzrFRFYVgqN+GbFWRg3UMU8VsHZ90obS59qFyYT7unnB8q43Q+WBUOUj3iS1QH3kSaCvM4uFVNB4TsgXsdZJ0uZmOfUi3+zTRi+s5PGJMqo0bGebGVsirBRSmppzz50wzJqwli6IvBWoL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710790931; c=relaxed/simple;
	bh=ale89vUoJpMEo0+ss4tyzF52HWPdXyIN0XFezNPuRKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bw9WEB/whefDdaCLl5IF12sElGUloJmuTuLVgFFkM4O7AwxUQvH7mS1ux9pFSuqkrLmX+m1H+Vi4m3jV0Q6HmWDi+JNdw+dlp/lUr+VwwNmbmgRLzE73WFrbrdqXANH09l6Ysci7lcOCTJ+mdRSuc13Tgd/cQEcijby3wJ6xWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AfMjhp6J; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-568a9c331a3so4545650a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710790927; x=1711395727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HaVbhTB7mAtrZZxFWhtZksrr9aUMglMdAVpXYeAu2e4=;
        b=AfMjhp6J/UzX6s5qFzabyYGp7QmaIXMOOknFIp/AyY/LYLuAiRnoePKgpf9LWVbqUL
         +2PkwfFnnrvyxPK6gAgKr7BwnObUtSRonhXd+r1sBPwiy+ffpS5XDtBgL6f5SzGrGiSj
         oU1s3IydBzBDUlPAq2cNLFbJucWSiCq/tVEeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710790927; x=1711395727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HaVbhTB7mAtrZZxFWhtZksrr9aUMglMdAVpXYeAu2e4=;
        b=k0pWNr1j16ahS1/2ExGjRH3Kilg89xIEWkmKRwhITNapyPCOlbhAXsNNqXcT4F3fqD
         Sm5vgrXL4VCjIq7jR9/z1JzZ7ZSPOUAbBNEWhOLcxLURbgV2a8kL0J8FcTzbp+lA3Ndd
         LM/iGlvayTveKUiFSlZSI1LfuttfCiKGBUVBwvycK9qOA9MAyxeG8ZXg585UA2WcdaUy
         DEp5MmJESzPc/FTzb3b33OTdsjJ7A6uMR/A1tc/iwZocqiC5N8ZxSvz/slxKO+kr396C
         0XKQynPQlopzJ9efr/Ll0VHChKHLMtIpbgpXcU9si+jdXzK7at+RaajtEE39sAqLHLJN
         qY6g==
X-Gm-Message-State: AOJu0YyevgcQmmCXm3EWV65CrDL3eqKaQM/kMfe0IupGhbzRQtoUqpI2
	rJgIPLlYzoxFNQP52QFN3ihmvCOPzt2R6bSj28ETsLba7y9QN4+ZbAEhBYKbpcrWxsSwCZLHkSo
	lMWqFGw==
X-Google-Smtp-Source: AGHT+IF3Mj3tV0W0QhP0ammSR+Mu+7BbI5GI/sMiEh7UpcSmcCztA663dBprv0IIM29a3Y0qxcMRcA==
X-Received: by 2002:a05:6402:2789:b0:568:c309:f7f5 with SMTP id b9-20020a056402278900b00568c309f7f5mr4485522ede.6.1710790927551;
        Mon, 18 Mar 2024 12:42:07 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id f22-20020aa7d856000000b0056b818544a9sm734422eds.90.2024.03.18.12.42.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 12:42:07 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a450bedffdfso584413266b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 12:42:07 -0700 (PDT)
X-Received: by 2002:a17:907:d40f:b0:a46:6b11:b861 with SMTP id
 vi15-20020a170907d40f00b00a466b11b861mr10285439ejc.33.1710790926761; Mon, 18
 Mar 2024 12:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-vfs-fixes-e0e7e114b1d1@brauner> <CAHk-=wj-uKiYKh7g1=R9jkXB=GmwJ79uDdFKBKib2rDq79VDUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj-uKiYKh7g1=R9jkXB=GmwJ79uDdFKBKib2rDq79VDUQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Mar 2024 12:41:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRukhPxmDFAk+aAZEcA_RQvmbOoJGOw6w2RBSDd1Nmwg@mail.gmail.com>
Message-ID: <CAHk-=wjRukhPxmDFAk+aAZEcA_RQvmbOoJGOw6w2RBSDd1Nmwg@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 12:14, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> IOW, isn't the 'get()' always basically paired with the mounting? And
> the 'put()' would probably be best done iin kill_block_super()?

.. or alternative handwavy approach:

 The fundamental _reason_ for the ->get/put seems to be to make the
'holder' lifetime be at least as long as the 'struct file' it is
associated with. No?

So how about we just make the 'holder' always *be* a 'struct file *'? That

 (a) gets rid of the typeless 'void *' part

 (b) is already what it is for normal cases (ie O_EXCL file opens).

wouldn't it be lovely if we just made the rule be that 'holder' *is*
the file pointer, and got rid of a lot of typeless WTF code?

Again, this comment (and the previous email) is more based on "this
does not feel right to me" than anything else.

That code just makes my skin itch. I can't say it's _wrong_, but it
just FeelsWrongToMe(tm).

          Linus

