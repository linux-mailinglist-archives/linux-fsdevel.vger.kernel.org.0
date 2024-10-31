Return-Path: <linux-fsdevel+bounces-33363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7659B7FAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 17:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA7C1C217F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 16:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01091B3F30;
	Thu, 31 Oct 2024 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnV+FhhZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399F919DF49;
	Thu, 31 Oct 2024 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391069; cv=none; b=uUZEq467epB2lNVS63ZibvwbqTKxgiGcrq3/s4xeRHs3yWgARQF/QdIFJhoiEPASuN88IwTBfh96bhUpVHYcOBgXebr13M4B+EAGBL7oNgJt3XyiI4Ecsd4VDfALBo7nlYKw0FenC6vHIx04YhVPl8MEza6ta4BDTT9/5YQHke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391069; c=relaxed/simple;
	bh=IJONyDekfDFWRc5UQ3Yl6ornL+fxJATS1eKBVCn8vIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDj6HZc5sMyE1mxqhbVhnuE1A+PCv1m0IRoT6iXXc6ar5KmV9l6kiDKyorjpZiJ0w3qYE/vsJi7ilurCFjAYkz0/QJlm/iYGFiyERt4/ntwkUYBlqvAzZvT7CBuWkLQ6hSr+EdMtcPKTI0OXPe1MlIE7XR4h8EPl9ScjpeQNW9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnV+FhhZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d808ae924so641271f8f.0;
        Thu, 31 Oct 2024 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730391065; x=1730995865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkVYFCrUf9lnrWXXH+FWVeusgMRdqmFXIn3Y3pXJD/s=;
        b=VnV+FhhZ8ZZo1KbXqbeSAM4A05M9morlAvel32sG0StNLlMcKrcY/MiQsYCK+Oi/x5
         gkawBfKctkcEGtLfQlmgdurKWI9rIa0GCeZ9H6NjxvphfJQuNZd65fUrycfLcXiNcvvv
         DdbHj/LeMfoPxW0LLwSySDCM5iEbsYCVAekf2TeuVayv6v6nCtpGJ6hGX7h9S+B6rj7R
         Md/fes2NrjjQEmoFVxvfgmUD3juqMn9dQlR99I0tTsy7mBiyRBpnrw3nGtFBcT4jS0Ub
         gfPb/cDNRvMS3WS2Xcb6eZDt2564X1rSuJnB75cXASyddLOAJLPZeUBAQpFKz/xWtxXa
         P+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730391065; x=1730995865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkVYFCrUf9lnrWXXH+FWVeusgMRdqmFXIn3Y3pXJD/s=;
        b=RBHzT4px0wtL8gs0Ln9g9PzGlL609miDplqvo1HbLrOebgwzXEhZdrAw4naxiE5ClC
         gA4cVwCDJ2XmJYXxgivOslSix/pPp+9vk44/hKy7my7kMLNJ+kzYm8GSg5Duh70WWSgA
         NqBHbD1k9UQ8IKlnLxqZYg9GfQihPFzQYckluVOkau/iHPh8HAO6NwOhmDBnLRWMuBYu
         J3Xd+qN7c4LUKnrqR49bDuNoXOOIpWIa1uCGz1AjOzSBkkHG/m7jAMz7pe5rxorsLCIy
         t+ewzGHpA9wlgzNsBIyCAk9pdQRFp0ykMYP9eCmUTmJXk+vaFFfJs9c/HJ6XabmRk7n4
         HFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnGdHEpynzog7Abk0kiCgEiOPrq+nCkSQW50vYazk422XRu6QL4CN8heQtO4gH1FLktzBzEkUpHgiMaXWW@vger.kernel.org, AJvYcCXEA9iKpnX88fYd5wxUzn45sipAdY3AVXqEj3g0bBsZsmeZBcbXV9XtTLnN+m74g+Kba1bxGhTGg/6JHHpGKw==@vger.kernel.org, AJvYcCXWNwkiyByjPzI42aDyXEFe4HC122GeAmdzKKJM096YLmMGpCmoU6VZJNurDel2uhh73WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFO5eI4kDivUoF+9YwszEE61Ua/bPa7tj1lQfivo4dVyjINPem
	9NFjF3Stxf1xcYDkezPRSpRr8h7564Pk1nXNHuG2NgHMyCL2+5x+KrVSYYVmWSEDd2dvECgdzya
	DCpZXHKamhOkM2DS6v1Rv+zSo9Oc=
X-Google-Smtp-Source: AGHT+IHos3YbZVQo+uTr9o4cIsciMIcISsevDhXKg/ZyCHNdw3WAexka2CwqOl7OZiCqVJV1A/Dw7P2WrCzBiOxZK8g=
X-Received: by 2002:a5d:5590:0:b0:37d:4fe9:b6a6 with SMTP id
 ffacd0b85a97d-38061163240mr14442794f8f.29.1730391065309; Thu, 31 Oct 2024
 09:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zw34dAaqA5tR6mHN@infradead.org> <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
 <Zw384bed3yVgZpoc@infradead.org> <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
 <20241016135155.otibqwcyqczxt26f@quack3> <20241016-luxus-winkt-4676cfdf25ff@brauner>
 <ZxEnV353YshfkmXe@infradead.org> <20241021-ausgleichen-wesen-3d3ae116f742@brauner>
 <ZxibdxIjfaHOpGJn@infradead.org> <41CA4718-EE8E-499B-AC3C-E22C311035E7@fb.com>
 <ZyMqOyswxw1s1Jbt@infradead.org> <B6CD210E-96C6-4730-BD05-EC3A0C6905EB@fb.com>
In-Reply-To: <B6CD210E-96C6-4730-BD05-EC3A0C6905EB@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 31 Oct 2024 09:10:53 -0700
Message-ID: <CAADnVQKW4vq-0_Z8kec_Omox1urBCsA-Fpx=H1cY0WVwZHEOQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
To: Song Liu <songliubraving@meta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Al Viro <viro@zeniv.linux.org.uk>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:02=E2=80=AFAM Song Liu <songliubraving@meta.com> =
wrote:
>
> >  Not sure how you want to best handle that.
>
>  We may also introduce other prefixes for future use cases.

bpf infra makes zero effort to prevent insecure/nonsensical bpf programs.
It's futile. Humans will always find ways to shoot themselves in the foot.
Before bpf-lsm existed people were selling "security" products
where _tracing_ bpf programs monitored syscall activity with kprobes
suffering all TOCTOU issues and signaling root user same daemon
via bpf maps/ring buffers to kill "bad" processes.
Such startups still exist. There is no technical solution
to human "ingenuity".

