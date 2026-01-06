Return-Path: <linux-fsdevel+bounces-72525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD843CF9472
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 17:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E42DD3019BA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A0033A014;
	Tue,  6 Jan 2026 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="i1zDWpvm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB62337109
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715552; cv=none; b=LKBAsxUoj7pJsavdrhnR7q5ke6bJWf0CrTrSHtX3mHL+4s9nAhlE8JFH74NY5wsGq01FjB1hrMuzMoughYaVDyux10DqUy3efmSaOunJ3hjBYeHUVaYFnXpTSbrXrwVgr5VoXGCW1k+prFUR5YRDp33Xj5/f0rSWxSjmpqdeLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715552; c=relaxed/simple;
	bh=P9pkAPzgU9jiMtELSPkK4tgujKYh/5GTTPxNlHaGGAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJOMgCdgWszlubUTEyywAQMbxNB9OkSr/OiFCLECEI8EOlvD808q9pkq2AmG6oGm5m6241tGSEVxbp92vpD2zueHn0lLS/k2r4SVYr2liBD50vpzhwZpBbnJwmOxUqeUCzBcAWUNjCaMGf9gqkiRsLAyaV2tvOTmWoSI5uu9iXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=i1zDWpvm; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so10657041cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 08:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1767715549; x=1768320349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bxubu6bhf1aeIofDmdnq3Yy4S+a1o4zcmmWzD9LU3qU=;
        b=i1zDWpvmvujJ8hsl6QDaxmK7HlaTbH5xsQQf3kaeLWXQ2Nksg9XDA9sREX2gslCBum
         BD8/cZmedxX3BpVDyMvS3UNtIzZGjBfuk79roGeEJ2N8IUKZQqnK4IAzZZ6L+fpPXxmh
         IzNT41fhbnGq4jvOsVJ/QehnNdzLLVzMmUaGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767715549; x=1768320349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxubu6bhf1aeIofDmdnq3Yy4S+a1o4zcmmWzD9LU3qU=;
        b=UDGqD2wyZKvFPm/zwnc/dEHR0DGT+23TOXGZSNaVwWlFMtKTpRq7s/o9jRP/s0G8vf
         rak+ljU15yI4Ju54yszULKECdT672HZU9f4LqNbW//zKMbnzr5HRB+Jnzl4giRK0HEgX
         nNW0iTJt+kTgnLPWP59xaFX7lVp6njz7NNnGjjbheP+xeTeXx8qH17y9e7YZP7PwCSpm
         p0C+mjK2pyfSC66RU1buMtV5kVOXti8AiIAWGEQ3s6Xl7xcHxN8FwwcwDM/Xf53RmH1g
         65fIx1NrNRS5/L9Ggub6rXXxSncPFfVJRnXULSjF8k+Nm6vE7SBhAPNeoa+MJ0dtA0Hs
         wbDg==
X-Forwarded-Encrypted: i=1; AJvYcCVGBHMauGbDFMXcH6IpWmyrcv1EP2fPt0xclPJ0ThYMBryQIesely02gAbKTPt4eJwmXVZzW+oYfRd64pUG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6CaRfchOXrGUm3A5nRhJLpmkYHhoIcbmT3y1wqQiZ+NYdnxpR
	IG3QFzn9Dvh3xRSLbk3Av9ZBlih3s5l7jGusRvU0Lcc7VTQyoADredFLLRuGQN0KwvZMZdmBG2S
	wI0JGc4zwOjOvrvBmXGaZTLTAPAeWPo0VIszRn5jRSQ==
X-Gm-Gg: AY/fxX5XjsyBswevbwOWPpEI6dFArR7309DRtC+mTihVSnWeXD5sJNF5moyvj2v9Wu2
	MQkkJBGoOiydtDqmRIzV20jD6cf2YQLp4cBtMe5Zxs3AyfsqxJTlQWU6PxphJ81JAme/RoHa1UP
	uZ8sQ0+LskbKkwqoWaHmr0DgZKuOGWz5NTVhMqrXyFpCWPDAxi/TLJfK07+5ZGIuMAOvSfKrnY2
	GnKrgkC7lR7wWRuxQq598sAKS9EIgO43ykdC+4TfnlhtoB8vyjZ6pWGTJs8Q7r6N4u7Yw==
X-Google-Smtp-Source: AGHT+IFCiBafqUgtl2raN6GQUVNDDPPvtFF/AxT7TW768dFtVoExGBHENTdsULyggB6RdI6ZLBqSAqmAI5g+2iJa/go=
X-Received: by 2002:a05:622a:4c0b:b0:4e8:b85f:8a7a with SMTP id
 d75a77b69052e-4ffa77a5584mr38480931cf.41.1767715549416; Tue, 06 Jan 2026
 08:05:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com> <ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
 <616c2e51-ff69-4ef9-9637-41f3ff8691dd@kernel.org> <CAJfpeguBuHBGUq45bOFvypsyd8XXekLKycRBGO1eeqLxz3L0eA@mail.gmail.com>
 <238ef4ab-7ea3-442a-a344-a683dd64f818@kernel.org> <CAJfpegvUP5MK-xB2=djmGo4iYzmsn9LLWV3ZJXFbyyft_LsA_Q@mail.gmail.com>
 <c39232ea-8cf0-45e6-9a5a-e2abae60134c@kernel.org>
In-Reply-To: <c39232ea-8cf0-45e6-9a5a-e2abae60134c@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 6 Jan 2026 17:05:38 +0100
X-Gm-Features: AQt7F2rb-cr5B2gKtHwtRDiTVmalqmfCL58if05whOX7dHeEO4sH6ByS6QMbH6g
Message-ID: <CAJfpegt0Bp5qNFPS0KsAZeU62vw4CqHv+1d53CmEOV45r-Rj0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Joanne Koong <joannelkoong@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, 
	carnil@debian.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Jan 2026 at 16:41, David Hildenbrand (Red Hat)
<david@kernel.org> wrote:

> I assume the usual suspects, including mm/memory-failure.c.
>
> memory_failure() not only contains a folio_wait_writeback() but also a
> folio_lock(), so twice the fun :)

As long as it's run from a workqueue it shouldn't affect the rest of
the system, right?  The wq thread will consume a nontrivial amount of
resources, I suppose, so it would be better to implement those waits
asynchronously.

Thanks,
Miklos

